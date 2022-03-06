Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285904CEC22
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 16:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiCFPnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 10:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiCFPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 10:43:14 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA19910FEB;
        Sun,  6 Mar 2022 07:42:21 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hw13so26982346ejc.9;
        Sun, 06 Mar 2022 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HfO2h5q1473JP2upK1zqZF3m0Phtdwl0dsxMjuAMUAc=;
        b=TUG2TbXA26Z7N1AdNjzw5HZWtBkBdsXv/EgmeAiKT5NQJn7ma2tI921ze85VnP1szT
         P4lPetpnIzpdqCyvo9vxUKY8lP0o6/TBIp2/0uRHEUkwix4wtNqmMzZGE96jSJS9lTdC
         1lhSplGrTY0luO0XkZhO1uaL7EavP+1J4EUYQ4zByDypg7QIJVGpHTQEbo95/fw7HTYA
         6zGsvuJGYZzyvbJOwQ8FOV3SkMjPP8CzYlKRbrpJifORo7xRzNTLKdS6T5RbhtiaSCiy
         X02REn2eDUZUzA6OyxfCiZxWz8PjcGL9fJTHe+trTDR5UiMiU0xGwXOLfUdSxfd5Zsyh
         /u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HfO2h5q1473JP2upK1zqZF3m0Phtdwl0dsxMjuAMUAc=;
        b=RWNUDv6JUdKktOO0AmsFpZo5DOTnUsaZ6QDHFfKu8r4fLPyX9ogYIMCvk3/p6O5BDy
         N32ubBQg+AldM9jq54NUvAnXQ/uPUK3xsT8zBdVk+r79IYtvl3CiC2IMfzbV5bzrOMxR
         8wL9g3cB4X7JNZb7BkBdv8WraPtEyhh4i5QwdHcqiAjshPnXRN7rkksDi3ERpgKvkAvb
         Xuous/y4VcmESB6jZuzgIqhRbczDuI1tzVWZVPsOCZv9FeT+9uLApFTYdM501lkaCN2B
         DTE2w50mmLLAvu1nrr6o4aE8vf49BiF6Git9Okep//JXjngBUa+F70QmUejA/PIr7s+E
         VxQQ==
X-Gm-Message-State: AOAM533gHIWBt3SBC1JNGDOxzvooxwUMZzqbMeJFiK4JgwSsjnCiUPp9
        v/HrAb/JrCLCCC7w3p6ljt4tHaRcyl2poQ==
X-Google-Smtp-Source: ABdhPJwNCo+8KRwq9nmvmwmLV85jcIttAIb9ng/q1JMqBPiV/Ons8xrtuf3CO1z3ijgUBYyRIdxe1Q==
X-Received: by 2002:a17:906:9744:b0:6da:9e49:9fe3 with SMTP id o4-20020a170906974400b006da9e499fe3mr6218024ejy.319.1646581340155;
        Sun, 06 Mar 2022 07:42:20 -0800 (PST)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id v2-20020a509d02000000b00412d53177a6sm4941630ede.20.2022.03.06.07.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 07:42:19 -0800 (PST)
Date:   Sun, 6 Mar 2022 16:42:14 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Linux-v5.17-rc6] Building tools/perf with perl v5.34
Message-ID: <YiTWVjKwOO/bMNz/@krava>
References: <CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com>
 <YiPDaiYffeK4lF+l@krava>
 <CA+icZUW0XyDHFTYF_j1QECpqP4kmTXqCqX_HfEVvQ4aWZecW5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUW0XyDHFTYF_j1QECpqP4kmTXqCqX_HfEVvQ4aWZecW5Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 03:28:09AM +0100, Sedat Dilek wrote:
