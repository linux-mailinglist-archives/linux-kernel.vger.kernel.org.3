Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA3B5A6D02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiH3TUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiH3TT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:19:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B49E76;
        Tue, 30 Aug 2022 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=CHzCA7GPiORmBHidTJtpvbQeys/yG/nFcsS5vBNnrck=; b=G2Bn4P6vc9unPtOZ3olpVw4eoD
        qdpXnrfgEG0VlxM+3aOGWOzvYg2SPz7py+JAP+8GDWOvLaXDzT+DFy/SbYAFY9c2zQs7VJDBTtDpw
        w67Inc/aUIf78Ut9Zmh1ONKCzg5SteV9tkJaZdUdGEOkfHlqbRNVjlxNtuIbRuOxJlgy2PyaL4QoX
        N+aZ4k/+rpKAdxDs4VLgJJ4GYQ/gSSXENbPBrjD7BIE97rwGhRHu0uwHm69nxJ/ddrrLREYOky9Cy
        UoDOPU1x66dajZlV7ti10PYQCK7NM320h0POB6MRCK3YIYfI3W7Zh5AywcJFEVtnhU2M1DV6jT5Wl
        gsZ0n4Xw==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oT6m2-004M4w-Pq; Tue, 30 Aug 2022 19:19:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org
Subject: [PATCH v3] keys: remove __user annotation from function prototype
Date:   Tue, 30 Aug 2022 12:19:40 -0700
Message-Id: <20220830191940.1498-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.2
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2: rebase/resend; no changes
v3: add Rev-by from Jarkko; resend

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
