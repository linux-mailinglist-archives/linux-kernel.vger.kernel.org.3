Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AED755CDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345737AbiF1M2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345702AbiF1M1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:27:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5368D2610A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:27:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b26so5063299wrc.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ah0oP8sC6vNZQuTz/qBPulazK7fI2h9aJC/x7/uskDM=;
        b=F+++aTM0ybwR/Bl0sF5/dEOKXTjI2ShX7t1I5Sm4yQlplOoVFE4iOA+GI73IGO1PXL
         WqkYFW22m9gfVdotsuTQ0b3EEQTRqi8sMhqdWEV0JOuJESy+8pQGg3J3+OpW+TPKlOye
         9XTW1esExflISvLQ0a32m8iv0zbZFqgrY4uE8bLZEIZCC2TBa6dIQlIedVk/X+p0IcXF
         A6Q5mum9AqxUnA/eC/EBTlmLbbD1okWlTAKbL+4w+HrczGZzxEJwY/llJ2fRWDFsBiqh
         jumrfUZEAqHe1segPsABvvev10/uQECO/1UR8YOXiD0jPWc7D3D2R05eVzDFJr25L6XP
         d8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ah0oP8sC6vNZQuTz/qBPulazK7fI2h9aJC/x7/uskDM=;
        b=wBwBec035MPwyXY3ZUWk/Xne0UJ4/K8LxMk5FBy6ARuSGhHyRPLPu8C1tVuPeZTQrX
         62lH4PBFo+jcnCKOTnkg/OjwAbThB2V1c0cdKozwdBf+uKWSNCw6s3lFv7Jd1H3tTRHJ
         n8Ar6YXyr7foWWTW3cr+qeW3D4mWVrPeZ76D9tc5Abu4Hu7fqJ74QQPAX91fzf030jUf
         IuzwHsqRctY4TaEl6GtHXb/uZ1jwZNRdgAriLuK5JN3LJ+LhJzdjViPD/e1Tjo1VG7PK
         H4LtFpK5OmjmEHJRPpK2B52gePpHIX0wJQoAA4QHiOTVPI1lyU7Kg6lHvh+vZ8IbC/NZ
         bpRQ==
X-Gm-Message-State: AJIora/EuVyULkimNduBQiEAZ33OsUCUCs1cFg2/17qEtXBH1oEh/iHR
        apPbpvRoRcL5TWL+r/PfoZq3EqbdSTSH6T3j
X-Google-Smtp-Source: AGRyM1tpRfy9+i2D7nawV2QAGsEe1pyjn/0o+QUpqSQFKJwVXm90XbyDkYJeE9T7EdG+2lctgXkymw==
X-Received: by 2002:a05:6000:70b:b0:21b:a816:85c6 with SMTP id bs11-20020a056000070b00b0021ba81685c6mr16857540wrb.639.1656419268787;
        Tue, 28 Jun 2022 05:27:48 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id ay36-20020a05600c1e2400b0039746638d6esm17184212wmb.33.2022.06.28.05.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:27:46 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clang-tools: Generate clang compatible output even with gcc builds
Date:   Tue, 28 Jun 2022 13:27:39 +0100
Message-Id: <20220628122741.93641-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628122741.93641-1-daniel.thompson@linaro.org>
References: <20220628122741.93641-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently `make compile_commands.json` cannot produce useful output for
kernels built with gcc. That is because kbuild will opportunistically
enable gcc-specific command line options from recent versions of gcc.
Options that are not compatible with clang cause trouble because most of
the tools that consume compile_commands.json only understand the clang
argument set. This is to be expected since it was the clang folks wrote
the spec to help make those tools come alive (and AFAIK all the tools
that consume the compilation database are closely linked to the clang
tools):
https://clang.llvm.org/docs/JSONCompilationDatabase.html

Let's fix this by adding code to gen_compile_commands.py that will
automatically strip not-supported-by-clang command line options from
the compilation database. This allows the common consumers of the
compilation database (clang-tidy, clangd code completion engine,
CodeChecker, etc) to work without requiring the developer to build the
kernel using a different C compiler.

