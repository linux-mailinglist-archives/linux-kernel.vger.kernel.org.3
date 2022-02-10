Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668674B1112
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbiBJO5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:57:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243290AbiBJO5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:57:37 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3337DC51
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:57:37 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u6so10986842lfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pg9FzP26LmpWryPvitUm/Fbht2mPNaCOpOrgJa4B7iA=;
        b=MGIalNatTRUPqIdr82kA6Jju/JdwJreTzuJ4RNGJl1CckGXGKe8QnPM2OD3Qln/SyA
         agBNetYMZJaxG23W1Wp8HxL/g59dFpXRybZ6ewZeYTlw77dep3Sj/DU/6OWdEKGoxQS/
         GtpGSDxB6a+tmcLEffj+XUG6sxjZM/qp6jT0kyjMLuCCtswWHpZqkNcLmIehx5S3jKTe
         /+0kVQA4OJfYapGNFhcoabSMJgczrP+bhujvpM4msu0mwNgxGicAvI7+5BUqanttMyI5
         Ihf7kqznMLwuxNSTfAfXAI3+Sg4qCfuhycUbGPtlVQIsXcV7HcPE6i8wPWvVDWfC840W
         K3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pg9FzP26LmpWryPvitUm/Fbht2mPNaCOpOrgJa4B7iA=;
        b=VG/nRGyUlbE8XfP2UQiPp0pGVm/eEaBKafSrtQ26IXLC4PtEUTzKyLqi8A6ESZ9q4V
         IJoAi/odG6Vrm7ArreUDPYej+lr1HPI+C6DNcnTtyKt9dqg0BdcC27zXv0CHCXYecCLa
         Clz2h2ZObd7jDGuCgqOo0xfJC3Fu0iA7ANaFnVY/5gKTwQ/hA9ceR/i3Gi9A8dQ2WW/d
         xSqCk/0yYkjx1iG6A56eP14oLv6jrouKv5X6TE4xxWiawqUoPAFafGyTVtnOHIlUBCvE
         MABZun+nHWfbVpWvmCgHGtd/PX+EehO8XXMweIlkNjSl6FWEfAvDp2+oynEz9mpHEP38
         L6yg==
X-Gm-Message-State: AOAM5339czrHGRZNSZzYK3Ijt07+jWlmLo/pMuptJsgKYYukiDIT5SY3
        O9dT/jcMT32ovuqV+8Z/fVvhwDpyPYIXmpPc6RvHog==
X-Google-Smtp-Source: ABdhPJwgTzQY+E0X4TE56VOW7BCxvAonO5DARQPbf6Gklh3B7hKtHsAaZZgDoLna4twwtute5zGtrCOkwiMaMiapo30=
X-Received: by 2002:a05:6512:108e:: with SMTP id j14mr733232lfg.233.1644505055430;
 Thu, 10 Feb 2022 06:57:35 -0800 (PST)
MIME-Version: 1.0
References: <8e61aed5f64e434abc1d7b6f81859c8a@realtek.com> <CAPDyKFrLpim75nUB7ksDie2edkWsnFSq6TbFSFFpw5cY5d4y1w@mail.gmail.com>
 <fabaed5751f04105a9719c1cb0390c98@realtek.com> <CAPDyKFr3NRUgfKtkb2DBrhziekFAB0jT_X3Fsfvjk_bGZLC9mA@mail.gmail.com>
 <fa10aa1c644241808c2ad880088240ab@realtek.com> <CAPDyKFrtBKHHRgeF-JO27ANsbSmt8rdnhn-WNr5Je9okEgA29Q@mail.gmail.com>
 <feb0c4e71e9c48a2a21f18b7d3baf135@realtek.com> <CAPDyKFoq_PDk_JgW4D+o4eEPdcffUq2RLbBreRDqeK47m0UnJA@mail.gmail.com>
 <a82d7e877dc041d4be5e0ef38c2da406@realtek.com>
