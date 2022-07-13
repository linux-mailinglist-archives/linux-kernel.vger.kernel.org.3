Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869D3572BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiGMDaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiGMDaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:30:06 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4383AB8509
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:30:04 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 75so15977693ybf.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PP/OhW0gPEu1hOVZ+LUBvYiiXRfoCiVcRjdOa19gXfg=;
        b=fDsANUBNqxqJQSzD5I2/ATj5PCX9C6oYXmSsRDPqIJ45RV85L2ujdW80J+UV2EFYmh
         /o3RT8Rv27WC8ycz6U7qtk0uvwsITN64jrHZDfy6ZPNpX77n17kKX41JZbD9rSKjJKgV
         Q4QTWPBPObM8fSN5jn4NI9Ih0wzO0ojEpf5BOwaD9o/E4r5+GV47XqEG2ehqqCmWbAf5
         4v6ZNR5d2mPZPJOc0TY6MnOwMSq8BdX95606FmAIJC5JsblJHpbjSIEEvdDs7ZmI2X0T
         ru+0gd1PETSjAdOK84tJdpELjLW+9w4sfgsvIsds4eEzVKAR/TtRXbEGArFTotmDFs2E
         SfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PP/OhW0gPEu1hOVZ+LUBvYiiXRfoCiVcRjdOa19gXfg=;
        b=UBb7jYREesf8eVd7XyTZg0t5JnDIOEuq4Dho+/TUb41UlyUmwBQLq/Mpdvt01ECbLV
         MZGvjGig9NAxXvrmX5UejBul/A8wHLGDghQmy/tTXe5GalQdMfwDtAQ9WnNhtMn3FQGo
         Xo09PPusBjAJYYVSJjLhYmk4dbHRvClZ5aMuEWMM4vG0mkpz6F0FwK+Q7blMfVp0m9bl
         w1k2rYI3+L51/yY0nFPG5nSKsnTB307lSr5JWV++KtCtNfRI5WghKCd2VSL8H0dV7gqz
         CVChLCJDP+sGcTWk7KNHnNOElo9T1qXIR3TrO17e22tsvS9AgGpJXAd/xcEaZlQAa785
         zCgw==
X-Gm-Message-State: AJIora+vIck4dY5PUlAAkLZPqVLnsqQzJIGCgXvGKAqY2q6PGWvC8doG
        pDo1HXfDMFSqZi7loijrlyz1MHeddlDC1jcTgtILZw==
X-Google-Smtp-Source: AGRyM1sepXKZ1P9DsojICWLKf64xn0nLoGSMru9yJuTGxSqksRWOOShl7umoF9CZdjkI5nzPAVN7tRevwzwT8JNRdv0=
X-Received: by 2002:a5b:58e:0:b0:66f:2c4f:e542 with SMTP id
 l14-20020a5b058e000000b0066f2c4fe542mr1635753ybp.572.1657683003374; Tue, 12
 Jul 2022 20:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220710012204.2390293-1-leo.yan@linaro.org> <CAP-5=fX_fT7e9tqDBKXh_1CQ8w80iOXCGz2kJT_nHpY6wYWqmQ@mail.gmail.com>
 <20220711172706.rtfd6pp2pochmdre@google.com> <20220712040538.GB10379@leoy-ThinkPad-X240s>
In-Reply-To: <20220712040538.GB10379@leoy-ThinkPad-X240s>
From:   Fangrui Song <maskray@google.com>
Date:   Tue, 12 Jul 2022 20:29:52 -0700
Message-ID: <CAFP8O3+dQi8b6C_f9bTb0TFpEmNjsroBv4agUpRKps2p3hpP+A@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf symbol: Correct address for bss symbols
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chang Rui <changruinj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jul 11, 2022 at 9:05 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> On Mon, Jul 11, 2022 at 10:27:06AM -0700, Fangrui Song wrote:
>
> Thanks for review, Ian and Fangrui!

You are welcome:)

> [...]
>
> > > > First we used 'perf mem record' to run the test program and then us=
ed
> > > > 'perf --debug verbose=3D4 mem report' to observe what's the symbol =
info
> > > > for 'buf1' and 'buf2' structures.
> > > >
> > > >   # ./perf mem record -e ldlat-loads,ldlat-stores -- false_sharing.=
exe 8
> > > >   # ./perf --debug verbose=3D4 mem report
> > > >     ...
> > > >     dso__load_sym_internal: adjusting symbol: st_value: 0x40c0 sh_a=
ddr: 0x4040 sh_offset: 0x3028
> > > >     symbol__new: buf2 0x30a8-0x30e8
> > > >     ...
> > > >     dso__load_sym_internal: adjusting symbol: st_value: 0x4080 sh_a=
ddr: 0x4040 sh_offset: 0x3028
> > > >     symbol__new: buf1 0x3068-0x30a8
> > > >     ...
> >
> > It seems unclear how 0x30a8 and 0x3068 are derived,
>
> In perf tool, 0x30a8 and 0x3068 are adjusted address, which are derived
> from 'st_value', 'sh_addr' and 'sh_offset' with the formula:
>
>   adjusted_address =3D st_value - sh_addr + sh_offset
>
> So perf computes symbol address for buf1:
>
>   adjusted_address =3D st_value - sh_addr + sh_offset
>                    =3D 0x4080 - 0x4040 + 0x3028
>                    =3D 0x3068

Thanks.

