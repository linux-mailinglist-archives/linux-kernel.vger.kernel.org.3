Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930A7587532
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiHBBvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiHBBvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:51:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6462CC93;
        Mon,  1 Aug 2022 18:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED3356109E;
        Tue,  2 Aug 2022 01:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97680C433D7;
        Tue,  2 Aug 2022 01:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405097;
        bh=J1kZYuBmy2p9V5rJr5cWhtju3zoN163Uf1mW1Uq9geI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5AxP4mf4Iu3qEUZfXedzNz44vtyOofAn711pkzt4+DjVe7y+vBnBYB3ORnEwewTF
         g3JZIrZlG3+/r2GsZvkertUOTRHDQ4xpq9HwC/vFTUEed/ddDdupy3AaRdzQOM61B2
         25K+ibXl/MR3xk6VK/o4djWkFi28TRcZAzAvtcJvGrHvMyc23FKW4m9ff9eJ2UzeG+
         Cy5YwMvZ91HS5JGrOyDm5Fm65OEu3Hidy7UU7iQOwRV8HTE0WKwHkuXrCqqjGj99HT
         K1wKSGiNfA4RcYSvVE7yF+H211jM2NBf9jhKo1ck3+tCaES7gO+PANehJDpHbeYeyk
         wJZDNAJyKXMXA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v8 03/31] kallsyms: add static relationship between `KSYM_NAME_LEN{,_BUFFER}`
Date:   Tue,  2 Aug 2022 03:49:50 +0200
Message-Id: <20220802015052.10452-4-ojeda@kernel.org>
In-Reply-To: <20220802015052.10452-1-ojeda@kernel.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a static assert to ensure `KSYM_NAME_LEN_BUFFER`
gets updated when `KSYM_NAME_LEN` changes.

The relationship used is one that keeps the new size (512+1)
close to the original buffer size (500).

Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/kallsyms.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f3c5a2623f71..f543b1c4f99f 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -33,7 +33,11 @@
 #define KSYM_NAME_LEN		128
 
 /* A substantially bigger size than the current maximum. */
-#define KSYM_NAME_LEN_BUFFER	499
+#define KSYM_NAME_LEN_BUFFER	512
+_Static_assert(
+	KSYM_NAME_LEN_BUFFER == KSYM_NAME_LEN * 4,
+	"Please keep KSYM_NAME_LEN_BUFFER in sync with KSYM_NAME_LEN"
+);
 
 struct sym_entry {
 	unsigned long long addr;
-- 
2.37.1

