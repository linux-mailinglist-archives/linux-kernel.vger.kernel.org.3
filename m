Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7324B51058F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351257AbiDZRkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiDZRj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:39:59 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88EAB53E8;
        Tue, 26 Apr 2022 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650994611; x=1682530611;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LfeU+qR1LVCLWLHBR/AmkPZiH2YFo20bzm5nVGPB3CI=;
  b=jMhV7g5itxKnp+Qufeya3OFLGqUSH/1uf1qGIXgqERqGBBPCYvJ0a6Zz
   bkrOk9TBvefTEow2nSWqcaT6sDBdSxm636aI8+NSuUlbKc/0koh0Illpl
   cfRX4MFycnfuXKNRSa0YB0EP0g/7CqigNSeZOEjxnZntw8dMTPsq0y3v7
   I=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Apr 2022 10:36:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 10:36:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 10:36:50 -0700
Received: from [10.111.160.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Apr
 2022 10:36:47 -0700
Message-ID: <244db806-7afc-e8e9-a855-c592e0af8c44@quicinc.com>
Date:   Tue, 26 Apr 2022 10:36:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] drm/msm/dp: remove fail safe mode related code
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dmitry.baryshkov@linaro.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_aravindh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1650952595-27783-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n53kv+NPJ-4Cpjy_FeJT5xOo7fLNz24fyGUcjy6ucccjbQ@mail.gmail.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAE-0n53kv+NPJ-4Cpjy_FeJT5xOo7fLNz24fyGUcjy6ucccjbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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



On 4/25/2022 11:00 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-04-25 22:56:35)
>> Current DP driver implementation has adding safe mode done at
>> dp_hpd_plug_handle() which is expected to be executed under event
>> thread context.
>>
>> However there is possible circular locking happen (see blow stack trace)
>> after edp driver call dp_hpd_plug_handle() from dp_bridge_enable() which
>> is executed under drm_thread context.
>>
>> After review all possibilities methods and as discussed on
>> https://patchwork.freedesktop.org/patch/483155/, supporting EDID
>> compliance tests in the driver is quite hacky. As seen with other
>> vendor drivers, supporting these will be much easier with IGT. Hence
>> removing all the related fail safe code for it so that no possibility
>> of circular lock will happen.
> [...]
>>
>> Changes in v2:
>> -- re text commit title
>> -- remove all fail safe mode
>>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> 
> Should add some Fixes tags here, probably for the first introduction of
> this logic and the one that moved stuff around to try to avoid the
> lockdep warning.

Fixes: 8b2c181 ("drm/msm/dp: add fail safe mode outside of event_mutex 
context")
