Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6928B4EFAFD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351876AbiDAUTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbiDAUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:19:22 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C3D2706E7;
        Fri,  1 Apr 2022 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648844251; x=1680380251;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=0iVObdGleih24MzhGqYB2GKJBy7AJG+MlhwGJWDUXIU=;
  b=yaMUbgJfEOhU/cS4yp16kQyfNSVwKIKURiaKaciS7qSNbaN47A6AjCuF
   yVF3dMWpgnqcU+hgupDyM/8Q11c1uGx0wpwHgRnIhSkQUhAvTsEC+oZHF
   k7IGJ1TvucM3XqZVThHmneF0SBRZ0YZ/31rZrf/WyZo+x9PoTDyD2R2Wu
   M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Apr 2022 13:17:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 13:17:30 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Apr 2022 13:17:30 -0700
Received: from [10.110.60.126] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 1 Apr 2022
 13:17:29 -0700
Message-ID: <edc4a19e-c792-1e58-e73f-f26e423f11b9@quicinc.com>
Date:   Fri, 1 Apr 2022 13:17:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v12 4/4] drm/msm/dp: enable widebus feature for display
 port
Content-Language: en-US
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dmitry.baryshkov@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1645824192-29670-1-git-send-email-quic_khsieh@quicinc.com>
 <1645824192-29670-5-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n53s11KHrj-rzRkjV4q775XCoxzZCLK-HRCt=H1++DR-YQ@mail.gmail.com>
 <ccd8e82d-6121-3d2a-6a63-4fc7c0896881@quicinc.com>
In-Reply-To: <ccd8e82d-6121-3d2a-6a63-4fc7c0896881@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2022 1:00 PM, Kuogee Hsieh wrote:
> Hi Stephen,
>
>
> Would you please to help land this serial of 4 patch into msm-next?
My mistake, should be kernel v5.15
>
> Thanks,
>
> On 2/25/2022 2:17 PM, Stephen Boyd wrote:
>> Quoting Kuogee Hsieh (2022-02-25 13:23:12)
>>> Widebus feature will transmit two pixel data per pixel clock to 
>>> interface.
>>> This feature now is required to be enabled to easy migrant to higher
>>> resolution applications in future. However since some legacy chipsets
>>> does not support this feature, this feature is enabled by setting
>>> wide_bus_en flag to true within msm_dp_desc struct.
>>>
>>> changes in v2:
>>> -- remove compression related code from timing
>>> -- remove op_info from  struct msm_drm_private
>>> -- remove unnecessary wide_bus_en variables
>>> -- pass wide_bus_en into timing configuration by struct msm_dp
>>>
>>> Changes in v3:
>>> -- split patch into 3 patches
>>> -- enable widebus feature base on chip hardware revision
>>>
>>> Changes in v5:
>>> -- DP_INTF_CONFIG_DATABUS_WIDEN
>>>
>>> Changes in v6:
>>> -- static inline bool msm_dp_wide_bus_enable() in msm_drv.h
>>>
>>> Changes in v7:
>>> -- add Tested-by
>>>
>>> Changes in v9:
>>> -- add wide_bus_en to msm_dp_desc
>>>
>>> Changes in v10:
>>> -- add wide_bus_en boolean to dp_catalog struc to avoid passing it 
>>> as parameter
>>>
>>> Changes in v11:
>>> -- add const to dp_catalog_hw_revision()
>>> -- add const to msm_dp_wide_bus_available()
>>>
>>> Changes in v12:
>>> -- dp_catalog_hw_revision(const struct dp_catalog *dp_catalog)
>>> -- msm_dp_wide_bus_available(const struct msm_dp *dp_display)
>>>
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> ---
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
