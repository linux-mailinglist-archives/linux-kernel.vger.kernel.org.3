Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3004754E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbhLOJKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:10:52 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:33756 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230104AbhLOJKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:10:51 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BF6WFxZ014899;
        Wed, 15 Dec 2021 03:10:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=yy0VBhIF+bsMnDA1PIVgbA1mUC91n6W7msOhRQXWw64=;
 b=QXRKjPHcMwa08ts72RJJrvGapn2gc58v6OFBHBTv1zdDzanZBNoYUVBaMSiLQGLVfKSJ
 J1p+oi/pk9J1yj9wf63yxCdcnUOPvevj3Xyg8vLqlL7qF9gIlpKUOaRjz0exEDXYjCLA
 E8EvDYQyY0kOEZW0x5GNxSDJKZ//fpwBhARrc1xspd7nSP1gVVKOh1QVncMjCITUZtBX
 Ouv30c+aSKvAeZx5UOHhxxwlDht5NDfm8HroBBf1Cx8C7ZfvBq+J0WUbBYt4YeWqCgxo
 9PAVMBSO1/nsQ3MoPO/y+eT8qWKqoWWIaPv5p+InCr/M56/WE5lT3DlLASqMgpGLsD0g IA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cxe2f229j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Dec 2021 03:10:33 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 09:10:32 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 15 Dec 2021 09:10:32 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3755745A;
        Wed, 15 Dec 2021 09:10:31 +0000 (UTC)
Date:   Wed, 15 Dec 2021 09:10:31 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/10] ASoC: cs35l41: Move power initializations to
 reg_sequence
Message-ID: <20211215091031.GS18506@ediswmail.ad.cirrus.com>
References: <20211214135959.1317949-1-tanureal@opensource.cirrus.com>
 <20211214135959.1317949-4-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211214135959.1317949-4-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: xRcMeJr2XL4GQrasakDpaujII0yveUqZ
X-Proofpoint-GUID: xRcMeJr2XL4GQrasakDpaujII0yveUqZ
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 01:59:52PM +0000, Lucas Tanure wrote:
> +	{ CS35L41_PWR_CTRL2,		 0x00000000 },
> +	{ CS35L41_AMP_GAIN_CTRL,	 0x00000000 },
>  };
> -	ret = regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
> -				 CS35L41_AMP_EN_MASK, 0);
> -	if (ret < 0) {
> -		dev_err(cs35l41->dev, "Write CS35L41_PWR_CTRL2 failed: %d\n", ret);
> -		goto err;
> -	}
> -
> -	ret = regmap_update_bits(cs35l41->regmap, CS35L41_AMP_GAIN_CTRL,
> -				 CS35L41_AMP_GAIN_PCM_MASK, 0);
> -	if (ret < 0) {
> -		dev_err(cs35l41->dev, "Write CS35L41_AMP_GAIN_CTRL failed: %d\n", ret);
> -		goto err;
> -	}

Sorry for not spotting earlier but just noticed these two writes
are update bits, so you shouldn't just be setting the values to
zero in the patch you just want to clear the relevant bit.

Thanks,
Charles
