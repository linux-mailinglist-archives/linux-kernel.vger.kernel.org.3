Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15395571112
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 06:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiGLEFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 00:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiGLEFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:05:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465C637180
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 21:05:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a15so6420987pfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 21:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Sz9szSa4PbjdihEuUkN/48M4rjKmKhhNvz2LsBkiT+8=;
        b=QX15/6NlbhAEeDEbNujQ9sq7v5HZAqpO0vg+ua1cnzwnIdJVmtlO9/lJLOwIQ3876I
         EzQoy/GEI04wgBhVNZvkh3TJgIluMqdkBfGfvLZy4PVG6LMzzNi24jykMrgQYMXTpNIG
         vfciD/9f1LcU5h45GdUy3WcEFkeMa324qeX1fkbxn6WZoU2T6B0/K1kch8Dc4rJga8/T
         xyNYWJwa8xc0gWKMXBmNysDTBGh3uXCNQ0UelxzwNrmyNictyqOsmhTqxP2upNsBfz4T
         /rJAxYYGV32jkFCvYitlUlSFfRtw0g0LragRs/ohG43/UQYXHueu6jgBBdb7N/qu0DT9
         9yGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sz9szSa4PbjdihEuUkN/48M4rjKmKhhNvz2LsBkiT+8=;
        b=VRZ/b3MrJrNcGDSc+SETRb2dYX4uDJx6g/BLxsfx38FyuaW7qTLUezlp7qhCc10gJr
         BRZMUAJjlQsJqqKivxS4bdQPpLhi3v9MaFFLpyc/b5i0V83zDhUtmzmoJhNYPJ4lc776
         zStG0QaFcguF7QEsxhZRcAUa+72OY3WLvN0f3RoONQa+tljgsNGx6Y4ryrlhQiLSEf9W
         o6YekxivqHiy4fCQFPjRmuNBGn+7P/641LeVSKjl7MA9bUfPuV6ejvMGoDmv1TcGA0MY
         kspaSbGbJPlDn76TPaf8/XKJm3vQkh353fNH2TRbOp3wj4X6qS+W5x/ED28VQcl1+6qs
         5ikg==
X-Gm-Message-State: AJIora92oQXyCvnBLydW9G1lyafwQbwrI29UNnihhCCXGbE6dE5nBQXS
        ErhTLScx/wGUYN/KSaaMH2R3eg==
X-Google-Smtp-Source: AGRyM1up2gx7HxHdTNFwz/N7EM5ljIsXcl9JX4Rr0Y1ZU41hewb5iNJsOePKQTn1z407POCg2DtHSA==
X-Received: by 2002:a63:a46:0:b0:412:b1d6:94cf with SMTP id z6-20020a630a46000000b00412b1d694cfmr19249022pgk.373.1657598744629;
        Mon, 11 Jul 2022 21:05:44 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id ce23-20020a17090aff1700b001ef8780f873sm5576182pjb.39.2022.07.11.21.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 21:05:44 -0700 (PDT)
Date:   Tue, 12 Jul 2022 12:05:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chang Rui <changruinj@gmail.com>
Subject: Re: [RFC PATCH v1] perf symbol: Correct address for bss symbols
Message-ID: <20220712040538.GB10379@leoy-ThinkPad-X240s>
References: <20220710012204.2390293-1-leo.yan@linaro.org>
 <CAP-5=fX_fT7e9tqDBKXh_1CQ8w80iOXCGz2kJT_nHpY6wYWqmQ@mail.gmail.com>
 <20220711172706.rtfd6pp2pochmdre@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220711172706.rtfd6pp2pochmdre@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 10:27:06AM -0700, Fangrui Song wrote:

Thanks for review, Ian and Fangrui!

[...]

> > > First we used 'perf mem record' to run the test program and then used
> > > 'perf --debug verbose=4 mem report' to observe what's the symbol info
> > > for 'buf1' and 'buf2' structures.
> > > 
> > >   # ./perf mem record -e ldlat-loads,ldlat-stores -- false_sharing.exe 8
> > >   # ./perf --debug verbose=4 mem report
> > >     ...
> > >     dso__load_sym_internal: adjusting symbol: st_value: 0x40c0 sh_addr: 0x4040 sh_offset: 0x3028
> > >     symbol__new: buf2 0x30a8-0x30e8
> > >     ...
> > >     dso__load_sym_internal: adjusting symbol: st_value: 0x4080 sh_addr: 0x4040 sh_offset: 0x3028
> > >     symbol__new: buf1 0x3068-0x30a8
> > >     ...
> 
> It seems unclear how 0x30a8 and 0x3068 are derived,

In perf tool, 0x30a8 and 0x3068 are adjusted address, which are derived
from 'st_value', 'sh_addr' and 'sh_offset' with the formula:

  adjusted_address = st_value - sh_addr + sh_offset

