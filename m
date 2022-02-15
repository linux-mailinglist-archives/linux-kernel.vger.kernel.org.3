Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66354B6235
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 05:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiBOEoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 23:44:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiBOEoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 23:44:01 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFFB205C2;
        Mon, 14 Feb 2022 20:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644900229; x=1676436229;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=tNvbhTo5yoDWvXEbejXdKHBOPnCfq/ULbpuyV4zgSTQ=;
  b=zUjFTFNxB7dc3LjueoMaa0T3XUCkRyBCEnOXyKAkcW0bZ3ELEer0b9TX
   9g1rnf4CxI2oREl4KTElDE5rldIWhmcrgNggraKQmPghwin/KJ2KrFAy0
   G/ytV8cJRFyat7hoKJRJ3T27TskDz/T6b7yFNxCGrft2KRza8fjs95gw6
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 14 Feb 2022 20:43:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 20:43:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 20:43:48 -0800
Received: from [10.216.12.129] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 14 Feb
 2022 20:43:42 -0800
Subject: Re: [PATCH 1/2] ASoC: codec: wcd938x: Add switch control for
 selecting CTIA/OMTP Headset
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <alsa-devel@alsa-project.org>, <bgoswami@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <judyhsiao@chromium.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <perex@perex.cz>,
        <quic_plai@quicinc.com>, <robh+dt@kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644668672-29790-1-git-send-email-quic_srivasam@quicinc.com>
 <1644668672-29790-2-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n52uBY7GzjtFwV67y5mfqZRoK9ooW-kT3=4sH=8NtVK7FQ@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <cc99e97d-5256-b121-2785-1290505bc994@quicinc.com>
Date:   Tue, 15 Feb 2022 10:13:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n52uBY7GzjtFwV67y5mfqZRoK9ooW-kT3=4sH=8NtVK7FQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/15/2022 3:17 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-12 04:24:31)
>> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
>> index eff200a..08d16a9 100644
>> --- a/sound/soc/codecs/wcd938x.c
>> +++ b/sound/soc/codecs/wcd938x.c
>> @@ -194,6 +194,7 @@ struct wcd938x_priv {
>>          int ear_rx_path;
>>          int variant;
>>          int reset_gpio;
>> +       int us_euro_gpio;
>>          u32 micb1_mv;
>>          u32 micb2_mv;
>>          u32 micb3_mv;
>> @@ -4196,6 +4197,33 @@ static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_pri
>>                  dev_info(dev, "%s: Micbias4 DT property not found\n", __func__);
>>   }
>>
>> +static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component, bool active)
>> +{
>> +       int value;
>> +
>> +       struct wcd938x_priv *wcd938x;
>> +
>> +       if (!component) {
> So component is NULL
>
>> +               dev_err(component->dev, "%s component is NULL\n", __func__);
> And now we deref component. Great NULL pointer exception Batman! Please
> test your code and remove useless checks. It makes the code harder to
> read and slows things down.
Okay. In last minute, changed from pr_err to dev_err and overlooked this 
mistake. Will remove it.
>
>> +               return false;
>> +       }
>> +
>> +       wcd938x = snd_soc_component_get_drvdata(component);
>> +       if (!wcd938x) {
>> +               dev_err(component->dev, "%s private data is NULL\n", __func__);
> Is this possible? I doubt it so can we just remove it?
Okay. Will remove it.
>
>> +               return false;
>> +       }
>> +
>> +       value = gpio_get_value(wcd938x->us_euro_gpio);
>> +
>> +       gpio_set_value(wcd938x->us_euro_gpio, !value);
>> +       /* 20us sleep required after changing the gpio state*/
> Add a space before ending comment with */
Okay.
>
>> +       usleep_range(20, 30);
>> +
>> +       return true;
>> +}
>> +
>> +
>>   static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device *dev)
>>   {
>>          struct wcd_mbhc_config *cfg = &wcd938x->mbhc_cfg;
>> @@ -4208,6 +4236,16 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
>>                  return wcd938x->reset_gpio;
>>          }
>>
>> +       wcd938x->us_euro_gpio = of_get_named_gpio(dev->of_node, "us-euro-gpios", 0);
> Why do we need to use of GPIO APIs here? Can this driver be converted to
> use GPIO descriptors via the gpiod APIs?
Okay.  will look into it and proceed accordingly!!!
>
>> +       if (wcd938x->us_euro_gpio < 0) {
>> +               dev_err(dev, "Failed to get us-euro-gpios gpio: err = %d\n", wcd938x->us_euro_gpio);
>> +       } else {
>> +               cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
>> +               gpio_direction_output(wcd938x->us_euro_gpio, 0);
>> +               /* 20us sleep required after pulling the reset gpio to LOW */
>> +               usleep_range(20, 30);
>> +       }
>> +
