Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6784D553648
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbiFUPiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353071AbiFUPiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13DBFB7C6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655825924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FnbHuNXX+33sc1khx411pyZstIbascagbQJiHj3LaFU=;
        b=Q361U+kBqmfO25Eu+hmWja8O9nhGLbwb40T2N+D8TFDemY0Ks+QSPt6KsxjOHWW2KZLAps
        SwuarveSWT1nHYWbM1Sev2hOyP8broycHGnkg7k2r3Kna3BAVRwbss+M5/JP4zOleDIt4H
        4XrBPeC17lgxlK2+/DmQ7N6rxEyr8B0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-sLuP8idpMZi0QL3JCARdvQ-1; Tue, 21 Jun 2022 11:38:42 -0400
X-MC-Unique: sLuP8idpMZi0QL3JCARdvQ-1
Received: by mail-qv1-f69.google.com with SMTP id b18-20020a0ccd12000000b004703d1b04e8so7433709qvm.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FnbHuNXX+33sc1khx411pyZstIbascagbQJiHj3LaFU=;
        b=UgWpliJgREDZ5dfUqmu9+eVeu7paYiss5E0RPPiHbWkGb3zm3mDnywVmXwrJRG18RZ
         E4xfWVfgyJ06FMpjuorim6H5lHWepB/CjLSAcCBvUif3M+1bBQ1RsygCl/93n2K8HuEW
         jQsSiSEAjW1ss/Lvc7J/fOR5HITh5tsYoU4K9KN87TOzN+mjbAFGou1z0rSKiuTt46I5
         DePsYH/IKLMMXyfh/ai1CPQoo50o0oN8/qjPlKUBeUDEzldqiPF9ZU24K96NPJPpuQoh
         LZiGIDQfRZavol/2L4DkSS5hmCTGXg98jBzj+7n+EkAJuJfcihNJWdidTwnQ8HBl4tjD
         KXBQ==
X-Gm-Message-State: AJIora/Y03lcH0APDmxa8g1rj+yiH+p+ye+W2ZXK4+BBvD9OKITKIMNp
        SHETTzoc8nVxX0LjgPQjUhTMWIxvKMI30P0Zey+LWX9AheeB5nxFBz0KWMe1yH9tttBclDD2WYU
        AqurbFw6YHe+7nMTIi0tkwe1V
X-Received: by 2002:a05:622a:5ca:b0:306:6c7c:efe7 with SMTP id d10-20020a05622a05ca00b003066c7cefe7mr24478225qtb.310.1655825922391;
        Tue, 21 Jun 2022 08:38:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1snfFXk68dQT4mRBgAFD3F/WUiGoBjFE3pNpAayeNMZAj/1qtmjBnO8Rp9miRu6x2a7GQi+Yw==
X-Received: by 2002:a05:622a:5ca:b0:306:6c7c:efe7 with SMTP id d10-20020a05622a05ca00b003066c7cefe7mr24478201qtb.310.1655825922126;
        Tue, 21 Jun 2022 08:38:42 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bl17-20020a05620a1a9100b006a6c9e17088sm13650258qkb.65.2022.06.21.08.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 08:38:41 -0700 (PDT)
Subject: Re: [PATCH v1] memory: dfl-emif: Update the dfl emif driver support
 revision 1
To:     Tianfei Zhang <tianfei.zhang@intel.com>, ssantosh@kernel.org,
        krzysztof.kozlowski@linaro.org
Cc:     yilun.xu@intel.com, russell.h.weight@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com,
        Debarati Biswas <debaratix.biswas@intel.com>
References: <20220621123854.8686-1-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <39675efc-5c35-74e6-c824-d7f09d80fa61@redhat.com>
Date:   Tue, 21 Jun 2022 08:38:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220621123854.8686-1-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not seem like version 0 is being handled in all places, please 
review for backward compatibility.

On 6/21/22 5:38 AM, Tianfei Zhang wrote:
> From: Debarati Biswas <debaratix.biswas@intel.com>
>
> The next generation (revision 1) of the DFL EMIF feature device requires
> support for more than 4 memory banks. It does not support the selective

more than 4 or 8 ? below seems like 8.

ver > 0 is not the same as ver == 1, I prefer the later

> clearing of memory banks. A capability register replaces the previous
> control register, and contains a bitmask to indicate the presence of each
> memory bank. This bitmask aligns with the previous control register
> bitmask that served the same purpose. The control and capability
> registers are treated like a C Union structure in order to support both
> the new and old revisions of the EMIF device.
>
> Signed-off-by: Debarati Biswas <debaratix.biswas@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>   drivers/memory/dfl-emif.c | 62 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 57 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/memory/dfl-emif.c b/drivers/memory/dfl-emif.c
> index 3f719816771d..da06cd30a016 100644
> --- a/drivers/memory/dfl-emif.c
> +++ b/drivers/memory/dfl-emif.c
> @@ -24,11 +24,24 @@
>   #define EMIF_STAT_CLEAR_BUSY_SFT	16
>   #define EMIF_CTRL			0x10
>   #define EMIF_CTRL_CLEAR_EN_SFT		0
> -#define EMIF_CTRL_CLEAR_EN_MSK		GENMASK_ULL(3, 0)
> +#define EMIF_CTRL_CLEAR_EN_MSK		GENMASK_ULL(7, 0)

