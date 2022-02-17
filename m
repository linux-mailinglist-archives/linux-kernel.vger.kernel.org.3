Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213E74B9A87
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiBQIEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:04:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiBQIEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:04:34 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F43279918
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645085061; x=1676621061;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pwDo/bThQTAJtt8i/IPbk2BJGF9LYzjGYVkpUNL0TLI=;
  b=gbDMbbIEhiXfhrrObJQ2v8HiQgKMlxPOa7RcPtuiLeiRhSc8Acd96HxU
   IP/cBff4jK1tvzJrsKDs2HhbRDQFwjMy57DjO3kXeZmDqYKq4wA/5xR0I
   hTGpFmjxafqUkbBqKU1Uc9BID8kDROd5BR/vbtpGsVP6YfUfvdZNVvKmf
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Feb 2022 00:04:20 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 00:04:20 -0800
Received: from [10.216.4.163] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 17 Feb
 2022 00:04:17 -0800
Message-ID: <48e32131-2313-5b0e-ac1b-530d0118de18@quicinc.com>
Date:   Thu, 17 Feb 2022 13:34:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] regmap-irq: Update interrupt clear register for proper
 reset
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        "Srinivas Kandagatla [ B [ B [ B" <srinivas.kandagatla@linaro.org>
References: <20220216100026.25543-1-quic_pkumpatl@quicinc.com>
 <Yg0tUlQ/Qs8AHa4O@sirena.org.uk>
From:   Prasad Kumpatla <quic_pkumpatl@quicinc.com>
In-Reply-To: <Yg0tUlQ/Qs8AHa4O@sirena.org.uk>
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


On 2/16/2022 10:28 PM, Mark Brown wrote:
Thanks for your time Mark Brown.
> On Wed, Feb 16, 2022 at 03:30:26PM +0530, Prasad Kumpatla wrote:
>> With the existing logic where clear_ack is true, interrupt clear register
>> reset is not handled properly. Due to this only the first interrupts get
>> processed properly and further interrupts are blocked due to interrupt
>> clear register is not reset. So writing 0x00 and 0xff(when ack_invert is
>> true) should have no effect, other than clearing the ACKs just set.
> This commit log still has the problem that it's not clearly describing
> the problem and I've forgotten again - in what way is the interrupt
> clear reset not handled properly?  What should happen and what does
> happen?
Okay, will elaborate the commit message and resend.
>>   				if (d->chip->ack_invert && !ret)
>> -					ret = regmap_write(map, reg,
>> -							   d->mask_buf[i]);
>> +					ret = regmap_write(map, reg, 0xff);
> Why only 0xff and not UINT_MAX?
Okay.
>
>>   				else if (!ret)
>> -					ret = regmap_write(map, reg,
>> -							   ~d->mask_buf[i]);
>> +					ret = regmap_write(map, reg, 0x00);
> Please write 0 normally, no need for 00.
Okay.
