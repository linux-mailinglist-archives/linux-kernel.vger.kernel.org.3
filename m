Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4EE59932E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245649AbiHSCsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245256AbiHSCs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:48:28 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2693ED59;
        Thu, 18 Aug 2022 19:48:26 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id bf22so3392399pjb.4;
        Thu, 18 Aug 2022 19:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TFsMtRqG/TbJmGF6CHrOUDDBRGq4lB+/ETI2WErXxoU=;
        b=nsxiwrPprxWmD2vOhGId7ykePw+j9uKhV5MNnF0OITx6NzCWxbsD4n072iyY0xMWXw
         Zpr6um7jInwlRHV7rHxkBkl++cZ8PnHtQu8Fe6mD/RvYGeDi2nW27XxokM895q1I/Df9
         7UGKGZ5pwJFMGjrBR35xn6XGncH8JgAgoyE/kWRfvmJs7JupTgMrND5bFBDQzwpIolDd
         QnLgFvFewfd6ZIpzKFJSvELT3e5JGAIGiIg6bGMImM4nAolSe8BxolTpG5EzOdMEj9zC
         Ji7EqLiTZsyVYUW0sycFGFbjL7AW0XhlSE/AkEJyUJKoohTUw/wggIKkielCVM98jOrZ
         TcnA==
X-Gm-Message-State: ACgBeo3qxR7FlnfTEVuSHltVV5yaucRHeQh41dgzXyVyv5NjSsL4rhJ2
        2jKfyM5FnuyePV695b2oyCw=
X-Google-Smtp-Source: AA6agR6nH+aI02CAs3v/v+DadbqfjnWgx1c9ghlbQDADl+OmcdjYwaLnAtOVZGr44+ZGDmy73jOJVg==
X-Received: by 2002:a17:902:da8a:b0:16f:1aab:2226 with SMTP id j10-20020a170902da8a00b0016f1aab2226mr5323993plx.28.1660877305758;
        Thu, 18 Aug 2022 19:48:25 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id ik23-20020a170902ab1700b00172a33c84a8sm2038593plb.251.2022.08.18.19.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 19:48:24 -0700 (PDT)
Message-ID: <4ad8c00e-f752-dfb2-331e-8cdff02eaa05@acm.org>
Date:   Thu, 18 Aug 2022 19:48:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH v2 2/2] scsi: ufs-qcom: Add MCQ support
Content-Language: en-US
To:     Can Guo <quic_cang@quicinc.com>, quic_asutoshd@quicinc.com,
        quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, mani@kernel.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1660213984-37793-1-git-send-email-quic_cang@quicinc.com>
 <1660213984-37793-3-git-send-email-quic_cang@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1660213984-37793-3-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 03:33, Can Guo wrote:
> +static int ufs_qcom_get_outstanding_cqs(struct ufs_hba *hba,
> +					unsigned long *ocqs)
> +{
> +	return -EINVAL;
> +}

Why does the get_outstanding_cqs vop exist since the only implementation 
of that vop returns EINVAL?

> +static int ufs_qcom_config_mcq_rop(struct ufs_hba *hba)
> +{
> +	struct ufshcd_mcq_rop_info_t *rop;
> +	struct ufshcd_res_info_t *mem_res, *sqdao_res;
> +	int i;
> +
> +	mem_res = &hba->res[RES_MEM];
> +	sqdao_res = &hba->res[RES_MCQ_SQD];
> +
> +	if (!mem_res->base || !sqdao_res->base)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ROP_MAX; i++) {
> +		rop = &hba->mcq_rop[i];
> +		rop->offset = sqdao_res->resource->start -
> +			      mem_res->resource->start + 0x40 * i;
> +		rop->stride = 0x100;
> +		rop->base = sqdao_res->base + 0x40 * i;
> +	}
> +
> +	return 0;
> +}

Is there anything in the above function that is specific to the Qualcomm 
controller? If not, please move the above code into ufshcd.c.

> +static int ufs_qcom_get_hba_mac(struct ufs_hba *hba)
> +{
> +	return MAX_SUPP_MAC;
> +}

Since there is a register in the UFSHCI 4.0 specification from which the 
maximum number of outstanding commands can be retrieved, why does the 
get_hba_mac vop exist?

Thanks,

Bart.
