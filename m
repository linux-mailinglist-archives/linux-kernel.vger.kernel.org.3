Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022B35129C1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241742AbiD1DGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbiD1DGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:06:36 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620F225587;
        Wed, 27 Apr 2022 20:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651115003; x=1682651003;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6O59IgNgL7B7erRuttFBLDv1f9E92kCNdtPD0G/1VB8=;
  b=jLqLuHN0Py8MWCvREFUor2aQXo+WMzOIgshLLv4/sZagDjEiC0//QkTe
   lmeCYK/kjemRb3E93zqobjjIY8BGfJnzT0Xjg1GRs6dD/jCPuGm2gQfMW
   juMa8gO1F84yLBknNECWDL37eIGnHOqhiO6JgX1K89KwxkJnneDz9Vv7C
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Apr 2022 20:03:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 20:03:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 20:03:22 -0700
Received: from [10.50.42.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 20:03:17 -0700
Message-ID: <65531cb4-efff-1e0e-2bac-7c7759ff55cd@quicinc.com>
Date:   Thu, 28 Apr 2022 08:33:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv10 4/6] drm/meson: Fix overflow implicit truncation
 warnings
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        kernel test robot <lkp@intel.com>
References: <cover.1644824638.git.quic_saipraka@quicinc.com>
 <9c7ff199d826b60e019c0eeeb6aa280abfdb9a82.1644824638.git.quic_saipraka@quicinc.com>
 <CAK8P3a3_Ea2Szn61D-t--52V-zk+B-sq2mi5YbfMbTim7M9ZAQ@mail.gmail.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <CAK8P3a3_Ea2Szn61D-t--52V-zk+B-sq2mi5YbfMbTim7M9ZAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/2022 9:29 PM, Arnd Bergmann wrote:
> On Thu, Feb 24, 2022 at 7:07 AM Sai Prakash Ranjan
> <quic_saipraka@quicinc.com> wrote:
>> Fix -Woverflow warnings for drm/meson driver which is a result
>> of moving arm64 custom MMIO accessor macros to asm-generic function
>> implementations giving a bonus type-checking now and uncovering these
>> overflow warnings.
>>
>> drivers/gpu/drm/meson/meson_viu.c: In function ‘meson_viu_init’:
>> drivers/gpu/drm/meson/meson_registers.h:1826:48: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
>>   #define  VIU_OSD_BLEND_REORDER(dest, src)      ((src) << (dest * 4))
>>                                                  ^
>> drivers/gpu/drm/meson/meson_viu.c:472:18: note: in expansion of macro ‘VIU_OSD_BLEND_REORDER’
>>     writel_relaxed(VIU_OSD_BLEND_REORDER(0, 1) |
>>                    ^~~~~~~~~~~~~~~~~~~~~
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> It took me a bit to understand why we got the warning in the first place, but I
> should have just read the patch description, it's all there....

Right :)

Thanks,
Sai
