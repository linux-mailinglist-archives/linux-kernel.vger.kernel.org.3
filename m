Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61202494EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbiATNZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiATNZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:25:47 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A0CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:25:46 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id w26so12190741wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kAsXsTC0RU0DhDqIgVdxNCmIQvwWy+xHCXDDCFyjF7k=;
        b=D9Z4YdkhIp52f/F0ohGFC1DwtH5ScPFz9I6fu/t+cxl3IFj5j4AEU65igDmyulaVUP
         +YC8zdn10aOCJG4WZDw8XjAwP76h5Fc2WSY+gFBCa5Ao1ThkO27mPo9wBxWsAXPavVDW
         1WceziBjpMLuY/Yxn1xAuup5daUzIfh1OcN35XSqEdlSRzsfNETQ+TTjymHv8PA2n4K8
         S5mMwkgQx+JOnT7VjB9pqnUHo8GYf35ui/vAzwfAHxJic12yuusWe3k7TY1pwyO0JNLU
         ngpS+COg/BWHxAbIm3RA3Y1OJ1oAL7IabGQ1po+uUDSmuLmhXS4mwpsPm8G/CdDE7H9n
         77nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kAsXsTC0RU0DhDqIgVdxNCmIQvwWy+xHCXDDCFyjF7k=;
        b=bPWofxRPoQKBt5JqXd6sr/OWdAFMn6vjvgUfvTZ/j7/AKrBL2ARWHSPZeAzVLZmtSO
         ugA6OQXn1j8Kga9eCKbvjDp+zLF+m7Ki9XxXSMB6a2KWVV4FWkT/u6VERXtCZTMh/ycY
         pg3XLFdZGghGcf85SW5hpbRm4L0uLd1BqUY+4hDPcKbQJR+UR+D3ZLJma+4RQhYmxukZ
         aOvatZhxlcnGvPDIwca8PiuK7zhPo1MIYsALqckARcNOJVs+fA3XRdVCbULobnL4o70r
         DMX0CtD1yq7XNQgV6D/X4CT58oTgVTDxUqBwc50ip1YenmHQlmIEcKLG7FGD307mxAb7
         QLDw==
X-Gm-Message-State: AOAM532Zddf1f0N6simelVqaYDv/R1kfcmzWd9xinRJIMUmSMk1zy3Ej
        8fXFN+zb0rU5LzD++jh3m5cRsA==
X-Google-Smtp-Source: ABdhPJx9tUMWG1WqLLKxj5kQMCM7A0vvR/CyiPFx0lBhMi5gZkpTZhT//+hM9bKKl357iiwJTNAotQ==
X-Received: by 2002:a7b:c5ce:: with SMTP id n14mr9009688wmk.11.1642685145050;
        Thu, 20 Jan 2022 05:25:45 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:ced2:397a:bee8:75f5? ([2001:861:44c0:66c0:ced2:397a:bee8:75f5])
        by smtp.gmail.com with ESMTPSA id r7sm6134731wma.39.2022.01.20.05.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 05:25:44 -0800 (PST)
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi: use safe format when first in
 bridge chain
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     robert.foss@linaro.org, jernej.skrabec@gmail.com, jonas@kwiboo.se,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kieran.bingham@ideasonboard.com,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        laurent.pinchart@ideasonboard.com, biju.das.jz@bp.renesas.com
References: <20220119122843.1455611-1-narmstrong@baylibre.com>
 <CAMty3ZBHSt2jjOxhQWpyYviTM3-uF0HXFtbGPjVddk4PP8Npsw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <93be750c-c96b-d257-584a-e5da3f260b05@baylibre.com>
Date:   Thu, 20 Jan 2022 14:25:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMty3ZBHSt2jjOxhQWpyYviTM3-uF0HXFtbGPjVddk4PP8Npsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/01/2022 12:14, Jagan Teki wrote:
> On Wed, Jan 19, 2022 at 5:58 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> When the dw-hdmi bridge is in first place of the bridge chain, this
>> means there is no way to select an input format of the dw-hdmi HW
>> component.
>>
>> Since introduction of display-connector, negotiation was broken since
>> the dw-hdmi negotiation code only worked when the dw-hdmi bridge was
>> in last position of the bridge chain or behind another bridge also
>> supporting input & output format negotiation.
>>
>> Commit 0656d1285b79 ("drm/bridge: display-connector: implement bus fmts callbacks")
>> was introduced to make negotiation work again by making display-connector
>> act as a pass-through concerning input & output format negotiation.
>>
>> But in the case where the dw-hdmi is single in the bridge chain, for
>> example on Renesas SoCs, with the display-connector bridge the dw-hdmi
>> is no more single, breaking output format.
>>
>> Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
>> Bisected-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> Fixes: 0656d1285b79 ("drm/bridge: display-connector: implement bus fmts callbacks").
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>> Changes since v1:
>> - Remove bad fix in dw_hdmi_bridge_atomic_get_input_bus_fmts
>> - Fix typos in commit message
>>
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index 54d8fdad395f..97cdc61b57f6 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -2551,8 +2551,9 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>>         if (!output_fmts)
>>                 return NULL;
>>
>> -       /* If dw-hdmi is the only bridge, avoid negociating with ourselves */
>> -       if (list_is_singular(&bridge->encoder->bridge_chain)) {
>> +       /* If dw-hdmi is the first or only bridge, avoid negociating with ourselves */
>> +       if (list_is_singular(&bridge->encoder->bridge_chain) ||
>> +           list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain)) {
> 
> What if we use bridge helper, drm_bridge_chain_get_first_bridge in
> order to find the first bridge in chain?

drm_bridge_chain_get_first_bridge() would be similar, since we already access bridge_chain
in the previous check, it's simpler like that.

Neil

> 
> Thanks,
> Jagan.
> 

