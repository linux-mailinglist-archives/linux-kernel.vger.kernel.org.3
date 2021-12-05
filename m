Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC99468BB4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhLEPS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:18:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235646AbhLEPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638717313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPczSTn9rJ4tF0n02nzdBohmqW7rspZdQKioW5HUwoY=;
        b=b6uIHn2jQZ4RKx6QXbdxIJtJZ1727eh/wV5oeAwQA6Bge1l1CF3kLX3V1+fWhjQnve7JDi
        x5PoWh/nS97XH2kRgkGRTOlmUKeQ+GxdzMtEtyQTcNvu0ZK1Ig300gNCqz8M9p3D5fRsJX
        lTtAKc7VM70+tigUATCQ6FxTr6chfXc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-hMi48KZwN-y09zbfV0KQVA-1; Sun, 05 Dec 2021 10:15:12 -0500
X-MC-Unique: hMi48KZwN-y09zbfV0KQVA-1
Received: by mail-wm1-f70.google.com with SMTP id a64-20020a1c7f43000000b003335e5dc26bso4667947wmd.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 07:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CPczSTn9rJ4tF0n02nzdBohmqW7rspZdQKioW5HUwoY=;
        b=RdoJPWgr3Sp05/fcpf/WQRjAErmE8JYDiHdo42AgadWLf0lhm+4jIl1wIQg+j8iERD
         0ezLafIROefE8D9YOwLoN1ZHtULfFU89pJ8jZX68o1DL6IemDFlxTtM9GoBSes3Rllga
         ms1Dx6wUs6JBntDiiDHW2qQj5BpC/G8RMvwmoXBrFJxlPk1jfgQFTJ78gthJt8O/jKfM
         RzDXHetAhOjNXLcmIAFOrBPTlngiZ1jC4oV95CuWdZGWp2BnfpbJDFBQLqpxGeAIb8YM
         bhVSKwOcFF5+bfaRsYqMyabk+g3ey1jQro3fHOsYty0iALcFYE0/99HvVUd0+FfB5rEP
         b8Og==
X-Gm-Message-State: AOAM532EObFbttS83q93WzunOzV5IxtgejfwDLaqH6otk10AXQ8wK1a7
        DfGuuTG0j+aZgEkuw4hd86C/vvLIFJz+J0NaBlmQ9YgiHowXu+RzOqsVTCNohoMIdQQZQuG6Ea5
        +oa0HXI8+FA/Dk/DXZPHUM4Zu
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr37533578wrm.259.1638717310710;
        Sun, 05 Dec 2021 07:15:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+xctttq7Lp1gADO7YjK5mN7E9NfC/+wjfBoAQ2aRUzbZkLalo/9wtKDZIOo6a5qVZRCibww==
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr37533553wrm.259.1638717310390;
        Sun, 05 Dec 2021 07:15:10 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l3sm9692054wmq.46.2021.12.05.07.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:15:10 -0800 (PST)
Date:   Sun, 5 Dec 2021 16:15:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v12 00/16] Introduce threaded trace streaming for basic
 perf record operation
Message-ID: <YazXfO9CoCaR4THO@krava>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 05:07:56PM +0300, Alexey Bayduraev wrote:
> Changes in v12:
> - fixed nr_threads=1 cases
> - fixed "Woken up %ld times" message
> - removed unnecessary record__fini_thread_masks function
> - moved bytes written/compressed statistics to struct record_thread
> - moved all unnecessary debug messages to verbose=2 level
> - renamed "socket" option to "package" for consistency with util/cputopo.h
> - excluded single trace file reading patches
> 
> v11: https://lore.kernel.org/lkml/cover.1629186429.git.alexey.v.bayduraev@linux.intel.com/


I'm getting perf record hang with:

[root@krava perf]# ./perf record --threads
^C[ perf record: Woken up 1 times to write data ]

^C^C^C^C^C




with following backtrace:


