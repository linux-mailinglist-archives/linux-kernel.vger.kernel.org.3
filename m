Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883624A4729
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbiAaM36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiAaM3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:29:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63448C061714;
        Mon, 31 Jan 2022 04:29:55 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k18so25103422wrg.11;
        Mon, 31 Jan 2022 04:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XfDEtvQ/tzVD1YeBowq1DH94HINF3JBGxRgfDDz4P9Q=;
        b=W4NHjEA+9XVVL8xz6qTEqQvruINpNG1pl5p/yaTwPsUbqDWoTdwk6B90cytFkMTHZT
         lrQuJGMCrkrs3FC5BaobUmorxlxni/0C26+D4VsSXYqKlUY8Ar8xiHI3b74c2sMVkTLU
         gSKadOZdH4vnOVfaH7dEpE2s9zlDj36v/3eMYHeSfAyUcZJ1HDwwiM1nyWsQnV4O0yRb
         O1xd+UqJM3rUINASsACdI5OKMhaHlXLsyvVO9ERwrZUlIgIG7kIn8nF6cUlGtvVMzycp
         83qu/fIP/2WVZAxPlTcZxmh9pHc3byTUiIOGNQbWxrf5VMQI0tURoHxAzof9DE6mx1vg
         FIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XfDEtvQ/tzVD1YeBowq1DH94HINF3JBGxRgfDDz4P9Q=;
        b=pB+fn8DDCI07v69lujnSCYAORy8YAhCznFgb57yOEw39spEtyPA8G+/pvj1b8TnRPI
         hQFQIJeSBbq5ik0BDH49jl49fCSrAWo4RIdxUnJOGy6YTetfuB+UvnRYgggXINwSlpXm
         brcmVg+N8XWgimjSEPTlEgfpa54RRafXCKUSIuj4ZLR59ROeaa3z/DtzaYhir1EpxoII
         6J6QDlMkbcLVHuag+FwRkgxzv9JfvjQYUYO/G3rM1DQOwyDaT3enZn5AMoZW2R/kmgt5
         Gje0TY4sfzgWPzDJKFlbjsd9dQmFn81aI9AH+fZis5d3Fsg8Of7P2pz6zslBhYnE4V+b
         V/Mw==
X-Gm-Message-State: AOAM531p10YYEUPiYv3Rz/m+8wBmQktZy86pwFLk9dRDHhUhI08IMMoe
        oy8OdpBiNG6Qlsgy56OiLR8=
X-Google-Smtp-Source: ABdhPJwKPAOlfE8A7dNEWpNDKJVV/rApo0lar6YbP+IVu/WUEb/GzeZxyimip5vdiaqDYs3eC4tjRQ==
X-Received: by 2002:a05:6000:1548:: with SMTP id 8mr16792438wry.504.1643632193762;
        Mon, 31 Jan 2022 04:29:53 -0800 (PST)
Received: from [192.168.0.14] ([37.223.145.74])
        by smtp.gmail.com with ESMTPSA id m12sm13729547wrp.61.2022.01.31.04.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 04:29:53 -0800 (PST)
Message-ID: <5991ad51-4181-d445-284c-386447cffb95@gmail.com>
Date:   Mon, 31 Jan 2022 13:29:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 02/13] iommu/mediatek-v1: Free the existed fwspec if
 the master dev already has
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, Joerg Roedel <jroedel@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>, anan.sun@mediatek.com,
        yi.kuo@mediatek.com, acourbot@chromium.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        anthony.huang@mediatek.com,
        Frank Wunderlich <frank-w@public-files.de>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20220117070510.17642-1-yong.wu@mediatek.com>
 <20220117070510.17642-3-yong.wu@mediatek.com>
 <20220128134055.720bb43c@coco.lan> <20220128134540.00c6c380@coco.lan>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220128134540.00c6c380@coco.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/01/2022 13:45, Mauro Carvalho Chehab wrote:
