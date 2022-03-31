Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225044EE49F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbiCaXYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiCaXYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:24:02 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017C749685
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:22:13 -0700 (PDT)
Date:   Thu, 31 Mar 2022 23:22:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michaelmarod.com;
        s=protonmail; t=1648768931;
        bh=H/HIIOtE6ezWt3oBMOEbUNvqPRvMS/qhwtcdJgLLn40=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=QFUpB8Mf5Yo249YgcpZ2mBq/kbYlExC4LlzZC9jN5oobhUwMNnV3yPX5RgUtdCQV9
         stnloZ02HxUnlbbDG8BgBswAfG4aNxP0QPBTKspeZSh5CwVkzzoPq1wY2p8tuo/Jxf
         FPUqDsTIhOGhqZwXivTEpSjnx3bJKQpAm64p14zk=
To:     Christoph Hellwig <hch@infradead.org>
From:   Michael Marod <michael@michaelmarod.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Reply-To: Michael Marod <michael@michaelmarod.com>
Subject: Re: NVME performance regression in Linux 5.x due to lack of block level IO queueing
Message-ID: <4034AD9F-2A6A-4AE6-B5FC-58FC2BC238F5@michaelmarod.com>
In-Reply-To: <YkUvgu6VxNORv8M6@infradead.org>
References: <51E3A396-F68B-496D-AE36-B0457A3B0968@michaelmarod.com> <847D3821-1D92-468C-88C3-34284BA7922E@michaelmarod.com> <C06B8EF0-BF3B-4F14-994F-F80B5102D538@michaelmarod.com> <YkUvgu6VxNORv8M6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good call -- Turns out that that cache issue is resolved in 5.17. I tried a=
 number of kernels and narrowed it down to a problem that started after 4.9=
 and before 4.15, and ended some time after 5.13. Namely, 4.9 is good, 4.15=
 is bad, 5.13 is bad, and 5.17 is good. I did not bisect it all the way dow=
n to the specific versions where the behaviors changed.

Device            r/s     w/s     rkB/s     wkB/s   rrqm/s   wrqm/s  %rrqm =
 %wrqm r_await w_await aqu-sz rareq-sz wareq-sz  svctm  %util
nvme1n1       2758.00 2783.00  11032.00  11132.00     0.00     0.00   0.00 =
  0.00    0.10    0.03   0.36     4.00     4.00   0.18 100.00
nvme0n1       2830.00 2875.00  11320.00  11500.00     0.00     0.00   0.00 =
  0.00    0.10    0.03   0.39     4.00     4.00   0.18 100.00

With regards to the performance between 4.4.0 and 5.17, for a single thread=
, 4.4.0 still had better performance over 5.17. However, the 5.17 kernel wa=
s significantly better at multiple threads. In fact, it is so much better I=
 don't believe the results (10x improvement!). Is this to be expected that =
a single thread would be slower in 5.17, but recent improvements make it po=
ssible to run many of them in parallel more efficiently?

# /usr/local/bin/fio -name=3Drandrw -filename=3D/opt/foo -direct=3D1 -iodep=
th=3D1 -thread -rw=3Drandrw -ioengine=3Dpsync -bs=3D4k -size=3D10G -numjobs=
=3D16 -group_reporting=3D1 -runtime=3D120

// Ubuntu 16.04 / Linux 4.4.0:
Run status group 0 (all jobs):
   READ: bw=3D54.5MiB/s (57.1MB/s), 54.5MiB/s-54.5MiB/s (57.1MB/s-57.1MB/s)=
, io=3D6537MiB (6854MB), run=3D120002-120002msec
  WRITE: bw=3D54.5MiB/s (57.2MB/s), 54.5MiB/s-54.5MiB/s (57.2MB/s-57.2MB/s)=
, io=3D6544MiB (6862MB), run=3D120002-120002msec

// Ubuntu 18.04 / Linux 5.4.0:
Run status group 0 (all jobs):
   READ: bw=3D23.5MiB/s (24.7MB/s), 23.5MiB/s-23.5MiB/s (24.7MB/s-24.7MB/s)=
, io=3D2821MiB (2959MB), run=3D120002-120002msec
  WRITE: bw=3D23.5MiB/s (24.6MB/s), 23.5MiB/s-23.5MiB/s (24.6MB/s-24.6MB/s)=
, io=3D2819MiB (2955MB), run=3D120002-120002msec

// Ubuntu 18.04 / Linux 5.17:
Run status group 0 (all jobs):
   READ: bw=3D244MiB/s (255MB/s), 244MiB/s-244MiB/s (255MB/s-255MB/s), io=
=3D28.6GiB (30.7GB), run=3D120001-120001msec
  WRITE: bw=3D244MiB/s (256MB/s), 244MiB/s-244MiB/s (256MB/s-256MB/s), io=
=3D28.6GiB (30.7GB), run=3D120001-120001msec

Thanks,
Michael
