Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49848534C95
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbiEZJhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbiEZJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:37:47 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69981101C8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:37:46 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24Q6j4ns023965;
        Thu, 26 May 2022 04:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=eSj5zYBwY24mn9xJf93mfFhpP1TsbEug8hBnh0nGbcc=;
 b=j0zzhnXEsv1m8eSSGYXxYPPtoHyurf0GReMgc+8IjaYONiQkak2mSCUdD18yW4aQui9Z
 TwpcTdvQCSCCijysz0fhqknAFj8NdDsW9lQ8POktI6T+m66CJQgfSlDeM9H6EYvfw4r/
 YR/JeaVQWr+73FqHZK1mCZ5t3QAccHRfbuEWz67Fjy7h+xc4My+6gWlfXsmzw/aKgu7G
 CnFh2IGxefeCHxuPu+Q3ylTsQurPdY5RF4q8Swm1fl1AAZCNig3c1GGa0SKkFFTQqRAP
 KS7pRPSegOEM2C2T0K5Ce+meLMDPC4nWjpuFCNGRGpKEI2s+S5WCdF5lziVFxmutwkoG jQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3g93u4j0ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 May 2022 04:37:01 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 10:36:59 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 26 May 2022 10:36:59 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8B89D46C;
        Thu, 26 May 2022 09:36:58 +0000 (UTC)
Date:   Thu, 26 May 2022 09:36:58 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v4 02/17] ALSA: hda: hda_cs_dsp_ctl: Add apis to write
 the controls directly
Message-ID: <20220526093658.GQ38351@ediswmail.ad.cirrus.com>
References: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
 <20220525131638.5512-3-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220525131638.5512-3-vitalyr@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: ZCILVYNVKLxwKbQshogZsWwivpOiURe4
X-Proofpoint-GUID: ZCILVYNVKLxwKbQshogZsWwivpOiURe4
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 02:16:23PM +0100, Vitaly Rodionov wrote:
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> DSP controls are exposed as ALSA controls, however,
> some of these controls are required to be accessed by
> the driver. Add apis which allow read/write of these
> controls. The write api will also notify the ALSA control
> on value change.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---
> 
> Changes since v2:
>  - No change
> 
>  sound/pci/hda/hda_cs_dsp_ctl.c | 52 ++++++++++++++++++++++++++++++++++
>  sound/pci/hda/hda_cs_dsp_ctl.h |  4 +++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
> index 46df48ff2ae1..3b837d000a00 100644
> --- a/sound/pci/hda/hda_cs_dsp_ctl.c
> +++ b/sound/pci/hda/hda_cs_dsp_ctl.c
> @@ -237,6 +237,58 @@ void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
>  }
>  EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_control_remove, SND_HDA_CS_DSP_CONTROLS);
>  
> +int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
> +			 unsigned int alg, void *buf, size_t len)
> +{
> +	struct cs_dsp_coeff_ctl *cs_ctl;
> +	struct hda_cs_dsp_coeff_ctl *ctl;
> +	struct snd_kcontrol *kctl;
> +	int ret;
> +
> +	cs_ctl = cs_dsp_get_ctl(dsp, name, type, alg);
> +	if (!cs_ctl)
> +		return -EINVAL;
> +
> +	ctl = cs_ctl->priv;
> +
> +	if (len > cs_ctl->len)
> +		return -EINVAL;

Is it just me or are these length check unnecessary? I realise
they are also in the wm_adsp code you are copying, but it looks
to me like they are redundant in both cases, cs_dsp_coeff_*_ctrl
appears to do a length check itself.

> +
> +	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, buf, len);
> +	if (ret)
> +		return ret;
> +
> +	if (cs_ctl->flags & WMFW_CTL_FLAG_SYS)
> +		return 0;
> +
> +	list_for_each_entry(kctl, &ctl->card->controls, list)
> +		if (!strncmp(kctl->id.name, ctl->name, sizeof(kctl->id.name))) {
> +			snd_ctl_notify(ctl->card, SNDRV_CTL_EVENT_MASK_VALUE, &kctl->id);
> +			return 0;
> +		}
> +
> +	dev_warn(dsp->dev, "Cannot find Control for %s\n", name);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_write_ctl, SND_HDA_CS_DSP_CONTROLS);
> +
> +int hda_cs_dsp_read_ctl(struct cs_dsp *dsp, const char *name, int type,
> +			unsigned int alg, void *buf, size_t len)
> +{
> +	struct cs_dsp_coeff_ctl *cs_ctl;
> +
> +	cs_ctl = cs_dsp_get_ctl(dsp, name, type, alg);
> +	if (!cs_ctl)
> +		return -EINVAL;
> +
> +	if (len > cs_ctl->len)
> +		return -EINVAL;

ditto.

Thanks,
Charles
