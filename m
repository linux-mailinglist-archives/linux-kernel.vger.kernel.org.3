Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905EB530779
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352215AbiEWCFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352705AbiEWCEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:04:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA20393EE;
        Sun, 22 May 2022 19:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD01160F55;
        Mon, 23 May 2022 02:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C522C385AA;
        Mon, 23 May 2022 02:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653271446;
        bh=/8UpaMSYs61DMNlz4chI/v1lHncBMbdLeSx/dxrI6ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zayvx34RpsBhHG4F+cOf2NnpgS3Ath1NRW+5/ZKN8n6XC/rEqxEFGdpu093d43ga7
         Pj9BNQrM38cHLxDpZ+DZxNqYE+2XUazOM9a3M3UIOyGgQNOUroQipoYC+gAlB3K6nr
         yysK9p7ejieK9FsXJ4I2+b0rgSPpbgqfg0rJutwQk7FEdcqNO5SfiojN6TlWSoCdUI
         QxMcO+H21kdST1bjJs2DRv+TCi+sIcj+mnsq2CepM6L1NdBkyDWmjdeU37F80PD388
         q0Ki6tAzRPPlJfHSlJU10hU0p1/uc3wfq9xPZOThsw6YHP3CIFtUosLsibxqCWMjm6
         fX16UQQ4B23nQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v7 15/25] scripts: checkpatch: diagnose uses of `%pA` in the C side
Date:   Mon, 23 May 2022 04:01:28 +0200
Message-Id: <20220523020209.11810-16-ojeda@kernel.org>
In-Reply-To: <20220523020209.11810-1-ojeda@kernel.org>
References: <20220523020209.11810-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `%pA` format specifier is only intended to be used from Rust.

`checkpatch.pl` already gives a warning for invalid specificers:

    WARNING: Invalid vsprintf pointer extension '%pA'

With this change, we introduce an error message with further
explanation:

    ERROR: '%pA' is only intended to be used from Rust code

Suggested-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 577e02998701..457d544b0b9d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6784,6 +6784,10 @@ sub process {
 					my $stat_real = get_stat_real($linenr, $lc);
 					my $ext_type = "Invalid";
 					my $use = "";
+					if ($bad_specifier =~ /pA/) {
+						ERROR("VSPRINTF_RUST",
+							"'\%pA' is only intended to be used from Rust code\n" . "$here\n$stat_real\n");
+					}
 					if ($bad_specifier =~ /p[Ff]/) {
 						$use = " - use %pS instead";
 						$use =~ s/pS/ps/ if ($bad_specifier =~ /pf/);
-- 
2.36.1

