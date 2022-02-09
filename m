Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320FB4AED0C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiBIIrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:47:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiBIIra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:47:30 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38CE00E585;
        Wed,  9 Feb 2022 00:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644396443; x=1675932443;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=3E/k9hHBNfXwsD5JScD3Hm1owmhXeuhCGouRaTwikqE=;
  b=Zk3fcnUiysMH58XvdL1/h5RmYmpE45coU6tuBbcmzKBNkc7b+Tl/9Kyk
   HJKnMnx1rtuTnbfWJWxvhG07cA1dfJNAbbSnLAX7L49SOkeSD6Ys5Ilsk
   /NGAuLJld7SVaZu2Bn2J8ooG1L6Ur3HHf5OJyd7BeCa9tLPMg/ax9kOte
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Feb 2022 00:41:20 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 00:41:20 -0800
Received: from [10.216.42.92] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 9 Feb 2022
 00:41:17 -0800
Message-ID: <c055e4e8-fd11-49e9-c7a9-bf2f1ec9de36@quicinc.com>
Date:   Wed, 9 Feb 2022 14:11:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] regmap-irq: Use regmap_irq_update_bits instead of
 regmap_write
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
References: <20220119142953.1804-1-quic_pkumpatl@quicinc.com>
 <CGME20220208122955eucas1p2d4e32f51224242e9ebd0bce58b9c04ca@eucas1p2.samsung.com>
 <39f1b598-58ca-1e3d-3065-8dd692ee7c9f@samsung.com>
From:   Prasad Kumpatla <quic_pkumpatl@quicinc.com>
In-Reply-To: <39f1b598-58ca-1e3d-3065-8dd692ee7c9f@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/8/2022 5:59 PM, Marek Szyprowski wrote:

> There is something wrong with this patch. Since it landed in linux-next
> (20220204) I get an interrupt storm on two of my test devices:
>
> 1. ARM 32bit Exynos4412-based Trats2 ("wm8994-codec wm8994-codec: FIFO
> error" message)
>
> 2. ARM 64bit Exynos5433-based TM2e ("arizona spi1.0: Mixer dropped
> sample" message)
>
> Definitely the interrupts are not acknowledged properly. Once I find
> some spare time, I will check it further which regmap configuration
> triggers the issue, but it is definitely related to this patch.
> Reverting it on top of current linux-next fixes the issue.

Change is needed to handle the interrupt ack properly to clear the ack.

I observed that the regmap_irq_update_bits() writes the register only if 
it finds a difference b/w existing reg value to update reg value.

This may be causing the interrupt storm issue mentioned above.

Setting the mask_writeonly flag to 1, to force write the register may 
resolve the interrupt storm issue.

--Prasad

