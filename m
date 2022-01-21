Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7DB495DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379984AbiAUKXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:23:08 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:2750 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349884AbiAUKXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:23:07 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20L5THpx009597;
        Fri, 21 Jan 2022 04:22:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=1Pj0a8nkcMdoeHViL8o4xa3w7vEvMA0LvSinV0C8EYA=;
 b=izZgzTUHwVdvj389FVYq/1NC+klr/q1vuO84Tni0ADG9NiZZAoYDleCtoZFqe8l8XmmC
 tMpiP8Zw9r8CwCV9x9RrZxWEic0304hScWl6mFqBTTp4CLn/th/ZcJbL5KTcHxWq2rz1
 SMf2dzrnJze1FPQZEcda4duRxFjndWG3hUwrdwjtWNfYdwE7+wAhr+75eebinswACUaF
 oNwMFHVjtI3SaB5gbNF+CEb6Gw9f94ks35tf0r7thSOCY9NN0/kgsnnchwOoJN5QbM4u
 6Y9TLed9xg2jZQ05+TDoGYyAMM62siviFJqOgGT/sDNZuOxCUrR31stByQh43/CQcfMl zA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dqhyq0j64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 04:22:57 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 21 Jan
 2022 10:22:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 21 Jan 2022 10:22:54 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.33])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B2ECE45D;
        Fri, 21 Jan 2022 10:22:54 +0000 (UTC)
Subject: Re: [PATCH 3/3] ASoC: cs42l42: Handle system suspend
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20220120175549.671831-1-rf@opensource.cirrus.com>
 <20220120175549.671831-4-rf@opensource.cirrus.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <49c925e8-b6e9-0dcb-b8ed-7e03d9e2b188@opensource.cirrus.com>
Date:   Fri, 21 Jan 2022 10:22:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220120175549.671831-4-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pSfwcL6fTdyCuR0StuSbKo4FNNpWhNMI
X-Proofpoint-ORIG-GUID: pSfwcL6fTdyCuR0StuSbKo4FNNpWhNMI
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2022 17:55, Richard Fitzgerald wrote:

> +static int __maybe_unused cs42l42_resume(struct device *dev)
> +{
> +	struct cs42l42_private *cs42l42 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/*
> +	 * If jack was unplugged and re-plugged during suspend it could
> +	 * have changed type but the tip-sense state hasn't changed.
> +	 * Force a plugged state to be re-evaluated.
> +	 */
> +	if (cs42l42->plug_state != CS42L42_TS_UNPLUG)
> +		cs42l42->plug_state = CS42L42_TS_TRANS;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(cs42l42->supplies), cs42l42->supplies);
> +	if (ret != 0) {
> +		dev_err(dev, "Failed to enable supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
> +	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
> +
> +	regcache_cache_only(cs42l42->regmap, false);
> +	regcache_mark_dirty(cs42l42->regmap);
> +
> +	/* Sync LATCH_TO_VP first so the VP domain registers sync correctly */
> +	regcache_sync_region(cs42l42->regmap, CS42L42_MIC_DET_CTL1, CS42L42_MIC_DET_CTL1);
> +	regcache_sync(cs42l42->regmap);
> +
> +	cs42l42->suspended = false;

This should be taking the irq_mutex around the regcache_sync() so that
we don't get unhandled interrupts after the interrupts are unmasked
but before cs42l42->suspended is cleared.

Will push a V2 with this fix.