(gdb) bt
#0  0x00007f8115d2885f in __GI___poll (fds=fds@entry=0x7ffd2116b930, nfds=1, timeout=1000) at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x00007f811574029e in poll (__timeout=<optimized out>, __nfds=<optimized out>, __fds=0x7ffd2116b930) at /usr/include/bits/poll2.h:48
#2  Curl_poll (timeout_ms=<optimized out>, nfds=<optimized out>, ufds=0x7ffd2116b930) at ../../lib/select.c:374
#3  Curl_poll (ufds=0x7ffd2116b930, nfds=<optimized out>, timeout_ms=<optimized out>) at ../../lib/select.c:329
#4  0x00007f8115739cf7 in multi_wait (multi=multi@entry=0x3458c50, extra_fds=extra_fds@entry=0x0, extra_nfds=extra_nfds@entry=0, timeout_ms=<optimized out>, 
    timeout_ms@entry=1000, ret=ret@entry=0x0, extrawait=extrawait@entry=false, use_wakeup=<optimized out>) at ../../lib/multi.c:1282
#5  0x00007f8115739f26 in multi_wait (use_wakeup=false, extrawait=false, ret=0x0, timeout_ms=1000, extra_nfds=0, extra_fds=0x0, multi=0x3458c50)
    at ../../lib/multi.c:1410
#6  curl_multi_wait (multi=multi@entry=0x3458c50, extra_fds=extra_fds@entry=0x0, extra_nfds=extra_nfds@entry=0, timeout_ms=timeout_ms@entry=1000, 
    ret=ret@entry=0x0) at ../../lib/multi.c:1411
#7  0x00007f811653a7f2 in debuginfod_query_server (c=c@entry=0x2571fb0, build_id=build_id@entry=0x7ffd2116ed70 "c6eee0984964c63e328d13be49d68bd52595ad00", 
    build_id_len=build_id_len@entry=0, type=type@entry=0x7f811653c3ba "debuginfo", filename=filename@entry=0x0, path=path@entry=0x7ffd2116dcf8)
    at /usr/src/debug/elfutils-0.186-1.fc35.x86_64/debuginfod/debuginfod-client.c:1057
#8  0x00007f811653b2a6 in debuginfod_find_debuginfo (client=client@entry=0x2571fb0, 
    build_id=build_id@entry=0x7ffd2116ed70 "c6eee0984964c63e328d13be49d68bd52595ad00", build_id_len=build_id_len@entry=0, path=path@entry=0x7ffd2116dcf8)
    at /usr/src/debug/elfutils-0.186-1.fc35.x86_64/debuginfod/debuginfod-client.c:1511
#9  0x00000000004b18e1 in build_id_cache__find_debug (nsi=0x0, sbuild_id=0x7ffd2116ed70 "c6eee0984964c63e328d13be49d68bd52595ad00") at util/build-id.c:660
#10 build_id_cache__add (sbuild_id=sbuild_id@entry=0x7ffd2116ed70 "c6eee0984964c63e328d13be49d68bd52595ad00", 
    name=name@entry=0x259be50 "/lib/modules/5.15.6-200.fc35.x86_64/kernel/sound/core/seq/snd-seq-dummy.ko.xz", 
    realname=realname@entry=0x27255e0 "/usr/lib/modules/5.15.6-200.fc35.x86_64/kernel/sound/core/seq/snd-seq-dummy.ko.xz", nsi=nsi@entry=0x0, 
    is_kallsyms=is_kallsyms@entry=false, is_vdso=is_vdso@entry=false) at util/build-id.c:724
#11 0x00000000004b1b24 in build_id_cache__add_s (is_vdso=false, is_kallsyms=false, nsi=0x0, 
    name=0x259be50 "/lib/modules/5.15.6-200.fc35.x86_64/kernel/sound/core/seq/snd-seq-dummy.ko.xz", 
    sbuild_id=0x7ffd2116ed70 "c6eee0984964c63e328d13be49d68bd52595ad00") at util/build-id.c:805
