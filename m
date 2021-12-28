Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AE34809CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhL1OFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhL1OFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:05:23 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC28C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 06:05:22 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id s4so12851546ljd.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 06:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CD159WSDCNs1sJ+Mi35aaV09+ezYMaoFXLhOa2eMKw=;
        b=MYXyDIE42LQuizMj9Ldvg3dFL0VfEe9ntOR/IaGaNGbwvlpszWnAkZEWYsA9z4l3St
         b8LRla241M4Aj8pEjiippqi1ceJhhf339RafAGZ4bNm17AvPgbu0kr9nfYWcqXTwZpAd
         mIGqDp1tQkdmesmzhIgYKKE9lF/g1qNZ/bZw4l9V3XaaRI2L5mzdOmlj7HqXNLIcDXFR
         cs183YIUfxqMDUeh/s5VZ4H6FcNCmdNM63YqAF1UdWGJj/ItdvxTVFWmJRpUhg0Aq3Ir
         JESwBOcwdumW61eZ/R+yd3MI/76t8Dc5zrC994TxVe1VZcWX3QvL8QmFBpIWL8xnFBZe
         T/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CD159WSDCNs1sJ+Mi35aaV09+ezYMaoFXLhOa2eMKw=;
        b=XPUyYPQvD+r8vOyU7pgKCosRPlW449qGCrKzL3BP4dkCSJ0mlZtYhervegISuK3qtf
         Tfh/g28QNDcaPUwVgvKC3XtVKLaTBVarc/ezSKEJ26vJpui/RXm8xXRsurGtxgnQbTYu
         84xoRi50dy8VqpVOSx+SAEIDb3QvbncwTWpRkGe1ZwZ+BMKP1R3M46JMTjCkFjxGnIfj
         7v+X7dT7+D+OzJPJ+xCxQzBrnNcaHM6Mu97hIKSRCiZJ2bsSSb/Z3XvAYgZsp+mK6Aj8
         xrlraQYkD/qB1falmwatRNCAG8YuIIh6N/H+ZxSeQXvoBO9LB4zzcWw/FiasYulPeuwZ
         RTGg==
X-Gm-Message-State: AOAM5312rM4UqUrR7oPXdb/WNDZRaj0XRNFBJrueVLnRjW0jzsGSc+zD
        bBawL369PmfCepZP9D/aWqBfy23VAnXxBR/j9jWqKg==
X-Google-Smtp-Source: ABdhPJyOYSQOipfIsJJxL2+gRAQQvmrYATzQAIb2Jc44rUK/M9/w/cJpNiLrEdNP005DFOZ3+nmCkCFEwPtbFYYAczI=
X-Received: by 2002:a2e:968d:: with SMTP id q13mr17648935lji.463.1640700320842;
 Tue, 28 Dec 2021 06:05:20 -0800 (PST)
MIME-Version: 1.0
References: <8e61aed5f64e434abc1d7b6f81859c8a@realtek.com> <CAPDyKFrLpim75nUB7ksDie2edkWsnFSq6TbFSFFpw5cY5d4y1w@mail.gmail.com>
 <fabaed5751f04105a9719c1cb0390c98@realtek.com> <CAPDyKFr3NRUgfKtkb2DBrhziekFAB0jT_X3Fsfvjk_bGZLC9mA@mail.gmail.com>
 <fa10aa1c644241808c2ad880088240ab@realtek.com>
