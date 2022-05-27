Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D654A5366F8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354166AbiE0Sfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244925AbiE0Sfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:35:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A0CE2781
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:35:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id qe5-20020a17090b4f8500b001e26126abccso2922324pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WbmG0BxQL0R992+1mkLkmRm547n++V/TI4xlf+GH/tc=;
        b=tQWjfnFLTWBFHvgl/VG2XJA5ghivQFp2Sz2UAYppDuUjX3+IIndkvD+9719qnRLrQo
         uToN8xZn6rbOB0Tr4rOY68vr4ADYR5y7hEw1cL1cuuFMsCfsKo/ZbRpVLlTxdFyJutO0
         6M6v8WGi+5z7JONrVpNCfp4wQ/3dvu0O0XrQZdVj1o50aSjtbTr9G494iLeaJn6WI9PC
         cav3ODzqaFF7nvo10qhk8KDyUv4duGwQRL8HZrU7sAr2DGCfX19NLH+qj/JHlNtwIvOi
         4nBT1hwUXAFXLuMgkuVJG0o+emZY13jVOFSyzaw8OMZrIztg/1CCmUKWzU5eW4DcS56y
         POHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WbmG0BxQL0R992+1mkLkmRm547n++V/TI4xlf+GH/tc=;
        b=WyW/0hp71zz1QpIHvnRP/CALhxgGFS6M9zrfd1YHyUHHKExSPdZJKPT49xeP2QrZ0U
         O+QgYw9/Z0OzYU7pFn1bUgIv0i+vE3jKMjUCsKIasS9kSDL8/t7jBWPnCSLwV4Fd91tO
         tSm9ae3h/g6RZN2Pe3euPVeTY3TZyNxtzuRbF27k27RNyRDHpnA6MCz805DqKTqfIoep
         IKBEJ32xe+/sHsoVhNUJaPBBmykjaFnSZQr9nJhMeL+KzE3B5NS8hZGRF1UItE/Gew8w
         k0KdQwr4OxW9cx+3K4ny/bqLgNJ1zpRYw46VWVbbqZsEePsg/Puqz22GuRIrWjHoAfpo
         gHkg==
X-Gm-Message-State: AOAM531198m8lSlYFqePUbSkkt9qheYSvRPI8a4AIzoBVqZ3iS9DMU+E
        VmRh9s6W/NGQqTGL0U1HuQwQ1g==
X-Google-Smtp-Source: ABdhPJwho9P0/hsaEFwp0K7Fu4JeYmCk4WUHmiE3+kt3MT7X5yanxhn1NM/JuaheD7q/+beU3CZamQ==
X-Received: by 2002:a17:902:f789:b0:156:5f56:ddff with SMTP id q9-20020a170902f78900b001565f56ddffmr44145155pln.116.1653676534197;
        Fri, 27 May 2022 11:35:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:781f:286a:7724:6870])
        by smtp.gmail.com with ESMTPSA id x26-20020aa793ba000000b0050dc76281e5sm3760913pff.191.2022.05.27.11.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 11:35:33 -0700 (PDT)
Date:   Fri, 27 May 2022 11:35:30 -0700
From:   Fangrui Song <maskray@google.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sebastian Ullrich <sebasti@nullri.ch>
Subject: Re: [PATCH] perf: Fix segbase for ld.lld linked objects
Message-ID: <20220527183530.x4rpomvpehxctf3l@google.com>
References: <20220527055217.452307-1-maskray@google.com>
 <CAP-5=fVk9BmzcinBnjjFKBbNA+ojOo+qjS2m2ZAs7t9c2EkLxw@mail.gmail.com>
 <CAP-5=fU8Pzzz+5W7Vy13tKv0=j8LYNc=+cv12LFvkGoAofJNqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAP-5=fU8Pzzz+5W7Vy13tKv0=j8LYNc=+cv12LFvkGoAofJNqA@mail.gmail.com>
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