> On Sat, Mar 5, 2022 at 9:09 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Sat, Mar 05, 2022 at 08:52:18AM +0100, Sedat Dilek wrote:
> > > Hi,
> > >
> > > I am here on Debian/unstable AMD64 which switched over to perl v5.34
> > > in February 2022.
> > >
> > > Unfortunately, my perf does not build with this (lib)perl version:
> > >
> > > $ ~/bin/perf -vv
> > > perf version 5.17-rc6
> > >                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
> > >    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> > >                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
> > >         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> > >                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
> > >                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> > >               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > >               libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT
> > >             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> > >              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> > >             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> > >             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
> > >    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
> > >                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> > >                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> > >             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> > >                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> > >                   aio: [ on  ]  # HAVE_AIO_SUPPORT
> > >                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> > >               libpfm4: [ OFF ]  # HAVE_LIBPFM
> > >
> > > $ grep libperl ../make-log_perf-python3.10-install_bin.txt
> > > 9:Makefile.config:788: Missing perl devel files. Disabling perl
> > > scripting support, please install perl-ExtUtils-Embed/libperl-dev
> > > 22:...                       libperl: [ OFF ]
> > >
> > > Checking for these requirements:
> > >
> > > # dpkg -l | grep perl | grep 5.34 | awk '/^ii/ {print $1 " " $2 " "
> > > $3}' | column -t
> > > ii  libperl-dev:amd64  5.34.0-3
> > > ii  libperl5.34:amd64  5.34.0-3
> > > ii  perl               5.34.0-3
> > > ii  perl-base          5.34.0-3
> > > ii  perl-modules-5.34  5.34.0-3
> > >
> > > # dpkg -L perl-modules-5.34 | grep -i ExtUtils | grep -i Embed
> > > /usr/share/perl/5.34.0/ExtUtils/Embed.pm
> > >
> > > Can you please comment on this?
> >
> > hi,
> > is there something in tools/build/feature/test-libperl.make.output ?
> >
> 
> Hey jirka!
> 
> Indeed there is such a file.
> 
> $ LC_ALL=C ll tools/build/feature/test-libperl.make.output
> -rw-r--r-- 1 dileks dileks 24K Mar  6 03:22
> tools/build/feature/test-libperl.make.output
> 
> Reproducer:
> 
> make distclean
> make -C tools/perf clean
> 
> MAKE="make"
> MAKE_OPTS="HOSTCC=clang-13 HOSTCXX=clang++-13 HOSTLD=ld.lld-13
> HOSTAR=llvm-ar-13 CC=clang-13 LD=ld.lld-13 AR=llvm-ar-13 NM=llvm-nm-13
> OBJCOPY=llvm-objcopy-13 OBJDUMP=llvm-objdump-13 OBJSIZE=llvm-size-13
> READELF=llvm-readelf-13 STRIP=llvm-strip-13 LLVM_IAS=1"
> 
> LC_ALL=C $MAKE V=1 $MAKE_OPTS -C tools/perf PYTHON=python3 install-bin

yea, looks like we can't compile perl devel includes with clang,
we use simple perl test program:

	$ cd tools/build/feature/
	$ cat test-libperl.c 
	// SPDX-License-Identifier: GPL-2.0
	#include <EXTERN.h>
	#include <perl.h>

	int main(void)
	{
		perl_alloc();

		return 0;
	}


and if I compile it with:

	$ CC=clang make test-libperl.bin
	clang  -MD -Wall -Werror -o test-libperl.bin test-libperl.c  > test-libperl.make.output 2>&1 `perl -MExtUtils::Embed -e ccopts 2>/dev/null` -Wl,--enable-new-dtags -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -fstack-protector-strong -L/usr/local/lib  -L/usr/lib64/perl5/CORE -lperl -lpthread -lresolv -ldl -lm -lcrypt -lutil -lc
	make: *** [Makefile:224: test-libperl.bin] Error 1


I'm getting some other lto related error:

	$ cat test-libperl.make.output 
	clang-13: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]


with my clang version:

	$ clang --version
	clang version 13.0.0 (Fedora 13.0.0-3.fc35)
	Target: x86_64-redhat-linux-gnu
	Thread model: posix
	InstalledDir: /usr/bin

so you need to figure out how to compile the test program
above first with clang

jirka
