Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888A6543297
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbiFHOam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbiFHOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:30:40 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813801F7012;
        Wed,  8 Jun 2022 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654698640; x=1686234640;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wy3q5swCJkf2ktsGowx7L5B+6fEwt7Bq5SRhOUfH3B4=;
  b=aHw1jM5M9TAoJazR7PZr66XGMFagx+jOxxPNb8M+s+DoCKe/ke3AMDD7
   WP7UvmpWCyT7Y4pIw+0JGd1z0j+MI3c5ysWX8alrpER+VzR9yYikO2orV
   reBiv319s3G6wFcjdDUkloc2Ts+nqH7uJl9ndXVsuUyJEdRsAmJcAKb4u
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 08 Jun 2022 07:30:39 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 07:30:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 8 Jun 2022 07:30:38 -0700
Received: from [10.216.34.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 8 Jun 2022
 07:30:33 -0700
Message-ID: <5c847f66-9caf-b303-2c25-b22e67a83c79@quicinc.com>
Date:   Wed, 8 Jun 2022 20:00:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/3] usb: phy: Add devm_of_usb_get_phy_by_phandle
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        <ahalaney@redhat.com>
References: <1654276362-28930-1-git-send-email-quic_harshq@quicinc.com>
 <1654276362-28930-3-git-send-email-quic_harshq@quicinc.com>
 <c52d93db-e89a-24ba-725c-420641bd43af@omp.ru>
From:   Harsh Agarwal <quic_harshq@quicinc.com>
In-Reply-To: <c52d93db-e89a-24ba-725c-420641bd43af@omp.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/6/2022 4:30 PM, Sergey Shtylyov wrote:
> Hello!
>
> On 6/3/22 8:12 PM, Harsh Agarwal wrote:
>
>> Adding support for devm_of_usb_get_phy_by_phandle which allows
>> us to get PHY phandles of a device declared inside lookup_node.
>>
>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> [...]
>> diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
>> index e4de6bc..2581c72 100644
>> --- a/include/linux/usb/phy.h
>> +++ b/include/linux/usb/phy.h
> [...]
>> @@ -249,6 +251,12 @@ static inline struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
>>   	return ERR_PTR(-ENXIO);
>>   }
>>   
>> +extern inline struct usb_phy *devm_of_usb_get_phy_by_phandle(struct device *dev,
>     *extern inline*? :-O
>     Shouldn't it be *static*?
This was a typo. Will change it. Thanks
>   
>> +	const char *phandle, u8 index, struct device_node *lookup_node)
>> +{
>> +	return ERR_PTR(-ENXIO);
>> +}
>> +
>>   static inline struct usb_phy *devm_usb_get_phy_by_node(struct device *dev,
>>   	struct device_node *node, struct notifier_block *nb)
>>   {
> MBR, Sergey
