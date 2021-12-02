Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11914660FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346234AbhLBJ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:59:13 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:28368 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1356917AbhLBJ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:57:06 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B29G25c029166;
        Thu, 2 Dec 2021 03:53:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=r8zaAsLHo07c7hy3+fKjG+IGB1xKyHnCMkRrTxygNJU=;
 b=SMp8dNRXnf5E43N0eWevahK7KzW4uD67PXj1iAVHzbUZ0u1tvRh25k7DIgDecvfmdo6z
 TUEbIZzYyuNVwPdI04TSga3Jzmr8C3EXfiPliAqo3td1JMe3FLjagUk459ro+fCEb8Tp
 FBmiN3CNpqA47HbxBwG8ZBTwjwfQ4RcNImo1qhFQeANPDEOkyYRavOkr+mar4DAGyEKA
 5tyL/eu8CZhhCVeo6lhaHMoPMKn5Yn56oy5F7Xlw99SDXZBQzaJe7PzPwGa0Umbk2Dld
 tlZi3MfpBUq3AHnirKZmiDvRqFGg+FWPtxWNoltmlfGfCzQrWwXt5nOPppFo/iXSgfhA nA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cp6c89f9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 02 Dec 2021 03:53:35 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 09:53:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 2 Dec 2021 09:53:33 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 58B912A9;
        Thu,  2 Dec 2021 09:53:33 +0000 (UTC)
Date:   Thu, 2 Dec 2021 09:53:33 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: Implement system suspend
Message-ID: <20211202095333.GK18506@ediswmail.ad.cirrus.com>
References: <20211201153648.17259-1-rf@opensource.cirrus.com>
 <YaejghraYE6lD7FD@sirena.org.uk>
 <87930df9-6220-807e-a655-1c7d7ec020ab@opensource.cirrus.com>
 <YafyWnVA1J1rgCf1@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YafyWnVA1J1rgCf1@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: __Af_305nabKEyouY-eabprAXCrJVWQ5
X-Proofpoint-GUID: __Af_305nabKEyouY-eabprAXCrJVWQ5
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 10:08:26PM +0000, Mark Brown wrote:
> On Wed, Dec 01, 2021 at 06:04:00PM +0000, Richard Fitzgerald wrote:
> > On 01/12/2021 16:32, Mark Brown wrote:
> > > On Wed, Dec 01, 2021 at 03:36:48PM +0000, Richard Fitzgerald wrote:
> ...that's based on the assumption that this is all about the magic write
> sequences you're using for shutdown potentially conflicting with default
> values you've got in the cache?  If it's not those then the assumption
> is that either the device was reset in which case it has reset values or
> the device was not reset and held it's previous value, in which case the
> cache sync is redundant.

This isn't quite accurate though, as whilst the device was
suspended the user may have touched ALSA controls which will have
updated the state of the cache. Thus the cache requires a sync
regardless of if the hardware turned off.

I suspect we do need to have a think about the write sequences,
but there is also a more general issue here. The sequence looks
like this:

1) Device enters cache only mode.
2) User writes an ALSA control causing a register to return to
its default value.
3) Device exits cache only and does a cache sync.

This flow works if the device was reset but not if the registers
retained their value since the register written by the user will
be at default in the cache, but not on the hardware. The cache
sync code assumes the device returned to defaults.

It is often tricky to know if the device reset since the
regulator could be shared and even if they arn't capacitance can
play a part if the off time is very small. Usually we mandate a
hard reset or use a soft reset if the hard isn't available. I
think the soft reset has some issues on this chip but perhaps we
should look into that more.

> > > Given that you're using disable_irq() to force the interrupt off (which
> > > is a bit rude but often the best one can do) how might we be getting an
> > > interrupt while suspended?  This seems to indicate an error condition.
> 
> > I may have misunderstood here, but the documentation says that
> > enables/disables are nested. The interrupt starts out enabled right
> > after calling request_threaded_irq(), so I expected that all users of
> > the shared interrupt would have to call disable_irq() for it to actually
> > get disabled (I put the call in on that basis that it does no harm). If
> > disable_irq() forces the irq off even if it's shared then I'll remove it
> > because as you say that would be rude.
> 
> Hrm, that may have changed since I last looked - if that's the case then
> I guess it's best not to warn which was what I was thinking here.
> 

No I am pretty sure you are correct here calling disable_irq will
immediately disable the IRQ for everyone using it. The reference
counting is on the other side, ie. if I call disable_irq 5 times
I have to call enable_irq 5 times before it turns back on.

Thanks,
Charles
