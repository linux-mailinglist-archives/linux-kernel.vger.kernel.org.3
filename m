Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599AA4F5F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiDFNGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiDFNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:06:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB064301299;
        Tue,  5 Apr 2022 18:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CDt6O1qEIdlN6ztswL/r+3cOb6tC6ktRTDJ0omZJKrQ=; b=qPsGmF5ZPZE2DUAk22ClY4MeTT
        nF8oxwYaifG12VYjqBpWuT9bOZx9MFD8fNtiItf5hmuTT/9S+r4lzFaU0qUywZnG4BLASwdy2hwi9
        85KS5nUxJ0jvXgxds2u5+uIAYbabEOLSnsN4AI2kJ8jqFFBDDdyzkrAOKPd1xfuhKotTBWJr8VDQD
        qNmURL5qlrbpOVpDmNi+PBeEPxFhtLtNDo7grok8bL8qT8OlH9LJHD1f2JG57k9Dy2kO0KmLuoJr0
        8RSwHJlANh0Cos+mZzmuwrN/QJGsNEH+7a4dndpGYW/55xfPuJ8XiqoBRSLgrZ1ExvNtJUbxF7ss8
        6gL6mwew==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbuj8-003G2g-5q; Wed, 06 Apr 2022 01:44:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2] keys: remove __user annotation from function prototype
Date:   Tue,  5 Apr 2022 18:44:53 -0700
Message-Id: <20220406014453.32091-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a missed __user annotation from the prototype for
keyring_read(). This cures a sparse warning when it complains about
the difference in the prototype and the function definition.

security/keys/keyring.c:481:13: sparse:    long static [signed] [toplevel] keyring_read( ... )
security/keys/keyring.c:81:13: sparse:    long static [addressable] [signed] [toplevel] keyring_read( ... )

Fixes: 796e46f9e2cb ("keys: Remove outdated __user annotations").
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
v2: rebase/resend; add more Cc:s

 security/keys/keyring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -79,7 +79,7 @@ static void keyring_revoke(struct key *k
 static void keyring_destroy(struct key *keyring);
 static void keyring_describe(const struct key *keyring, struct seq_file *m);
 static long keyring_read(const struct key *keyring,
-			 char __user *buffer, size_t buflen);
+			 char *buffer, size_t buflen);
 
 struct key_type key_type_keyring = {
 	.name		= "keyring",
