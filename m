Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4151457EF4B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiGWNwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 09:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiGWNwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 09:52:02 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E147A1A399
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 06:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658584264; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=XYU1zZnXuqFX5/HEudi9MdMxktvd9itAU+I2kePgDtCgp6Li1x8deFEeTSo4eTQS1AbaC/ivef2pbxmOYDcr2MTZ3t4RpyknGzLsXwEhNuVnyM40iFlvYFHv1s6A4JVc97EEyhqomPGugRHf6mFMnY8vj2Z+pRvpg+t8RZgiH00=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658584264; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=kk/+ZMIM3QEokLR9dNDr3dm8l5WXXAEPykmzd3WKeh8=; 
        b=bBmfhYES5zT2HidO8HpjBfslnBmO60DtgLqOtOH5Sz+OLgjxOhtn2KH1Uz8/eFMCpaI5O6vHw+spAgfOU1gCxzta9YMbvk6j9CBjTZqDm1BkKRuOV9X+zPxixdBv4ljsbHaOpjPz5HMLN2uqV6ievgrMCFjHYvCafKDwNv099Dg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658584264;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=kk/+ZMIM3QEokLR9dNDr3dm8l5WXXAEPykmzd3WKeh8=;
        b=C5Kc0g6QcesPZacQeSWUfVye11w85Epm+2OhT0JWxQuKAC0qiYGDe5rM2GegGr6F
        0GncE33rxOJHfMEfbX9lJ/wGrkzBNGaBREdPQmq4uoF7icdrgn8A0XmbYG4yKWadTN6
        O7VluijrgjArt2qZmswtFWS1t01hw+BtIxp4wY6s=
Received: from localhost.localdomain (43.250.158.127 [43.250.158.127]) by mx.zoho.in
        with SMTPS id 1658584262744848.2252468169082; Sat, 23 Jul 2022 19:21:02 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     keyrings <keyrings@vger.kernel.org>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <20220723135035.199188-1-code@siddh.me>
Subject: [PATCH] keys/keyctl: Use kfree_rcu instead of kfree
Date:   Sat, 23 Jul 2022 19:20:35 +0530
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In keyctl_watch_key, use kfree_rcu() for freeing watch and wlist
as they support RCU and have an rcu_head in the struct definition.

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 security/keys/keyctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 96a92a645216..087fbc141cfd 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1832,9 +1832,9 @@ long keyctl_watch_key(key_serial_t id, int watch_queu=
e_fd, int watch_id)
 =09}
=20
 err_watch:
-=09kfree(watch);
+=09kfree_rcu(watch, rcu);
 err_wlist:
-=09kfree(wlist);
+=09kfree_rcu(wlist, rcu);
 err_wqueue:
 =09put_watch_queue(wqueue);
 err_key:
--=20
2.35.1


