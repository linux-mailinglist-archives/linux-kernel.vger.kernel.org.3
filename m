Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F525708D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiGKR1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGKR1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:27:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65EE5C97F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:27:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l12so4986159plk.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WcvhCKti2055EmbLZjAJ5wRJ0YEDhf7c61xLVsqRjBI=;
        b=WYOkGsJLMRHvHD5G03oUcaGbojV1/jsrNMdAXHuamvZA6gwtJ6Pt7PmGXUmsOkO2ro
         hk5RXex8He+1mZ5WmuTKx4uhgtamA7VOO0h06l6Cj4vp5JqMkjPcICY9Z81SzPyMC0ti
         ZrNu7vFPTYmKJETiOEC/G9gnDy5kOKzJtxiKvs5X4DqJnU/0GU5WK/nZ0Jkj/NKnzGd9
         5Okcr5KCSIklGKh29VmSsL7dtlzZ3BzfjiGohsHpEr23mnBeTPJaFOpRwyJUmR8RhPnB
         VFfOTR1Gekxq8cusTkhkqp4uKYIP1ADGUEfBJQzIhtN3DjBGnAq44ptSwO30hoLZGpK1
         r36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WcvhCKti2055EmbLZjAJ5wRJ0YEDhf7c61xLVsqRjBI=;
        b=LmFbWp0a4vYUvAtZ6XIubHQcVMq1qGOh3Amvoxnr7TqiX0t/F8EDx2uC1gN7SlTy/L
         sx68UYdJDdOW6YWXYXx9/sDtd3T3C9j7Uz05vD/cyD8nVKEjGlL+KE+9L5j2/6PVKL7o
         8dN677f+507tD8Lmw3ov7Bhbt9PUjsaUtMyujeR2Vo/qtjG+rDb1bF/lhNr0drDmmVdt
         UGDcK74Zp5+q2kDpzHSim7/oDbzx19xpzL8zrXqqfqwPTHJ6xeJjX7Yjv/niZXg/ut9X
         l12xc155xpH25zFtvQP6ikprSzutYwhX1115SjPiBaNSkY4z9oetiVLu2tGtp1UxFPLj
         kUNQ==
X-Gm-Message-State: AJIora/8omBH8g/c0jNlof9tKy9WL+AesLiGqHXSjE07QKQMUaEVRDug
        4L+CauDRvHgFp83UIn2t8BDCtg==
X-Google-Smtp-Source: AGRyM1uUaucU50mPOjuv2B4dz98Z4bcnKuU/J0EIGrQk2bw8GbapVJ7+sXIizZgG7Cx519/ySEFmww==
X-Received: by 2002:a17:90b:33ce:b0:1ef:e5f4:f8e2 with SMTP id lk14-20020a17090b33ce00b001efe5f4f8e2mr19571588pjb.70.1657560431115;
        Mon, 11 Jul 2022 10:27:11 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:bbec:e06d:b778:f9bc])
        by smtp.gmail.com with ESMTPSA id x5-20020a623105000000b005289ef6db79sm5012448pfx.32.2022.07.11.10.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:27:10 -0700 (PDT)
Date:   Mon, 11 Jul 2022 10:27:06 -0700
From:   Fangrui Song <maskray@google.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chang Rui <changruinj@gmail.com>
Subject: Re: [RFC PATCH v1] perf symbol: Correct address for bss symbols
Message-ID: <20220711172706.rtfd6pp2pochmdre@google.com>
References: <20220710012204.2390293-1-leo.yan@linaro.org>
 <CAP-5=fX_fT7e9tqDBKXh_1CQ8w80iOXCGz2kJT_nHpY6wYWqmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAP-5=fX_fT7e9tqDBKXh_1CQ8w80iOXCGz2kJT_nHpY6wYWqmQ@mail.gmail.com>
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