On 2022-05-27, Ian Rogers wrote:
>On Thu, May 26, 2022 at 11:49 PM Ian Rogers <irogers@google.com> wrote:
>>
>> On Thu, May 26, 2022 at 10:52 PM Fangrui Song <maskray@google.com> wrote:
>> >
>> > segbase is the address of .eh_frame_hdr and table_data is segbase plus
>> > the header size. find_proc_info computes segbase as `map->start +
>> > segbase - map->pgoff` which is wrong when
>> >
>> > * .eh_frame_hdr and .text are in different PT_LOAD program headers
>> > * and their p_vaddr difference does not equal their p_offset difference
>> >
>> > Since 10.0, ld.lld's default --rosegment -z noseparate-code layout has
>> > such R and RX PT_LOAD program headers.
>> >
>> >     ld.lld => fail
>> >     ld.lld --no-rosegment => ok
>> >     ld.lld -z separate-code => ok
>> >
>> >     ld.bfd -z separate-code (default for Linux/x86) => ok
>> >     ld.bfd -z noseparate-code => ok
>> >
>> > To fix the issue, compute segbase as dso's base address plus
>> > PT_GNU_EH_FRAME's p_vaddr.
>> >
>> > Reported-by: Sebastian Ullrich <sebasti@nullri.ch>
>> > Link: https://github.com/ClangBuiltLinux/linux/issues/1646
>> > Signed-off-by: Fangrui Song <maskray@google.com>
>> > Cc: Ian Rogers <irogers@google.com>
>>
>> Thanks Fangrui! I tested static vs not, bfd and lld, perf test and
>> some hand tests. I couldn't see anything out of order. The code looks
>> good although there could be some ambiguity over the variables ending
>> _addr as these are the ELF given addresses rather than the thread's
>> virtual memory addresses. I'm also trying to get more comments
>> especially on major data structures like dso, but that can be fixed as
>> a follow-on.
>>
>> Tested-by: Ian Rogers <irogers@google.com>
>>
>> > ---
>> >  tools/perf/util/dso.h                    |  2 +
>> >  tools/perf/util/unwind-libunwind-local.c | 96 ++++++++++++++++--------
>> >  2 files changed, 67 insertions(+), 31 deletions(-)
>> >
>> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
>> > index 3a9fd4d389b5..ec4fc1a9454b 100644
>> > --- a/tools/perf/util/dso.h
>> > +++ b/tools/perf/util/dso.h
>> > @@ -179,6 +179,7 @@ struct dso {
>> >         bool             loaded;
>> >         u8               rel;
>> >         struct build_id  bid;
>> > +       u64              base_addr;
>
>This is an address in a thread, as one dso can be shared by multiple
>threads/processes it seems unsafe to hold it as the dso may be loaded
>at a different address in a different thread. For now we can just
>recompute the value rather than store it in the dso.

Ack. Thanks for spotting the issue!
I did not know that dso can be shared (read the code for the first
time), guessing this is why `dso__data_get_fd(dso, ui->machine);` needs
a lock.

>> >         u64              text_offset;
>> >         const char       *short_name;
>> >         const char       *long_name;
>> > @@ -197,6 +198,7 @@ struct dso {
>> >                 u64              file_size;
>> >                 struct list_head open_entry;
>> >                 u64              debug_frame_offset;
>> > +               u64              eh_frame_hdr_addr;
>
>This is the elf section address and safe to hold here.

Ack.

Fixed in PATCH v2
https://lore.kernel.org/linux-perf-users/20220527182039.673248-1-maskray@google.com/T/#u

>Thanks,
>Ian
>
>> >                 u64              eh_frame_hdr_offset;
>> >         } data;
>> >         /* bpf prog information */
>> > diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
>> > index 41e29fc7648a..7a0053954e49 100644
>> > --- a/tools/perf/util/unwind-libunwind-local.c
>> > +++ b/tools/perf/util/unwind-libunwind-local.c
>> > @@ -169,30 +169,55 @@ static int __dw_read_encoded_value(u8 **p, u8 *end, u64 *val,
>> >         __v;                                                    \
>> >         })
>> >
>> > -static u64 elf_section_offset(int fd, const char *name)
>> > +static int elf_section_address_and_offset(int fd, const char *name, u64 *address, u64 *offset)
>> >  {
>> >         Elf *elf;
>> >         GElf_Ehdr ehdr;
>> >         GElf_Shdr shdr;
>> > -       u64 offset = 0;
>> > +       int ret;
>> >
>> >         elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
>> >         if (elf == NULL)
>> > -               return 0;
>> > +               return -1;
>> >
>> > -       do {
>> > -               if (gelf_getehdr(elf, &ehdr) == NULL)
>> > -                       break;
>> > +       if (gelf_getehdr(elf, &ehdr) == NULL)
>> > +               goto out_err;
>> >
>> > -               if (!elf_section_by_name(elf, &ehdr, &shdr, name, NULL))
>> > -                       break;
>> > -
>> > -               offset = shdr.sh_offset;
>> > -       } while (0);
>> > +       if (!elf_section_by_name(elf, &ehdr, &shdr, name, NULL))
>> > +               goto out_err;
>> >
>> > +       *address = shdr.sh_addr;
>> > +       *offset = shdr.sh_offset;
>> > +       ret = 0;
>> > +out_err:
>> >         elf_end(elf);
>> > +       return ret;
>> > +}
>> > +
>> > +#ifndef NO_LIBUNWIND_DEBUG_FRAME
>> > +static u64 elf_section_offset(int fd, const char *name)
>> > +{
>> > +       u64 address, offset;
>> > +
>> > +       if (elf_section_address_and_offset(fd, name, &address, &offset))
>> > +               return 0;
>> > +
>> >         return offset;
>> >  }
>> > +#endif
>> > +
>> > +static int elf_base_address(int fd)
>> > +{
>> > +       Elf *elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
>> > +       GElf_Phdr phdr;
>> > +       int retval = 0;
>> > +
>> > +       if (gelf_getphdr(elf, 0, &phdr) != NULL)
>> > +               retval = phdr.p_vaddr & -getpagesize();
>> > +
>> > +       elf_end(elf);
>> > +       return retval;
>> > +}
>> >
>> >  #ifndef NO_LIBUNWIND_DEBUG_FRAME
>> >  static int elf_is_exec(int fd, const char *name)
>> > @@ -248,8 +273,7 @@ struct eh_frame_hdr {
>> >  } __packed;
>> >
>> >  static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
>> > -                              u64 offset, u64 *table_data, u64 *segbase,
>> > -                              u64 *fde_count)
>> > +                              u64 offset, u64 *table_data_offset, u64 *fde_count)
>> >  {
>> >         struct eh_frame_hdr hdr;
>> >         u8 *enc = (u8 *) &hdr.enc;
>> > @@ -265,35 +289,45 @@ static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
>> >         dw_read_encoded_value(enc, end, hdr.eh_frame_ptr_enc);
>> >
>> >         *fde_count  = dw_read_encoded_value(enc, end, hdr.fde_count_enc);
>> > -       *segbase    = offset;
>> > -       *table_data = (enc - (u8 *) &hdr) + offset;
>> > +       *table_data_offset = enc - (u8 *) &hdr;
>> >         return 0;
>> >  }
>> >
>> > -static int read_unwind_spec_eh_frame(struct dso *dso, struct machine *machine,
>> > +static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
>> >                                      u64 *table_data, u64 *segbase,
>> >                                      u64 *fde_count)
>> >  {
>> > -       int ret = -EINVAL, fd;
>> > -       u64 offset = dso->data.eh_frame_hdr_offset;
>> > +       struct map *map;
>> > +       int ret, fd;
>> >
>> > -       if (offset == 0) {
>> > -               fd = dso__data_get_fd(dso, machine);
>> > +       if (dso->data.eh_frame_hdr_offset == 0) {
>> > +               u64 addr_min = UINT64_MAX;
>> > +
>> > +               fd = dso__data_get_fd(dso, ui->machine);
>> >                 if (fd < 0)
>> >                         return -EINVAL;
>> >
>> >                 /* Check the .eh_frame section for unwinding info */
>> > -               offset = elf_section_offset(fd, ".eh_frame_hdr");
>> > -               dso->data.eh_frame_hdr_offset = offset;
>> > +               ret = elf_section_address_and_offset(fd, ".eh_frame_hdr",
>> > +                                                    &dso->data.eh_frame_hdr_addr,
>> > +                                                    &dso->data.eh_frame_hdr_offset);
>> > +               maps__for_each_entry(ui->thread->maps, map) {
>> > +                       if (map->dso == dso && map->start < addr_min)
>> > +                               addr_min = map->start;
>> > +               }
>> > +               dso->base_addr = addr_min - elf_base_address(fd);
>> >                 dso__data_put_fd(dso);
>> > +               if (ret || dso->data.eh_frame_hdr_offset == 0)
>> > +                   return -EINVAL;
>> >         }
>> >
>> > -       if (offset)
>> > -               ret = unwind_spec_ehframe(dso, machine, offset,
>> > -                                         table_data, segbase,
>> > -                                         fde_count);
>> > -
>> > -       return ret;
>> > +       *segbase = dso->base_addr + dso->data.eh_frame_hdr_addr;
>> > +       ret = unwind_spec_ehframe(dso, ui->machine, dso->data.eh_frame_hdr_offset,
>> > +                                  table_data, fde_count);
>> > +       if (ret)
>> > +           return ret;
>> > +       *table_data += *segbase;
>> > +       return 0;
>> >  }
>> >
>> >  #ifndef NO_LIBUNWIND_DEBUG_FRAME
>> > @@ -388,14 +422,14 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
>> >         pr_debug("unwind: find_proc_info dso %s\n", map->dso->name);
>> >
>> >         /* Check the .eh_frame section for unwinding info */
>> > -       if (!read_unwind_spec_eh_frame(map->dso, ui->machine,
>> > +       if (!read_unwind_spec_eh_frame(map->dso, ui,
>> >                                        &table_data, &segbase, &fde_count)) {
>> >                 memset(&di, 0, sizeof(di));
>> >                 di.format   = UNW_INFO_FORMAT_REMOTE_TABLE;
>> >                 di.start_ip = map->start;
>> >                 di.end_ip   = map->end;
>> > -               di.u.rti.segbase    = map->start + segbase - map->pgoff;
>> > -               di.u.rti.table_data = map->start + table_data - map->pgoff;
>> > +               di.u.rti.segbase    = segbase;
>> > +               di.u.rti.table_data = table_data;
>> >                 di.u.rti.table_len  = fde_count * sizeof(struct table_entry)
>> >                                       / sizeof(unw_word_t);
>> >                 ret = dwarf_search_unwind_table(as, ip, &di, pi,
>> > --
>> > 2.36.1.124.g0e6072fb45-goog
>> >
