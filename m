Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7140B4F751A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 07:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiDGFO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 01:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiDGFOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 01:14:49 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087C295A04;
        Wed,  6 Apr 2022 22:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649308369; x=1680844369;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WRHcwAZsrJSbQqVeku+LCjPc+dm4mQsYd2guFxSdvzM=;
  b=YlgnlEVN0s3P75zZTRifc2VE/O+DuHooQrXElTrgPNw/83M+6DrYZh6s
   5DmwdpY44NCub6kQbaoTW0ooP7usgQHFFr4ds69k4JUjF7VRri62/+zon
   MUiZdmxSvK1z11ErhFuOlbX70WpP87fywwcRtbM3xoISnpbD4cIjYGtVy
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Apr 2022 22:12:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 22:12:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 22:12:48 -0700
Received: from [10.216.2.192] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 22:12:43 -0700
Subject: Re: [PATCH V9 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
To:     Stephen Boyd <swboyd@chromium.org>, Mark Brown <broonie@kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com>
 <Yk1B4f51WMGIV9WB@sirena.org.uk>
 <CAE-0n53Cv_bR92M64dhdnDge_=_jeOs4VZzDhUkksN90Y7rgog@mail.gmail.com>
 <Yk21pdu16lyR8jXm@sirena.org.uk>
 <CAE-0n50C8khP2x4sgNP5xnfLVMRQj2=LChyWWx1BWL+Xgecgyw@mail.gmail.com>
 <Yk3Bfnxe/meBYokp@sirena.org.uk>
 <CAE-0n53O23=N0zkZpg87Q3EyKquLe3WLNJT8qnZz4WEor6QK7A@mail.gmail.com>
 <Yk3NkNK3e+fgj4eG@sirena.org.uk>
 <CAE-0n51DJyWQKG1AsMjD1wwxx=KCyvyp7-P9BGfiRX=EKjxfdw@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <aae93f42-c949-0b86-6559-01a4d07fb838@quicinc.com>
Date:   Thu, 7 Apr 2022 10:42:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n51DJyWQKG1AsMjD1wwxx=KCyvyp7-P9BGfiRX=EKjxfdw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2022 11:46 PM, Stephen Boyd wrote:
> Quoting Mark Brown (2022-04-06 10:27:44)
>> On Wed, Apr 06, 2022 at 10:21:01AM -0700, Stephen Boyd wrote:
>>> Quoting Mark Brown (2022-04-06 09:36:14)
>>>> On Wed, Apr 06, 2022 at 08:51:48AM -0700, Stephen Boyd wrote:
>>>>> My guess is that this is one IC that responds to multiple i2c addresses.
>>>>> The "main" qcom,pm8008 address is 0x8 and that supports things like
>>>>> interrupts. Then there's an address for regulators at 0x9 which controls
>>>>> the handful of LDOs on the PMIC.
>>>> So it's like the TI TWL4030 and Palmas - in which case it should
>>>> probably be handled similarly?
>>> How did those work out? I wasn't involved and I don't know what you
>>> mean. Do they have multiple i2c addresses they respond to?
>> Yes, exactly.  The main device uses i2c_new_dummy_device() to
>> instantiate the extras when it probes.  See twl-core.c
> Cool. That approach sounds good to me. Then the regulators can be child
> nodes of the qcom,pm8008 node at i2c address 0x8? It still feels like
> making a struct driver for each regulator node is overkill and will
> waste memory.
>
>>>> Note that the original sumbission was
>>>> *also* a MFD subfunction, but using a DT compatible to match the
>>>> platform device - this is the first I've heard of this being a separate
>>>> I2C function.
>>> I'm mainly looking at the dts file now. It clearly has two i2c devices
>>> at 0x8 and 0x9. Maybe the regulator driver followed the mfd design
>>> because the first driver for this device is an mfd.
>> I'm guessing from the naming that they're also externally described as
>> the same device - presumably it's two dies shoved together in the same
>> package for some reason without being otherwise joined up.  Is the
>> second device geniunely regulators only or does it have anything else
>> bundled in there?
> I think it's regulators only. Pretty sure I asked qcom this a round or
> two ago on this patch series and they said that. Let's wait for Satya to
> respond.


Yes, it contains regulators only.

