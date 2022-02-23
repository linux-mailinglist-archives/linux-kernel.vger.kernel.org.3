Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ADB4C0CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiBWHBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiBWHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:01:20 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613B549C82;
        Tue, 22 Feb 2022 23:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645599653; x=1677135653;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=P8IB5i4i8mccW/2mm5mdBV6fgyPwz4NSzRZVqW15XCw=;
  b=PYm9O+WRwZkcs2lBRKgPWNCB7V2uSXVyXtvpYZ1yKyUR1YQsvXonsjbB
   wAUxOaEEOo7S/KwirSgjEA/yP9x7P0eeD4tGYj73vecgNxVIbLru5wnz2
   ScB4sDqUMpzMOmgkx2/Bjaq7DHpIEOv9k830Z6nTSScYUEKxpfrwBTj0f
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Feb 2022 23:00:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 23:00:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Feb 2022 23:00:51 -0800
Received: from [10.216.58.51] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 22 Feb
 2022 23:00:45 -0800
Message-ID: <9a618cb6-c528-94f1-c10c-248e2a04aa13@quicinc.com>
Date:   Wed, 23 Feb 2022 12:30:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 5/7] pinctrl: qcom: Extract chip specific LPASS LPI
 code
Content-Language: en-US
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>, <agross@kernel.org>,
        <alsa-devel@alsa-project.org>, <bgoswami@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <judyhsiao@chromium.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <perex@perex.cz>, <quic_plai@quicinc.com>, <robh+dt@kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com>
 <1644851994-22732-6-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53-GRneymVoac=AT6M17aYseS88vM-o1xZxmk8sFQOYhw@mail.gmail.com>
 <ee5004ea-0aa9-b7ef-061a-e07d0d47c7c6@quicinc.com>
Organization: Qualcomm
In-Reply-To: <ee5004ea-0aa9-b7ef-061a-e07d0d47c7c6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 2/20/2022 12:02 AM, Srinivasa Rao Mandadapu (Temp) wrote:
>
> On 2/19/2022 8:13 AM, Stephen Boyd wrote:
> Thanks for Your time Stephen!!!
>> Quoting Srinivasa Rao Mandadapu (2022-02-14 07:19:52)
>>> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c 
>>> b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
>>> new file mode 100644
>>> index 0000000..27e358e
>>> --- /dev/null
>>> +++ b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
>>> @@ -0,0 +1,166 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2020 Linaro Ltd.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/gpio/driver.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +#include "pinctrl-lpass-lpi.h"
>> Please include ../core.h here as well for the pin_group definition.
> Okay. will add it.

Actually, core.h was included in pinctrl-lpass-lpi.h. Including again 
here giving redefinition errors.

Already sent V8 with this change. will revert it and post again in v9.

