Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9FA54DF23
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbiFPKbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiFPKbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:31:44 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CD65DBDC;
        Thu, 16 Jun 2022 03:31:43 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25G5bV9E020293;
        Thu, 16 Jun 2022 05:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=SWjGMvo8oAklPuUAPr0GO8gsjG1MhEdsELaW6hchfiw=;
 b=BipmMncsH74v8veNumsPG80f69ITxRoIc7MJV5Zi2rL3bQ5+mk51dE2OhSzmVSXcq7gH
 PEGgFbnUqvwGXfIrqJ+5fjoPCs/Ec0Xkqzid+BtBguxF7AGz3jEk9HM97FUnz0llfj2J
 SnaDhpCKFjCiclLcSST3ThiOhMPJANt3/jQlGnqJBJU3znPc2cnzoHs2T5JeP00r4vW1
 +i2GvVWeZtsvJEW+DVZc6JY+bzUtTbpkOGfl5P2UwepAFVGjZ9KNqVBGJKLeMv/iBE60
 omgqxkY1nHhzKD6lTOH8noQqMiYRamjt+moKRGOZFv1oaYgr5Yax3RQkuoMHdxAE2o+x DQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gmrf35mrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Jun 2022 05:30:47 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 11:30:45 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 16 Jun 2022 11:30:45 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 59ACC11D1;
        Thu, 16 Jun 2022 10:30:45 +0000 (UTC)
Date:   Thu, 16 Jun 2022 10:30:45 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Sameer Pujar <spujar@nvidia.com>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: tegra: Fix clock DAI format on Tegra210
Message-ID: <20220616103045.GD38351@ediswmail.ad.cirrus.com>
References: <1655280277-4701-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1655280277-4701-1-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: Wz0DY6398pYy0H8B1wlsGdEhSyg4wtwQ
X-Proofpoint-ORIG-GUID: Wz0DY6398pYy0H8B1wlsGdEhSyg4wtwQ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 01:34:37PM +0530, Sameer Pujar wrote:
> I2S reset failures are seen on Tegra210 and later platforms. This indicates
> absence of I2S bit clock, which is required to perform the reset operation.
> Following failures are seen with I2S based tests on Tegra210 and later:
> 
>   tegra210-i2s 2901100.i2s: timeout: failed to reset I2S for playback
>   tegra210-i2s 2901100.i2s: ASoC: PRE_PMU: I2S2 RX event failed: -110
>   tegra210-i2s 2901100.i2s: timeout: failed to reset I2S for capture
>   tegra210-i2s 2901100.i2s: ASoC: PRE_PMU: I2S2 TX event failed: -110
> 
> The commit d92ad6633fa7 ("ASoC: tegra: Update to use set_fmt_new callback")
> regressed I2S functionality on Tegra platforms. Basically it flipped clock
> provider and consumer DAI formats. This configures Tegra I2S in consumer
> mode by default now and there is none to provide bit clock during loopback
> tests. The external codec based tests also fail because both Tegra I2S and
> codec I2S get configured in consumer mode.
> 
> ASoC core flips the DAI format before calling set_fmt() for CPU DAIs. This
> is negated in above commit. Fix this by swapping SND_SOC_DAIFMT_BC_FC and
> SND_SOC_DAIFMT_BP_FP switch cases.
> 
> Fixes: d92ad6633fa7 ("ASoC: tegra: Update to use set_fmt_new callback")
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

Ah.... I see what has happened there. As this device is one of
the few CPU side components defining non_legacy_dai_naming whilst
processing the DAI links the core would have been flipping the
format for this driver as it would have mistaken it for a CODEC
to CODEC link, so unlike the other CPU side components the flags
shouldn't have been inverted when I converted this driver.

Apologies for missing this whilst doing the updates, and thank
you for fixing. I will check if there are any other cases of this
that need to be hit.

A bit late but for what it is worth:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
