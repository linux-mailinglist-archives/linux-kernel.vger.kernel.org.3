Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7457D048
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiGUPu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiGUPu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:50:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA7A371AF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:50:56 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L5LeXL020687;
        Thu, 21 Jul 2022 10:50:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=Apq/AgQpV/gyFR7POoYO5N2hlaO5daOXlN1AT17e/Gs=;
 b=MOPgq9syNYnW11k80AdW5iNehLZHwGamk+2+VHavYLMbHeaf9zUa3kM+8kpJNXsa9LDp
 XFS8wDzxNNVq6l2aEg3YP0kxYR6+ODVDqucCGuMSf9Gyv9zrdZ4cb4OseWV8QCn6WRdE
 ZtHNe5oZ5Hkl0H64/ul1tbQHXZ2nOXAFgnVoX0YohiA0qmGsaTmaU/Es0rzlg3urAGy7
 Fo2K39X2GBZtN9cYixyKPEZy7TQoCF7SZYMaVgW1cKW7qaaM9V/z87NxBi/Y141CLr21
 bJQfnLH4dPEJ9CdCQ2MUUyZWcPVwZYmcqLC9igcQYT5kIMdKcS8+n80yiqNtZm4eJ1Bh hw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hdxffarqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 10:50:31 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Thu, 21 Jul
 2022 10:50:29 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Thu, 21 Jul 2022 10:50:29 -0500
Received: from [198.90.202.131] (unknown [198.90.202.131])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 081E946B;
        Thu, 21 Jul 2022 15:50:29 +0000 (UTC)
Message-ID: <f7dde431-7a97-b5bb-a47e-8953030ade87@opensource.cirrus.com>
Date:   Thu, 21 Jul 2022 16:50:28 +0100
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
        Yong Wu <yong.wu@mediatek.com>, <patches@opensource.cirrus.com>
References: <20220719142015.244426-1-kai.heng.feng@canonical.com>
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
In-Reply-To: <20220719142015.244426-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WNlq5lSN-9U0aC-DxBmpXoFUpqeh__MR
X-Proofpoint-GUID: WNlq5lSN-9U0aC-DxBmpXoFUpqeh__MR
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
Reviewed-by: Lucas Tanure <tanureal@opensource.cirrus.com>
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
