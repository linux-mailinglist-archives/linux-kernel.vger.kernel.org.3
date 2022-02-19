Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099124BCAAB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 22:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiBSVEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 16:04:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiBSVEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 16:04:20 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78DF343EFD;
        Sat, 19 Feb 2022 13:03:59 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C654052F78C;
        Sun, 20 Feb 2022 08:03:55 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nLWtW-00E1z1-7i; Sun, 20 Feb 2022 08:03:54 +1100
Date:   Sun, 20 Feb 2022 08:03:54 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Kyle Sanderson <kyle.leet@gmail.com>
Cc:     qat-linux@intel.com, giovanni.cabiddu@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <20220219210354.GF59715@dread.disaster.area>
References: <CACsaVZ+mt3CfdXV0_yJh7d50tRcGcRZ12j3n6-hoX2cz3+njsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsaVZ+mt3CfdXV0_yJh7d50tRcGcRZ12j3n6-hoX2cz3+njsg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62115b3d
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=nt1UNTH2AAAA:8 a=7-415B0cAAAA:8
        a=tiecrrFWBOFT3706sEAA:9 a=CjuIK1q_8ugA:10 a=1jnEqRSf4vEA:10
        a=7AW3Uk2BEroXwU7YnAE8:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 09:02:28PM -0800, Kyle Sanderson wrote:
> A2SDi-8C-HLN4F has IQAT enabled by default, when this device is
> attempted to be used by xfs (through dm-crypt) the entire kernel
> thread stalls forever. Multiple users have hit this over the years
> (through sporadic reporting) - I ended up trying ZFS and encryption
> wasn't an issue there at all because I guess they don't use this
> device. Returning to sanity (xfs), I was able to provision a dm-crypt
> volume no problem on the disk, however when running mkfs.xfs on the
> volume is what triggers the cascading failure (each request kills a
> kthread).

Can you provide the full stack traces for these errors so we can see
exactly what this cascading failure looks like, please? In reality,
the stall messages some time after this are not interesting - it's
the first errors that cause the stall that need to be investigated.

A good idea would be to provide the full storage stack decription
and hardware in use, as per:

https://xfs.org/index.php/XFS_FAQ#Q:_What_information_should_I_include_when_reporting_a_problem.3F

> Disabling IQAT on the south bridge results in a working
> system, however this is not the default configuration for the
> distribution of choice (Ubuntu 20.04.3 LTS), nor the motherboard. I'm
> convinced this never worked properly based on the lack of popularity
> for kernel encryption (crypto), and the embedded nature that
> SuperMicro has integrated this device in collaboration with intel as
> it looks like the primary usage is through external accelerator cards.

This really sounds like broken hardware, not a kernel problem.

> Kernels tried were from RHEL8 over a year ago, and this impacts the
> entirety of the 5.4 series on Ubuntu.
> Please CC me on replies as I'm not subscribed to all lists. CPU is C3758.

[snip stalled kcryptd worker threads]

This implies a dmcrypt level problem - XFS can't make progress is
dmcrypt is not completing IOs.

Where are the XFS corruption reports that the subject implies is
occurring?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
