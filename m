Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CD148D4E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiAMJSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:18:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:33867 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230273AbiAMJSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642065512; x=1673601512;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zCOcgBKd8njK/MJdhiU5UdE0gC+gElPzoDmQ58NanVE=;
  b=O9FmOKjPsq6MwffhXI79QcbRk9G+FbR32rhD6ZNARS3jQF3RtnkOCAhC
   RV8GLt8m2a/gVoBtqfxY3gOUBjpMPEmMmQadLfjfa/PzigW3S4AsPo2I6
   cchPO1bJIDrhVynJqnu2BUhZjLGvxev/QbRYZefvU3yMocssQYfnfk9mu
   WNZgS0tULbbN0BBppVoKbjMflRqPlTlNVmwIfRakClkAvq8uhfSDxImSz
   r/CDmJovRR8CoTTLOW5kOtFq7IsRVFOs6++49IOUWF/ONA+Wbi8lnytvN
   s6Mx5UxeTJXYDJM3Qbh1cbyFN+FVXC7DIVzVrOISq5m8A+laQWO3zErxO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="241529290"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="241529290"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 01:18:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="691737675"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.237.180.79]) ([10.237.180.79])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 01:18:30 -0800
Message-ID: <703cec53-5de7-e8c1-5a1f-e44f0cbc141f@linux.intel.com>
Date:   Thu, 13 Jan 2022 10:18:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] ASoC: add support for TAS5805M digital amplifier
Content-Language: en-US
To:     Daniel Beer <daniel.beer@igorinstitute.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Liu <andy-liu@ti.com>, Mark Brown <broonie@kernel.org>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>
References: <cover.1642063121.git.daniel.beer@igorinstitute.com>
 <a2e4461ee2d2a052984f447f9891f8b4ecc9307c.1642063121.git.daniel.beer@igorinstitute.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <a2e4461ee2d2a052984f447f9891f8b4ecc9307c.1642063121.git.daniel.beer@igorinstitute.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2022 12:53 AM, Daniel Beer wrote:
> The Texas Instruments TAS5805M is a class D audio amplifier with an
> integrated DSP. DSP configuration is expected to be supplied via a
> device-tree attribute containing a sequence of register writes.
> 
> These register writes set up application-specific DSP settings and are
> expected to be generated using TI's PPC3 tool.
> 
> Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>
> ---

...

> +
> +static int tas5805m_vol_put(struct snd_kcontrol *kcontrol,
> +			    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =
> +		snd_soc_kcontrol_component(kcontrol);
> +	struct tas5805m_priv *tas5805m =
> +		snd_soc_component_get_drvdata(component);
> +
> +	if (!(volume_is_valid(ucontrol->value.integer.value[0]) &&
> +	      volume_is_valid(ucontrol->value.integer.value[1])))
> +		return -EINVAL;
> +
> +	mutex_lock(&tas5805m->lock);
> +	tas5805m->vol[0] = ucontrol->value.integer.value[0];
> +	tas5805m->vol[1] = ucontrol->value.integer.value[1];
> +	dev_dbg(component->dev, "set vol=%d/%d (is_powered=%d)\n",
> +		tas5805m->vol[0], tas5805m->vol[1], tas5805m->is_powered);
> +	if (tas5805m->is_powered)
> +		tas5805m_refresh_unlocked(component);
> +	mutex_unlock(&tas5805m->lock);
> +
> +	return 0;
> +}
> +

put method should return '1' if value changed, so ALSA knows to inform 
userspace utilities about change. You can check if userspace is notified 
of changes with "alsactl monitor", you should see something like:
node hw:2, #3 (2,0,0,ADC0 Capture Volume,0) VALUE
when value changes.