> Em Fri, 28 Jan 2022 13:40:55 +0100
> Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
> 
>> Hi Matthias/Yong,
>>
>> Are you ok if this patch gets merged via the media tree together with the
>> remaining series, or do you prefer to apply it via SoC tree instead?
> 
> Same questions for other patches touching files outside drivers/media
> on this pull request:
> 
> 	https://patchwork.kernel.org/project/linux-mediatek/patch/7af52d61-47c7-581d-62ed-76a7f8315b16@xs4all.nl/
> 

Looks good to me.

Please let me know once you accepted the pull request and I'll queue the DTS 
related changes from this series.

Regards,
Matthias

> Like those:
> 	0004-0013-iommu-mediatek-v1-Free-the-existed-fwspec-if-the-mas.patch
> 	0005-0013-iommu-mediatek-Return-ENODEV-if-the-device-is-NULL.patch
> 	0006-0013-iommu-mediatek-Add-probe_defer-for-smi-larb.patch
> 	0007-0013-iommu-mediatek-Add-device_link-between-the-consumer-.patch
> 
> Regards,
> Mauro
> 
>>
>> Regards,
>> Mauro
>>
>>
>> Em Mon, 17 Jan 2022 15:04:59 +0800
>> Yong Wu <yong.wu@mediatek.com> escreveu:
>>
>>> When the iommu master device enters of_iommu_xlate, the ops may be
>>> NULL(iommu dev is defered), then it will initialize the fwspec here:
>>>
>>> [<c0c9c5bc>] (dev_iommu_fwspec_set) from [<c06bda80>]
>>> (iommu_fwspec_init+0xbc/0xd4)
>>> [<c06bd9c4>] (iommu_fwspec_init) from [<c06c0db4>]
>>> (of_iommu_xlate+0x7c/0x12c)
>>> [<c06c0d38>] (of_iommu_xlate) from [<c06c10e8>]
>>> (of_iommu_configure+0x144/0x1e8)
>>>
>>> BUT the mtk_iommu_v1.c only supports arm32, the probing flow still is a bit
>>> weird. We always expect create the fwspec internally. otherwise it will
>>> enter here and return fail.
>>>
>>> static int mtk_iommu_create_mapping(struct device *dev,
>>> 				    struct of_phandle_args *args)
>>> {
>>>          ...
>>> 	if (!fwspec) {
>>> 	        ....
>>> 	} else if (dev_iommu_fwspec_get(dev)->ops != &mtk_iommu_ops) {
>>>                  >>>>>>>>>>Enter here. return fail.<<<<<<<<<<<<
>>> 		return -EINVAL;
>>> 	}
>>> 	...
>>> }
>>>
>>> Thus, Free the existed fwspec if the master device already has fwspec.
>>>
>>> This issue is reported at:
>>> https://lore.kernel.org/linux-mediatek/trinity-7d9ebdc9-4849-4d93-bfb5-429dcb4ee449-1626253158870@3c-app-gmx-bs01/
>>>
>>> Reported-by: Frank Wunderlich <frank-w@public-files.de>
>>> Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> Acked-by: Joerg Roedel <jroedel@suse.de>
>>> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   drivers/iommu/mtk_iommu_v1.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
>>> index be22fcf988ce..1467ba1e4417 100644
>>> --- a/drivers/iommu/mtk_iommu_v1.c
>>> +++ b/drivers/iommu/mtk_iommu_v1.c
>>> @@ -425,6 +425,15 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
>>>   	struct mtk_iommu_data *data;
>>>   	int err, idx = 0;
>>>   
>>> +	/*
>>> +	 * In the deferred case, free the existed fwspec.
>>> +	 * Always initialize the fwspec internally.
>>> +	 */
>>> +	if (fwspec) {
>>> +		iommu_fwspec_free(dev);
>>> +		fwspec = dev_iommu_fwspec_get(dev);
>>> +	}
>>> +
>>>   	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
>>>   					   "#iommu-cells",
>>>   					   idx, &iommu_spec)) {
>>
>>
>>
>> Thanks,
>> Mauro
> 
> 
> 
> Thanks,
> Mauro
