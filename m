Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104D757B29C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbiGTINn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240349AbiGTINb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:13:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C6D6E8BA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:12:26 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 17so5524436pfy.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U7IBtEsWEANNBn2uVDz/KgXAATJ+X6e2srPCnq8910M=;
        b=GWU2+SXjA8jIcaelEQcEAI3kCwuQSxb3Bt9GwiX1G/TAtoBjFhIx9gIfYdDAJJohMx
         yKQEaqSCH8Sfix99LDDP6Dp/cLKlgKzZETMilycZf4X23ttr+pWai9uHAMYC8olm8Crr
         zNYcfR9Ta6UK5Kz95c2g7GCAdllNp5RRCTyT1eW1mMScZsAWpj/E8tbMeOhiDG9V1/5v
         2UyWYHlxgOMGU1iGuAQv1d/4JLwtV41rEnt8JWmjrCSr2vKOTrNeXUAU0eAmArByapHX
         eUqDi/LCAKRMDNIz/aHbliKaj8dibsHVs8kGSgsOH/jSyyrIEjwD5pqyoT/0yMj0b7gk
         N5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U7IBtEsWEANNBn2uVDz/KgXAATJ+X6e2srPCnq8910M=;
        b=yCEPZNFADBH9axk7sxKRWJchQwxjAY2X9P+eIlvscW2VexR9cRVRPEXEfu0exixCyV
         jUVVRxDHPUf3NcIpJHw3YmV7vVLyg2R2PaWJ9dHK5ZGMS2Mo8WH36nkn/EoC6TqTz795
         ITAkFBflykVWmmfHRRU6thZNqPx+7q9tV97y/WMdfWvgd43KUPShG0YjfBlB88KlK5bn
         uvtAZKd62OO9o9nTCtIcfm5bSdDU+iW4JOWPGyDAT7ckiX0QAgv0YqfW8GTzemyYg+Md
         iLfSLiTIvqSOaYmpJscdGm9TztooRcwKmPpVkj9CJK41HAs/VNf/8IdnE/XjKZCk7JBm
         u6XA==
X-Gm-Message-State: AJIora+KZ12hiWHyVWuI0TKo8C5VUqipkVRRFSQ8qJbiB4OAANWIm0j7
        Qw99w0QDUemlaslsi5sgllgtnQ==
X-Google-Smtp-Source: AGRyM1thDBY42HWj78s+WNa+OGNoXxQajpgRcWha8Mo87hwgmKpx0L81LChYX/PwmYJQ+aX1PZwm+w==
X-Received: by 2002:a62:140e:0:b0:52b:780d:fb9d with SMTP id 14-20020a62140e000000b0052b780dfb9dmr12604772pfu.65.1658304745247;
        Wed, 20 Jul 2022 01:12:25 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:709e:6fec:df37:6562:5a80? ([2401:4900:1f3b:709e:6fec:df37:6562:5a80])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090341cd00b00163e06e1a99sm13313172ple.120.2022.07.20.01.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 01:12:24 -0700 (PDT)
Message-ID: <2cc90e5a-172f-3c94-0e57-79c725d45819@linaro.org>
Date:   Wed, 20 Jul 2022 13:42:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] firmware: qcom_scm: Add support for tsens reinit
 workaround
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org
References: <20220701145815.2037993-1-bhupesh.sharma@linaro.org>
 <20220701145815.2037993-2-bhupesh.sharma@linaro.org>
 <YtYdxlbLvgimN2MQ@builder.lan>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <YtYdxlbLvgimN2MQ@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for your review.

On 7/19/22 8:28 AM, Bjorn Andersson wrote:
> On Fri 01 Jul 09:58 CDT 2022, Bhupesh Sharma wrote:
> 
> Please update $subject to match the most uses prefix for the qcom_scm
> driver.
> 
>> Some versions of QCoM tsens controller might enter a
> 
> s/QCoM/Qualcomm/ please.

Ok.

>> 'bad state' while running stability tests causing sensor
>> temperatures/interrupts status to be in an 'invalid' state.
>>
>> It is recommended to re-initialize the tsens controller
>> via trustzone (secure registers) using scm call(s) when that
>> happens.
>>
>> Add support for the same in the qcom_scm driver.
>>
>> Cc: Amit Kucheria <amitk@kernel.org>
>> Cc: Thara Gopinath <thara.gopinath@gmail.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-arm-msm@vger.kernel.org
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>   drivers/firmware/qcom_scm.c | 17 +++++++++++++++++
>>   drivers/firmware/qcom_scm.h |  4 ++++
>>   include/linux/qcom_scm.h    |  2 ++
>>   3 files changed, 23 insertions(+)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index 3163660fa8e2..0bc7cc466218 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -796,6 +796,23 @@ int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
>>   }
>>   EXPORT_SYMBOL(qcom_scm_mem_protect_video_var);
>>   
>> +int qcom_scm_tsens_reinit(int *tsens_ret)
>> +{
>> +	unsigned int ret;
> 
> qcom_scm_call() returns negative numbers on error, so this should be
> signed.

Ok.

>> +	struct qcom_scm_desc desc = {
> 
> const?

Sure.

>> +		.svc = QCOM_SCM_SVC_TSENS,
>> +		.cmd = QCOM_SCM_TSENS_INIT_ID,
>> +	};
>> +	struct qcom_scm_res res;
>> +
>> +	ret = qcom_scm_call(__scm->dev, &desc, &res);
>> +	if (tsens_ret)
>> +		*tsens_ret = res.result[0];
> 
> Most similar qcom_scm functions use negative return value for errors and
> positive (including 0) values for the returned data.
> 
> Looking at patch 3, the only thing you seem to care about is tsens_ret
> being 0 or not, so I do think you would be fine returning both using the
> return value.

Ok, let me double check the same and fix the same in v2.

Regards,
Bhupesh


>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(qcom_scm_tsens_reinit);
>> +
>>   static int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
>>   				 size_t mem_sz, phys_addr_t src, size_t src_sz,
>>   				 phys_addr_t dest, size_t dest_sz)
>> diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
>> index 0d51eef2472f..495fa00230c7 100644
>> --- a/drivers/firmware/qcom_scm.h
>> +++ b/drivers/firmware/qcom_scm.h
>> @@ -94,6 +94,10 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
>>   #define QCOM_SCM_PIL_PAS_IS_SUPPORTED	0x07
>>   #define QCOM_SCM_PIL_PAS_MSS_RESET	0x0a
>>   
>> +/* TSENS Services and Function IDs */
>> +#define QCOM_SCM_SVC_TSENS		0x1E
>> +#define QCOM_SCM_TSENS_INIT_ID		0x5
>> +
>>   #define QCOM_SCM_SVC_IO			0x05
>>   #define QCOM_SCM_IO_READ		0x01
>>   #define QCOM_SCM_IO_WRITE		0x02
>> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
>> index f8335644a01a..f8c9eb739df1 100644
>> --- a/include/linux/qcom_scm.h
>> +++ b/include/linux/qcom_scm.h
>> @@ -124,4 +124,6 @@ extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>>   extern int qcom_scm_lmh_profile_change(u32 profile_id);
>>   extern bool qcom_scm_lmh_dcvsh_available(void);
>>   
>> +extern int qcom_scm_tsens_reinit(int *tsens_ret);
>> +
>>   #endif
>> -- 
>> 2.35.3
>>
