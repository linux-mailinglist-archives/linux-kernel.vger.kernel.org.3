Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7151C4F6100
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiDFODE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiDFOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:02:37 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822D6636E;
        Wed,  6 Apr 2022 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649236785; x=1680772785;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=C30EsKSnyXniVsuHK+cXjwGqiqlPYMws48JZ2eTUz6s=;
  b=XVA4uOShm3u9NeDWBVFvWvVJF9+G9O9GAGUOojkAAfYnbB2Vvarqrnpc
   jHm+B3NwgAIXCkZVhGxd0MvVgdcwHsPtyLCoOKs2OxEu6YImUQRlXBfjf
   49I4NBE+bKVf5bIP9ih/ELM9wkeiJJZ1kfzk7mVzweYcG54YmAxn4jlyr
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 06 Apr 2022 02:19:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 02:19:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 02:19:44 -0700
Received: from [10.216.50.162] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 02:19:39 -0700
Subject: Re: [PATCH V9 3/6] mfd: pm8008: Add mfd cell struct to register LDOs
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649166633-25872-4-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n52hZy6ia3i0yv9U_1TnqDf-NAW3587RSS_qG+GRNhh3yg@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <738b87e0-85dd-70b4-178b-9c3a9c5a7468@quicinc.com>
Date:   Wed, 6 Apr 2022 14:49:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n52hZy6ia3i0yv9U_1TnqDf-NAW3587RSS_qG+GRNhh3yg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2022 12:38 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-04-05 06:50:30)
>> Add mfd cell struct to match with the "qcom,pm8008-regulator"
>> driver and a separate probe to add pm8008_regulator_devs.
>> This separate probe is required to ensure the regulators are
>> registered only with the mfd device which contains regulators.
> I don't get it. Shouldn't the pm8008-regulators compatible string be a
> different i2c driver in drivers/regulator/ that matches the compatible
> string for qcom,pm8008-regulators?


Initially we had it that way but as per Mark's suggestion here [1] I've 
made these changes to register regulators directly through mfd driver.

[1] 
https://patchwork.kernel.org/project/linux-arm-msm/patch/1637314953-4215-3-git-send-email-quic_c_skakit@quicinc.com/#24618011


>> Add the reset-gpio toggling in the pm8008_probe() to bring
>> pm8008 chip out of reset instead of doing it in DT node using
>> "output-high" property.
> Please split this part off to a different patch.


Okay.


