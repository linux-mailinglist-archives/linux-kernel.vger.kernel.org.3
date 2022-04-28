Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D91512CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245374AbiD1Hf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245367AbiD1HfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:35:23 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D149BAD1;
        Thu, 28 Apr 2022 00:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651131129; x=1682667129;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TtTEDOKV+7lqUt5tmJpa+arLx7nlS1Q6ti+9N5cH9lE=;
  b=grs91oUZ/aYPOpNWtZL2AXdx1N7fy3xdL1v3DF1Yr1mZ5N2Ul/Cr+ItS
   0UzUM8KETJFu/qiZrb1MN1Uu/t6y2otsZCkD6ngGiHmhsGk7HbhSFzdFC
   t8SwxBGPz6eQ5f+ZNrhQVnJ+SxpiKC5j9NQTvHcDlETi+vW+3JdFpc2ie
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 28 Apr 2022 00:32:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 00:32:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 00:32:08 -0700
Received: from [10.50.42.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 00:32:04 -0700
Message-ID: <b935102a-3f4b-2b45-b4d3-03b489404b44@quicinc.com>
Date:   Thu, 28 Apr 2022 13:02:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv11 6/6] asm-generic/io: Add logging support for MMIO
 accessors
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <catalin.marinas@arm.com>, <rostedt@goodmis.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>
References: <cover.1645772606.git.quic_saipraka@quicinc.com>
 <3de35c9f4a3a070d197bab499acefc709a6f5336.1645772606.git.quic_saipraka@quicinc.com>
 <YmorwEGw/SATMUKt@kroah.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <YmorwEGw/SATMUKt@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/2022 11:23 AM, Greg KH wrote:
> On Thu, Apr 28, 2022 at 09:00:13AM +0530, Sai Prakash Ranjan wrote:
>> Add logging support for MMIO high level accessors such as read{b,w,l,q}
>> and their relaxed versions to aid in debugging unexpected crashes/hangs
>> caused by the corresponding MMIO operation. Also add a generic flag
>> (__DISABLE_TRACE_MMIO__) which is used to disable MMIO tracing in nVHE KVM
>> and if required can be used to disable MMIO tracing for specific drivers.
> Also, this should be split up into 2 patches, one to add the "disable
> the feature" flag, and one to enable it for the specific driver(s) you
> want.
>
> Hint, when you say "also" in a changelog text, that's a huge sign that
> it perhaps should be split up into smaller pieces.
>

Right, will split them.

Thanks,
Sai
