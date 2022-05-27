Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF05365A2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353744AbiE0QEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 12:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345710AbiE0QEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 12:04:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AA211C1B
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:04:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o9so2905862wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBiP6vW4sF/6LQTBgA+dMGRC5zva8gp7vJCCVGRKZkY=;
        b=PIYjMgdNxRIA2Tuw3Y4gmhqlMeQ0ch8rdEcM/OJfoIEI6Kw/AVbIskGP0tANoqCdOb
         de3epEKpSYBsAIIbdPdmrL9eP4L5UhC0jFgG/FLz+GLQ0g6a3WT1b1ckisa5dL5Xnpog
         wFu+YgH2KYGliMVtuBT/2eePV7siWGrfLkDEv7KwOIkMZJ+7wURHITCUCXKfJgHSPJcF
         1aCWXfxlNmG7DVmUMOQjpEa/uMXK31f52Is0Nmgs3z+5p0Er8Q5dnhSJi7xiKjg4hStY
         CKSbi1TPZxE5c6F57pQXE1LfsGOF7Yw4QyBSEjnBOq3NqppchUnAux++XQIaW8fMKVBN
         kJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBiP6vW4sF/6LQTBgA+dMGRC5zva8gp7vJCCVGRKZkY=;
        b=p8lGXWjEfNlRvb0c8rdTcGAiQXCDQmiGcnzWMZcJouaoZk/+qkjZPyYl8RWZBy9Jf+
         zPIeET+slLCt/wGOwCx+02/6HA6oril6GvCgtbGLUoQ66A3HnxrD30aB4Lc7UDWzMgqL
         nQu/eQdf9POg7r/PhvuOJBTpa0rvqbDQQKfMGps17Mfyow+7fmLT0Bi+Qbk9QRG4IcJ1
         sRWEfYamaJQXbLwQUCkXtf1/06wHmctYI150WCX9+fF6k3Y+mRhKXiT2/hqSladteoVh
         5fVjRetgz7U235kKBZQUtW2caDuuppdpPssg3VfjWRp8gjC8v1s6a5aCJVLBH7Lfxfu0
         Aekw==
X-Gm-Message-State: AOAM530EG8mX9PmFpP/BrM7+xlWRGSZwlyb02YwhrxYFx1zFz5//vTnT
        gd5uLU7yy3+grsnCWsbwO/OK1JwU6Y/+tDlLutPdYg==
X-Google-Smtp-Source: ABdhPJwEum2+MBzphrcqGv6VA7uucC1mioqzsX+CjRL4+M/OSmP3Dd1iYs0J2lhNtitCSrdygtODmIXNlazfymK1H08=
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id
 m1-20020a1ca301000000b003929bc5203cmr7618104wme.67.1653667440924; Fri, 27 May
 2022 09:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220527055217.452307-1-maskray@google.com> <CAP-5=fVk9BmzcinBnjjFKBbNA+ojOo+qjS2m2ZAs7t9c2EkLxw@mail.gmail.com>
