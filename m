Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFEB589CB4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbiHDNcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbiHDNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:32:04 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B7D3D5AF
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659619868; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=SZw+8XMbXUhCC9M5zws+UTT4BnqMIiledxtl9zcqM91/pPLeB1UzprgJoS+bXuMSxmjVR/0lTawbBopGawupmsXMbgrse4H0Ty0a3g4ql76W/5ykBkw0P9S3/1JT1JeTdQIAhjdGlVJtfqmpb5cLpJ+dRkHWytGyyqAGbxpMNPo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659619868; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Mkouf4SEWTVHaF7w1SKVoF67Ydf5Jf61GjhuLviyvJI=; 
        b=f1CWY6eayz5V5C9qgyTnEBauougLevVyN+HAyBc1ycM5g3+oddudC54vSThdy/VAxGansevU66EONexIyeD9/t04T8ANaNiteOEoedk0HnYKuhnhMWvSAx9MXQDsqwPIZdOjcaqEfAWxMU3lp7JyrgMJgtoS24QYE3Sf/jE7xcw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659619868;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=Mkouf4SEWTVHaF7w1SKVoF67Ydf5Jf61GjhuLviyvJI=;
        b=Vyp62Aw68XEUvrRYpXNy938pR6kpxx37ANsObBuIItdFBuDtb+PFlHVe44b8dllE
        ESyFabbj6UnW/wnj6WsSrH5dZUZmtSfQVVttL2R135evsr901ge8kBxEsSPUzHiK+XO
        XkvyHCxv2TcJrSnCVhsKfgGBq1CuxbHDSZZnAJpQ=
Received: from localhost.localdomain (103.250.137.206 [103.250.137.206]) by mx.zoho.in
        with SMTPS id 1659619866703572.7773396291667; Thu, 4 Aug 2022 19:01:06 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Eric Biggers <ebiggers@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <cover.1659618705.git.code@siddh.me>
Subject: [PATCH 0/3] kernel/watch_queue: Clean up some code
Date:   Thu,  4 Aug 2022 19:00:21 +0530
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

There is a dangling reference to pipe in a watch_queue after clearing it.
Thus, NULL that pointer while clearing. This can be thought of as a v4 of
the patches I had sent earlier.

This change renders wqueue->defunct superfluous, as the latter is only used
to check if watch_queue is cleared. With this change, the pipe is NULL'd
while clearing, so we can just check if the pipe is NULL.

Extending comment for watch_queue->pipe in the definition of watch_queue
made the comment conventionally too long (it was already past 80 chars),
so I have changed the struct annotations to be doxygen-styled, so that
I can extend the comment mentioning that the pipe is NULL when watch_queue
is cleared.

Siddh Raman Pant (3):
  kernel/watch_queue: Remove dangling pipe reference while clearing
    watch_queue
  kernel/watch_queue: Improve struct annotation formatting
  kernel/watch_queue: Remove wqueue->defunct and use pipe for clear
    check

 include/linux/watch_queue.h | 95 +++++++++++++++++++++++++++----------
 kernel/watch_queue.c        | 11 ++---
 2 files changed, 75 insertions(+), 31 deletions(-)

--=20
2.35.1


