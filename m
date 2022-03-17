Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC46B4DCD56
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbiCQSOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbiCQSOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:14:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54812220FD1;
        Thu, 17 Mar 2022 11:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BDA96168D;
        Thu, 17 Mar 2022 18:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC441C340E9;
        Thu, 17 Mar 2022 18:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647540738;
        bh=eQW2ATffmvkt9gCu0ENmX99Cst240SX3xWPmhSKl83M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4PTAJb5T6l/Dni/ESRCNfw6Z6FnsJhXtdSM2mkYhVh6uH77yAzySyUVUnz56G2FA
         ZfBpTDUTf6g9FQjBD5VKHIy5gIE52VkBd3MtAeaMxIUxGfUnzqnvQJvZFvlSx+62hn
         fLHkEvN+7+3lEu+++xXt0kQ5IXGiR4WcsHj9epC/gkoQbHx3ESaVm2/sp+cbUrbi4j
         EH/QGcN1VWqOzvFGM19/N4gWvDTZqpmegcbWTjYvTJ0zkgLs0nznS88Mvu87ClLTFh
         E1CWIfkph/9+gwLaVGL0TyRQEzknqbnlgHCUNjAaHAlgztTd+CaCo7XIiBaGbgy/DP
         rgWJ6OtYZrpVQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v5 14/20] scripts: decode_stacktrace: demangle Rust symbols
Date:   Thu, 17 Mar 2022 19:10:02 +0100
Message-Id: <20220317181032.15436-15-ojeda@kernel.org>
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

Recent versions of both Binutils (`c++filt`) and LLVM (`llvm-cxxfilt`)
provide Rust v0 mangling support.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
I would like to use this patch for discussing the demangling topic.

The following discusses the different approaches we could take.


# Leave demangling to userspace

This is the easiest and less invasive approach, the one implemented
by this patch.

The `decode_stacktrace.sh` script is already needed to map
the offsets to the source code. Therefore, we could also take
the chance to demangle the symbols here.

With this approach, we do not need to introduce any change in the
`vsprintf` machinery and we minimize the risk of breaking user tools.

Note that, if we take this approach, it is likely we want to ask
for a minimum version of either of the tools (since there may be
users of the script that do not have recent enough toolchains).


# Demangling in kernelspace on-the-fly

That is, at backtrace print time, we demangle the Rust symbols.

The size of the code that would be needed is fairly small; around
5 KiB using the "official" library (written in Rust), e.g.:

    text    data    bss     dec      hex    filename
    7799976 1689820 2129920 11619716 b14d84 vmlinux
    7801111 1693916 2129920 11624947 b161f3 vmlinux + demangling

We can remove a few bits from the official library, e.g. punycode
support that we do not need (all our identifiers will be ASCII),
but it does not make a substantial difference.

The official library performs the demangling without requiring
allocations. However, of course, it will increased our stack usage
and complexity, specially considering a stack dump may be requested
in not ideal conditions.

Furthermore, this approach (and the ones below) likely require adding
a new `%p` specifier (or a new modifier to existing ones) if we do
not want to affect non-backtrace uses of the `B`/`S` ones. Also,
it is unclear whether we should write the demangled versions in an
extra, different line or replace the real symbol -- we could be
breaking user tools relying on parsing backtraces (e.g. our own
`decode_stacktrace.sh`). For instance, they could be relying on
having real symbols there, or may break due to e.g. spaces.


# Demangling at compile-time

This implies having kallsyms demangle all the Rust symbols.

The size of this data is around the same order of magnitude of the
non-demangled ones. However, this is notably more than the demangling
code (see previous point), e.g. 120 KiB (uncompressed) in a
small kernel.

This approach also brings the same concerns regarding modifying
the backtrace printing (see previous point).


# Demangling at compile-time and substituting symbols by hashes

One variation of the previous alternative is avoiding the mangled
names inside the kernel, by hashing them. This would avoid having
to support "big symbols" and would also reduce the size of the
kallsyms tables, while still allowing to link modules.

However, if we do not have the real symbols around, then we do not
have the possibility of providing both the mangled and demangled
versions in the backtrace, which brings us back to the issues
related to breaking userspace tools. There are also other places
other than backtraces using "real" symbols that users may be
relying on, such as `/proc/*/stack`.

 scripts/decode_stacktrace.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 5fbad61fe490..f3c7b506d440 100755
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
@@ -169,6 +177,12 @@ parse_symbol() {
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
2.35.1

