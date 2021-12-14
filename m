Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CA747492F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhLNRWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:22:22 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12100 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235889AbhLNRWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639502540; x=1671038540;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yq8N2AXZoLLyeKdy61gCr0CS4sQ/YtBJ910CTaGYMFY=;
  b=N4CbasOmySUk4T09gWRuXAwOYEy9J4BGOT9+KLzRYR0H8pthY3TO8IZk
   wLXaBXqQawZr0l1gmrpzHBruN0x+Jy5pf8DF0RAyvtQFiPWWoyknhQhaW
   Anxos+QiW6PisAtantjtjgOg3FFrydndx8i3VGvvHOGeooT/FJJo7NE3f
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Dec 2021 09:22:19 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 09:22:19 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 14 Dec 2021 09:22:18 -0800
Received: from [10.216.27.180] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 14 Dec
 2021 09:22:11 -0800
Subject: Re: [PATCH v5 3/5] pinctrl: qcom: Extract chip specific LPASS LPI
 code
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <rohitkr@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com>
 <1638891339-21806-4-git-send-email-quic_srivasam@quicinc.com>
 <CAHp75Vd=47Tv9Sf+styPhxS2=O1H2KUDeKQXTULUYU5fDgGwwA@mail.gmail.com>
 <0f6621e5-f014-27c9-be8b-6c32ab994304@quicinc.com>
 <CAHp75VdL3hmr23CcJLDpvbHaKv5HrDZjmVQpCnRNmPM7nEx6WQ@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <4bcfadd0-8abb-e9e9-ad18-a5b1d3d46308@quicinc.com>
Date:   Tue, 14 Dec 2021 22:52:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdL3hmr23CcJLDpvbHaKv5HrDZjmVQpCnRNmPM7nEx6WQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/2021 10:46 PM, Andy Shevchenko wrote:
> On Tue, Dec 14, 2021 at 7:15 PM Srinivasa Rao Mandadapu
> <quic_srivasam@quicinc.com> wrote:
>> On 12/8/2021 11:58 AM, Andy Shevchenko wrote:
> ...
>
>>>> +#define NO_SLEW                                -1
>>> Naming sucks for the header.
>>>
>>> LPI_NO_SLEW ?
>> Actually it's already mainline code. Just these patches are
>> rearrangement of old code.
>>
>> still do you suggest to change?
> I would, but this means it should be in a separate change.
>
> ...
Yes. Will do it separate patch later.
>
>>>> +struct lpi_pingroup {
>>>> +       const char *name;
>>>> +       const unsigned int *pins;
>>>> +       unsigned int npins;
>>>> +       unsigned int pin;
>>>> +       /* Bit offset in slew register for SoundWire pins only */
>>>> +       int slew_offset;
>>>> +       unsigned int *funcs;
>>>> +       unsigned int nfuncs;
>>>> +};
>>> Are you going to convert this to use struct group_desc?
> Any comments on this? It sounds like further improvements.
Actually this also needs as separate patch. these patches will do as 
separate series.
>
