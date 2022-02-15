Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6964B73A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbiBOOvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:51:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbiBOOvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:51:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 367E1119433
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644936551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQuhuF7IKOqYCKxv1Xz0llTmBI5LAygxnXZl/GDmFGk=;
        b=IhfFGrrz01EQcj/B0bm6rusNoI+jK/sbGM+My3OBtRMZQwTDPfzZuI60YGQGchB3MBVUsh
        /Oa9BhF/WFRFuJv+3P0mivmG9ziiZkAVdpYAXGKOFNfpu3cfC9+yHzc0fHOPY2MCLzDrGv
        0nD4JQyuUsT2OUtO/BoGaFb75prAlVg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-p8cr_AJpNpCnBs4AzT7KDA-1; Tue, 15 Feb 2022 09:49:10 -0500
X-MC-Unique: p8cr_AJpNpCnBs4AzT7KDA-1
Received: by mail-ot1-f69.google.com with SMTP id h3-20020a9d6003000000b005acef9b2c7dso457799otj.17
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AQuhuF7IKOqYCKxv1Xz0llTmBI5LAygxnXZl/GDmFGk=;
        b=bdVf2mGZSL/FQhnVcZTJGdnCPUT8t/XWGqbALMwQMP18l4qvdwyb165+LXum82LPRA
         Mv6LgrT2jwzWXAn4wyM56dZX+DMy6ZJMPbGWnK877Cvo3PxPzI5tUrGxB82fh1zedkpg
         y7BbF3ATYLGXcZ35IeGz5OeGAXGJZzqowXPnYDvw+iWSPD7JC8TMYv3BQuv7iWRK4WXV
         zILeXYRIj8iPrzc/s/dFJN+GBkBOMQ5nSnWfIZzf7dhozuVx8ufG3VPqQD+QxOnlalsI
         s1fFP9TSL1Qg13T/jFA7CAtaXckzhR7Q+F4ffbTLcwRJS6iJ6i3BMIIHI5gez6fiWryN
         e5gA==
X-Gm-Message-State: AOAM532I0hXzKnPWL62UoO/9l2MgveT4ay+qjh8cK7hETXB2sWHTiYPB
        R6QM2lwoLMJ7ai+dH3fqCxP8I9tkmq6l7F+y9qrie3pVmbIAJZP+Ck4n2NMwUMQOHv0Y3nn1bbJ
        VU1EgECmC3WTvVE6OkHe+wF9Q
X-Received: by 2002:a9d:6a54:: with SMTP id h20mr1420696otn.69.1644936549412;
        Tue, 15 Feb 2022 06:49:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzai+xgP98JN0UjOQG8GF48r2lPVtIxEbdcn6aEWbM7Nij7yxY9X08kqNJaRqS2nI8+t+MGgw==
X-Received: by 2002:a9d:6a54:: with SMTP id h20mr1420684otn.69.1644936549204;
        Tue, 15 Feb 2022 06:49:09 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id v10sm13728219oto.53.2022.02.15.06.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 06:49:07 -0800 (PST)
Subject: Re: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
 info
To:     Tianfei zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-3-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0de9c8fb-0f04-684f-630c-1d13b0b55ba1@redhat.com>
Date:   Tue, 15 Feb 2022 06:49:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220214112619.219761-3-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/14/22 3:26 AM, Tianfei zhang wrote:
> From: Tianfei Zhang <tianfei.zhang@intel.com>
>
> The feature ID of "Port User Interrupt" and the
> "PMCI Subsystem" are identical, 0x12, but one is for FME,
> other is for Port. It should check the feature type While
> parsing the irq info in parse_feature_irqs().

This seems like a bug fix and not part of iofs feature.

Split this out of the patchset.

This is a workaround a hardware problem, there should be some comments 
to the effect that you can't trust _this_ or _that_ feature id and some 
special handling earlier.

The ambiguity of feature id is a problem, and this sort of bug will 
happen again.

What can be done to prevent this in the future ?

>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>   drivers/fpga/dfl.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 599bb21d86af..26f8cf890700 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -940,9 +940,14 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>   {
>   	void __iomem *base = binfo->ioaddr + ofst;
>   	unsigned int i, ibase, inr = 0;
> +	enum dfl_id_type type;
>   	int virq;
>   	u64 v;
>   
> +	type = feature_dev_id_type(binfo->feature_dev);
> +	if (type >= DFL_ID_MAX)
> +		return -EINVAL;
> +
>   	/*
>   	 * Ideally DFL framework should only read info from DFL header, but
>   	 * current version DFL only provides mmio resources information for
> @@ -959,16 +964,22 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>   	 */
>   	switch (fid) {
>   	case PORT_FEATURE_ID_UINT:
> +		if (type != PORT_ID)
> +			break;

Instead of embedding a break in the switch, break the switch into fme 
switch and port switch

if (type == PORT_ID)

   port-switch

else if (type == FME_ID

   fme-switch

Tom

>   		v = readq(base + PORT_UINT_CAP);
>   		ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
>   		inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
>   		break;
>   	case PORT_FEATURE_ID_ERROR:
> +		if (type != PORT_ID)
> +			break;
>   		v = readq(base + PORT_ERROR_CAP);
>   		ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
>   		inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
>   		break;
>   	case FME_FEATURE_ID_GLOBAL_ERR:
> +		if (type != FME_ID)
> +			break;
>   		v = readq(base + FME_ERROR_CAP);
>   		ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
>   		inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);

