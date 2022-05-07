Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93AE51E469
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 07:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445725AbiEGFdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 01:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445685AbiEGFa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 01:30:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0939C66AF1;
        Fri,  6 May 2022 22:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A81E3B83A9A;
        Sat,  7 May 2022 05:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74778C385AE;
        Sat,  7 May 2022 05:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651901229;
        bh=D5NURiNHd+2oKxgCiKXrfPLtE93OQ8ngjAq5OQOHbYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bl4Xt0QAzmdSu5f0xLJ6iSATCnV7fC8ymXN2+ZwR8SImSDO5E508ScSrTXvWs7xw4
         zLapgdl9y4xTvm+XE+8E/xYjnSqT6NXNezVH85kzaoe26Srz3J8We3LwIiAOeVQprg
         nOQUYeQUc6SBxXIOD5qzNTkzrw+UexFFEbcCfr+cG99EIqEPHOzmiJJHtX4ITa/SFf
         JM2iamO7e7ZYKYbOr4UFs+cOn/UKpw8dZvW5u54K+LFAfFdHKXWzgqcbJ3tbsaMnb0
         I6gGUVkiSrpMFNVJUgiFb82O1fFv4CNTrubu9GqIThFjoaSZJf09nuXK8KfAbcx6yE
         btlJHlOjRKh4g==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: [PATCH v6 17/23] scripts: decode_stacktrace: demangle Rust symbols
Date:   Sat,  7 May 2022 07:24:15 +0200
Message-Id: <20220507052451.12890-18-ojeda@kernel.org>
In-Reply-To: <20220507052451.12890-1-ojeda@kernel.org>
References: <20220507052451.12890-1-ojeda@kernel.org>
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
2.35.3