So perf computes symbol address for buf1:

  adjusted_address = st_value - sh_addr + sh_offset
                   = 0x4080 - 0x4040 + 0x3028
                   = 0x3068

> > > Perf tool relies on libelf to parse symbols, here 'st_value' is the
> > > address from executable file, 'sh_addr' is the belonged section's linked
> > > start address, and 'sh_offset' is the dynamic loaded address for this
> > > section, then perf tool uses below formula to adjust symbol address:
> > > 
> > >   adjusted_address = st_value - sh_addr + sh_offset
> > > 
> > > So we can see the final adjusted address ranges for buf1 and buf2 are
> > > [0x30a8-0x30e8) and [0x3068-0x30a8) respectively, apparently this is
> > > incorrect, in the code, the structure for 'buf1' and 'buf2' specifies
> > > compiler attribute with 64-byte alignment.
> 
> so I cannot judge this paragraph.
> 
> > > The problem happens for 'sh_offset', libelf returns it as 0x3028 which
> > > is not 64-byte aligned, on the other hand, we can see both 'st_value'
> > > and 'sh_addr' are 64-byte aligned.  Combining with disassembly, it's
> > > likely libelf uses the .data section end address as .bss section
> > > start address, therefore, it doesn't respect the alignment attribute for
> > > structures in .bss section.
> > > 
> > > Since .data and .bss sections are in the continuous virtual address
> > > space, and .data section info returned by libelf is reliable, to fix
> > > this issue, if detects it's a bss symbol, it rolls back to use .data
> > > section info to adjust symbol's virtual address.
> 
> This is not necessarily true.
> 
> * In GNU ld's internal linker script, .data1 sits between .data and .bss.
> * A linker script can add other sections between .data and .bss
> * A linker script may place .data and .bss in two PT_LOAD program headers.

Agreed the approach in this patch cannot handle all cases.

> % readelf -WS aa
> There are 13 section headers, starting at offset 0x10a8:
> 
> With a linker script like
> 
> % cat a/a.lds
> SECTIONS {
>   .text : { *(.text) }
>   data1 : { *(data1) }
>   data2 : { *(data2) }
>   .bss : { *(.bss) }
> }
> 
> I can get something like
> 
> Section Headers:
>   [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
>   [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
>   [ 1] .text             PROGBITS        0000000000000000 001000 000001 00  AX  0   0  1
>   [ 2] data1             PROGBITS        0000000000000001 001001 000001 00  WA  0   0  1
>   [ 3] data2             PROGBITS        0000000000000002 001002 000001 00  WA  0   0  1
>   [ 4] .data             PROGBITS        0000000000000003 001003 000000 00  WA  0   0  1
>   [ 5] data3             PROGBITS        0000000000000003 001003 000001 00  WA  0   0  1
>   [ 6] .bss              NOBITS          0000000000000020 001004 000001 00  WA  0   0 32
> 
> .bss's sh_offset does not need to be aligned per http://www.sco.com/developers/gabi/latest/ch4.sheader.html
> 
>     sh_offset
>     This member's value gives the byte offset from the beginning of the file to the first byte in the section. One section type, SHT_NOBITS described below, occupies no space in the file, and its sh_offset member locates the conceptual placement in the file.

> I don't have more context why the file offset is needed for a variable in the all-zero section.

We need to create symbol info for not only .text section but also for
.data section and .bss sectionṡ.  So based on the data address, we can
know what's the symbol for the data access.

But I need to correct the description for "st_value" [1]: In
executable and shared object files, st_value holds a virtual address.
To make these files' symbols more useful for the dynamic linker, the
section offset (file interpretation) gives way to a virtual address
(memory interpretation) for which the section number is irrelevant.

So perf tool uses the formula "st_value - sh_addr + sh_offset" to
convert from the memory address to file address.  But it calculates
the wrong file address because "sh_offset" doesn't respect the
alignment.

[1] http://www.sco.com/developers/gabi/latest/ch4.symtab.html#symbol_value

> If the file offset has to be used and we want to use a heuristic, a better one is to find the section index of .bss, say, i.
> 
> const uint64_t align = shdr[i].sh_addralign;
> assert(i > 0);
> if (shdr[i].offset % align == 0)
>   return shdr[i].offset;
> return (shdr[i-1].sh_offset + shdr[i-1].sh_size + align - 1) & -align;
> 
> Really, it is better to use the program header to derive the virtual address of a variable residing in .bss.

I think we can simplify the code.  Because:

  shdr[i].sh_offset = shdr[i-1].sh_offset + shdr[i-1].sh_size

... thus we can simply fixup "sh_offset":

  const uint64_t align = shdr[i].sh_addralign;
  aligned_sh_offset = (shdr[i].sh_offset + align - 1) & ~(align - 1);

So:

  symbol_addr = st_value - sh_addr + aligned_sh_offset

If you still see any issue, please let me know.

Thanks a lot for suggestions.

Leo