This would seem to be version specific and not a static value.

ver 0 is (3,0) , ver > 0 (7,0)

like what is done below.

This #define is used in emif_clear_attr() but there is not version check 
in this macro.

>   
>   #define EMIF_POLL_INVL			10000 /* us */
>   #define EMIF_POLL_TIMEOUT		5000000 /* us */
>   
> +/*
> + * The Capability Register replaces the Control Register (at the same
> + * offset) for EMIF feature revisions > 0. The bitmask that indicates
> + * the presence of memory channels exists in both the Capability Register
> + * and Control Register definitions. These can be thought of as a C union.
> + * The Capability Register definitions are used to check for the existence
> + * of a memory channel, and the Control Register definitions are used for
> + * managing the memory-clear functionality in revision 0.
> + */
> +#define EMIF_CAPABILITY_BASE		0x10
> +#define EMIF_CAPABILITY_CHN_MSK_V0	GENMASK_ULL(3, 0)
> +#define EMIF_CAPABILITY_CHN_MSK		GENMASK_ULL(7, 0)
> +
>   struct dfl_emif {
>   	struct device *dev;
>   	void __iomem *base;
> @@ -106,16 +119,30 @@ emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 0);
>   emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 1);
>   emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 2);
>   emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 3);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 4);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 5);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 6);
> +emif_state_attr(init_done, EMIF_STAT_INIT_DONE_SFT, 7);
>   
>   emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 0);
>   emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 1);
>   emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 2);
>   emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 3);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 4);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 5);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 6);
> +emif_state_attr(cal_fail, EMIF_STAT_CALC_FAIL_SFT, 7);
> +
>   
>   emif_clear_attr(0);
>   emif_clear_attr(1);
>   emif_clear_attr(2);
>   emif_clear_attr(3);
> +emif_clear_attr(4);
> +emif_clear_attr(5);
> +emif_clear_attr(6);
> +emif_clear_attr(7);
> +
>   
>   static struct attribute *dfl_emif_attrs[] = {
>   	&emif_attr_inf0_init_done.attr.attr,
> @@ -134,6 +161,22 @@ static struct attribute *dfl_emif_attrs[] = {
>   	&emif_attr_inf3_cal_fail.attr.attr,
>   	&emif_attr_inf3_clear.attr.attr,
>   
> +	&emif_attr_inf4_init_done.attr.attr,
> +	&emif_attr_inf4_cal_fail.attr.attr,
> +	&emif_attr_inf4_clear.attr.attr,
> +
> +	&emif_attr_inf5_init_done.attr.attr,
> +	&emif_attr_inf5_cal_fail.attr.attr,
> +	&emif_attr_inf5_clear.attr.attr,
> +
> +	&emif_attr_inf6_init_done.attr.attr,
> +	&emif_attr_inf6_cal_fail.attr.attr,
> +	&emif_attr_inf6_clear.attr.attr,
> +
> +	&emif_attr_inf7_init_done.attr.attr,
> +	&emif_attr_inf7_cal_fail.attr.attr,
> +	&emif_attr_inf7_clear.attr.attr,
> +
>   	NULL,
>   };
>   
> @@ -143,15 +186,24 @@ static umode_t dfl_emif_visible(struct kobject *kobj,
>   	struct dfl_emif *de = dev_get_drvdata(kobj_to_dev(kobj));
>   	struct emif_attr *eattr = container_of(attr, struct emif_attr,
>   					       attr.attr);
> +	struct dfl_device *ddev = to_dfl_dev(de->dev);
>   	u64 val;
>   
>   	/*
> -	 * This device supports upto 4 memory interfaces, but not all
> +	 * This device supports up to 8 memory interfaces, but not all
>   	 * interfaces are used on different platforms. The read out value of
> -	 * CLEAN_EN field (which is a bitmap) could tell how many interfaces
> -	 * are available.
> +	 * CAPABILITY_CHN_MSK field (which is a bitmap) indicates which
> +	 * interfaces are available.
>   	 */
> -	val = FIELD_GET(EMIF_CTRL_CLEAR_EN_MSK, readq(de->base + EMIF_CTRL));
> +	if (ddev->revision > 0 && strstr(attr->name, "_clear"))

This check does not match to comment, why is this needed ?

Tom

> +		return 0;
> +
> +	if (ddev->revision == 0)
> +		val = FIELD_GET(EMIF_CAPABILITY_CHN_MSK_V0,
> +				readq(de->base + EMIF_CAPABILITY_BASE));
> +	else
> +		val = FIELD_GET(EMIF_CAPABILITY_CHN_MSK,
> +				readq(de->base + EMIF_CAPABILITY_BASE));
>   
>   	return (val & BIT_ULL(eattr->index)) ? attr->mode : 0;
>   }

