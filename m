Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A63054B613
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344373AbiFNQ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344012AbiFNQ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:28:28 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6CC2DD7C;
        Tue, 14 Jun 2022 09:28:27 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d13so8144427plh.13;
        Tue, 14 Jun 2022 09:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KxyuTywMpO/66pvcVmFIHSuich2DF5impDBsu9BDdd8=;
        b=61ZNMv/rTLVnHsqHWowA+mTZG+cdmsbg/QDxR4TLlWeWJyn7tVGVqZihmxh3zZpE6T
         l4rMSsgkdlOhoD9agPiQ0PhKF5ZHYQ2a4NQvOYjAr+lcAH0f7F4L191FRsVaMMKh2+r/
         8fYgCR9cBqzraA2R9JhvcF03NfNNkGoKag0m+pz8+klA+qEW0xZUJ1CNMq4qtxm16Sy3
         dEMjMBNR6o53CccKUzUqi3FzLGH9lwnfE61w0aEut/pphp8StnXHVedrhDjY2UB3x5uV
         p3Okz9Fn4/5M5ATxuXULem7WWni7eBv3VbHS4nJ39CMyvd+C15bhBa/b4Sn6PR6jjU9R
         9eCg==
X-Gm-Message-State: AJIora/CKT34GGcDS35gsS6q4tjFpl8ZdwH2WKAFr2JBCb3vTnQOBtDc
        x872Sd3S7Xlp67qAdY0rXAk=
X-Google-Smtp-Source: AGRyM1vZ/RlHyRQlMZNO4wF7HIR29wi2QDifMTtA0HlUhfEQhfxU82vH528GxkNdc59d9YZ60aPLZA==
X-Received: by 2002:a17:903:40ce:b0:164:248:1464 with SMTP id t14-20020a17090340ce00b0016402481464mr5131883pld.16.1655224106461;
        Tue, 14 Jun 2022 09:28:26 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id r33-20020a17090a43a400b001e305f5cd22sm7521541pjg.47.2022.06.14.09.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:28:25 -0700 (PDT)
Message-ID: <fe6ba3bd-81f4-215d-5f1b-0fa05e68a0c5@acm.org>
Date:   Tue, 14 Jun 2022 09:28:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 07/10] scsi: ufs-mediatek: Support flexible parameters
 for smc calls
Content-Language: en-US
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc:     peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
References: <20220614141655.14409-1-stanley.chu@mediatek.com>
 <20220614141655.14409-8-stanley.chu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220614141655.14409-8-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 07:16, Stanley Chu wrote:
> From: Alice Chao <alice.chao@mediatek.com>
> 
> Provide flexible number of parameters for UFS SMC calls to be
> easily used for future SMC usages.

How far in the future? Please only introduce what is needed for this 
patch series.

> +/*
> + * SMC call wapper function
                ^^^^^^
typo

> + */
> +#define _ufs_mtk_smc(cmd, res, v1, v2, v3, v4, v5, v6) \
> +		arm_smccc_smc(MTK_SIP_UFS_CONTROL, \
> +				  cmd, v1, v2, v3, v4, v5, v6, &(res))
> +
> +#define _ufs_mtk_smc_0(cmd, res) \
> +	_ufs_mtk_smc(cmd, res, 0, 0, 0, 0, 0, 0)
> +
> +#define _ufs_mtk_smc_1(cmd, res, v1) \
> +	_ufs_mtk_smc(cmd, res, v1, 0, 0, 0, 0, 0)
> +
> +#define _ufs_mtk_smc_2(cmd, res, v1, v2) \
> +	_ufs_mtk_smc(cmd, res, v1, v2, 0, 0, 0, 0)
> +
> +#define _ufs_mtk_smc_3(cmd, res, v1, v2, v3) \
> +	_ufs_mtk_smc(cmd, res, v1, v2, v3, 0, 0, 0)
> +
> +#define _ufs_mtk_smc_4(cmd, res, v1, v2, v3, v4) \
> +	_ufs_mtk_smc(cmd, res, v1, v2, v3, v4, 0, 0)
> +
> +#define _ufs_mtk_smc_5(cmd, res, v1, v2, v3, v4, v5) \
> +	_ufs_mtk_smc(cmd, res, v1, v2, v3, v4, v5, 0)
> +
> +#define _ufs_mtk_smc_6(cmd, res, v1, v2, v3, v4, v5, v6) \
> +	_ufs_mtk_smc(cmd, res, v1, v2, v3, v4, v5, v6)
> +
> +#define _ufs_mtk_smc_selector(cmd, res, v1, v2, v3, v4, v5, v6, FUNC, ...) FUNC
> +
> +#define ufs_mtk_smc(...) \
> +	_ufs_mtk_smc_selector(__VA_ARGS__, \
> +	_ufs_mtk_smc_6(__VA_ARGS__), \
> +	_ufs_mtk_smc_5(__VA_ARGS__), \
> +	_ufs_mtk_smc_4(__VA_ARGS__), \
> +	_ufs_mtk_smc_3(__VA_ARGS__), \
> +	_ufs_mtk_smc_2(__VA_ARGS__), \
> +	_ufs_mtk_smc_1(__VA_ARGS__), \
> +	_ufs_mtk_smc_0(__VA_ARGS__) \
> +	)

If _ufs_mtk_smc() would be modified to accept an struct _ufs_mtk_args as 
its only argument, would that allow to simplify the above into the 
following?

#define ufs_mtk_smc(...) \
   _ufs_mtk_smc((struct _ufs_mtk_args){__VA_ARGS__})

> +/*
> + * Sip kernel interface
> + */

What is "Sip"? Should it perhaps be spelled as "SIP"?

Thanks,

Bart.
