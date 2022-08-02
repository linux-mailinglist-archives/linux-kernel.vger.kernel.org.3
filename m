Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDA558754B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235766AbiHBBzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbiHBBx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355724B0D5;
        Mon,  1 Aug 2022 18:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7D4F6106F;
        Tue,  2 Aug 2022 01:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D62C433D6;
        Tue,  2 Aug 2022 01:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405188;
        bh=FzcxabaZhSQ69xBMAwnH2bzRNcykHT1NhBRq2p1N3ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bT7r0rS66XSpWMdO0B6TKWtlShJeFO7LPSLKtMp9cChYXGq15fzk4esB6Q/60zf6A
         LNmcYrcajSADLWhRtoF9thhYQftiwq/MJMhd9p+10zsVKqCZWm6MPmaucfJysRg6f+
         NpB1Gs5+i+eQCx3ug0EpjXofXATz8o6ZHjidfyaLw4+4Q46BYNTlotfalbPPqODOnK
         9TLhXKFKY0ep4ZmSktd1Qqto4m6Xg6Bk5oXh3LLRYtF0bSOW1TROJrYv6gwBTQJTR+
         HOqMyq9IzQO8gk3+N/afKBOaboK13B2/m8x0qUWfW7KZKUE8nykJb4ImMl/DcVnAYi
         12h4zpY0H9rCQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v8 20/31] scripts: checkpatch: diagnose uses of `%pA` in the C side as errors
Date:   Tue,  2 Aug 2022 03:50:07 +0200
Message-Id: <20220802015052.10452-21-ojeda@kernel.org>
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

The `%pA` format specifier is only intended to be used from Rust.

`checkpatch.pl` already gives a warning for invalid specificers:

    WARNING: Invalid vsprintf pointer extension '%pA'

This makes it an error and introduces an explanatory message:

    ERROR: Invalid vsprintf pointer extension '%pA' - '%pA' is only intended to be used from Rust code

Suggested-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Joe Perches <joe@perches.com>
Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/checkpatch.pl | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 503e8abbb2c1..23799e8013b3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6782,15 +6782,19 @@ sub process {
 				}
 				if ($bad_specifier ne "") {
 					my $stat_real = get_stat_real($linenr, $lc);
+					my $msg_level = \&WARN;
 					my $ext_type = "Invalid";
 					my $use = "";
 					if ($bad_specifier =~ /p[Ff]/) {
 						$use = " - use %pS instead";
 						$use =~ s/pS/ps/ if ($bad_specifier =~ /pf/);
+					} elsif ($bad_specifier =~ /pA/) {
+						$use =  " - '%pA' is only intended to be used from Rust code";
+						$msg_level = \&ERROR;
 					}
 
-					WARN("VSPRINTF_POINTER_EXTENSION",
-					     "$ext_type vsprintf pointer extension '$bad_specifier'$use\n" . "$here\n$stat_real\n");
+					&{$msg_level}("VSPRINTF_POINTER_EXTENSION",
+						      "$ext_type vsprintf pointer extension '$bad_specifier'$use\n" . "$here\n$stat_real\n");
 				}
 			}
 		}
-- 
2.37.1