> > > > Perf tool relies on libelf to parse symbols, here 'st_value' is the
> > > > address from executable file, 'sh_addr' is the belonged section's l=
inked
> > > > start address, and 'sh_offset' is the dynamic loaded address for th=
is
> > > > section, then perf tool uses below formula to adjust symbol address=
:
> > > >
> > > >   adjusted_address =3D st_value - sh_addr + sh_offset
> > > >
> > > > So we can see the final adjusted address ranges for buf1 and buf2 a=
re
> > > > [0x30a8-0x30e8) and [0x3068-0x30a8) respectively, apparently this i=
s
> > > > incorrect, in the code, the structure for 'buf1' and 'buf2' specifi=
es
> > > > compiler attribute with 64-byte alignment.
> >
> > so I cannot judge this paragraph.
> >
> > > > The problem happens for 'sh_offset', libelf returns it as 0x3028 wh=
ich
> > > > is not 64-byte aligned, on the other hand, we can see both 'st_valu=
e'
> > > > and 'sh_addr' are 64-byte aligned.  Combining with disassembly, it'=
s
> > > > likely libelf uses the .data section end address as .bss section
> > > > start address, therefore, it doesn't respect the alignment attribut=
e for
> > > > structures in .bss section.
> > > >
> > > > Since .data and .bss sections are in the continuous virtual address
> > > > space, and .data section info returned by libelf is reliable, to fi=
x
> > > > this issue, if detects it's a bss symbol, it rolls back to use .dat=
a
> > > > section info to adjust symbol's virtual address.
> >
> > This is not necessarily true.
> >
> > * In GNU ld's internal linker script, .data1 sits between .data and .bs=
s.
> > * A linker script can add other sections between .data and .bss
> > * A linker script may place .data and .bss in two PT_LOAD program heade=
rs.
>
> Agreed the approach in this patch cannot handle all cases.
>
> > % readelf -WS aa
> > There are 13 section headers, starting at offset 0x10a8:
> >
> > With a linker script like
> >
> > % cat a/a.lds
> > SECTIONS {
> >   .text : { *(.text) }
> >   data1 : { *(data1) }
> >   data2 : { *(data2) }
> >   .bss : { *(.bss) }
> > }
> >
> > I can get something like
> >
> > Section Headers:
> >   [Nr] Name              Type            Address          Off    Size  =
 ES Flg Lk Inf Al
> >   [ 0]                   NULL            0000000000000000 000000 000000=
 00      0   0  0
> >   [ 1] .text             PROGBITS        0000000000000000 001000 000001=
 00  AX  0   0  1
> >   [ 2] data1             PROGBITS        0000000000000001 001001 000001=
 00  WA  0   0  1
> >   [ 3] data2             PROGBITS        0000000000000002 001002 000001=
 00  WA  0   0  1
> >   [ 4] .data             PROGBITS        0000000000000003 001003 000000=
 00  WA  0   0  1
> >   [ 5] data3             PROGBITS        0000000000000003 001003 000001=
 00  WA  0   0  1
> >   [ 6] .bss              NOBITS          0000000000000020 001004 000001=
 00  WA  0   0 32
> >
> > .bss's sh_offset does not need to be aligned per http://www.sco.com/dev=
elopers/gabi/latest/ch4.sheader.html
> >
> >     sh_offset
> >     This member's value gives the byte offset from the beginning of the=
 file to the first byte in the section. One section type, SHT_NOBITS descri=
bed below, occupies no space in the file, and its sh_offset member locates =
the conceptual placement in the file.
>
> > I don't have more context why the file offset is needed for a variable =
in the all-zero section.
>
> We need to create symbol info for not only .text section but also for
> .data section and .bss section=E1=B9=A1.  So based on the data address, w=
e can
> know what's the symbol for the data access.
>
> But I need to correct the description for "st_value" [1]: In
> executable and shared object files, st_value holds a virtual address.
> To make these files' symbols more useful for the dynamic linker, the
> section offset (file interpretation) gives way to a virtual address
> (memory interpretation) for which the section number is irrelevant.
>
> So perf tool uses the formula "st_value - sh_addr + sh_offset" to
> convert from the memory address to file address.  But it calculates
> the wrong file address because "sh_offset" doesn't respect the
> alignment.

Thanks for the explanation. I think st_value - p_vaddr + p_offset  may
be a better formula where p_vaddr/p_offset is from the PT_LOAD program
header.

For a SHT_NOBITS section, sh_offset may not be accurate, but PT_LOAD
has precise information.

> [1] http://www.sco.com/developers/gabi/latest/ch4.symtab.html#symbol_valu=
e
>
> > If the file offset has to be used and we want to use a heuristic, a bet=
ter one is to find the section index of .bss, say, i.
> >
> > const uint64_t align =3D shdr[i].sh_addralign;
> > assert(i > 0);
> > if (shdr[i].offset % align =3D=3D 0)
> >   return shdr[i].offset;
> > return (shdr[i-1].sh_offset + shdr[i-1].sh_size + align - 1) & -align;
> >
> > Really, it is better to use the program header to derive the virtual ad=
dress of a variable residing in .bss.
>
> I think we can simplify the code.  Because:
>
>   shdr[i].sh_offset =3D shdr[i-1].sh_offset + shdr[i-1].sh_size
>
> ... thus we can simply fixup "sh_offset":
>
>   const uint64_t align =3D shdr[i].sh_addralign;
>   aligned_sh_offset =3D (shdr[i].sh_offset + align - 1) & ~(align - 1);
>
> So:
>
>   symbol_addr =3D st_value - sh_addr + aligned_sh_offset
>
> If you still see any issue, please let me know.
>
> Thanks a lot for suggestions.
>
> Leo