In-Reply-To: <a82d7e877dc041d4be5e0ef38c2da406@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 10 Feb 2022 15:56:58 +0100
Message-ID: <CAPDyKFo59Q3dmUJU-hJ++=k0uwx2KxamW9KckDX=O_CA84O1_g@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: rtsx: improve performance for multi block rw
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 at 07:43, Ricky WU <ricky_wu@realtek.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Monday, February 7, 2022 7:11 PM
> > To: Ricky WU <ricky_wu@realtek.com>
> > Cc: tommyhebb@gmail.com; linux-mmc@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3] mmc: rtsx: improve performance for multi block =
rw
> >
> > [...]
> >
> > > > > > >
> > > > > > > Do you have any suggestion for testing random I/O But we thin=
k
> > > > > > > random I/O will not change much
> > > > > >
> > > > > > I would probably look into using fio,
> > > > > > https://fio.readthedocs.io/en/latest/
> > > > > >
> > > > >
> > > > > Filled random I/O data
> > > > > Before the patch:
> > > > > CMD (Randread):
> > > > > sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -threa=
d
> > > > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D1G -name=
=3Dmytest
> > > > > -bs=3D1M -rw=3Drandread
> > > >
> > > > Thanks for running the tests! Overall, I would not expect an impact
> > > > on the throughput when using a big blocksize like 1M. This is also
> > > > pretty clear from the result you have provided.
> > > >
> > > > However, especially for random writes and reads, we want to try wit=
h
> > > > smaller blocksizes. Like 8k or 16k, would you mind running another
> > > > round of tests to see how that works out?
> > > >
> > >
> > > Filled random I/O data(8k/16k)
> >
> > Hi Ricky,
> >
> > Apologize for the delay! Thanks for running the tests. Let me comment o=
n
> > them below.
> >
> > >
> > > Before(randread)
> > > 8k:
> > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -thre=
ad
> > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D1G -name=3Dmy=
test
> > > -bs=3D8k -rw=3Drandread
> > > mytest: (g=3D0): rw=3Drandread, bs=3D(R) 8192B-8192B, (W) 8192B-8192B=
, (T)
> > > 8192B-8192B, ioengine=3Dpsync, iodepth=3D1
> > > result:
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D16.5MiB/s (17.3MB/s), 16.5MiB/s-16.5MiB/s
> > > (17.3MB/s-17.3MB/s), io=3D1024MiB (1074MB), run=3D62019-62019msec Dis=
k
> > stats (read/write):
> > >   mmcblk0: ios=3D130757/0, merge=3D0/0, ticks=3D57751/0, in_queue=3D5=
7751,
> > > util=3D99.89%
> > >
> > > 16k:
> > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -thre=
ad
> > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D1G -name=3Dmy=
test
> > > -bs=3D16k -rw=3Drandread
> > > mytest: (g=3D0): rw=3Drandread, bs=3D(R) 16.0KiB-16.0KiB, (W)
> > > 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=3Dpsync, iodepth=3D1
> > > result:
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D23.3MiB/s (24.4MB/s), 23.3MiB/s-23.3MiB/s
> > > (24.4MB/s-24.4MB/s), io=3D1024MiB (1074MB), run=3D44034-44034msec Dis=
k
> > stats (read/write):
> > >   mmcblk0: ios=3D65333/0, merge=3D0/0, ticks=3D39420/0, in_queue=3D39=
420,
> > > util=3D99.84%
> > >
> > > Before(randrwrite)
> > > 8k:
> > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -thre=
ad
> > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D100M -name=3D=
mytest
> > > -bs=3D8k -rw=3Drandwrite
> > > mytest: (g=3D0): rw=3Drandwrite, bs=3D(R) 8192B-8192B, (W) 8192B-8192=
B, (T)
> > > 8192B-8192B, ioengine=3Dpsync, iodepth=3D1
> > > result:
> > > Run status group 0 (all jobs):
> > >   WRITE: bw=3D4060KiB/s (4158kB/s), 4060KiB/s-4060KiB/s
> > > (4158kB/s-4158kB/s), io=3D100MiB (105MB), run=3D25220-25220msec Disk =
stats
> > (read/write):
> > >   mmcblk0: ios=3D51/12759, merge=3D0/0, ticks=3D80/24154, in_queue=3D=
24234,
> > > util=3D99.90%
> > >
> > > 16k:
> > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -thre=
ad
> > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D100M -name=3D=
mytest
> > > -bs=3D16k -rw=3Drandwrite
> > > mytest: (g=3D0): rw=3Drandwrite, bs=3D(R) 16.0KiB-16.0KiB, (W)
> > > 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=3Dpsync, iodepth=3D1
> > > result:
> > > Run status group 0 (all jobs):
> > >   WRITE: bw=3D7201KiB/s (7373kB/s), 7201KiB/s-7201KiB/s
> > > (7373kB/s-7373kB/s), io=3D100MiB (105MB), run=3D14221-14221msec Disk =
stats
> > (read/write):
> > >   mmcblk0: ios=3D51/6367, merge=3D0/0, ticks=3D82/13647, in_queue=3D1=
3728,
> > > util=3D99.81%
> > >
> > >
> > > After(randread)
> > > 8k:
> > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -thre=
ad
> > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D1G -name=3Dmy=
test
> > > -bs=3D8k -rw=3Drandread
> > > mytest: (g=3D0): rw=3Drandread, bs=3D(R) 8192B-8192B, (W) 8192B-8192B=
, (T)
> > > 8192B-8192B, ioengine=3Dpsync, iodepth=3D1
> > > result:
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D12.4MiB/s (13.0MB/s), 12.4MiB/s-12.4MiB/s
> > > (13.0MB/s-13.0MB/s), io=3D1024MiB (1074MB), run=3D82397-82397msec Dis=
k
> > stats (read/write):
> > >   mmcblk0: ios=3D130640/0, merge=3D0/0, ticks=3D74125/0, in_queue=3D7=
4125,
> > > util=3D99.94%
> > >
> > > 16k:
> > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -thre=
ad
> > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D1G -name=3Dmy=
test
> > > -bs=3D16k -rw=3Drandread
> > > mytest: (g=3D0): rw=3Drandread, bs=3D(R) 16.0KiB-16.0KiB, (W)
> > > 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=3Dpsync, iodepth=3D1
> > > result:
> > > Run status group 0 (all jobs):
> > >    READ: bw=3D20.0MiB/s (21.0MB/s), 20.0MiB/s-20.0MiB/s
> > > (21.0MB/s-21.0MB/s), io=3D1024MiB (1074MB), run=3D51076-51076msec Dis=
k
> > stats (read/write):
> > >   mmcblk0: ios=3D65282/0, merge=3D0/0, ticks=3D46255/0, in_queue=3D46=
254,
> > > util=3D99.87%
> > >
> > > After(randwrite)
> > > 8k:
> > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -thre=
ad
> > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D100M -name=3D=
mytest
> > > -bs=3D8k -rw=3Drandwrite
> > > mytest: (g=3D0): rw=3Drandwrite, bs=3D(R) 8192B-8192B, (W) 8192B-8192=
B, (T)
> > > 8192B-8192B, ioengine=3Dpsync, iodepth=3D1
> > > result:
> > > Run status group 0 (all jobs):
> > >   WRITE: bw=3D4215KiB/s (4317kB/s), 4215KiB/s-4215KiB/s
> > > (4317kB/s-4317kB/s), io=3D100MiB (105MB), run=3D24292-24292msec Disk =
stats
> > (read/write):
> > >   mmcblk0: ios=3D52/12717, merge=3D0/0, ticks=3D86/23182, in_queue=3D=
23267,
> > > util=3D99.92%
> > >
> > > 16k:
> > > Cmd: sudo fio -filename=3D/dev/mmcblk0 -direct=3D1 -numjobs=3D1 -thre=
ad
> > > -group_reporting -ioengine=3Dpsync -iodepth=3D1 -size=3D100M -name=3D=
mytest
> > > -bs=3D16k -rw=3Drandwrite
> > > mytest: (g=3D0): rw=3Drandwrite, bs=3D(R) 16.0KiB-16.0KiB, (W)
> > > 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=3Dpsync, iodepth=3D1
> > > result:
> > > Run status group 0 (all jobs):
> > >   WRITE: bw=3D6499KiB/s (6655kB/s), 6499KiB/s-6499KiB/s
> > > (6655kB/s-6655kB/s), io=3D100MiB (105MB), run=3D15756-15756msec Disk =
stats
> > (read/write):
> > >   mmcblk0: ios=3D51/6347, merge=3D0/0, ticks=3D84/15120, in_queue=3D1=
5204,
> > > util=3D99.80%
> >
> > It looks like the rand-read tests above are degrading with the new chan=
ges,
> > while rand-writes are both improving and degrading.
> >
> > To summarize my view from all the tests you have done at this point (th=
anks a
> > lot); it looks like the block I/O merging isn't really happening at com=
mon
> > blocklayer, at least to that extent that would benefit us. Clearly you =
have shown
> > that by the suggested change in the mmc host driver, by detecting wheth=
er the
> > "next" request is sequential to the previous one, which allows us to sk=
ip a
> > CMD12 and minimize some command overhead.
> >
> > However, according to the latest tests above, you have also proved that=
 the
