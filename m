Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E9257DA4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiGVGbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVGb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:31:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC3C3DBF2;
        Thu, 21 Jul 2022 23:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658471485; x=1690007485;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y9U9hgHsliqp7Qq1Blddtrmz1F+idNaVLFX9hxiQUgw=;
  b=xmIvK/cfsaue7bZfIz30zRUJ5WNiBTXNc3xB0Q79NVfdX3QGmhnRKXLM
   ZYNblSUxifAZ+pHuekZdnlXGwGW95alp3nwqE7hS0rcVYicH5Ncp4JCHG
   9f8jCbjii0NNyDFy17cfnu0xkz7Y4qHT3luL9iPH9pPanw5IDQHLfipCa
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 21 Jul 2022 23:31:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 23:31:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 21 Jul 2022 23:31:24 -0700
Received: from [10.50.44.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 21 Jul
 2022 23:31:19 -0700
Message-ID: <dc737abb-041b-491a-14f1-a584f9e64a3d@quicinc.com>
Date:   Fri, 22 Jul 2022 12:01:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V15 6/9] mfd: pm8008: Use i2c_new_dummy_device() API
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <YrxtXdOsIZ5LKhdV@google.com>
 <f8e70198-d0d8-5500-2869-be9e3a34f3c1@quicinc.com>
 <Yr18M9dzTOWL0m2c@google.com>
 <de1f3f33-0a8c-eb87-694c-16ebf2835720@quicinc.com>
 <Yr6oLlmfWRkiAZG7@google.com>
 <52c6ab15-1cd8-324e-4bcc-c449d8bceb19@quicinc.com>
 <Yr66ZZqEnBApHYMA@google.com>
 <0481d3cc-4bb9-4969-0232-76ba57ff260d@quicinc.com>
 <YsLhxx+L3+GJDRyO@google.com>
 <bcc5f059-b991-296a-bba6-9cb1236097f2@quicinc.com>
 <Ys1tYAO39LKzEAOE@google.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <Ys1tYAO39LKzEAOE@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

> Okay, so I've taken some time to read through your previous
> submissions to see how we ended up down this rabbit hole.
>
> Essentially, it looks to me like the 2 I2C devices should be kept
> separate and the Regulator driver should be registered/probed without
> requiring this I2C dummy device hoop jumping exercise.
>
> As Stephen asked in v9 [0], why can't the regulator driver be I2C?
>
> Then it can manage its own resources and all of this craziness can be
> avoided.
>
> That's not to say that the v9 submission was the right way to go
> either.  Everything in relation to:
>
>    i2c_add_driver(&pm8008_regulators_driver);
>
> ... should be moved into the Regulator driver itself.


So, IIUC, we need to register the regulator driver as an i2c_driver and 
do all the regmap init stuff in its probe, and not touch the mfd 
driver(apart from adding reset-gpios).

Then the DT would be simply:

&pm8008_bus {
     pm8008: pm8008@8 {
         compatible = "qcom,pm8008";
         reg = <0x8>;
         #address-cells = <1>;
         #size-cells = <0>;
         #interrupt-cells = <2>;
     };

     pm8008_regulators: pm8008@9 {
         compatible = "qcom,pm8008-regulators";
         reg = <0x9>;
         #address-cells = <0>;
         #size-cells = <0>;

         pm8008_l1: ldo1@4000 {
             reg = <0x4000>;
             regulator-name = "pm8008_l1";
         };

         pm8008_l2: ldo2@4100 {
             reg = <0x4100>;
             regulator-name = "pm8008_l2";
         };

         pm8008_l3: ldo3@4200 {
             reg = <0x4200>;
             regulator-name = "pm8008_l3";
         };

         pm8008_l4: ldo4@4300 {
             reg = <0x4300>;
             regulator-name = "pm8008_l4";
         };

         pm8008_l5: ldo5@4400 {
             reg = <0x4400>;
             regulator-name = "pm8008_l5";
         };

         pm8008_l6: ldo6@4500 {
             reg = <0x4500>;
             regulator-name = "pm8008_l6";
         };

         pm8008_l7: ldo7@4600 {
             reg = <0x4600>;
             regulator-name = "pm8008_l7";
         };
     };
};


Stephen/Mark, Please do let me know if you are OK with this design.