In theory this could cause problems if/when a not-based-on-clang tool
emerges that reuses the clang compilation database format. This is not
expected to be a problem in practice since the heuristics added to
gen_compile_commands.py are pretty conservative. The should only ever
disable some rather esoteric compiler options ("they must be esoteric
otherwise clang would have implemented them..."). It is hard to reason
about what will/won't break tools that are not yet written but we can
hope the removing esoteric options will be benign!

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 Makefile                                    |  5 +-
 scripts/clang-tools/gen_compile_commands.py | 71 ++++++++++++++++++++-
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 513c1fbf7888..9ea6867aaf9c 100644
--- a/Makefile
+++ b/Makefile
@@ -1886,8 +1886,11 @@ nsdeps: modules
 # Clang Tooling
 # ---------------------------------------------------------------------------
 
+ifdef CONFIG_CC_IS_GCC
+gen_compile_commands-flags += --gcc
+endif
 quiet_cmd_gen_compile_commands = GEN     $@
-      cmd_gen_compile_commands = $(PYTHON3) $< -a $(AR) -o $@ $(filter-out $<, $(real-prereqs))
+      cmd_gen_compile_commands = $(PYTHON3) $< $(gen_compile_commands-flags) -a $(AR) -o $@ $(filter-out $<, $(real-prereqs))
 
 $(extmod_prefix)compile_commands.json: scripts/clang-tools/gen_compile_commands.py \
 	$(if $(KBUILD_EXTMOD),,$(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)) \
diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index 1d1bde1fd45e..02f6a1408968 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -56,6 +56,9 @@ def parse_arguments():
     ar_help = 'command used for parsing .a archives'
     parser.add_argument('-a', '--ar', type=str, default='llvm-ar', help=ar_help)
 
+    gcc_help = 'tidy up gcc invocations to work with clang'
+    parser.add_argument('-g', '--gcc', action='store_true', help=gcc_help)
+
     paths_help = ('directories to search or files to parse '
                   '(files should be *.o, *.a, or modules.order). '
                   'If nothing is specified, the current directory is searched')
@@ -67,6 +70,7 @@ def parse_arguments():
             os.path.abspath(args.directory),
             args.output,
             args.ar,
+            args.gcc,
             args.paths if len(args.paths) > 0 else [args.directory])
 
 
@@ -196,10 +200,73 @@ def process_line(root_directory, command_prefix, file_path):
         'command': prefix + file_path,
     }
 
+clang_options = {}
+
+def check_clang_compatibility(target, flag):
+    """Check that the supplied flag does not cause clang to return an error.
+
+    The results of the check, which is expensive if repeated many times, is
+    cached in the clang_options variable and reused in subsequent calls.
+    """
+    global clang_options
+    if flag in clang_options:
+        return clang_options[flag]
+
+    c = 'echo "int f;"| clang {} {} - -E > /dev/null 2>&1'.format(target, flag)
+    rc = os.system(c)
+    compatible = rc == 0
+    clang_options[flag] = compatible
+    if not compatible:
+        logging.info('Not supported by clang: %s', flag)
+
+    return compatible
+
+def make_clang_compatible(entry):
+    """Scans and transforms the command line options to make the invocation
+    compatible with clang.
+
+    There are two main heuristics:
+
+    1. Use the gcc compiler prefix to populate the clang --target variable
+       (which is needed for cross-compiles to work correctly)
+
+    2. Scan for any -f or -m options that are not supported by clang and
+       discard them.
+
+    This allows us to use clang tools on our kernel builds even if we built the
+    kernel using gcc.
+    """
+    newcmd = []
+    target = ''
+
+    # Splitting the command line like this isn't going to handle quoted
+    # strings transparently. However assuming the quoted string does not
+    # contain tabs, double spaces or words commencing with '-f' or '-c'
+    # (which is fairly reasonable) then this simple approach will be
+    # sufficient.
+    atoms = entry['command'].split()
+
+    # Use the compiler prefix as the clang --target variable
+    if atoms[0].endswith('-gcc'):
+        target = '--target=' + os.path.basename(atoms[0][:-4])
+        newcmd.append(atoms[0])
+        newcmd.append(target)
+        del atoms[0]
+
+    # Drop incompatible flags that provoke fatal errors for clang. Note that
+    # unsupported -Wenable-warning flags are not fatal so we don't have to
+    # worry about those.
+    for atom in atoms:
+        if atom.startswith('-f') or atom.startswith('-m'):
+            if not check_clang_compatibility(target, atom):
+                continue
+        newcmd.append(atom)
+
+    entry['command'] = ' '.join(newcmd)
 
 def main():
     """Walks through the directory and finds and parses .cmd files."""
-    log_level, directory, output, ar, paths = parse_arguments()
+    log_level, directory, output, ar, gcc, paths = parse_arguments()
 
     level = getattr(logging, log_level)
     logging.basicConfig(format='%(levelname)s: %(message)s', level=level)
@@ -232,6 +299,8 @@ def main():
                     try:
                         entry = process_line(directory, result.group(1),
                                              result.group(2))
+                        if gcc:
+                            make_clang_compatible(entry)
                         compile_commands.append(entry)
                     except ValueError as err:
                         logging.info('Could not add line from %s: %s',
-- 
2.35.1

