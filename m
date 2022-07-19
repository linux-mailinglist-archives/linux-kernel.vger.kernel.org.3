Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D458957A2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbiGSP13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiGSP1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:27:22 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A866142AF7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:27:20 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JASFD6009799;
        Tue, 19 Jul 2022 10:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=tRp0ATBo1z4/9fP7ZU/d5GfIkS5eLHP8Aq5Gl5wnJxQ=;
 b=E8uWefqSr3lrQg+XL3DDJudOSQOR5C7QEu69+o7RpKBGpGBVW3Of4H2xhMxUh8Ax7oNT
 L48BMgoelOCKEGFD8myvfCMeloL/0gdiAKRrpXCoXepxwWrnLBXcftxfnXomMuOueKSQ
 vOLKh8c3QMPhjsG+NdVpuugyOM1W6JWkcb5IxHs3/eM/IMo4fL3PpTD6CzvfkeogbfXS
 u5fnQ1DPxQAlo+8S0MoGI+Q60DZecOs0NhcVpr9BGem9KtBtbqOnHRQSr8lQwbGAuJdh
 WoiHf2P8s4iXmvaUWP8cga3qF5DjrOKun+Q1Lqxz9G9ilYlw7S2qCNoji2dMw04l1bQO zw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hdrqfgj84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 10:26:51 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 19 Jul
 2022 10:26:49 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Tue, 19 Jul 2022 10:26:49 -0500
Received: from [198.90.202.47] (unknown [198.90.202.47])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D765B477;
        Tue, 19 Jul 2022 15:26:48 +0000 (UTC)
Message-ID: <444a7ab6-d47e-6e0a-de0c-1efb292edb8a@opensource.cirrus.com>
Date:   Tue, 19 Jul 2022 16:26:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ALSA: hda/realtek: Enable speaker and mute LEDs for HP
 laptops
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, <tiwai@suse.com>
CC:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Kailang Yang <kailang@realtek.com>,
        <linux-kernel@vger.kernel.org>, Meng Tang <tangmeng@uniontech.com>,
        <alsa-devel@alsa-project.org>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Tim Crawford <tcrawford@system76.com>,
        Andy Chi <andy.chi@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Yong Wu <yong.wu@mediatek.com>
References: <20220719142015.244426-1-kai.heng.feng@canonical.com>
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <20220719142015.244426-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Bi9dZeQRbcYU3iDeQk2fJVej360xCa5k
X-Proofpoint-GUID: Bi9dZeQRbcYU3iDeQk2fJVej360xCa5k
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/19/22 15:20, Kai-Heng Feng wrote:
> Two more HP laptops that use cs35l41 AMP for speaker and GPIO for mute
> LEDs.
>
> So use the existing quirk to enable them accordingly.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   sound/pci/hda/patch_realtek.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 2f55bc43bfa9c..cdbee71e83216 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -9109,6 +9109,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>   	SND_PCI_QUIRK(0x103c, 0x89c3, "Zbook Studio G9", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
>   	SND_PCI_QUIRK(0x103c, 0x89c6, "Zbook Fury 17 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>   	SND_PCI_QUIRK(0x103c, 0x89ca, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> +	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
>   	SND_PCI_QUIRK(0x103c, 0x8a78, "HP Dev One", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
>   	SND_PCI_QUIRK(0x103c, 0x8aa0, "HP ProBook 440 G9 (MB 8A9E)", ALC236_FIXUP_HP_GPIO_LED),
>   	SND_PCI_QUIRK(0x103c, 0x8aa3, "HP ProBook 450 G9 (MB 8AA1)", ALC236_FIXUP_HP_GPIO_LED),

Hi,

Can you send us the ACPI dump (DSDT file) for review for both laptops?

We want to ensure that the ACPI has the correct information so the 
driver will work properly.

Thanks

Lucas Tanure

