Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE48587550
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiHBBzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbiHBByy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:54:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C2A48CA4;
        Mon,  1 Aug 2022 18:53:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C2BD7CE19F4;
        Tue,  2 Aug 2022 01:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F69C433D7;
        Tue,  2 Aug 2022 01:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405202;
        bh=NuOpRdMsihtMLYOwhaS3C4UEtVr+be11RVn2cwjc27A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8B0Rnx5hiPLbSQoil8jKzXGRaRTnT8LMR36JCM47QXX1Ycf4AmUmgZdAiE+oV1D3
         o4p5tpjKvbuIxvWblx+XLusOwnoMU6JVRIQeGkHMDX7LDIKgYgCp8SdvuisfDOAcHI
         /K2RzIhggO2YLXfENgxZqpouWFDB5+RNR1Tf24TW6np5BTFSNusinvIZd8My4lONp9
         SWViyeJwWFo86tWZWFMvYJrTd05pVn+TFyzn7AVIYFadgj9MKTzf+yRbEiYyc9O3IT
         dOQ5kkp0mkxS32epGd7W7pL6UdRODLdr8vuOSssLVHbsHfujhuZmldPwtkSpgM4U97
         zQVwM3n+zstIw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v8 24/31] scripts: decode_stacktrace: demangle Rust symbols
Date:   Tue,  2 Aug 2022 03:50:11 +0200
Message-Id: <20220802015052.10452-25-ojeda@kernel.org>
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

Recent versions of both Binutils (`c++filt`) and LLVM (`llvm-cxxfilt`)
provide Rust v0 mangling support.

Reviewed-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/decode_stacktrace.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 7075e26ab2c4..564c5632e1a2 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -8,6 +8,14 @@ usage() {
 	echo "	$0 -r <release> | <vmlinux> [<base path>|auto] [<modules path>]"
 }
 
+# Try to find a Rust demangler
+if type llvm-cxxfilt >/dev/null 2>&1 ; then
+	cppfilt=llvm-cxxfilt
+elif type c++filt >/dev/null 2>&1 ; then
+	cppfilt=c++filt
+	cppfilt_opts=-i
+fi
+
 if [[ $1 == "-r" ]] ; then
 	vmlinux=""
 	basepath="auto"
@@ -180,6 +188,12 @@ parse_symbol() {
 	# In the case of inlines, move everything to same line
 	code=${code//$'\n'/' '}
 
+	# Demangle if the name looks like a Rust symbol and if
+	# we got a Rust demangler
+	if [[ $name =~ ^_R && $cppfilt != "" ]] ; then
+		name=$("$cppfilt" "$cppfilt_opts" "$name")
+	fi
+
 	# Replace old address with pretty line numbers
 	symbol="$segment$name ($code)"
 }
-- 
2.37.1