In-Reply-To: <fa10aa1c644241808c2ad880088240ab@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 15:04:44 +0100
Message-ID: <CAPDyKFrtBKHHRgeF-JO27ANsbSmt8rdnhn-WNr5Je9okEgA29Q@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: rtsx: improve performance for multi block rw
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 at 08:23, Ricky WU <ricky_wu@realtek.com> wrote:
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Thursday, December 23, 2021 6:37 PM
> > To: Ricky WU <ricky_wu@realtek.com>
> > Cc: tommyhebb@gmail.com; linux-mmc@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3] mmc: rtsx: improve performance for multi block rw
> >
> > On Thu, 23 Dec 2021 at 11:27, Ricky WU <ricky_wu@realtek.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Sent: Tuesday, December 21, 2021 8:51 PM
> > > > To: Ricky WU <ricky_wu@realtek.com>
> > > > Cc: tommyhebb@gmail.com; linux-mmc@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v3] mmc: rtsx: improve performance for multi
> > > > block rw
> > > >
> > > > On Tue, 21 Dec 2021 at 13:24, Ricky WU <ricky_wu@realtek.com> wrote:
> > > > >
> > > > > Improving performance for the CMD is multi-block read/write and
> > > > > the data is sequential.
> > > > > sd_check_multi_seq() to distinguish multi-block RW (CMD 18/25) or
> > > > > normal RW (CMD 17/24) if the CMD is multi-block and the data is
> > > > > sequential then call to sd_rw_multi_seq()
> > > > >
> > > > > This patch mainly to control the timing of reply at CMD 12/13.
> > > > > Originally code driver reply CMD 12/13 at every RW (CMD 18/25).
> > > > > The new code to distinguish multi-block RW(CMD 18/25) and the data
> > > > > is sequential or not, if the data is sequential RW driver do not
> > > > > send CMD
> > > > > 12 and bypass CMD 13 until wait the different direction RW CMD or
> > > > > trigger the delay_work to sent CMD 12.
> > > > >
> > > > > run benchmark result as below:
> > > > > SD Card : Samsumg Pro Plus 128GB
> > > > > Number of Samples:100, Sample Size:10MB <Before> Read : 86.9 MB/s,
> > > > > Write : 38.3 MB/s <After>  Read : 91.5 MB/s, Write : 55.5 MB/s
> > > >
> > > > A much nicer commit message, thanks a lot! Would you mind running
> > > > some additional tests, like random I/O read/writes?
> > > >
> > > > Also, please specify the benchmark tool and command you are using.
> > > > In the meantime, I will continue to look at the code.
> > > >
> > >
> > > The Tool just use Ubuntu internal GUI benchmark Tool in the "Disks"
> > > and the Tool don't have random I/O to choice...
> > >
> > > Do you have any suggestion for testing random I/O But we think random
> > > I/O will not change much
> >
> > I would probably look into using fio, https://fio.readthedocs.io/en/latest/
> >
>
> Filled random I/O data
> Before the patch:
> CMD (Randread):
> sudo fio -filename=/dev/mmcblk0 -direct=1 -numjobs=1 -thread -group_reporting -ioengine=psync -iodepth=1 -size=1G -name=mytest -bs=1M -rw=randread

Thanks for running the tests! Overall, I would not expect an impact on
the throughput when using a big blocksize like 1M. This is also pretty
clear from the result you have provided.

However, especially for random writes and reads, we want to try with
smaller blocksizes. Like 8k or 16k, would you mind running another
round of tests to see how that works out?

I haven't yet been able to provide you with comments on the code, but
I am looking into it.

Kind regards
Uffe

