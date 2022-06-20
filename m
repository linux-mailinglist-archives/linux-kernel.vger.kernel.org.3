Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504AB55143B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbiFTJZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbiFTJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:25:04 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0B912604
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:25:03 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b7so11209818ljr.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xbydWtTEQ7/9ZWZC+wL+2zf+Ge3aJVYC062WRrIfkg0=;
        b=Mbk+soIB+gNfMR++dR/N+4RrxMk+FZPgSYoBYMP9pou/tI+pWFRwGuTSczx+EozJMM
         AlWDarxHpI0bFfguGDaFHOWJiZFfzgbrnBrrdSo7xFyxD0vBX4AWFDUpmaZuIP7xLTIx
         mTI4GfPzBs2Ct0G8Wqm8uCPENtr0UfB/0GqpO16cn3oHYgMLN3IuwLS+BDjCtni3PTKC
         ECH48h6wOHRc4UpHhzjWKaj2BbBCsCjb0AL6Kw8+muEnVUSkdl4XyWcWEw9YuiqQIYY9
         H7euaxE/MOH7LimSFjVo5SszxacqZL9xIWMPDHMYuBM72bqcNWOKz1LjskbBgg1ZtC74
         6HnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xbydWtTEQ7/9ZWZC+wL+2zf+Ge3aJVYC062WRrIfkg0=;
        b=Ipl71b27B+jDSierHiqyeyhDi8GQhTDamBMsqYGOUM9r3bgHj/oPCHpupjFbw3S2qZ
         VQQ0j3Yx9202s4eRNH5RiOCcpKDvM0DErB0QRxM2PaisL14pp3JVwODMl2Q3TRpbCNtx
         rwkFuV9+/SavpwhPy0iUYXzsI5SvzB4aL+m+D/vsRXszp7UqkHtD/xgEy5FlbhjajnVx
         Sv4jGQWsXy1XmzFClBqT3TQritzAbOO8IqbupaZc1JeGRWbHhrHU1z3kuI5WNIN+3Bpx
         a13fyYso4rGNm1gN9krW0gmJV9Zysa3ioz+ppd/eE84mhjYpFrXQsGl1iS788Ns3eReG
         P3TQ==
X-Gm-Message-State: AJIora/todks6zbfxEacgJv72rtULzwcUkdbCKetaUZbuqHhanqYrBvh
        ETzRlhNgQNvKeUc/kW3HUrfkmvC05rWotw==
X-Google-Smtp-Source: AGRyM1suLPIRh/79vPEuUEkBApingnuv7ol/BqpefRAXAjYrZcQv+mHti1q2oHM3BNipn1o0Sc2JUw==
X-Received: by 2002:a2e:964a:0:b0:25a:66ac:70e with SMTP id z10-20020a2e964a000000b0025a66ac070emr4082158ljh.147.1655717101522;
        Mon, 20 Jun 2022 02:25:01 -0700 (PDT)
Received: from mutt (c-7303e555.07-21-73746f28.bbcust.telenor.se. [85.229.3.115])
        by smtp.gmail.com with ESMTPSA id e17-20020a195011000000b00478e9b28fe4sm1699729lfb.80.2022.06.20.02.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:25:01 -0700 (PDT)
Date:   Mon, 20 Jun 2022 11:24:59 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com, bvanassche@acm.org,
        peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
Subject: Re: [PATCH v5 10/11] scsi: ufs-mediatek: Support multiple VCC sources
Message-ID: <20220620092459.GA37723@mutt>
References: <20220616053725.5681-1-stanley.chu@mediatek.com>
 <20220616053725.5681-11-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220616053725.5681-11-stanley.chu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-16 13:37, Stanley Chu wrote:
> Support multiple VCC source in MediaTek UFS platforms.
> 
> Two options are provided and distinguished by specific
> device tree attributes as below examples,
> 
> [Option 1: By numbering]
> mediatek,ufs-vcc-by-num;
> vcc-opt1-supply = <&mt6373_vbuck4_ufs>;
> vcc-opt2-supply = <&mt6363_vemc>;
> 
> [Option 2: By UFS version]
> mediatek,ufs-vcc-by-ver;
> vcc-ufs3-supply = <&mt6373_vbuck4_ufs>;
> 
> Signed-off-by: Alice Chao <alice.chao@mediatek.com>
> Signed-off-by: Peter Wang <peter.wang@mediatek.com>
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  drivers/ufs/host/ufs-mediatek.c | 46 ++++++++++++++++++++++++++++++++-
>  drivers/ufs/host/ufs-mediatek.h | 14 ++++++++++
>  2 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
> index e756aba45acd..34e51c094366 100755
> --- a/drivers/ufs/host/ufs-mediatek.c
> +++ b/drivers/ufs/host/ufs-mediatek.c
> @@ -669,6 +669,49 @@ static u32 ufs_mtk_get_ufs_hci_version(struct ufs_hba *hba)
>  	return hba->ufs_version;
>  }
>  
> +#define MAX_VCC_NAME 30
> +static int ufs_mtk_vreg_fix_vcc(struct ufs_hba *hba)
> +{
> +	struct ufs_vreg_info *info = &hba->vreg_info;
> +	struct device_node *np = hba->dev->of_node;
> +	struct device *dev = hba->dev;
> +	char vcc_name[MAX_VCC_NAME];
> +	struct arm_smccc_res res;
> +	int err, ver;
> +
> +	if (hba->vreg_info.vcc)
> +		return 0;
> +
> +	if (of_property_read_bool(np, "mediatek,ufs-vcc-by-num")) {
> +		ufs_mtk_get_vcc_num(res);
> +		if (res.a1 > UFS_VCC_NONE && res.a1 < UFS_VCC_MAX)
> +			snprintf(vcc_name, MAX_VCC_NAME, "vcc-opt%u", res.a1);

Building this showes the following build warning/error

drivers/ufs/host/ufs-mediatek.c: In function 'ufs_mtk_vreg_fix_vcc':
drivers/ufs/host/ufs-mediatek.c:688:67: error: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Werror=format=]
  688 |                         snprintf(vcc_name, MAX_VCC_NAME, "vcc-opt%u", res.a1);
      |                                                                  ~^   ~~~~~~
      |                                                                   |      |
      |                                                                   |      long unsigned int
      |                                                                   unsigned int
      |                                                                  %lu
cc1: all warnings being treated as errors


Cheers,
Anders