On 2022-07-11, Ian Rogers wrote:
>On Sat, Jul 9, 2022 at 6:22 PM Leo Yan <leo.yan@linaro.org> wrote:
>>
>> When using 'perf mem' and 'perf c2c', an issue is observed that tool
>> reports the wrong offset for global data symbols.  This is a common
>> issue on both x86 and Arm64 platforms.
>>
>> Let's see an example, for a test program, below is the disassembly for
>> its .bss section which is dumped with objdump:
>>
>>   ...
>>
>>   Disassembly of section .data:
>>
>>   0000000000004000 <__data_start>:
>>         ...
>>
>>   0000000000004008 <__dso_handle>:
>>       4008:     08 40 00                or     %al,0x0(%rax)
>>       400b:     00 00                   add    %al,(%rax)
>>       400d:     00 00                   add    %al,(%rax)
>>         ...
>>
>>   0000000000004010 <wait_to_begin>:
>>       4010:     01 00                   add    %eax,(%rax)
>>       4012:     00 00                   add    %al,(%rax)
>>       4014:     00 00                   add    %al,(%rax)
>>         ...
>>
>>   0000000000004018 <lock_thd_name>:
>>       4018:     08 20                   or     %ah,(%rax)
>>       401a:     00 00                   add    %al,(%rax)
>>       401c:     00 00                   add    %al,(%rax)
>>         ...
>>
>>   0000000000004020 <reader_thd_name>:
>>       4020:     10 20                   adc    %ah,(%rax)
>>       4022:     00 00                   add    %al,(%rax)
>>       4024:     00 00                   add    %al,(%rax)
>>         ...
>>
>>   Disassembly of section .bss:
>>
>>   0000000000004040 <completed.0>:
>>         ...
>>
>>   0000000000004080 <buf1>:
>>         ...
>>
>>   00000000000040c0 <buf2>:
>>         ...
>>
>>   0000000000004100 <thread>:
>>         ...
>>
>> First we used 'perf mem record' to run the test program and then used
>> 'perf --debug verbose=4 mem report' to observe what's the symbol info
>> for 'buf1' and 'buf2' structures.
>>
>>   # ./perf mem record -e ldlat-loads,ldlat-stores -- false_sharing.exe 8
>>   # ./perf --debug verbose=4 mem report
>>     ...
>>     dso__load_sym_internal: adjusting symbol: st_value: 0x40c0 sh_addr: 0x4040 sh_offset: 0x3028
>>     symbol__new: buf2 0x30a8-0x30e8
>>     ...
>>     dso__load_sym_internal: adjusting symbol: st_value: 0x4080 sh_addr: 0x4040 sh_offset: 0x3028
>>     symbol__new: buf1 0x3068-0x30a8
>>     ...

It seems unclear how 0x30a8 and 0x3068 are derived,

>> Perf tool relies on libelf to parse symbols, here 'st_value' is the
>> address from executable file, 'sh_addr' is the belonged section's linked
>> start address, and 'sh_offset' is the dynamic loaded address for this
>> section, then perf tool uses below formula to adjust symbol address:
>>
>>   adjusted_address = st_value - sh_addr + sh_offset
>>
>> So we can see the final adjusted address ranges for buf1 and buf2 are
>> [0x30a8-0x30e8) and [0x3068-0x30a8) respectively, apparently this is
>> incorrect, in the code, the structure for 'buf1' and 'buf2' specifies
>> compiler attribute with 64-byte alignment.

so I cannot judge this paragraph.

>> The problem happens for 'sh_offset', libelf returns it as 0x3028 which
>> is not 64-byte aligned, on the other hand, we can see both 'st_value'
>> and 'sh_addr' are 64-byte aligned.  Combining with disassembly, it's
>> likely libelf uses the .data section end address as .bss section
>> start address, therefore, it doesn't respect the alignment attribute for
>> structures in .bss section.
>>
>> Since .data and .bss sections are in the continuous virtual address
>> space, and .data section info returned by libelf is reliable, to fix
>> this issue, if detects it's a bss symbol, it rolls back to use .data
>> section info to adjust symbol's virtual address.

This is not necessarily true.

* In GNU ld's internal linker script, .data1 sits between .data and .bss.
* A linker script can add other sections between .data and .bss
* A linker script may place .data and .bss in two PT_LOAD program headers.

% readelf -WS aa
There are 13 section headers, starting at offset 0x10a8:

With a linker script like

% cat a/a.lds
SECTIONS {
   .text : { *(.text) }
   data1 : { *(data1) }
   data2 : { *(data2) }
   .bss : { *(.bss) }
}

I can get something like