In-Reply-To: <CAP-5=fVk9BmzcinBnjjFKBbNA+ojOo+qjS2m2ZAs7t9c2EkLxw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 27 May 2022 09:03:46 -0700
Message-ID: <CAP-5=fU8Pzzz+5W7Vy13tKv0=j8LYNc=+cv12LFvkGoAofJNqA@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix segbase for ld.lld linked objects
To:     Fangrui Song <maskray@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sebastian Ullrich <sebasti@nullri.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 11:49 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, May 26, 2022 at 10:52 PM Fangrui Song <maskray@google.com> wrote:
> >
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
> >     ld.lld => fail
> >     ld.lld --no-rosegment => ok
> >     ld.lld -z separate-code => ok
> >
> >     ld.bfd -z separate-code (default for Linux/x86) => ok
> >     ld.bfd -z noseparate-code => ok
> >
> > To fix the issue, compute segbase as dso's base address plus
> > PT_GNU_EH_FRAME's p_vaddr.
> >
> > Reported-by: Sebastian Ullrich <sebasti@nullri.ch>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1646
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > Cc: Ian Rogers <irogers@google.com>
>
> Thanks Fangrui! I tested static vs not, bfd and lld, perf test and
> some hand tests. I couldn't see anything out of order. The code looks
> good although there could be some ambiguity over the variables ending
> _addr as these are the ELF given addresses rather than the thread's
> virtual memory addresses. I'm also trying to get more comments
> especially on major data structures like dso, but that can be fixed as
> a follow-on.
>
> Tested-by: Ian Rogers <irogers@google.com>
>
> > ---
> >  tools/perf/util/dso.h                    |  2 +
> >  tools/perf/util/unwind-libunwind-local.c | 96 ++++++++++++++++--------
> >  2 files changed, 67 insertions(+), 31 deletions(-)
> >
> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > index 3a9fd4d389b5..ec4fc1a9454b 100644
> > --- a/tools/perf/util/dso.h
> > +++ b/tools/perf/util/dso.h
> > @@ -179,6 +179,7 @@ struct dso {
> >         bool             loaded;
> >         u8               rel;
> >         struct build_id  bid;
> > +       u64              base_addr;

This is an address in a thread, as one dso can be shared by multiple
threads/processes it seems unsafe to hold it as the dso may be loaded
at a different address in a different thread. For now we can just
recompute the value rather than store it in the dso.

> >         u64              text_offset;
> >         const char       *short_name;
> >         const char       *long_name;
> > @@ -197,6 +198,7 @@ struct dso {
> >                 u64              file_size;
> >                 struct list_head open_entry;
> >                 u64              debug_frame_offset;
> > +               u64              eh_frame_hdr_addr;

This is the elf section address and safe to hold here.

Thanks,
Ian

> >                 u64              eh_frame_hdr_offset;
> >         } data;
> >         /* bpf prog information */
> > diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> > index 41e29fc7648a..7a0053954e49 100644
> > --- a/tools/perf/util/unwind-libunwind-local.c
> > +++ b/tools/perf/util/unwind-libunwind-local.c
> > @@ -169,30 +169,55 @@ static int __dw_read_encoded_value(u8 **p, u8 *end, u64 *val,
> >         __v;                                                    \
> >         })
> >
> > -static u64 elf_section_offset(int fd, const char *name)
> > +static int elf_section_address_and_offset(int fd, const char *name, u64 *address, u64 *offset)
> >  {
> >         Elf *elf;
> >         GElf_Ehdr ehdr;
> >         GElf_Shdr shdr;
> > -       u64 offset = 0;
> > +       int ret;
> >
> >         elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
> >         if (elf == NULL)
> > -               return 0;
> > +               return -1;
> >
> > -       do {
> > -               if (gelf_getehdr(elf, &ehdr) == NULL)
> > -                       break;
> > +       if (gelf_getehdr(elf, &ehdr) == NULL)
> > +               goto out_err;
> >
> > -               if (!elf_section_by_name(elf, &ehdr, &shdr, name, NULL))
> > -                       break;
> > -
> > -               offset = shdr.sh_offset;
> > -       } while (0);
> > +       if (!elf_section_by_name(elf, &ehdr, &shdr, name, NULL))
> > +               goto out_err;
> >
> > +       *address = shdr.sh_addr;
> > +       *offset = shdr.sh_offset;
> > +       ret = 0;
> > +out_err:
> >         elf_end(elf);
> > +       return ret;
> > +}
> > +
> > +#ifndef NO_LIBUNWIND_DEBUG_FRAME
> > +static u64 elf_section_offset(int fd, const char *name)
> > +{
> > +       u64 address, offset;
> > +
> > +       if (elf_section_address_and_offset(fd, name, &address, &offset))
> > +               return 0;
> > +
> >         return offset;
> >  }
> > +#endif
> > +
> > +static int elf_base_address(int fd)
> > +{
> > +       Elf *elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
> > +       GElf_Phdr phdr;
> > +       int retval = 0;
> > +
> > +       if (gelf_getphdr(elf, 0, &phdr) != NULL)
> > +               retval = phdr.p_vaddr & -getpagesize();
> > +
> > +       elf_end(elf);
> > +       return retval;
> > +}
> >
> >  #ifndef NO_LIBUNWIND_DEBUG_FRAME
> >  static int elf_is_exec(int fd, const char *name)
> > @@ -248,8 +273,7 @@ struct eh_frame_hdr {
> >  } __packed;
> >
> >  static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
> > -                              u64 offset, u64 *table_data, u64 *segbase,
> > -                              u64 *fde_count)
> > +                              u64 offset, u64 *table_data_offset, u64 *fde_count)
> >  {
> >         struct eh_frame_hdr hdr;
> >         u8 *enc = (u8 *) &hdr.enc;
> > @@ -265,35 +289,45 @@ static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
> >         dw_read_encoded_value(enc, end, hdr.eh_frame_ptr_enc);
> >
> >         *fde_count  = dw_read_encoded_value(enc, end, hdr.fde_count_enc);
> > -       *segbase    = offset;
> > -       *table_data = (enc - (u8 *) &hdr) + offset;
> > +       *table_data_offset = enc - (u8 *) &hdr;
> >         return 0;
> >  }
> >
> > -static int read_unwind_spec_eh_frame(struct dso *dso, struct machine *machine,
> > +static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
> >                                      u64 *table_data, u64 *segbase,
> >                                      u64 *fde_count)
> >  {
> > -       int ret = -EINVAL, fd;
> > -       u64 offset = dso->data.eh_frame_hdr_offset;
> > +       struct map *map;
> > +       int ret, fd;
> >
> > -       if (offset == 0) {
> > -               fd = dso__data_get_fd(dso, machine);
> > +       if (dso->data.eh_frame_hdr_offset == 0) {
> > +               u64 addr_min = UINT64_MAX;
> > +
> > +               fd = dso__data_get_fd(dso, ui->machine);
> >                 if (fd < 0)
> >                         return -EINVAL;
> >
> >                 /* Check the .eh_frame section for unwinding info */
> > -               offset = elf_section_offset(fd, ".eh_frame_hdr");
> > -               dso->data.eh_frame_hdr_offset = offset;
> > +               ret = elf_section_address_and_offset(fd, ".eh_frame_hdr",
> > +                                                    &dso->data.eh_frame_hdr_addr,
> > +                                                    &dso->data.eh_frame_hdr_offset);
> > +               maps__for_each_entry(ui->thread->maps, map) {
> > +                       if (map->dso == dso && map->start < addr_min)
> > +                               addr_min = map->start;
> > +               }
> > +               dso->base_addr = addr_min - elf_base_address(fd);
> >                 dso__data_put_fd(dso);
> > +               if (ret || dso->data.eh_frame_hdr_offset == 0)
> > +                   return -EINVAL;
> >         }
> >
> > -       if (offset)
> > -               ret = unwind_spec_ehframe(dso, machine, offset,
> > -                                         table_data, segbase,
> > -                                         fde_count);
> > -
> > -       return ret;
> > +       *segbase = dso->base_addr + dso->data.eh_frame_hdr_addr;
> > +       ret = unwind_spec_ehframe(dso, ui->machine, dso->data.eh_frame_hdr_offset,
> > +                                  table_data, fde_count);
> > +       if (ret)
> > +           return ret;
> > +       *table_data += *segbase;
> > +       return 0;
> >  }
> >
> >  #ifndef NO_LIBUNWIND_DEBUG_FRAME
> > @@ -388,14 +422,14 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
> >         pr_debug("unwind: find_proc_info dso %s\n", map->dso->name);
> >
> >         /* Check the .eh_frame section for unwinding info */
> > -       if (!read_unwind_spec_eh_frame(map->dso, ui->machine,
> > +       if (!read_unwind_spec_eh_frame(map->dso, ui,
> >                                        &table_data, &segbase, &fde_count)) {
> >                 memset(&di, 0, sizeof(di));
> >                 di.format   = UNW_INFO_FORMAT_REMOTE_TABLE;
> >                 di.start_ip = map->start;
> >                 di.end_ip   = map->end;
> > -               di.u.rti.segbase    = map->start + segbase - map->pgoff;
> > -               di.u.rti.table_data = map->start + table_data - map->pgoff;
> > +               di.u.rti.segbase    = segbase;
> > +               di.u.rti.table_data = table_data;
> >                 di.u.rti.table_len  = fde_count * sizeof(struct table_entry)
> >                                       / sizeof(unw_word_t);
> >                 ret = dwarf_search_unwind_table(as, ip, &di, pi,
> > --
> > 2.36.1.124.g0e6072fb45-goog
> >
