Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828484EAB33
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiC2K2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiC2K2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4F9F2AE3A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648549618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z3VdtsV7Mt0HPHZ2S0nq3Ho3kOS/p9vrNcK6WqWifvc=;
        b=gNWqY6JsYJJ6g7pwz2ExexUk0Mtun4Fo/9J1/CAchaahIISRi1oWzhqlMwB0cEzSH11G6d
        ++eP7y2DIgWW/u9XLeyuWB7tzaQk6hr10VS3oIenaLihqoF01TV2haFuNRhxWDJl10jSK8
        VOHb8X8QZrEj0BKepTfclF6adk0bJAE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-8ma5bdNwMqWsaYR3EVv_UQ-1; Tue, 29 Mar 2022 06:26:57 -0400
X-MC-Unique: 8ma5bdNwMqWsaYR3EVv_UQ-1
Received: by mail-lj1-f200.google.com with SMTP id f12-20020a2e918c000000b002496651f1d6so7293418ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z3VdtsV7Mt0HPHZ2S0nq3Ho3kOS/p9vrNcK6WqWifvc=;
        b=PbqMJucudJqeO0jZIF0crbLRcf/vyvuUu7cVBGThZgTopaH2lpFcNifnz9yHVSQw9P
         3MnakrErbBBJKOtBN/9K9U9HCo0X9O+U4hKxKm4rOayB3Z69TMdxGtcFjqvyP04H2Pv7
         T9r1DktOKX5Ty5nR9F+InZIJPqySHRwC8Spzf+E0GXOHZOnCLn8SQweEZHQsB4ooNujv
         iM6hBm+xE+0QQFcSb83hLo3vRgpBqcEE94qtHrc2QjnOYRQazTUOdWyXxD3iin31xjOU
         HFerRRJYLc6HiXtvokQRuHUJWqGKJ2KB4TdXea2VAKnGXzr+QK0xRa9UkAg22vu4culj
         xcbQ==
X-Gm-Message-State: AOAM5301RbpaiHvluAMhq3nS8PqMtYtAcnWsMu1h+IEH+51Q8RqLbSm6
        uwNC9RNX9A6NWeM+cEU3/idICVEfUNJ2Jvs4Fnzc5byRqnbU1v5tToJ8NQDxOgOEwMBgJw3s7yV
        JC92xLl64ZPMoMdXFpbWHtj1jYZ2SiG0B0WogY7fT
X-Received: by 2002:a05:6512:3d8f:b0:44a:2c65:8323 with SMTP id k15-20020a0565123d8f00b0044a2c658323mr2087411lfv.52.1648549614359;
        Tue, 29 Mar 2022 03:26:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1sVP3a3GKLVknaZbCgRPHgMmBx1vaBwHT/RpPgJKTOtXXlYxC14ENXweDZzGDz6dIshQw/oGN2NHbJngOKrU=
X-Received: by 2002:a05:6512:3d8f:b0:44a:2c65:8323 with SMTP id
 k15-20020a0565123d8f00b0044a2c658323mr2087385lfv.52.1648549614069; Tue, 29
 Mar 2022 03:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220311032233.GD18612@xsang-OptiPlex-9020>