Section Headers:
   [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
   [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
   [ 1] .text             PROGBITS        0000000000000000 001000 000001 00  AX  0   0  1
   [ 2] data1             PROGBITS        0000000000000001 001001 000001 00  WA  0   0  1
   [ 3] data2             PROGBITS        0000000000000002 001002 000001 00  WA  0   0  1
   [ 4] .data             PROGBITS        0000000000000003 001003 000000 00  WA  0   0  1
   [ 5] data3             PROGBITS        0000000000000003 001003 000001 00  WA  0   0  1
   [ 6] .bss              NOBITS          0000000000000020 001004 000001 00  WA  0   0 32

.bss's sh_offset does not need to be aligned per http://www.sco.com/developers/gabi/latest/ch4.sheader.html

     sh_offset
     This member's value gives the byte offset from the beginning of the file to the first byte in the section. One section type, SHT_NOBITS described below, occupies no space in the file, and its sh_offset member locates the conceptual placement in the file.

I don't have more context why the file offset is needed for a variable in the all-zero section.
If the file offset has to be used and we want to use a heuristic, a better one is to find the section index of .bss, say, i.

const uint64_t align = shdr[i].sh_addralign;
assert(i > 0);
if (shdr[i].offset % align == 0)
   return shdr[i].offset;
return (shdr[i-1].sh_offset + shdr[i-1].sh_size + align - 1) & -align;

Really, it is better to use the program header to derive the virtual address of a variable residing in .bss.

>> Essentially, we need to fix libelf to return correct offsets for
>> sections, on the other hand, we live commonly with existed versions of
>> libelf.  So we also need this change in perf tool.
>>
>> Fixes: f17e04afaff8 ("perf report: Fix ELF symbol parsing")
>> Reported-by: Chang Rui <changruinj@gmail.com>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>
>This looks good to me, I'm happy to add my:
>Acked-by: Ian Rogers <irogers@google.com>
>I've added Fangrui Song who is more knowledge-able on ELF, libelf,
>etc. than me and may have additional thoughts.
>
>Thanks,
>Ian
>
>> ---
>>  tools/perf/util/dso.h        |  1 +
>>  tools/perf/util/symbol-elf.c | 26 ++++++++++++++++++++++++++
>>  2 files changed, 27 insertions(+)
>>
>> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>> index 3a9fd4d389b5..00f57f4ac6bc 100644
>> --- a/tools/perf/util/dso.h
>> +++ b/tools/perf/util/dso.h
>> @@ -180,6 +180,7 @@ struct dso {
>>         u8               rel;
>>         struct build_id  bid;
>>         u64              text_offset;
>> +       int              data_sec_index;
>>         const char       *short_name;
>>         const char       *long_name;
>>         u16              long_name_len;
>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> index ecd377938eea..ed65dd26d58e 100644
>> --- a/tools/perf/util/symbol-elf.c
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -1095,6 +1095,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>>         Elf *elf;
>>         int nr = 0;
>>         bool remap_kernel = false, adjust_kernel_syms = false;
>> +       size_t sec_index;
>>
>>         if (kmap && !kmaps)
>>                 return -1;
>> @@ -1113,6 +1114,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>>                                 ".text", NULL))
>>                 dso->text_offset = tshdr.sh_addr - tshdr.sh_offset;
>>
>> +       if (elf_section_by_name(runtime_ss->elf, &runtime_ss->ehdr, &tshdr,
>> +                               ".data", &sec_index))
>> +               dso->data_sec_index = sec_index;
>> +
>>         if (runtime_ss->opdsec)
>>                 opddata = elf_rawdata(runtime_ss->opdsec, NULL);
>>
>> @@ -1227,6 +1232,27 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>>
>>                 gelf_getshdr(sec, &shdr);
>>
>> +               /*
>> +                * When the first data structure in .bss section is attributed
>> +                * with alignment (e.g. 64-byte aligned), libelf doesn't reflect
>> +                * the alignment in the 'shdr.sh_offset' field, at the end the
>> +                * field is filled with the end loading address of a prior
>> +                * section rather than the aligned address of .bss section.
>> +                * This leads to mess for later parsing .bss symbols.
>> +                *
>> +                * Since .data and .bss sections are in the continuous virtual
>> +                * address space, and .data section's info is reliable.  So if
>> +                * detects it's a bss symbol, we retrieve .data section info
>> +                * for adjusting address.
>> +                */
>> +               if (!strcmp(elf_sec__name(&shdr, secstrs_sym), ".bss")) {
>> +                       sec = elf_getscn(syms_ss->elf, dso->data_sec_index);
>> +                       if (!sec)
>> +                               goto out_elf_end;
>> +
>> +                       gelf_getshdr(sec, &shdr);
>> +               }
>> +
>>                 secstrs = secstrs_sym;
>>
>>                 /*
>> --
>> 2.25.1
>>
