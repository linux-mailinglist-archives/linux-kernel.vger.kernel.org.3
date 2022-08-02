Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75CA5881B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiHBSJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHBSJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:09:11 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1CB1260C;
        Tue,  2 Aug 2022 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659463750; x=1690999750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HnVKc3XQcKkacCwwPqn1Gcys57vujuhNWLXz1cK3oJE=;
  b=vmmY0LAKxlMl8ThKNSS1/QniKTsKJik/8buGUX0bBhs2kmb4ajsxalsV
   v85tYdsMK0YnCM7dcSfHmsnH3FeN/A2CcMPWp91Mx4aJKEYYumTxfti9j
   KSlqtj8KYNC7Hnk06nhcwmWnQHLyP3K8vTMJsSzUKF7wKeNEDy9oYuGcT
   o=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Aug 2022 11:09:10 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 11:09:09 -0700
Received: from [10.110.16.211] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 2 Aug 2022
 11:09:08 -0700
Message-ID: <710f2b46-f30a-3d69-4a2c-2c67cb62c80b@quicinc.com>
Date:   Tue, 2 Aug 2022 11:09:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v12 0/9] Coresight: Add support for TPDM and TPDA
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20220710021032.27455-1-quic_jinlmao@quicinc.com>
 <3f714c34-277d-ef71-b527-f758172160f9@quicinc.com>
 <20260db2-8c7e-e2b6-2385-74f433e4b55e@quicinc.com>
 <23ae507d-1a01-9a33-52fb-73ac9efca8aa@quicinc.com>
 <7ff0a9c5-b009-7b45-ac85-8ce26619a00a@arm.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <7ff0a9c5-b009-7b45-ac85-8ce26619a00a@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 8/2/2022 10:43 AM, Suzuki K Poulose wrote:
> Hi Trilok,
> 
> On 02/08/2022 18:33, Trilok Soni wrote:
>>
>>
>> On 8/2/2022 7:43 AM, Jinlong Mao wrote:
>>> Hi Reviewers,
>>>
>>> Please help to review V12 series of TPDM/TPDA patches.
>>>
>>> Thanks
>>>
>>
>> Suzuki and Mathieu, we are almost there it seems in getting the 
>> acceptance of these patches, so I hope you find the time to review 
>> these patches. I guess it is almost a year now for these patches and 
>> had a good amount of reviews and revisions :)
> 
> This series has been reviewed for the previous versions (which is why
> we have it in v12) and this one depends on a series worked on by Mike
> Leach. We cannot push this without the dynamic Trace ID allocation
> scheme, which is clearly mentioned in the cover letter for this
> series.
> 
> As such this series is in a good shape, assuming all the comments
> in the previous version has been addressed. So, we would rather
> get Mike's work priority and pull that in, so that we can eventually
> get this upstream.
> 
> 

I believe we have addressed all the comments in v12. Are you ok, if we 
post additional features series (around ~2k to ~3k SLOC)? I just want to 
make sure we are not creating flood of patches w/ features.

---Trilok Soni
