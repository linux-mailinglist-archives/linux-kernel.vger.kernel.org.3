Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8FA4DCD50
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbiCQSND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbiCQSMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:12:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9587D21F757;
        Thu, 17 Mar 2022 11:11:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EEA6B81F78;
        Thu, 17 Mar 2022 18:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD0DC340E9;
        Thu, 17 Mar 2022 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647540683;
        bh=cwX42oNMILb31uWuwrX4DLWMJYJsQrZZhHdeJy/mlH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FCHi9vddFiA9Gh/t6oPZ7hZ2LU8FoK1X+j3EpcZKyMUuDCc984pNBCvyZZRiuyFCE
         ChuMQQX5nTW45uawJhFSXICR5Mg2jKa4KGO87/AmJesnfMlr8p4egho29otiwDScMZ
         3E9bBZcmde2Et/SIH1S/iq6CD9n88cY8GfLeLTZcYh3c50QebybYTbJzJ4RhfSlF64
         3XgPwt+aJuyGOz3KN0OT78HyZfaz2+daoyjzgs0z+DC5ApgmAE6pgS3PcOsTGyE/qy
         5UkIU4ZyGqC3NDoFAYsVksFWdhedx2rsL+haBHIB5aNFnuN5T5huFNR/tNguw4zUep
         G0KnORtEBJekA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v5 03/20] kallsyms: use the correct buffer size for symbols
Date:   Thu, 17 Mar 2022 19:09:51 +0100
Message-Id: <20220317181032.15436-4-ojeda@kernel.org>
In-Reply-To: <20220317181032.15436-1-ojeda@kernel.org>
References: <20220317181032.15436-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

The buffered name size should be larger than `KSYM_NAME_LEN`, otherwise
we cannot tell whether the size of a symbol name is too long.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/kallsyms.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 72ba0fe4e43b..0e37c19d84af 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -27,6 +27,9 @@
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 
+#define _stringify_1(x)	#x
+#define _stringify(x)	_stringify_1(x)
+
 #define KSYM_NAME_LEN		512
 
 struct sym_entry {
@@ -197,15 +200,15 @@ static void check_symbol_range(const char *sym, unsigned long long addr,
 
 static struct sym_entry *read_symbol(FILE *in)
 {
-	char name[500], type;
+	char name[KSYM_NAME_LEN+1], type;
 	unsigned long long addr;
 	unsigned int len;
 	struct sym_entry *sym;
 	int rc;
 
-	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
+	rc = fscanf(in, "%llx %c %" _stringify(KSYM_NAME_LEN) "s\n", &addr, &type, name);
 	if (rc != 3) {
-		if (rc != EOF && fgets(name, 500, in) == NULL)
+		if (rc != EOF && fgets(name, KSYM_NAME_LEN + 1, in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return NULL;
 	}
-- 
2.35.1

