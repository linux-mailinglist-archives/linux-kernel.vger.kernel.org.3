Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53A651D795
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391810AbiEFMaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391778AbiEFM34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:29:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A985E5D679;
        Fri,  6 May 2022 05:26:12 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KvqXq3chjzhYv2;
        Fri,  6 May 2022 20:25:47 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 20:26:10 +0800
Subject: Re: [PATCH -next] drm/msm: Add missing OF dependency for DRM_MSM
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <robdclark@gmail.com>, <sean@poorly.run>,
        <quic_abhinavk@quicinc.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20220506020300.20704-1-yuehaibing@huawei.com>
 <dbe452b1-7f6a-141c-5fe3-bd889c62abc7@linaro.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <f0ac2d9a-1005-b7e9-f263-5f02a37f8e55@huawei.com>
Date:   Fri, 6 May 2022 20:26:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <dbe452b1-7f6a-141c-5fe3-bd889c62abc7@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/6 19:36, Dmitry Baryshkov wrote:
> On 06/05/2022 05:03, YueHaibing wrote:
>> WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS
>>    Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && OF [=n]
>>    Selected by [y]:
>>    - DRM_MSM [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_QCOM || SOC_IMX5 || COMPILE_TEST [=y]) && COMMON_CLK [=y] && IOMMU_SUPPORT [=y] && (QCOM_OCMEM [=n] || QCOM_OCMEM [=n]=n) && (QCOM_LLCC [=y] || QCOM_LLCC [=y]=n) && (QCOM_COMMAND_DB [=n] || QCOM_COMMAND_DB [=n]=n)
>>
>> DRM_DP_AUX_BUS depends on OF, so DRM_MSM also should depends on it.
> 
> I think the proper fix would be to make DRM_DP_AUX_BUS depend on OF || COMPILE_TEST rather than just OF

Make sense, will do this in v2.
> 
>>
>> Fixes: f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus support")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   drivers/gpu/drm/msm/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
>> index 4e0cbd682725..1d710a20ffdd 100644
>> --- a/drivers/gpu/drm/msm/Kconfig
>> +++ b/drivers/gpu/drm/msm/Kconfig
>> @@ -3,6 +3,7 @@
>>   config DRM_MSM
>>       tristate "MSM DRM"
>>       depends on DRM
>> +    depends on OF
>>       depends on ARCH_QCOM || SOC_IMX5 || COMPILE_TEST
>>       depends on COMMON_CLK
>>       depends on IOMMU_SUPPORT
> 
> 
