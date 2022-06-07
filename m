Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E548C541509
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 22:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376456AbiFGU0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 16:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356510AbiFGTgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 15:36:39 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3FF1ACE73;
        Tue,  7 Jun 2022 11:13:30 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 134so10075427iou.12;
        Tue, 07 Jun 2022 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3wk3vE05GmoK4OKiW6MbO1jzUBwfjbF3RO3sZka4u5w=;
        b=kyv+J9uo8rVfEt79as0se2cJZdaPRsgQkzKFFy+2OAU7l49GtWFdVzmBDhVS1+8R6K
         +tKNGY7Jgevr9Xav/0lxhb8w1Wh8phPkm16vzi71tjXxqwwGp/BEsS4czh6xSHRxRLkZ
         aCp05jbuqMtoF57twN/oYI8hZ8FZZXtZbvi5s8Hq3CZEzvbgd5McD9NgcPbT78yMIirz
         uPa50ZuptW66xplcwJIjeuBnULtYCx4iCY9i4ByE67f1ZOak2uE8UtRKCrCoS52i1ECf
         tZOH47ODKakU3fm/GV7+I0SjD8wfRgRlBYjQXboudvInKQ33xC0u1EL7funnQM8kbInN
         SENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3wk3vE05GmoK4OKiW6MbO1jzUBwfjbF3RO3sZka4u5w=;
        b=QkNyPoMfQn+wP1vR+Oc/kT/5nM0FfBO/X7DZCIT2M+v4JziDaAGesGIdpE/jDZG7dZ
         iSWOyY6SlwlfYAjQGUyrI0h6KD5NEjIPGeaJgHo9RojcwcM+zpSdZdNq/Zgvp1tBrjLF
         lC0i+Maox/jXzGJjYXu2CeRD+3Y2H+zg99BCz+fd5cvBfc/3v5ILNrM95MJggSt9NuR2
         f+L0j7pmIkDVhS5PR8tCAhrEK0dElSu7691izT4MHhC534mVHu9/sPUm4vTV2iifgCSK
         vgWwkAGBja1u/AowJB+I0cUpEBw78joDrVa42CU5bczfi+oG4Hg/vxDDxCHBORdSFHAc
         DuvA==
X-Gm-Message-State: AOAM532vmln7ECky4UomON2q7n7SH5JLYkXqkzH3tQjclBc06eIeh2Fw
        gSasY4qJiaJxt5cM/To3aBE7eFadPf0LiPndh6Y=
X-Google-Smtp-Source: ABdhPJywRDF4Gq9orpB0mEQklOMtyOI4f+fzvomrVYwKviGqK1E/7iq8Wc+QSMhTmppm8uuM0WPtj03uU6P9Owq9wCs=
X-Received: by 2002:a6b:440c:0:b0:669:440b:66f3 with SMTP id
 r12-20020a6b440c000000b00669440b66f3mr7647992ioa.128.1654625608321; Tue, 07
 Jun 2022 11:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220607000851.39798-1-irogers@google.com>
In-Reply-To: <20220607000851.39798-1-irogers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 7 Jun 2022 20:12:52 +0200
Message-ID: <CA+icZUW-Zrri=ofkdVtNNYcBCQ-cNvLt7GHfcJw54bxzf_zjZA@mail.gmail.com>
Subject: Re: [PATCH] perf unwind: Fix uninitialized variable
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Fangrui Song <maskray@google.com>,
        Sebastian Ullrich <sebasti@nullri.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 2:09 AM Ian Rogers <irogers@google.com> wrote:
>
> ret may be uninitialized on error goto paths.
>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Fixes: dc2cf4ca866f ("perf unwind: Fix segbase for ld.lld linked objects")
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks for the patch.

Feel free to add my:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

$ LC_ALL=C ll ~/bin/perf
-rwxr-xr-x 2 dileks dileks 16M Jun  7 20:10 /home/dileks/bin/perf

$ ~/bin/perf -vv
perf version 5.19.0-rc1
                dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
   dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
        syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
               libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
           debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
               libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
              libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
              libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
            libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
             libslang: [ on  ]  # HAVE_SLANG_SUPPORT
            libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
            libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
   libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                 zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                 lzma: [ on  ]  # HAVE_LZMA_SUPPORT
            get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                  bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                  aio: [ on  ]  # HAVE_AIO_SUPPORT
                 zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
              libpfm4: [ OFF ]  # HAVE_LIBPFM

-Sedat-

> ---
>  tools/perf/util/unwind-libunwind-local.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> index 37622699c91a..6e5b8cce47bf 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -174,7 +174,7 @@ static int elf_section_address_and_offset(int fd, const char *name, u64 *address
>         Elf *elf;
>         GElf_Ehdr ehdr;
>         GElf_Shdr shdr;
> -       int ret;
> +       int ret = -1;
>
>         elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
>         if (elf == NULL)
> --
> 2.36.1.255.ge46751e96f-goog
>
