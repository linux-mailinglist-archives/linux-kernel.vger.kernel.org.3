Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39B2496DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 21:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiAVUPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 15:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiAVUPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 15:15:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63B6C06173B;
        Sat, 22 Jan 2022 12:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=TFQ9CNPUu1Y/Wxiw9dstDcvw/MkO8+fgU7WdEUxn5vw=; b=SjeFAWEhTeFCQ8cGyy642VFK1y
        hXk9ohngJzRWgUrrfz0/v127DAPoUKfHIDRnPxHGMX2pF30xh7An5LonpxsunjsOduvam46QQebq8
        x2VnRvURiBWoug3hAynr4X7M+10heJBwHtnw7nGNtAAhUi/Kv76VDFmEGPc43r1a2g1mEOSwIfEGW
        vX1hDhdjNtr81pHiZsgJLOM/H4QrOKGwrKnOkEE9uTdzPwvF73q6iT3FsDVrXuqVTVo1IM0Fuwl+Z
        kQeAyVkG65fAEhGa09st2+b77JeK9Lh7SP1SdIsG6xjO5U8H574pUABVFIQ89wNBBNfVX7Fkz5WIU
        9BFZgedw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBMn7-0002Uu-BF; Sat, 22 Jan 2022 20:15:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org
Subject: [PATCH] keys: remove __user annotation from function prototype
Date:   Sat, 22 Jan 2022 12:15:16 -0800
Message-Id: <20220122201516.13547-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 security/keys/keyring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20220121.orig/security/keys/keyring.c
+++ linux-next-20220121/security/keys/keyring.c
@@ -79,7 +79,7 @@ static void keyring_revoke(struct key *k
 static void keyring_destroy(struct key *keyring);
 static void keyring_describe(const struct key *keyring, struct seq_file *m);
 static long keyring_read(const struct key *keyring,
-			 char __user *buffer, size_t buflen);
+			 char *buffer, size_t buflen);
 
 struct key_type key_type_keyring = {
 	.name		= "keyring",
