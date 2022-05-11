Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8625234ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbiEKOC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbiEKOCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:02:55 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6FF3BBCD
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:02:52 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BC4ek3000496;
        Wed, 11 May 2022 09:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=oIxr/xC1n5ZyDjdj6EgfIBAjcz3pjH99gFXnfJtabgA=;
 b=JmeWk3lg7MAKH29m11cseAUiFwvLI0tgjRC9VNYkYwmnRwaypR1VugdmR50cWK8pyi6N
 OwQAfqB2NCoF7afyFy+icRbUDEq9qfFr1tm6eivk4vCuy3Z3ZtYqUya/lmeOkiM1FWWq
 137QxGcAzyZgWY4wCRIVPqHCnfsHI1S4JjP9T/My5egM/MSRX/9U9eJ8xMR4XGA3nvz9
 Xk+UYSreB19bbgFXjm2uFpsKDCFzGOh2Q1tIbxajrIA/X10ntzK0E/08giyFrHkiynDT
 7SgbhG8XA4AFwTD+BFJR4GbJLXmKqg6YIyIGeDXIoExVEAhKIBkeRfxYe1w0kr/etHgI uw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fwp616pdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 May 2022 09:02:19 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 15:02:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 11 May 2022 15:02:17 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7ECE8B10;
        Wed, 11 May 2022 14:02:17 +0000 (UTC)
Date:   Wed, 11 May 2022 14:02:17 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v2 10/26] ALSA: hda: hda_cs_dsp_ctl: Add Library to
 support CS_DSP ALSA controls
Message-ID: <20220511140217.GI38351@ediswmail.ad.cirrus.com>
References: <20220509214703.4482-1-vitalyr@opensource.cirrus.com>
 <20220509214703.4482-11-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220509214703.4482-11-vitalyr@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 03tfxSSWisQ6hehUnsU3Ci8UZPqmpEfz
X-Proofpoint-ORIG-GUID: 03tfxSSWisQ6hehUnsU3Ci8UZPqmpEfz
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 10:46:47PM +0100, Vitaly Rodionov wrote:
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
> +static int hda_cs_dsp_coeff_info(struct snd_kcontrol *kctl, struct snd_ctl_elem_info *uinfo)
> +{
> +	struct soc_bytes_ext *bytes_ext =
> +		(struct soc_bytes_ext *)kctl->private_value;
> +	struct hda_cs_dsp_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
> +	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
> +
> +	switch (cs_ctl->type) {
> +	case WMFW_CTL_TYPE_ACKED:
> +		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> +		uinfo->value.integer.min = CS_DSP_ACKED_CTL_MIN_VALUE;
> +		uinfo->value.integer.max = CS_DSP_ACKED_CTL_MAX_VALUE;
> +		uinfo->value.integer.step = 1;
> +		uinfo->count = 1;
> +		break;

With the ACKED controls as well as the TLVs it would be worth
verifing if any of the relevant firmwares actually require these,
if we are going to duplicate a bunch of the wm_adsp code into HDA
lets duplicate only exactly what we need.

> +	switch (cs_dsp->fw_ver) {
> +	case 0:
> +	case 1:
> +		ret = scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
> +				"%s %s %s %x", info->amp_name, cs_dsp->name, region_name,
> +				cs_ctl->alg_region.alg);
> +		break;
> +	case 2:
> +		ret = scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
> +				"%s %s%c %.12s %x", info->amp_name, cs_dsp->name, *region_name,
> +				hda_cs_dsp_fw_text[info->fw_type], cs_ctl->alg_region.alg);
> +		break;
> +	default:
> +		ret = scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
> +				"%s %s %.12s %x", info->amp_name, cs_dsp->name,
> +				hda_cs_dsp_fw_text[info->fw_type], cs_ctl->alg_region.alg);
> +		break;
> +	}

Do we actually need to support all the historical fw_versions?
ADSP does since CODECs using it have been around forever, but I
would suggest it is quite like this stuff only needs to support
the latest version.

Thanks,
Charles
