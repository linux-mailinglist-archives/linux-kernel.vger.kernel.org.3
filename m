Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ECE554976
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355355AbiFVIkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355299AbiFVIks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:40:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214EE38BE9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655887247; x=1687423247;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VfNo7yVTgFB/Svew6Oy6XyZl047DErTPyzcdQPMqbxE=;
  b=Jlemc7/5LRzW1bd765bctCYxhNSuOvCjjLk9iO031xJv8pWKzlt1wcMn
   PN/bPKGsaf14XH/Kv0lAY3t7TbcX+nHvHDPQR6bDBbDX+QrFn8PWS7QUX
   o0D4+aQB+/9WM8+pcEyfCGvTx1pEj5dpvrL2A3yjvXqXe//PWjxYDq/BK
   RjSyQgFPQZ7bEYiQO/SfZVG9iqQeODRepZGVxvzBt4ab+fHMcXnN6daCm
   dxJsWqkuK2alUP5EJ6T2sEHe2gZSj27MJ1tZ8XXplztPIkLIwAIY1Q//s
   THHU3RHyyXLskCzW/6XU3bSbmk/8gZRFTcowYpHElFTqD0aJlxMrHScuG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="269076544"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="269076544"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:40:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644080007"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.103]) ([10.99.249.103])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 01:40:22 -0700
Message-ID: <d05c292e-f955-48df-50e3-55e36a956775@linux.intel.com>
Date:   Wed, 22 Jun 2022 10:40:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 01/14] ALSA: hda: hda_cs_dsp_ctl: Add Library to
 support CS_DSP ALSA controls
Content-Language: en-US
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Stefan Binding <sbinding@opensource.cirrus.com>
References: <20220622074653.179078-1-vitalyr@opensource.cirrus.com>
 <20220622074653.179078-2-vitalyr@opensource.cirrus.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220622074653.179078-2-vitalyr@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/2022 9:46 AM, Vitaly Rodionov wrote:
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> The cs35l41 part contains a DSP which is able to run firmware.
> The cs_dsp library can be used to control the DSP.
> These controls can be exposed to userspace using ALSA controls.
> This library adds apis to be able to interface between
> cs_dsp and hda drivers and expose the relevant controls as
> ALSA controls.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---
>   MAINTAINERS                    |   1 +
>   sound/pci/hda/Kconfig          |   4 +
>   sound/pci/hda/Makefile         |   2 +
>   sound/pci/hda/hda_cs_dsp_ctl.c | 207 +++++++++++++++++++++++++++++++++
>   sound/pci/hda/hda_cs_dsp_ctl.h |  33 ++++++
>   5 files changed, 247 insertions(+)
>   create mode 100644 sound/pci/hda/hda_cs_dsp_ctl.c
>   create mode 100644 sound/pci/hda/hda_cs_dsp_ctl.h
> 

...

> +
> +static unsigned int wmfw_convert_flags(unsigned int in)
> +{
> +	unsigned int out, rd, wr, vol;
> +
> +	rd = SNDRV_CTL_ELEM_ACCESS_READ;
> +	wr = SNDRV_CTL_ELEM_ACCESS_WRITE;
> +	vol = SNDRV_CTL_ELEM_ACCESS_VOLATILE;
> +
> +	out = 0;
> +
> +	if (in) {
> +		out |= rd;
> +		if (in & WMFW_CTL_FLAG_WRITEABLE)
> +			out |= wr;
> +		if (in & WMFW_CTL_FLAG_VOLATILE)
> +			out |= vol;
> +	} else {
> +		out |= rd | wr | vol;
> +	}
> +
> +	return out;
> +}

This is more question of preference, so you can leave above function as 
is, but you could also do something like the following, which is bit 
shorter:
static unsigned int wmfw_convert_flags(unsigned int in)
{
	unsigned int out = SNDRV_CTL_ELEM_ACCESS_READ;

	if (!in)
		return SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_VOLATILE;

	if (in & WMFW_CTL_FLAG_WRITEABLE)
		out |= SNDRV_CTL_ELEM_ACCESS_WRITE;
	if (in & WMFW_CTL_FLAG_VOLATILE)
		out |= SNDRV_CTL_ELEM_ACCESS_VOLATILE;

	return out;
}

> +
> +static int hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl)
> +{
> +	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
> +	struct snd_kcontrol_new *kcontrol;
> +	struct snd_kcontrol *kctl;
> +	int ret = 0;
> +
> +	if (cs_ctl->len > ADSP_MAX_STD_CTRL_SIZE) {
> +		dev_err(cs_ctl->dsp->dev, "Control %s: length %zu exceeds maximum %d\n", ctl->name,
> +			cs_ctl->len, ADSP_MAX_STD_CTRL_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	kcontrol = kzalloc(sizeof(*kcontrol), GFP_KERNEL);
> +	if (!kcontrol)
> +		return -ENOMEM;
> +
> +	kcontrol->name = ctl->name;
> +	kcontrol->info = hda_cs_dsp_coeff_info;
> +	kcontrol->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
> +	kcontrol->private_value = (unsigned long)ctl;
> +	kcontrol->access = wmfw_convert_flags(cs_ctl->flags);
> +
> +	kcontrol->get = hda_cs_dsp_coeff_get;
> +	kcontrol->put = hda_cs_dsp_coeff_put;
> +
> +	kctl = snd_ctl_new1(kcontrol, NULL);

Wouldn't
kctl = snd_ctl_new1(kcontrol, ctl);
work instead of
kcontrol->private_value = (unsigned long)ctl;
...
kctl = snd_ctl_new1(kcontrol, NULL);
?

You can then get the value using  snd_kcontrol_chip()  macro, so instead 
of doing quite long lines with casts like:
struct hda_cs_dsp_coeff_ctl *ctl = (struct hda_cs_dsp_coeff_ctl 
*)kctl->private_value;
you could do
struct hda_cs_dsp_coeff_ctl *ctl = snd_kcontrol_chip(kctl);