>
> mytest: (g=0): rw=randread, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=psync, iodepth=1
> fio-3.16
> Starting 1 thread
> Jobs: 1 (f=1): [r(1)][100.0%][r=86.0MiB/s][r=86 IOPS][eta 00m:00s]
> mytest: (groupid=0, jobs=1): err= 0: pid=2663: Fri Dec 24 14:28:33 2021
>   read: IOPS=85, BW=85.1MiB/s (89.3MB/s)(1024MiB/12026msec)
>     clat (usec): min=11253, max=34579, avg=11735.57, stdev=742.16
>      lat (usec): min=11254, max=34580, avg=11736.34, stdev=742.16
>     clat percentiles (usec):
>      |  1.00th=[11338],  5.00th=[11469], 10.00th=[11600], 20.00th=[11600],
>      | 30.00th=[11600], 40.00th=[11600], 50.00th=[11731], 60.00th=[11731],
>      | 70.00th=[11863], 80.00th=[11863], 90.00th=[11863], 95.00th=[11863],
>      | 99.00th=[11863], 99.50th=[12518], 99.90th=[15664], 99.95th=[34341],
>      | 99.99th=[34341]
>    bw (  KiB/s): min=81920, max=88064, per=99.91%, avg=87110.67, stdev=1467.81, samples=24
>    iops        : min=   80, max=   86, avg=85.00, stdev= 1.41, samples=24
>   lat (msec)   : 20=99.90%, 50=0.10%
>   cpu          : usr=0.17%, sys=1.26%, ctx=2048, majf=0, minf=256
>   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      issued rwts: total=1024,0,0,0 short=0,0,0,0 dropped=0,0,0,0
>      latency   : target=0, window=0, percentile=100.00%, depth=1
>
> Run status group 0 (all jobs):
>    READ: bw=85.1MiB/s (89.3MB/s), 85.1MiB/s-85.1MiB/s (89.3MB/s-89.3MB/s), io=1024MiB (1074MB), run=12026-12026msec
>
> Disk stats (read/write):
>   mmcblk0: ios=2026/0, merge=0/0, ticks=17612/0, in_queue=17612, util=99.23%
>
> CMD (Randwrite):
> sudo fio -filename=/dev/mmcblk0 -direct=1 -numjobs=1 -thread -group_reporting -ioengine=psync -iodepth=1 -size=1G -name=mytest -bs=1M -rw=randwrite
>
> mytest: (g=0): rw=randwrite, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=psync, iodepth=1
> fio-3.16
> Starting 1 thread
> Jobs: 1 (f=1): [w(1)][100.0%][w=41.0MiB/s][w=41 IOPS][eta 00m:00s]
> mytest: (groupid=0, jobs=1): err= 0: pid=2738: Fri Dec 24 14:30:05 2021
>   write: IOPS=38, BW=38.4MiB/s (40.2MB/s)(1024MiB/26695msec); 0 zone resets
>     clat (usec): min=18862, max=94708, avg=25990.34, stdev=9227.22
>      lat (usec): min=18910, max=94781, avg=26061.91, stdev=9228.04
>     clat percentiles (usec):
>      |  1.00th=[20579],  5.00th=[22414], 10.00th=[22676], 20.00th=[22938],
>      | 30.00th=[23200], 40.00th=[23462], 50.00th=[23462], 60.00th=[23725],
>      | 70.00th=[23725], 80.00th=[23987], 90.00th=[24773], 95.00th=[56361],
>      | 99.00th=[59507], 99.50th=[64226], 99.90th=[86508], 99.95th=[94897],
>      | 99.99th=[94897]
>    bw (  KiB/s): min=24576, max=43008, per=99.85%, avg=39221.13, stdev=3860.74, samples=53
>    iops        : min=   24, max=   42, avg=38.30, stdev= 3.77, samples=53
>   lat (msec)   : 20=0.98%, 50=92.38%, 100=6.64%
>   cpu          : usr=0.50%, sys=0.31%, ctx=1024, majf=0, minf=0
>   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      issued rwts: total=0,1024,0,0 short=0,0,0,0 dropped=0,0,0,0
>      latency   : target=0, window=0, percentile=100.00%, depth=1
>
> Run status group 0 (all jobs):
>   WRITE: bw=38.4MiB/s (40.2MB/s), 38.4MiB/s-38.4MiB/s (40.2MB/s-40.2MB/s), io=1024MiB (1074MB), run=26695-26695msec
>
> Disk stats (read/write):
>   mmcblk0: ios=52/2043, merge=0/0, ticks=81/39874, in_queue=39956, util=99.90%
>
>
> After the patch:
>
> CMD (Randread):
> sudo fio -filename=/dev/mmcblk0 -direct=1 -numjobs=1 -thread -group_reporting -ioengine=psync -iodepth=1 -size=1G -name=mytest -bs=1M -rw=randread
>
> mytest: (g=0): rw=randread, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=psync, iodepth=1
> fio-3.16
> Starting 1 thread
> Jobs: 1 (f=1): [r(1)][100.0%][r=87.0MiB/s][r=87 IOPS][eta 00m:00s]
> mytest: (groupid=0, jobs=1): err= 0: pid=11614: Fri Dec 24 14:07:06 2021
>   read: IOPS=86, BW=86.6MiB/s (90.8MB/s)(1024MiB/11828msec)
>     clat (usec): min=11068, max=32423, avg=11543.12, stdev=733.86
>      lat (usec): min=11069, max=32424, avg=11543.85, stdev=733.87
>     clat percentiles (usec):
>      |  1.00th=[11076],  5.00th=[11338], 10.00th=[11469], 20.00th=[11469],
>      | 30.00th=[11469], 40.00th=[11469], 50.00th=[11469], 60.00th=[11600],
>      | 70.00th=[11600], 80.00th=[11600], 90.00th=[11600], 95.00th=[11600],
>      | 99.00th=[11600], 99.50th=[11731], 99.90th=[21627], 99.95th=[32375],
>      | 99.99th=[32375]
>    bw (  KiB/s): min=83968, max=90112, per=99.94%, avg=88598.26, stdev=1410.46, samples=23
>    iops        : min=   82, max=   88, avg=86.52, stdev= 1.38, samples=23
>   lat (msec)   : 20=99.80%, 50=0.20%
>   cpu          : usr=0.09%, sys=1.40%, ctx=2048, majf=0, minf=256
>   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      issued rwts: total=1024,0,0,0 short=0,0,0,0 dropped=0,0,0,0
>      latency   : target=0, window=0, percentile=100.00%, depth=1
>
> Run status group 0 (all jobs):
>    READ: bw=86.6MiB/s (90.8MB/s), 86.6MiB/s-86.6MiB/s (90.8MB/s-90.8MB/s), io=1024MiB (1074MB), run=11828-11828msec
>
> Disk stats (read/write):
>   mmcblk0: ios=2016/0, merge=0/0, ticks=17397/0, in_queue=17397, util=99.21%
>
> CMD (Randwrite):
> sudo fio -filename=/dev/mmcblk0 -direct=1 -numjobs=1 -thread -group_reporting -ioengine=psync -iodepth=1 -size=1G -name=mytest -bs=1M -rw=randwrite
>
> mytest: (g=0): rw=randwrite, bs=(R) 1024KiB-1024KiB, (W) 1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=psync, iodepth=1
> fio-3.16
> Starting 1 thread
> Jobs: 1 (f=1): [w(1)][100.0%][w=50.0MiB/s][w=50 IOPS][eta 00m:00s]
> mytest: (groupid=0, jobs=1): err= 0: pid=11668: Fri Dec 24 14:08:36 2021
>   write: IOPS=39, BW=39.3MiB/s (41.2MB/s)(1024MiB/26059msec); 0 zone resets
>     clat (msec): min=16, max=118, avg=25.37, stdev=16.34
>      lat (msec): min=16, max=118, avg=25.44, stdev=16.34
>     clat percentiles (msec):
>      |  1.00th=[   17],  5.00th=[   20], 10.00th=[   20], 20.00th=[   20],
>      | 30.00th=[   20], 40.00th=[   20], 50.00th=[   20], 60.00th=[   20],
>      | 70.00th=[   21], 80.00th=[   21], 90.00th=[   52], 95.00th=[   75],
>      | 99.00th=[   78], 99.50th=[  104], 99.90th=[  114], 99.95th=[  120],
>      | 99.99th=[  120]
>    bw (  KiB/s): min=20480, max=51200, per=99.93%, avg=40211.69, stdev=10498.00, samples=52
>    iops        : min=   20, max=   50, avg=39.27, stdev=10.25, samples=52
>   lat (msec)   : 20=72.95%, 50=16.80%, 100=9.57%, 250=0.68%
>   cpu          : usr=0.41%, sys=0.38%, ctx=1024, majf=0, minf=0
>   IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      issued rwts: total=0,1024,0,0 short=0,0,0,0 dropped=0,0,0,0
>      latency   : target=0, window=0, percentile=100.00%, depth=1
>
> Run status group 0 (all jobs):
>   WRITE: bw=39.3MiB/s (41.2MB/s), 39.3MiB/s-39.3MiB/s (41.2MB/s-41.2MB/s), io=1024MiB (1074MB), run=26059-26059msec
>
> Disk stats (read/write):
>   mmcblk0: ios=51/2031, merge=0/0, ticks=84/40061, in_queue=40144, util=99.89%
>
> BR,
> Ricky