#12 build_id_cache__add_b (is_vdso=false, is_kallsyms=<optimized out>, nsi=<optimized out>, name=<optimized out>, bid=<optimized out>) at util/build-id.c:821
#13 dso__cache_build_id (dso=<optimized out>, machine=<optimized out>, priv=<optimized out>) at util/build-id.c:889
#14 0x0000000000501674 in machine__for_each_dso (machine=machine@entry=0x2512d58, fn=fn@entry=0x4b1a00 <dso__cache_build_id>, priv=priv@entry=0x0)
    at util/machine.c:3179
#15 0x00000000004b1f09 in machines__for_each_dso (priv=0x0, fn=0x4b1a00 <dso__cache_build_id>, machines=0x2512d58) at util/build-id.c:896
#16 __perf_session__cache_build_ids (priv=0x0, fn=0x4b1a00 <dso__cache_build_id>, session=0x2512b50) at util/build-id.c:917
#17 __perf_session__cache_build_ids (session=0x2512b50, fn=0x4b1a00 <dso__cache_build_id>, priv=0x0) at util/build-id.c:908
#18 0x00000000004e80fb in write_build_id (ff=ff@entry=0x7ffd2116ef40, evlist=evlist@entry=0x2506050) at util/header.c:329
#19 0x00000000004f15c1 in do_write_feat (evlist=0x2506050, p=<synthetic pointer>, type=2, ff=0x7ffd2116ef40) at util/header.c:3428
#20 perf_header__adds_write (fd=3, evlist=0x2506050, header=0x2512b50) at util/header.c:3473
#21 perf_session__write_header (session=0x2512b50, evlist=0x2506050, fd=3, at_exit=at_exit@entry=true) at util/header.c:3565
#22 0x0000000000423ec4 in record__finish_output (rec=0xbba300 <record>) at builtin-record.c:1673
#23 0x0000000000426374 in __cmd_record (argc=argc@entry=0, argv=argv@entry=0x7ffd21174770, rec=0xbba300 <record>) at builtin-record.c:2600
#24 0x00000000004298e7 in cmd_record (argc=<optimized out>, argv=<optimized out>) at builtin-record.c:3969
#25 0x00000000004a42eb in run_builtin (p=p@entry=0xbd0f78 <commands+216>, argc=argc@entry=2, argv=argv@entry=0x7ffd21174770) at perf.c:313
#26 0x000000000040ec23 in handle_internal_command (argv=<optimized out>, argc=<optimized out>) at perf.c:365
#27 run_argv (argv=<optimized out>, argcp=<optimized out>) at perf.c:409
#28 main (argc=2, argv=0x7ffd21174770) at perf.c:539


jirka

