Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD169463B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbhK3QYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:24:21 -0500
Received: from smtpout2.vodafonemail.de ([145.253.239.133]:35222 "EHLO
        smtpout2.vodafonemail.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238919AbhK3QYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:24:20 -0500
Received: from smtp.vodafone.de (unknown [10.2.0.33])
        by smtpout2.vodafonemail.de (Postfix) with ESMTP id BEF0A6112C;
        Tue, 30 Nov 2021 17:20:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
        s=vfde-smtpout-mb-15sep; t=1638289242;
        bh=IE2gRtUKwN9NbI3YSKGX70eCnOeuuRl6s2oJGbJ2gH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=pJ490t83pP+ncPzgfB9z6sr2iX/9G91lUpPIy/oxF3lVhEVAaSjMrRHpFr9+4Y4l4
         JXldhynKzm2A8ZfxBQEVKfG0d46iRJ+QbRzXT4JxBcTR6PJ/OXbMC5RdcoBo6T3HVH
         PRXf8hCsNMxNFus8KDnzcRo16DA1qFTn6E9nzB+U=
Received: from lazy.lzy (p579d7c55.dip0.t-ipconnect.de [87.157.124.85])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.vodafone.de (Postfix) with ESMTPSA id 4J3SB51gJ3zHnJM;
        Tue, 30 Nov 2021 16:20:26 +0000 (UTC)
Received: from lazy.lzy (localhost [127.0.0.1])
        by lazy.lzy (8.17.1/8.14.5) with ESMTPS id 1AUGKP8P012899
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Nov 2021 17:20:25 +0100
Received: (from red@localhost)
        by lazy.lzy (8.17.1/8.16.1/Submit) id 1AUGKPZc012898;
        Tue, 30 Nov 2021 17:20:25 +0100
Date:   Tue, 30 Nov 2021 17:20:25 +0100
From:   Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-raid@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-accelerators@lists.ozlabs.org, linux-nvme@lists.infradead.org
Subject: Re: Using aGPU for RAID calculations (proprietary GRAID SupremeRAID)
Message-ID: <YaZPScnojOLqDNPc@lazy.lzy>
References: <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccdbb0d7-d043-d41f-508b-4a464ffa5fe9@molgen.mpg.de>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 2214
X-purgate-ID: 149169::1638289242-00000479-66182D27/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 12:58:10PM +0100, Paul Menzel wrote:
> 
> Dear Linux folks,
> 
> 
> I read about GRAID SupremeRAID [1], which seems to be an Nvidia T1000 card
> and software to use the card for RAID calculations.
> 
> > GRAID SupremeRAID works by installing a virtual NVMe controller onto
> > the operating system and integrating a PCIe device into the system
> > equipped with a high-performance AI processor to handle all RAID
> > operations of the virtual NVMe controller
> 
> According to the review *GRAID SupremeRAID SR-1000 Review* [2] it performs
> quite well. I couldn’t find any driver files online.
> 
> Now I am wondering, why a graphics card seems to help so much. What
> operations are there, modern CPUs cannot keep up with?
> 
> If GPUs are that much better, are people already working on a FLOSS solution
> for the Linux kernel, so people can “just” plug in a graphics card to
> increase the speed?
> 
> Does the Linux kernel already have an API to offload calculations to
> accelerator cards, so it’s basically plug and play (with AMD graphics cards
> for example using HSA/KFD)? Entropy sources, like the ChaosKey [3], work
> like that. If not, would the implementation go under `lib/raid6`?

I think this was somehow discussed here
some times ago.
That is the use of "GPU" to accellerate
the parity computation.

There are a couple of things to keep in mind.

One is the data transfer to / from the video
card, which might be a bottleneck.
At any rate, there will be a write and read
streams going across the system bus(es).

An other point is that, unless an high end
video card is used, with ECC memory, the
reliability of the whole process might be
of concern.

Finally, usually video cards, while having
a lot of memory (caching could be good),
they miss the battery backup.
Power is off, data is gone...

bye,

pg

> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://www.graidtech.com/post/graid-reveals-the-next-generation-of-enterprise-data-protection-nvme-ssds
> [2]: https://www.storagereview.com/review/graid-supremeraid-sr-1000-review
> [3]: https://altusmetrum.org/ChaosKey/
> 

-- 

piergiorgio
