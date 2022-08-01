Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F207586B39
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiHAMr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiHAMrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:47:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0655CDFA5;
        Mon,  1 Aug 2022 05:38:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99CD161187;
        Mon,  1 Aug 2022 12:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D09C433D6;
        Mon,  1 Aug 2022 12:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659357506;
        bh=ajvGSPHi7s/PBQgVUp/8yoUUDSIpjZEtd1Glw97tgok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZqIFqp6ijlSg1qyppx2Fo88DBX5AjZ8nURUeKSHoMpq21YlZ1unVYRHs7SLgghi1
         i8NPoy2+GfVXxEy8Je4XK6rvIHbAia+NerbUIhE8fskKOWgCT95WWTjpKyGHwrhib+
         1n8m1iPVNHelMtDPev6Pm9hNeGzB4dEbSkgYCBaYMV2sPUp/G0Fxzi4IB6pj+d0VLj
         azCA2DC00t9SAU+UsLOf5+UNJjO9O8eMFwe2AFCiGpZ+4inWPaKOKlcxArl1/S/njJ
         A00YT4u4N3ggjt44jFO3IiW7snAZwBWLTtnce9I05gXNz4pQAnWelMekkVx+LWv/1A
         ZASDM6VztVdTw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 523AB40736; Mon,  1 Aug 2022 09:38:23 -0300 (-03)
Date:   Mon, 1 Aug 2022 09:38:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf symbol: Fail to read phdr workaround
Message-ID: <YufJP5YqeEBM51HL@kernel.org>
References: <20220731164923.691193-1-irogers@google.com>
 <20220801015259.GA101027@leoy-ThinkPad-X240s>
 <CAP-5=fVSjCQ4jeAeyP5THnQVyXDpKd6Ob33C7PDwFB_6+YSXuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVSjCQ4jeAeyP5THnQVyXDpKd6Ob33C7PDwFB_6+YSXuw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_HEX autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 31, 2022 at 11:19:15PM -0700, Ian Rogers escreveu:
> On Sun, Jul 31, 2022, 6:53 PM Leo Yan <leo.yan@linaro.org> wrote:
> 
> > On Sun, Jul 31, 2022 at 09:49:23AM -0700, Ian Rogers wrote:
> > > The perf jvmti agent doesn't create program headers, in this case
> > > fallback on section headers as happened previously.
> > >
> > > Fixes: 882528d2e776 ("perf symbol: Skip symbols if SHF_ALLOC flag is not
> > set")
> >
> > It's good to change fix tag as:
> > Fixes: 2d86612aacb7 ("perf symbol: Correct address for bss symbols")
> >
> 
> Doh! I was rushing this morning. Thanks for catching and reviewing!

I made the adjustments and added a note with the repro, to help in the
future when trying to test this area.

I also think we could have something like a 'perf test' mode where, when
asked to, it would enable tests that involve downloading such files to
perform tests, such as this dacapo benchmark, and then would test if the
output matches expectations.

- Arnaldo

commit 6d518ac7be6223811ab947897273b1bbef846180
Author: Ian Rogers <irogers@google.com>
Date:   Sun Jul 31 09:49:23 2022 -0700

    perf symbol: Fail to read phdr workaround
    
    The perf jvmti agent doesn't create program headers, in this case
    fallback on section headers as happened previously.
    
    Committer notes:
    
    To test this, from a public post by Ian:
    
    1) download a Java workload dacapo-9.12-MR1-bach.jar from
    https://sourceforge.net/projects/dacapobench/
    
    2) build perf such as "make -C tools/perf O=/tmp/perf NO_LIBBFD=1" it
    should detect Java and create /tmp/perf/libperf-jvmti.so
    
    3) run perf with the jvmti agent:
    
      perf record -k 1 java -agentpath:/tmp/perf/libperf-jvmti.so -jar dacapo-9.12-MR1-bach.jar -n 10 fop
    
    4) run perf inject:
    
      perf inject -i perf.data -o perf-injected.data -j
    
    5) run perf report
    
      perf report -i perf-injected.data | grep org.apache.fop
    
    With this patch reverted I see lots of symbols like:
    
         0.00%  java             jitted-388040-4656.so  [.] org.apache.fop.fo.FObj.bind(org.apache.fop.fo.PropertyList)
    
    With the patch (2d86612aacb7805f ("perf symbol: Correct address for bss
    symbols")) I see lots of:
    
      dso__load_sym_internal: failed to find program header for symbol:
      Lorg/apache/fop/fo/FObj;bind(Lorg/apache/fop/fo/PropertyList;)V
      st_value: 0x40
    
    Fixes: 2d86612aacb7805f ("perf symbol: Correct address for bss symbols")
    Reviewed-by: Leo Yan <leo.yan@linaro.org>
    Signed-off-by: Ian Rogers <irogers@google.com>
    Tested-by: Leo Yan <leo.yan@linaro.org>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Leo Yan <leo.yan@linaro.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stephane Eranian <eranian@google.com>
    Link: http://lore.kernel.org/lkml/20220731164923.691193-1-irogers@google.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index b3be5b1d9dbb00bc..75bec32d4f571319 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1305,16 +1305,29 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 
 			if (elf_read_program_header(syms_ss->elf,
 						    (u64)sym.st_value, &phdr)) {
-				pr_warning("%s: failed to find program header for "
+				pr_debug4("%s: failed to find program header for "
 					   "symbol: %s st_value: %#" PRIx64 "\n",
 					   __func__, elf_name, (u64)sym.st_value);
-				continue;
+				pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
+					"sh_addr: %#" PRIx64 " sh_offset: %#" PRIx64 "\n",
+					__func__, (u64)sym.st_value, (u64)shdr.sh_addr,
+					(u64)shdr.sh_offset);
+				/*
+				 * Fail to find program header, let's rollback
+				 * to use shdr.sh_addr and shdr.sh_offset to
+				 * calibrate symbol's file address, though this
+				 * is not necessary for normal C ELF file, we
+				 * still need to handle java JIT symbols in this
+				 * case.
+				 */
+				sym.st_value -= shdr.sh_addr - shdr.sh_offset;
+			} else {
+				pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
+					"p_vaddr: %#" PRIx64 " p_offset: %#" PRIx64 "\n",
+					__func__, (u64)sym.st_value, (u64)phdr.p_vaddr,
+					(u64)phdr.p_offset);
+				sym.st_value -= phdr.p_vaddr - phdr.p_offset;
 			}
-			pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
-				  "p_vaddr: %#" PRIx64 " p_offset: %#" PRIx64 "\n",
-				  __func__, (u64)sym.st_value, (u64)phdr.p_vaddr,
-				  (u64)phdr.p_offset);
-			sym.st_value -= phdr.p_vaddr - phdr.p_offset;
 		}
 
 		demangled = demangle_sym(dso, kmodule, elf_name);