> > changes in the mmc host driver doesn't come without a cost.
> > In particular, small random-reads would degrade in performance from the=
se
> > changes.
> >
> > That said, it looks to me that rather than trying to improve things for=
 one
> > specific mmc host driver, it would be better to look at this from the g=
eneric
> > block layer point of view - and investigate why sequential reads/writes=
 aren't
> > getting merged often enough for the MMC/SD case. If we can fix the prob=
lem
> > there, all mmc host drivers would benefit I assume.
> >
>
> So you are thinking about how to patch this in MMC/SD?
> I don't know if this method is compatible with other MMC Hosts? Or they n=
eed to patch other code on their host driver

I would not limit this to the core layer of MMC/SD. The point I was
trying to make was that it doesn't look like the generic block layer
is merging the sequential I/O requests in the most efficient way, at
least for the eMMC/SD devices. Why this is the case, I can't tell. It
looks like we need to do some more in-depth analysis to understand why
merging isn't efficient for us.

>
> > BTW, have you tried with different I/O schedulers? If you haven't tried=
 BFQ, I
> > suggest you do as it's a good fit for MMC/SD.
> >
>
> I don=E2=80=99t know what is different I/O schedulers means?

What I/O scheduler did you use when running the test?

For MMC/SD the only one that makes sense to use is BFQ, however that
needs to be configured via sysfs after boot. There is no way,
currently, to make it the default, I think. You may look at
Documentation/block/bfq-iosched.rst, if you are more interested.

Kind regards
Uffe