In-Reply-To: <20220311032233.GD18612@xsang-OptiPlex-9020>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 29 Mar 2022 12:26:43 +0200
Message-ID: <CA+QYu4osuzA+V5Th29SOsS1FnAZgdsaTc_qNPyPp=GH+q1LZYQ@mail.gmail.com>
Subject: Re: [fs] 37da949345: xfstests.generic.374.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 4:23 AM kernel test robot <oliver.sang@intel.com> w=
rote:
>
>
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 37da9493451c35886a11bfe45d62adc27d9c46b3 ("fs: allow cross-vfsmou=
nt reflink/dedupe")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> in testcase: xfstests
> version: xfstests-x86_64-1de1db8-1_20220217
> with following parameters:
>
>         disk: 4HDD
>         fs: btrfs
>         test: generic-group-18
>         ucode: 0xec
>
> test-description: xfstests is a regression test suite for xfs and other f=
iles ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>
>
> on test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz with=
 16G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
> 2022-03-10 14:43:23 export TEST_DIR=3D/fs/sda1
> 2022-03-10 14:43:23 export TEST_DEV=3D/dev/sda1
> 2022-03-10 14:43:23 export FSTYP=3Dbtrfs
> 2022-03-10 14:43:23 export SCRATCH_MNT=3D/fs/scratch
> 2022-03-10 14:43:23 mkdir /fs/scratch -p
> 2022-03-10 14:43:23 export SCRATCH_DEV_POOL=3D"/dev/sda2 /dev/sda3 /dev/s=
da4"
> 2022-03-10 14:43:23 sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests/g=
eneric-group-18
> 2022-03-10 14:43:23 ./check generic/360 generic/361 generic/362 generic/3=
63 generic/364 generic/365 generic/366 generic/367 generic/368 generic/369 =
generic/370 generic/371 generic/372 generic/373 generic/374 generic/375 gen=
eric/376 generic/377 generic/378 generic/379
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 lkp-skl-d06 5.17.0-rc7-00085-g37da9493451c =
#1 SMP Thu Mar 10 21:42:40 CST 2022
> MKFS_OPTIONS  -- /dev/sda2
> MOUNT_OPTIONS -- /dev/sda2 /fs/scratch
>
> generic/360      1s
> generic/361      12s
> generic/362     [not run] this test requires richacl support on $SCRATCH_=
DEV
> generic/363     [not run] this test requires richacl support on $SCRATCH_=
DEV
> generic/364     [not run] this test requires richacl support on $SCRATCH_=
DEV
> generic/365     [not run] this test requires richacl support on $SCRATCH_=
DEV
> generic/366     [not run] this test requires richacl support on $SCRATCH_=
DEV
> generic/367     [not run] this test requires richacl support on $SCRATCH_=
DEV
> generic/368     [not run] this test requires richacl support on $SCRATCH_=
DEV
> generic/369     [not run] this test requires richacl support on $SCRATCH_=
DEV
> generic/370     [not run] this test requires richacl support on $SCRATCH_=
DEV
> generic/371      68s
> generic/372     [not run] Explicit SHARED flag reporting not support by f=
ilesystem type: btrfs
> generic/373     - output mismatch (see /lkp/benchmarks/xfstests/results//=
generic/373.out.bad)
>     --- tests/generic/373.out   2022-02-17 11:55:00.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//generic/373.out.bad   2022-03-1=
0 14:44:54.201679653 +0000
>     @@ -3,7 +3,6 @@
>      Mount otherdir
>      Create file
>      Reflink one file to another
>     -cp: failed to clone 'OTHER_DIR/test-373/otherfiles' from 'SCRATCH_MN=
T/test-373/file': Invalid cross-device link
>      Check output
>      2d61aa54b58c2e94403fb092c3dbc027  SCRATCH_MNT/test-373/file
>      Unmount otherdir
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/373.out /lkp/ben=
chmarks/xfstests/results//generic/373.out.bad'  to see the entire diff)
> generic/374     - output mismatch (see /lkp/benchmarks/xfstests/results//=
generic/374.out.bad)
>     --- tests/generic/374.out   2022-02-17 11:55:00.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//generic/374.out.bad   2022-03-1=
0 14:44:55.890679630 +0000
>     @@ -3,7 +3,8 @@
>      Mount otherdir
>      Create file
>      Dedupe one file to another
>     -XFS_IOC_FILE_EXTENT_SAME: Invalid cross-device link
>     +deduped 65536/65536 bytes at offset 0
>     +64 KiB, 1 ops; 0.0018 sec (33.967 MiB/sec and 543.4783 ops/sec)
>      Check output
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/374.out /lkp/ben=
chmarks/xfstests/results//generic/374.out.bad'  to see the entire diff)
> generic/375      1s
> generic/376      2s
> generic/377      1s
> generic/378      1s
> generic/379     [not run] disk quotas not supported by this filesystem ty=
pe: btrfs
> Ran: generic/360 generic/361 generic/362 generic/363 generic/364 generic/=
365 generic/366 generic/367 generic/368 generic/369 generic/370 generic/371=
 generic/372 generic/373 generic/374 generic/375 generic/376 generic/377 ge=
neric/378 generic/379
> Not run: generic/362 generic/363 generic/364 generic/365 generic/366 gene=
ric/367 generic/368 generic/369 generic/370 generic/372 generic/379
> Failures: generic/373 generic/374
> Failed 2 of 20 tests
>
>

We are also able to reproduce this on mainline kernel with gcc12, the
problem seems to have been introduced by [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D5191290407668028179f2544a11ae9b57f0bcf07

Bruno
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> ---
> 0-DAY CI Kernel Test Service
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org
>
> Thanks,
> Oliver Sang
>

