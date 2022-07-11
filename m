Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D9F570808
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiGKQJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiGKQJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:09:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700E172EFA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:09:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h17so7703362wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oBvw4ZC9v7NRgSQxXD0TtpEyHB//5Lm16tq7nct2k0g=;
        b=CNPuDJR4PqpWKKKn01Uj9NuFLQjTyS1ToWLKr6/rI2roZYQmpaXpsVXN25WD5WfOTc
         DWHTTQd1GD3PgjT5f2ceKTxKV+5vJCVippo3MIgfC3p9vh7ILip+N6pcHT2g0NDT9IfS
         srckuEtfLLDOoykg7MhROYrmXB8DZT73C3j0qWSWzeE0W05reIb2O09/jnSUposZOCwt
         9jN/RDf/8xYejI43yeajRctAmcGaYzd6WrBSyrlJsRqeRf8X9CJ+Al3QZwKym5bFLNfw
         yEs804/n1gOj7OjQnOQDgOxKD1OY5VAbsABOUpuvrkGosqx9TNlnqu1mxKgifYYiCAkR
         QNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBvw4ZC9v7NRgSQxXD0TtpEyHB//5Lm16tq7nct2k0g=;
        b=BnwRNigY41O8O88lIpTYhG1GpxBE3bk8r2pAvAcB51OpV8RRT0PyYjkigOEmAMzih2
         cweyTMzg90YmtdEfgAXLIJDL2lVnm7CBqKuD3U1/2OAweDs0L1ycfhG+ipoIeUD0Gp41
         LtExhuU3IPEWD3hCp0ZDXl+fB6Sy9OeIibAHrS620AnOLOKYaTum+LR8DoD7o5BX47Nq
         DO1E/tQJ9vnmcKlTGCAtQRC9s0VqSnedHBFap4oB+De1JvjE+yUUPrhiY8bEe31ncxpQ
         l8TshHKNgkV+bVLOF989vYBWJVVlmy9r5OaOYVzhVWTsJrHc1rHyuXMBJA8syXouaMbS
         EuUw==
X-Gm-Message-State: AJIora9euuMTzsELJSnrqbuLuePJpQM2ywxdXaf1aNgrwnXDv9OtYsek
        QrYQI0RBIKj1fezJjny3UIK1GlgHmQEOIBKjirskuCP2j1I=
X-Google-Smtp-Source: AGRyM1sNJRo+XQx4nvetShl5Vbk7XLUjf19aGTDkXUZ6nL5Ers8QR4ycj57WxYsV7SnRe5GFuegugU0Eo3uGCtjTyC0=
X-Received: by 2002:a5d:4d8e:0:b0:21d:68d4:56eb with SMTP id
 b14-20020a5d4d8e000000b0021d68d456ebmr16934840wru.40.1657555789787; Mon, 11
 Jul 2022 09:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220710012204.2390293-1-leo.yan@linaro.org>
