Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395045AB527
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbiIBP3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbiIBP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:28:35 -0400
X-Greylist: delayed 598 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Sep 2022 08:04:48 PDT
Received: from ext6.scm.com (ext6.scm.com [5.9.60.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E09F5F60;
        Fri,  2 Sep 2022 08:04:48 -0700 (PDT)
Received: from mintaka.ncbr.muni.cz (mintaka.ncbr.muni.cz [147.251.90.119])
        by ext6.scm.com (Postfix) with ESMTPSA id 8E07E7E803ED;
        Fri,  2 Sep 2022 16:46:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=scm.com;
        s=dkim20220819; t=1662130007;
        bh=QipHUAFLlQN8U0AxHQTuwbsAVXcDR9FKYRB7FW1CTBE=;
        h=From:To:Cc:Subject:Date:From;
        b=AfN0yqr9om7o+c6a7MhakZ4jromiLK15f5sJbWN7DQA4RyZ2XOttED2bN0E3my+be
         nHIPjP6PqX8PXXsB5TJ3BcUr2vhHKR5RKXAxpU9guMzDPG8R8ZPFg+QtAYAAvoPUjS
         kpwegXHb/+DcEBQDVhNspRiMVqSu3C7R8jafQj9ZnR+J8SuI0RO7/kZycDbUUSEqsF
         XqOQewDqkXvefRyzntnvFQusutDT+fjVL18/mooXF/BdPvikrRR0Pd6uZdWd9rceTx
         Sv2Td07oph8vEvSQOYBtxS/YG55kbrtWUslb7gpNySf+J0gD5H6Ka+fAz/YCysLM0K
         7UzCyVyjyvfcQ==
From:   =?utf-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: perf top -p broken for multithreaded processes since 5.19
Date:   Fri, 02 Sep 2022 16:46:45 +0200
Message-ID: <10137382.nUPlyArG6x@mintaka.ncbr.muni.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A bug in perf v5.19 and newer completely breaks monitoring multithreaded
processes using "perf top -p". The tool fails to start with "Failed to mmap
with 22 (Invalid argument)". It still seems to work fine on single-threaded
processes. "perf record" is also unaffected.

I have bisected the issue to the following commit:

commit ae4f8ae16a07896403c90305d4b9be27f657c1fc
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Tue May 24 10:54:31 2022 +0300

    libperf evlist: Allow mixing per-thread and per-cpu mmaps
   =20
    mmap_per_evsel() will skip events that do not match the CPU, so all CPUs
    can be iterated in any case.

The issue can be easily reproduced using the following test:

$ python - <<EOF
import time
import threading
th =3D threading.Thread(target=3Dtime.sleep, args=3D(3600,))
th.start()
th.join()
EOF

stracing "perf top -p $(pgrep python)" yields this:

145184 perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3DPERF_ATTR_SIZE_VE=
R7, config=3DPERF_COUNT_HW_CPU_CYCLES, sample_freq=3D4000, sample_type=3DPE=
RF_SAMPLE_IP|PERF_SAMPLE_TID|PERF_SAMPLE_TIME|PERF_SAMPLE_PERIOD, read_form=
at=3DPERF_FORMAT_ID, disabled=3D1, exclude_kernel=3D1, mmap=3D1, comm=3D1, =
freq=3D1, task=3D1, precise_ip=3D0 /* arbitrary skid */, sample_id_all=3D1,=
 mmap2=3D1, comm_exec=3D1, ksymbol=3D1, ...}, 92061, -1, -1, PERF_FLAG_FD_C=
LOEXEC) =3D 3
 > tools/perf/perf(evsel__open_cpu+0x287) [0x4c8ad7]
 > tools/perf/perf(cmd_top+0x1996) [0x439b26]
 > tools/perf/perf(run_builtin+0x68) [0x4a91f8]
 > tools/perf/perf(main+0x645) [0x40cad5]
145184 perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3DPERF_ATTR_SIZE_VE=
R7, config=3DPERF_COUNT_HW_CPU_CYCLES, sample_freq=3D4000, sample_type=3DPE=
RF_SAMPLE_IP|PERF_SAMPLE_TID|PERF_SAMPLE_TIME|PERF_SAMPLE_PERIOD, read_form=
at=3DPERF_FORMAT_ID, disabled=3D1, exclude_kernel=3D1, mmap=3D1, comm=3D1, =
freq=3D1, task=3D1, precise_ip=3D0 /* arbitrary skid */, sample_id_all=3D1,=
 mmap2=3D1, comm_exec=3D1, ksymbol=3D1, ...}, 104619, -1, -1, PERF_FLAG_FD_=
CLOEXEC) =3D 5
 > tools/perf/perf(evsel__open_cpu+0x287) [0x4c8ad7]
 > tools/perf/perf(cmd_top+0x1996) [0x439b26]
 > tools/perf/perf(run_builtin+0x68) [0x4a91f8]
 > tools/perf/perf(main+0x645) [0x40cad5]
=E2=80=A6(snip)=E2=80=A6
145184 ioctl(5, PERF_EVENT_IOC_SET_OUTPUT, 3) =3D -1 EINVAL (Invalid argume=
nt)
 > tools/perf/perf(perf_evlist__mmap_ops+0x2cf) [0x5d497f]
 > tools/perf/perf(evlist__mmap+0xa7) [0x4c09b7]
 > perf/perf(cmd_top+0x1ccd) [0x439e5d]
 > tools/perf/perf(run_builtin+0x68) [0x4a91f8]
 > tools/perf/perf(main+0x645) [0x40cad5]

Best regards,

Tom=C3=A1=C5=A1
=2D-
Tom=C3=A1=C5=A1 Trnka
Software for Chemistry & Materials B.V.