> 
> Changes in v11:
> - removed python dependency on zstd (perf test 19)
> - captured tags from Riccardo Mancini 
> 
> v10: https://lore.kernel.org/lkml/cover.1626072008.git.alexey.v.bayduraev@linux.intel.com/
> 
> Changes in v10:
> - renamed fdarray__clone to fdarray__dup_entry_from
> - captured Acked-by: tags by Namhyung Kim for 09/24
> 
> v9: https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/
> 
> Changes in v9:
> - fixes in [v9 01/24]:
>   - move 'nr_threads' to before 'thread_masks'
>   - combined decl+assign into one line in record__thread_mask_alloc
>   - releasing masks inplace in record__alloc_thread_masks
> - split patch [v8 02/22] to [v9 02/24] and [v9 03/24]
> - fixes in [v9 03/24]:
>   - renamed 'struct thread_data' to 'struct record_thread'
>   - moved nr_mmaps after ctlfd_pos
>   - releasing resources inplace in record__thread_data_init_maps
>   - initializing pipes by -1 value
>   - added temporary gettid() wrapper
> - split patch [v8 03/22] to [v9 04/24] and [v9 05/24] 
> - removed upstreamed [v8 09/22]
> - split [v8 10/22] to [v9 12/24] and [v9 13/24]
> - moved --threads documentation to the related patches
> - fixed output of written/compressed stats in [v9 10/24]
> - split patch [v8 12/22] to [v9 15/24] and [v9 16/24]
> - fixed order of error checking for decompressed events in [v9 16/24]
> - merged patch [v8 21/22] with [v9 23/24] and [v9 24/24]
> - moved patch [v8 22/22] to [v9 09/24]
> - added max reader size constant in [v9 24/24]
> 
> v8: https://lore.kernel.org/lkml/cover.1625065643.git.alexey.v.bayduraev@linux.intel.com/
> 
> Changes in v8:
> - captured Acked-by: tags by Namhyung Kim
> - merged with origin/perf/core
> - added patch 21/22 introducing READER_NODATA state
> - added patch 22/22 fixing --max-size option
> 
> v7: https://lore.kernel.org/lkml/cover.1624350588.git.alexey.v.bayduraev@linux.intel.com/
> 
> Changes in v7:
> - fixed possible crash after out_free_threads label
> - added missing pthread_attr_destroy() call
> - added check of correctness of user masks 
> - fixed zsts_data finalization
> 
> v6: https://lore.kernel.org/lkml/cover.1622025774.git.alexey.v.bayduraev@linux.intel.com/
> 
> Changes in v6:
> - fixed leaks and possible double free in record__thread_mask_alloc()
> - fixed leaks in record__init_thread_user_masks()
> - fixed final mmaps flushing for threads id > 0
> - merged with origin/perf/core
> 
> v5: https://lore.kernel.org/lkml/cover.1619781188.git.alexey.v.bayduraev@linux.intel.com/
> 
> Changes in v5:
> - fixed leaks in record__init_thread_masks_spec()
> - fixed leaks after failed realloc
> - replaced "%m" to strerror()
> - added masks examples to the documentation
> - captured Acked-by: tags by Andi Kleen
> - do not allow --thread option for full_auxtrace mode 
> - split patch 06/12 to 06/20 and 07/20
> - split patch 08/12 to 09/20 and 10/20
> - split patches 11/12 and 11/12 to 13/20-20/20
> 
> v4: https://lore.kernel.org/lkml/6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com/
> 
> Changes in v4:
> - renamed 'comm' structure to 'pipes'
> - moved thread fd/maps messages to verbose=2
> - fixed leaks during allocation of thread_data structures
> - fixed leaks during allocation of thread masks
> - fixed possible fails when releasing thread masks
> 
> v3: https://lore.kernel.org/lkml/7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com/
> 
> Changes in v3:
> - avoided skipped redundant patch 3/15
> - applied "data file" and "data directory" terms allover the patch set
> - captured Acked-by: tags by Namhyung Kim
> - avoided braces where don't needed
> - employed thread local variable for serial trace streaming 
> - added specs for --thread option - core, socket, numa and user defined
> - added parallel loading of data directory files similar to the prototype [1]
> 
> v2: https://lore.kernel.org/lkml/1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com/
> 
> Changes in v2:
> - explicitly added credit tags to patches 6/15 and 15/15,
>   additionally to cites [1], [2]
> - updated description of 3/15 to explicitly mention the reason
>   to open data directories in read access mode (e.g. for perf report)
> - implemented fix for compilation error of 2/15
> - explicitly elaborated on found issues to be resolved for
>   threaded AUX trace capture
> 
> v1: https://lore.kernel.org/lkml/810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com/
> 
> Patch set provides parallel threaded trace streaming mode for basic
> perf record operation. Provided mode mitigates profiling data losses
> and resolves scalability issues of serial and asynchronous (--aio)
> trace streaming modes on multicore server systems. The design and
> implementation are based on the prototype [1], [2].
> 
> Parallel threaded mode executes trace streaming threads that read kernel
> data buffers and write captured data into several data files located at
> data directory. Layout of trace streaming threads and their mapping to data
> buffers to read can be configured using a value of --thread command line
> option. Specification value provides masks separated by colon so the masks
> define cpus to be monitored by one thread and thread affinity mask is
> separated by slash. <cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask 2>
> specifies parallel threads layout that consists of two threads with
> corresponding assigned cpus to be monitored. Specification value can be
> a string e.g. "cpu", "core" or "socket" meaning creation of data streaming
> thread for monitoring every cpu, whole core or socket. The option provided
> with no or empty value defaults to "cpu" layout creating data streaming
> thread for every cpu being monitored. Specification masks are filtered
> by the mask provided via -C option.
> 
> Parallel streaming mode is compatible with Zstd compression/decompression
> (--compression-level) and external control commands (--control). The mode
> is not enabled for pipe mode. The mode is not enabled for AUX area tracing,
> related and derived modes like --snapshot or --aux-sample. --switch-output-*
> and --timestamp-filename options are not enabled for parallel streaming.
> Initial intent to enable AUX area tracing faced the need to define some
> optimal way to store index data in data directory. --switch-output-* and
> --timestamp-filename use cases are not clear for data directories.
> Asynchronous(--aio) trace streaming and affinity (--affinity) modes are
> mutually exclusive to parallel streaming mode.
> 
> Basic analysis of data directories is provided in perf report mode.
> Raw dump and aggregated reports are available for data directories,
> still with no memory consumption optimizations.
> 
> Tested:
> 
> tools/perf/perf record -o prof.data --threads -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads= -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=cpu -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=core -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=socket -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=numa -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data -C 2,5 --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data -C 3,4 --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data -C 0,4,2,6 --threads=core -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data -C 0,4,2,6 --threads=numa -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads -g --call-graph dwarf,4096 -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads -g --call-graph dwarf,4096 --compression-level=3 -- matrix.gcc.g.O3
> tools/perf/perf record -o prof.data --threads -a
> tools/perf/perf record -D -1 -e cpu-cycles -a --control fd:10,11 -- sleep 30
> tools/perf/perf record --threads -D -1 -e cpu-cycles -a --control fd:10,11 -- sleep 30
> 
> tools/perf/perf report -i prof.data
> tools/perf/perf report -i prof.data --call-graph=callee
> tools/perf/perf report -i prof.data --stdio --header
> tools/perf/perf report -i prof.data -D --header
> 
> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> 
> Alexey Bayduraev (16):
>   perf record: Introduce thread affinity and mmap masks
>   tools lib: Introduce fdarray duplicate function
>   perf record: Introduce thread specific data array
>   perf record: Introduce function to propagate control commands
>   perf record: Introduce thread local variable
>   perf record: Stop threads in the end of trace streaming
>   perf record: Start threads in the beginning of trace streaming
>   perf record: Introduce data file at mmap buffer object
>   perf record: Introduce bytes written stats
>   perf record: Introduce compressor at mmap buffer object
>   perf record: Introduce data transferred and compressed stats
>   perf record: Introduce --threads command line option
>   perf record: Extend --threads command line option
>   perf record: Implement compatibility checks
>   perf session: Load data directory files for analysis
>   perf report: Output data file name in raw trace dump
> 
>  tools/lib/api/fd/array.c                 |   17 +
>  tools/lib/api/fd/array.h                 |    1 +
>  tools/perf/Documentation/perf-record.txt |   30 +
>  tools/perf/builtin-inject.c              |    3 +-
>  tools/perf/builtin-kvm.c                 |    2 +-
>  tools/perf/builtin-record.c              | 1167 ++++++++++++++++++++--
>  tools/perf/builtin-top.c                 |    2 +-
>  tools/perf/builtin-trace.c               |    2 +-
>  tools/perf/util/evlist.c                 |   16 +
>  tools/perf/util/evlist.h                 |    1 +
>  tools/perf/util/mmap.c                   |   10 +
>  tools/perf/util/mmap.h                   |    3 +
>  tools/perf/util/ordered-events.c         |    3 +-
>  tools/perf/util/ordered-events.h         |    3 +-
>  tools/perf/util/record.h                 |    2 +
>  tools/perf/util/session.c                |  208 +++-
>  tools/perf/util/session.h                |    3 +-
>  tools/perf/util/tool.h                   |    3 +-
>  18 files changed, 1370 insertions(+), 106 deletions(-)
> 
> -- 
> 2.19.0
> 

