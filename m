Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11E05444B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239895AbiFIHW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiFIHW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:22:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDEE2802A7;
        Thu,  9 Jun 2022 00:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0968661DFD;
        Thu,  9 Jun 2022 07:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1117AC34114;
        Thu,  9 Jun 2022 07:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654759374;
        bh=RUqBPuiFnGDcizHkOj1N9zmIBU4Hc2al7dVQSSZImWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=elyTdc0keXlyuqFHuj6jTBqKIijllhjYZIutFkdS0yLMZjITiN/xtyhos+bdM/ESf
         8fIVvcr0ms0oy868yLbdiuRcQYgus0IT0V0GVvDeCj+n9QfR5j0cHpeTDkHvdhtYXp
         y/G0lnkgoF/e/kxp2rAAqym3Txkydf9VF6OlJkhE3AtCI2TyIhPvv7AdZM1mSaB6DU
         +pfNnSkIWF9I8YTLfzfvNHx7SOhUKIKdUL1hSggq3A41fmkGopWYxkpWNN/Y7aPd6K
         35MFgjfcxxh9jOwY7hknO8RDdAbGWs8zAzCT6wDY1QFt7DCsguopHNRGevqq0Ltn5h
         f6MLMzoUT9S2Q==
Date:   Thu, 9 Jun 2022 12:52:40 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] mtd: nand: raw: qcom_nandc: reorder
 qcom_nand_host struct
Message-ID: <20220609072240.GB2758@thinkpad>
References: <20220608001030.18813-1-ansuelsmth@gmail.com>
 <20220608001030.18813-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220608001030.18813-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 02:10:30AM +0200, Ansuel Smith wrote:
> Reorder qcom_nand_host to save holes in the struct.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

If this patch gets moved to 2/3, you could save few changes. Also, do the same
for other structs as well.

Thanks,
Mani

> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 06ee9a836a3b..110f839c9e51 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -475,11 +475,13 @@ struct qcom_nand_host {
>  	int cs;
>  	int cw_size;
>  	int cw_data;
> -	bool use_ecc;
> -	bool bch_enabled;
>  	int ecc_bytes_hw;
>  	int spare_bytes;
>  	int bbm_size;
> +
> +	bool codeword_fixup;
> +	bool use_ecc;
> +	bool bch_enabled;
>  	u8 status;
>  	int last_command;
>  
> @@ -490,7 +492,6 @@ struct qcom_nand_host {
>  	u32 clrflashstatus;
>  	u32 clrreadstatus;
>  
> -	bool codeword_fixup;
>  	int nr_boot_partitions;
>  	struct qcom_nand_boot_partition *boot_partitions;
>  };
> -- 
> 2.36.1
> 

-- 
மணிவண்ணன் சதாசிவம்
