Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78737536D57
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 16:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiE1Ota (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 10:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiE1Ot3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 10:49:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158FB19033
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 07:49:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso4181859wmp.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DtIUUQgNQnlpKr+iJ/L5eRAgxDOGw8+U/orkSdFrre0=;
        b=L9GSkiKwTuc89mS42WiwEz6LhbkCvSZTA3ZmE9mUwBOJiY1jMMVgEVWQgeXdDybN39
         MdM6zhTguGCt+DnSmUkrWKLduYpHEQiT63Fz0lO+ZE34meNmPydwlZkYS1T8Q3W0jKUr
         sIwUZCBUyX8tjsmMSmV2e/WWzl6G3Idqj6QbnsVlgnIjrHKItzMnTItmPF97uAnrS05A
         oUfso78oJB1/x/9J4ZkyMwRiZtzBH2VZ5OvfLTcsc1b/cpuC07GO6J9KSTQFskktBpT6
         /XpPflPvfhclsLmeejCd2E3jVx0J5hihv8BV9JWb5kC47XDKX6RvULWw0yNA/ypTMkoq
         vU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DtIUUQgNQnlpKr+iJ/L5eRAgxDOGw8+U/orkSdFrre0=;
        b=Scyzqg7u5xTmE77z5cnxsZG1EhWHPrba3Iv410uk7kZdFrI0YlI0ZFqApOFyZOjtcO
         fonFpPx1/AYw6sJ5v7OEru9jf4+dzkHgoRvk1okZUOshv+5lI7UW3rCQjLIwhhg1oYx5
         bAjNLu/2JIT34bSAx7FwdOVtCwRMGQD6veaDCbSGHIPQ+BxGx6IiMr/M+ut08mko6Baq
         BpGVF+uSLpaYhU5ov++O0VlZlvlgxKAnUucQXWxnMQV01umYx+F8JgwOFbjGD6MSRxQa
         vbE0wxtSkcwv04GvgaFDVK2hapNnGULYBJPkpUHdEY7BL/OsyphoCd8iUxTmx2ZNQmK4
         p9/w==
X-Gm-Message-State: AOAM532Q1z8nLbhH/MQMYzGMH0D3J0EvDBvKzcdqdn/gn00CFZQvviz2
        3XqdWt2FWBhHGBU45eHgpDGCBqcFM0hvd6IwgAUEmg==
X-Google-Smtp-Source: ABdhPJyH/bw6uwLTMRfOIc15vvgx3Tvt24IEQk7keHoxTGOT7QQda8SsNpO6HKcMSEtYWcm+kB5T3b12L1g4v/9jDWs=
X-Received: by 2002:a05:600c:2305:b0:397:44a4:d3cb with SMTP id
 5-20020a05600c230500b0039744a4d3cbmr11320407wmo.115.1653749366349; Sat, 28
 May 2022 07:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220527182039.673248-1-maskray@google.com> <YpIQWdwtHqAdjLoC@krava>
In-Reply-To: <YpIQWdwtHqAdjLoC@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 28 May 2022 07:49:13 -0700
Message-ID: <CAP-5=fW042ozhWxV4aMF9FFbg1APPqy1Hs5e9-OZ4iaZNnO8qA@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Fix segbase for ld.lld linked objects
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Fangrui Song <maskray@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sebastian Ullrich <sebasti@nullri.ch>
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

On Sat, May 28, 2022 at 5:06 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Fri, May 27, 2022 at 11:20:39AM -0700, Fangrui Song wrote:
> > segbase is the address of .eh_frame_hdr and table_data is segbase plus
> > the header size. find_proc_info computes segbase as `map->start +
> > segbase - map->pgoff` which is wrong when
> >
> > * .eh_frame_hdr and .text are in different PT_LOAD program headers
> > * and their p_vaddr difference does not equal their p_offset difference
> >
> > Since 10.0, ld.lld's default --rosegment -z noseparate-code layout has
> > such R and RX PT_LOAD program headers.
> >
> >     ld.lld (default) => perf report fails to unwind `perf record
> >     --call-graph dwarf` recorded data
> >     ld.lld --no-rosegment => ok (trivial, no R PT_LOAD)
> >     ld.lld -z separate-code => ok but by luck: there are two PT_LOAD but
> >     their p_vaddr difference equals p_offset difference
> >
> >     ld.bfd -z noseparate-code => ok (trivial, no R PT_LOAD)
> >     ld.bfd -z separate-code (default for Linux/x86) => ok but by luck:
> >     there are two PT_LOAD but their p_vaddr difference equals p_offset
> >     difference
> >
> > To fix the issue, compute segbase as dso's base address plus
> > PT_GNU_EH_FRAME's p_vaddr. The base address is computed by iterating
> > over all dso-associated maps and then subtract the first PT_LOAD p_vaddr
> > (the minimum guaranteed by generic ABI) from the minimum address.
> >
> > In libunwind, find_proc_info transitively called by unw_step is cached,
> > so the iteration overhead is acceptable.
> >
> > Reported-by: Sebastian Ullrich <sebasti@nullri.ch>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1646
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > Cc: Ian Rogers <irogers@google.com>
>
> nice, is this a problem for libdw dwarf unwind as well?

libdw also is broken with lld but not bfd. When I switch on verbose
output (-vv) with perf report I see:

overlapping maps:
202000-203000 0 a.out
202000-203000 0 a.out

and:

unwind: failed with 'address range overlaps an existing module'

The sense I get from this is libdw is rejecting the file before
anything we can do in perf.

Thanks,
Ian

> you should be able to build it with:
>
>   $ make NO_LIBUNWIND=1
>
> thanks,
> jirka
>
> >
> > --
> > Changes from v1:
> > * Fix elf_base_address to use the first PT_LOAD
> > * Use dso::elf_base_addr which is a constant even if the dso is loaded into multiple processes
> > ---
> >  tools/perf/util/dso.h                    |   2 +
> >  tools/perf/util/unwind-libunwind-local.c | 107 ++++++++++++++++-------
> >  2 files changed, 78 insertions(+), 31 deletions(-)
> >
> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > index 3a9fd4d389b5..97047a11282b 100644
> > --- a/tools/perf/util/dso.h
> > +++ b/tools/perf/util/dso.h
> > @@ -196,7 +196,9 @@ struct dso {
> >               u32              status_seen;
> >               u64              file_size;
> >               struct list_head open_entry;
> > +             u64              elf_base_addr;
> >               u64              debug_frame_offset;
> > +             u64              eh_frame_hdr_addr;
> >               u64              eh_frame_hdr_offset;
> >       } data;
> >       /* bpf prog information */
> > diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> > index 41e29fc7648a..37622699c91a 100644
> > --- a/tools/perf/util/unwind-libunwind-local.c
> > +++ b/tools/perf/util/unwind-libunwind-local.c
> > @@ -169,30 +169,64 @@ static int __dw_read_encoded_value(u8 **p, u8 *end, u64 *val,
> >       __v;                                                    \
> >       })
> >
> > -static u64 elf_section_offset(int fd, const char *name)
> > +static int elf_section_address_and_offset(int fd, const char *name, u64 *address, u64 *offset)
> >  {
> >       Elf *elf;
> >       GElf_Ehdr ehdr;
> >       GElf_Shdr shdr;
> > -     u64 offset = 0;
> > +     int ret;
> >
> >       elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
> >       if (elf == NULL)
> > -             return 0;
> > +             return -1;
> >
> > -     do {
> > -             if (gelf_getehdr(elf, &ehdr) == NULL)
> > -                     break;
> > +     if (gelf_getehdr(elf, &ehdr) == NULL)
> > +             goto out_err;
> >
> > -             if (!elf_section_by_name(elf, &ehdr, &shdr, name, NULL))
> > -                     break;
> > -
> > -             offset = shdr.sh_offset;
> > -     } while (0);
> > +     if (!elf_section_by_name(elf, &ehdr, &shdr, name, NULL))
> > +             goto out_err;
> >
> > +     *address = shdr.sh_addr;
> > +     *offset = shdr.sh_offset;
> > +     ret = 0;
> > +out_err:
> >       elf_end(elf);
> > +     return ret;
> > +}
> > +
> > +#ifndef NO_LIBUNWIND_DEBUG_FRAME
> > +static u64 elf_section_offset(int fd, const char *name)
> > +{
> > +     u64 address, offset;
> > +
> > +     if (elf_section_address_and_offset(fd, name, &address, &offset))
> > +             return 0;
> > +
> >       return offset;
> >  }
> > +#endif
> > +
> > +static u64 elf_base_address(int fd)
> > +{
> > +     Elf *elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
> > +     GElf_Phdr phdr;
> > +     u64 retval = 0;
> > +     size_t i, phdrnum = 0;
> > +
> > +     if (elf == NULL)
> > +             return 0;
> > +     (void)elf_getphdrnum(elf, &phdrnum);
> > +     /* PT_LOAD segments are sorted by p_vaddr, so the first has the minimum p_vaddr. */
> > +     for (i = 0; i < phdrnum; i++) {
> > +             if (gelf_getphdr(elf, i, &phdr) && phdr.p_type == PT_LOAD) {
> > +                     retval = phdr.p_vaddr & -getpagesize();
> > +                     break;
> > +             }
> > +     }
> > +
> > +     elf_end(elf);
> > +     return retval;
> > +}
> >
> >  #ifndef NO_LIBUNWIND_DEBUG_FRAME
> >  static int elf_is_exec(int fd, const char *name)
> > @@ -248,8 +282,7 @@ struct eh_frame_hdr {
> >  } __packed;
> >
> >  static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
> > -                            u64 offset, u64 *table_data, u64 *segbase,
> > -                            u64 *fde_count)
> > +                            u64 offset, u64 *table_data_offset, u64 *fde_count)
> >  {
> >       struct eh_frame_hdr hdr;
> >       u8 *enc = (u8 *) &hdr.enc;
> > @@ -265,35 +298,47 @@ static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
> >       dw_read_encoded_value(enc, end, hdr.eh_frame_ptr_enc);
> >
> >       *fde_count  = dw_read_encoded_value(enc, end, hdr.fde_count_enc);
> > -     *segbase    = offset;
> > -     *table_data = (enc - (u8 *) &hdr) + offset;
> > +     *table_data_offset = enc - (u8 *) &hdr;
> >       return 0;
> >  }
> >
> > -static int read_unwind_spec_eh_frame(struct dso *dso, struct machine *machine,
> > +static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
> >                                    u64 *table_data, u64 *segbase,
> >                                    u64 *fde_count)
> >  {
> > -     int ret = -EINVAL, fd;
> > -     u64 offset = dso->data.eh_frame_hdr_offset;
> > +     struct map *map;
> > +     u64 base_addr = UINT64_MAX;
> > +     int ret, fd;
> >
> > -     if (offset == 0) {
> > -             fd = dso__data_get_fd(dso, machine);
> > +     if (dso->data.eh_frame_hdr_offset == 0) {
> > +             fd = dso__data_get_fd(dso, ui->machine);
> >               if (fd < 0)
> >                       return -EINVAL;
> >
> >               /* Check the .eh_frame section for unwinding info */
> > -             offset = elf_section_offset(fd, ".eh_frame_hdr");
> > -             dso->data.eh_frame_hdr_offset = offset;
> > +             ret = elf_section_address_and_offset(fd, ".eh_frame_hdr",
> > +                                                  &dso->data.eh_frame_hdr_addr,
> > +                                                  &dso->data.eh_frame_hdr_offset);
> > +             dso->data.elf_base_addr = elf_base_address(fd);
> >               dso__data_put_fd(dso);
> > +             if (ret || dso->data.eh_frame_hdr_offset == 0)
> > +                     return -EINVAL;
> >       }
> >
> > -     if (offset)
> > -             ret = unwind_spec_ehframe(dso, machine, offset,
> > -                                       table_data, segbase,
> > -                                       fde_count);
> > -
> > -     return ret;
> > +     maps__for_each_entry(ui->thread->maps, map) {
> > +             if (map->dso == dso && map->start < base_addr)
> > +                     base_addr = map->start;
> > +     }
> > +     base_addr -= dso->data.elf_base_addr;
> > +     /* Address of .eh_frame_hdr */
> > +     *segbase = base_addr + dso->data.eh_frame_hdr_addr;
> > +     ret = unwind_spec_ehframe(dso, ui->machine, dso->data.eh_frame_hdr_offset,
> > +                                table_data, fde_count);
> > +     if (ret)
> > +             return ret;
> > +     /* binary_search_table offset plus .eh_frame_hdr address */
> > +     *table_data += *segbase;
> > +     return 0;
> >  }
> >
> >  #ifndef NO_LIBUNWIND_DEBUG_FRAME
> > @@ -388,14 +433,14 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
> >       pr_debug("unwind: find_proc_info dso %s\n", map->dso->name);
> >
> >       /* Check the .eh_frame section for unwinding info */
> > -     if (!read_unwind_spec_eh_frame(map->dso, ui->machine,
> > +     if (!read_unwind_spec_eh_frame(map->dso, ui,
> >                                      &table_data, &segbase, &fde_count)) {
> >               memset(&di, 0, sizeof(di));
> >               di.format   = UNW_INFO_FORMAT_REMOTE_TABLE;
> >               di.start_ip = map->start;
> >               di.end_ip   = map->end;
> > -             di.u.rti.segbase    = map->start + segbase - map->pgoff;
> > -             di.u.rti.table_data = map->start + table_data - map->pgoff;
> > +             di.u.rti.segbase    = segbase;
> > +             di.u.rti.table_data = table_data;
> >               di.u.rti.table_len  = fde_count * sizeof(struct table_entry)
> >                                     / sizeof(unw_word_t);
> >               ret = dwarf_search_unwind_table(as, ip, &di, pi,
> > --
> > 2.36.1.124.g0e6072fb45-goog
> >