In-Reply-To: <20220710012204.2390293-1-leo.yan@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 Jul 2022 09:09:37 -0700
Message-ID: <CAP-5=fX_fT7e9tqDBKXh_1CQ8w80iOXCGz2kJT_nHpY6wYWqmQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf symbol: Correct address for bss symbols
To:     Leo Yan <leo.yan@linaro.org>, Fangrui Song <maskray@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chang Rui <changruinj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 9, 2022 at 6:22 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> When using 'perf mem' and 'perf c2c', an issue is observed that tool
> reports the wrong offset for global data symbols.  This is a common
> issue on both x86 and Arm64 platforms.
>
> Let's see an example, for a test program, below is the disassembly for
> its .bss section which is dumped with objdump:
>
>   ...
>
>   Disassembly of section .data:
>
>   0000000000004000 <__data_start>:
>         ...
>
>   0000000000004008 <__dso_handle>:
>       4008:     08 40 00                or     %al,0x0(%rax)
>       400b:     00 00                   add    %al,(%rax)
>       400d:     00 00                   add    %al,(%rax)
>         ...
>
>   0000000000004010 <wait_to_begin>:
>       4010:     01 00                   add    %eax,(%rax)
>       4012:     00 00                   add    %al,(%rax)
>       4014:     00 00                   add    %al,(%rax)
>         ...
>
>   0000000000004018 <lock_thd_name>:
>       4018:     08 20                   or     %ah,(%rax)
>       401a:     00 00                   add    %al,(%rax)
>       401c:     00 00                   add    %al,(%rax)
>         ...
>
>   0000000000004020 <reader_thd_name>:
>       4020:     10 20                   adc    %ah,(%rax)
>       4022:     00 00                   add    %al,(%rax)
>       4024:     00 00                   add    %al,(%rax)
>         ...
>
>   Disassembly of section .bss:
>
>   0000000000004040 <completed.0>:
>         ...
>
>   0000000000004080 <buf1>:
>         ...
>
>   00000000000040c0 <buf2>:
>         ...
>
>   0000000000004100 <thread>:
>         ...
>
> First we used 'perf mem record' to run the test program and then used
> 'perf --debug verbose=4 mem report' to observe what's the symbol info
> for 'buf1' and 'buf2' structures.
>
>   # ./perf mem record -e ldlat-loads,ldlat-stores -- false_sharing.exe 8
>   # ./perf --debug verbose=4 mem report
>     ...
>     dso__load_sym_internal: adjusting symbol: st_value: 0x40c0 sh_addr: 0x4040 sh_offset: 0x3028
>     symbol__new: buf2 0x30a8-0x30e8
>     ...
>     dso__load_sym_internal: adjusting symbol: st_value: 0x4080 sh_addr: 0x4040 sh_offset: 0x3028
>     symbol__new: buf1 0x3068-0x30a8
>     ...
>
> Perf tool relies on libelf to parse symbols, here 'st_value' is the
> address from executable file, 'sh_addr' is the belonged section's linked
> start address, and 'sh_offset' is the dynamic loaded address for this
> section, then perf tool uses below formula to adjust symbol address:
>
>   adjusted_address = st_value - sh_addr + sh_offset
>
> So we can see the final adjusted address ranges for buf1 and buf2 are
> [0x30a8-0x30e8) and [0x3068-0x30a8) respectively, apparently this is
> incorrect, in the code, the structure for 'buf1' and 'buf2' specifies
> compiler attribute with 64-byte alignment.
>
> The problem happens for 'sh_offset', libelf returns it as 0x3028 which
> is not 64-byte aligned, on the other hand, we can see both 'st_value'
> and 'sh_addr' are 64-byte aligned.  Combining with disassembly, it's
> likely libelf uses the .data section end address as .bss section
> start address, therefore, it doesn't respect the alignment attribute for
> structures in .bss section.
>
> Since .data and .bss sections are in the continuous virtual address
> space, and .data section info returned by libelf is reliable, to fix
> this issue, if detects it's a bss symbol, it rolls back to use .data
> section info to adjust symbol's virtual address.
>
> Essentially, we need to fix libelf to return correct offsets for
> sections, on the other hand, we live commonly with existed versions of
> libelf.  So we also need this change in perf tool.
>
> Fixes: f17e04afaff8 ("perf report: Fix ELF symbol parsing")
> Reported-by: Chang Rui <changruinj@gmail.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

This looks good to me, I'm happy to add my:
Acked-by: Ian Rogers <irogers@google.com>
I've added Fangrui Song who is more knowledge-able on ELF, libelf,
etc. than me and may have additional thoughts.

Thanks,
Ian

> ---
>  tools/perf/util/dso.h        |  1 +
>  tools/perf/util/symbol-elf.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 3a9fd4d389b5..00f57f4ac6bc 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -180,6 +180,7 @@ struct dso {
>         u8               rel;
>         struct build_id  bid;
>         u64              text_offset;
> +       int              data_sec_index;
>         const char       *short_name;
>         const char       *long_name;
>         u16              long_name_len;
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index ecd377938eea..ed65dd26d58e 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1095,6 +1095,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>         Elf *elf;
>         int nr = 0;
>         bool remap_kernel = false, adjust_kernel_syms = false;
> +       size_t sec_index;
>
>         if (kmap && !kmaps)
>                 return -1;
> @@ -1113,6 +1114,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>                                 ".text", NULL))
>                 dso->text_offset = tshdr.sh_addr - tshdr.sh_offset;
>
> +       if (elf_section_by_name(runtime_ss->elf, &runtime_ss->ehdr, &tshdr,
> +                               ".data", &sec_index))
> +               dso->data_sec_index = sec_index;
> +
>         if (runtime_ss->opdsec)
>                 opddata = elf_rawdata(runtime_ss->opdsec, NULL);
>
> @@ -1227,6 +1232,27 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>
>                 gelf_getshdr(sec, &shdr);
>
> +               /*
> +                * When the first data structure in .bss section is attributed
> +                * with alignment (e.g. 64-byte aligned), libelf doesn't reflect
> +                * the alignment in the 'shdr.sh_offset' field, at the end the
> +                * field is filled with the end loading address of a prior
> +                * section rather than the aligned address of .bss section.
> +                * This leads to mess for later parsing .bss symbols.
> +                *
> +                * Since .data and .bss sections are in the continuous virtual
> +                * address space, and .data section's info is reliable.  So if
> +                * detects it's a bss symbol, we retrieve .data section info
> +                * for adjusting address.
> +                */
> +               if (!strcmp(elf_sec__name(&shdr, secstrs_sym), ".bss")) {
> +                       sec = elf_getscn(syms_ss->elf, dso->data_sec_index);
> +                       if (!sec)
> +                               goto out_elf_end;
> +
> +                       gelf_getshdr(sec, &shdr);
> +               }
> +
>                 secstrs = secstrs_sym;
>
>                 /*
> --
> 2.25.1
>
