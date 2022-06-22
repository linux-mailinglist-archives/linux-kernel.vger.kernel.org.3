Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E205545FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355108AbiFVIkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354745AbiFVIke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:40:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FE938BD8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655887233; x=1687423233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lfCre8ivv7Zd1IkJm7XBr2ruY993pMUvBr7MGHnoa5E=;
  b=OnILg0MPQvb5OVLv5kxV/KQnQpmOUychfS5R3GhupR7X+Jsscy+oMZxj
   GQ0/WNWmeY/32qUXiEIQLSBEv8wxh89lN8+0TOUNEfs8ghBymt2ugGaXY
   O+OXTcMEr+pb7tXBYX39W6xanOrdxRjOuS/0rgxC4E0qesexrWK2WL1g1
   NQnuQP2AGK76ITF4TMw0saqJFEekspDrOv8ktBaVlW11XJNax6K6WvBBw
   CskufMmN8Csi1yMwX+JNWLR6XirCEiy0l0wwqSRzhxUnqDRuM+8SdWIJD
   YV/tAh5P0je5wQR1Tg6bm2XsmZEG9wCcXBABKVsEtlATEClos8OJbkX5C
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="277904491"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="277904491"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:40:32 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644080043"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.103]) ([10.99.249.103])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:40:31 -0700
Message-ID: <c0bd4b10-f846-6a6e-06a4-57284f536a98@linux.intel.com>
Date:   Wed, 22 Jun 2022 10:40:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 05/14] ALSA: hda: cs35l41: Save Subsystem ID inside
 CS35L41 Driver
Content-Language: en-US
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Stefan Binding <sbinding@opensource.cirrus.com>
References: <20220622074653.179078-1-vitalyr@opensource.cirrus.com>
 <20220622074653.179078-6-vitalyr@opensource.cirrus.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220622074653.179078-6-vitalyr@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/2022 9:46 AM, Vitaly Rodionov wrote:
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> The Subsystem ID is read from the HDA driver, and will
> be used by the CS35L41 driver to be able to uniquely
> identify the laptop, which is required to be able to
> define firmware to be used by specific models.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---
>   sound/pci/hda/cs35l41_hda.c   | 3 +++
>   sound/pci/hda/cs35l41_hda.h   | 1 +
>   sound/pci/hda/hda_component.h | 1 +
>   sound/pci/hda/patch_realtek.c | 1 +
>   4 files changed, 6 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
> index 92c6d8b7052e..7f0132694774 100644
> --- a/sound/pci/hda/cs35l41_hda.c
> +++ b/sound/pci/hda/cs35l41_hda.c
> @@ -356,6 +356,9 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
>   		return -EBUSY;
>   
>   	comps->dev = dev;
> +	if (!cs35l41->acpi_subsystem_id)
> +		cs35l41->acpi_subsystem_id = devm_kasprintf(dev, GFP_KERNEL,
> +							    "%.8x", comps->subsystem_id);

Wouldn't comps->codec->core.subsystem_id instead of comps->subsystem_id 
work here? You already added saving of codec in patch 3, and then you 
don't need rest of this patch?
