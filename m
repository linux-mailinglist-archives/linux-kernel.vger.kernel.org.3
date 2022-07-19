Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E102357A88A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbiGSUv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239707AbiGSUvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BD7545F4B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658263865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KLYjLPmh6TJHSo85bLGpDWqvGEwFmv1ujqnWhvAf7WE=;
        b=H5Wz1lFiCC+iNWtJf7F2qTpjfc5uICi5TZLoenNke975hXrAWEz28mTVlQSmWYCmv5i8VI
        mvEKsaEMo1ENEyAVvqAJiL24qFZ9lBR6bBQEkytrw1MZN5gHbYlVweSvkZLfiJSsMseggl
        719hsofTOb56pjB59Mf7zs3SS1fY8qU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-anIru0bLMB-uMd2lvILhHg-1; Tue, 19 Jul 2022 16:50:58 -0400
X-MC-Unique: anIru0bLMB-uMd2lvILhHg-1
Received: by mail-qv1-f69.google.com with SMTP id nn4-20020a056214358400b00474025b619eso476720qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KLYjLPmh6TJHSo85bLGpDWqvGEwFmv1ujqnWhvAf7WE=;
        b=E4KA1UV69MYUAiRCbYasPDXal5dhJN/CZldZIRglVpYrvz2M8TuK27cEqUR0ssCw66
         kCsgv/Q2vJfFe/rTVVR8ybdD5fCaWMvrZ81dq1MimFs6mbAcZwgsn6yUxMMGWiJPwxIS
         DqdOKRgsMlTLI/uDe+xHTXrkTZ5+bY7xHDG8BCjs7j1TnRTaNGmPkxGnn/IVsdcTvjaN
         BDelLuVb7GRS0uz2ik7Dp7XJvSWPo+UA0LOjo79fFiQlxP5n9ytJtd/1VvLAgzFF1iSO
         euSQLfvgcXhMZPU0oag5AvFSjbseOexYjD2qZyPDQf2+iMr1Dm7mFHLevFpxWhrKvc9T
         MY8A==
X-Gm-Message-State: AJIora97YHc3XfIPHE7V4d39boCHOFThf5Wvb7jm1FMnG/17U9Dqxfvv
        j3GHuQXTwt1O3COFZojkLbDZhPOyuxuTgwpgUx0nqUWaAdlF+pGOSvwpby5IaWDkL9jflpDEf03
        bRuNo1hX3hZn3LAHdUCyg8YLs
X-Received: by 2002:ac8:7dcc:0:b0:31e:f21c:45b9 with SMTP id c12-20020ac87dcc000000b0031ef21c45b9mr8052148qte.133.1658263857736;
        Tue, 19 Jul 2022 13:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tzoXesGuCrLRPfo4M//fgvXvF5fsn1Z0nYeFj7o2Nf6Zzm1jCriA5qoxx+oHAtNlsi4JFPgw==
X-Received: by 2002:ac8:7dcc:0:b0:31e:f21c:45b9 with SMTP id c12-20020ac87dcc000000b0031ef21c45b9mr8052128qte.133.1658263857483;
        Tue, 19 Jul 2022 13:50:57 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::2e])
        by smtp.gmail.com with ESMTPSA id h11-20020a05620a400b00b006b60c965024sm303742qko.113.2022.07.19.13.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:50:57 -0700 (PDT)
Date:   Tue, 19 Jul 2022 15:50:54 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] i2c: qcom-geni: Propagate GENI_ABORT_DONE to
 geni_i2c_abort_xfer()
Message-ID: <20220719205054.rdhinuwxgabbsiht@halaneylaptop>
References: <20220717035027.2135106-1-bjorn.andersson@linaro.org>
 <20220717035027.2135106-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220717035027.2135106-3-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 08:50:26PM -0700, Bjorn Andersson wrote:
> Waiting for M_CMD_ABORT_EN in geni_i2c_abort_xfer() races with the
> interrupt handler which will read and clear the abort bit, the result is
> that every abort attempt takes 1 second and is followed by a message
> about the abort having times out.
> 
> Introduce a new state variable to carry the abort_done state from the
> interrupt handler back to geni_i2c_abort_xfer().
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 3bec7c782824..e212e7ae7ad2 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -97,6 +97,7 @@ struct geni_i2c_dev {
>  	struct dma_chan *tx_c;
>  	struct dma_chan *rx_c;
>  	bool gpi_mode;
> +	bool abort_done;
>  };
>  
>  struct geni_i2c_err_log {
> @@ -203,9 +204,14 @@ static void geni_i2c_err(struct geni_i2c_dev *gi2c, int err)
>  		dev_dbg(gi2c->se.dev, "len:%d, slv-addr:0x%x, RD/WR:%d\n",
>  			gi2c->cur->len, gi2c->cur->addr, gi2c->cur->flags);
>  
> -	if (err != NACK && err != GENI_ABORT_DONE) {
> +	switch (err) {
> +	case GENI_ABORT_DONE:
> +		gi2c->abort_done = true;
> +		break;
> +	default:
>  		dev_err(gi2c->se.dev, "%s\n", gi2c_log[err].msg);
>  		geni_i2c_err_misc(gi2c);
> +		break;
>  	}
>  }
>  

If I'm reading this right this changes the behavior on a NACK error now,
right? Was that intentional?

Otherwise looks good to me.

> @@ -311,21 +317,21 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
>  
>  static void geni_i2c_abort_xfer(struct geni_i2c_dev *gi2c)
>  {
> -	u32 val;
>  	unsigned long time_left = ABORT_TIMEOUT;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&gi2c->lock, flags);
>  	geni_i2c_err(gi2c, GENI_TIMEOUT);
>  	gi2c->cur = NULL;
> +	gi2c->abort_done = false;
>  	geni_se_abort_m_cmd(&gi2c->se);
>  	spin_unlock_irqrestore(&gi2c->lock, flags);
> +
>  	do {
>  		time_left = wait_for_completion_timeout(&gi2c->done, time_left);
> -		val = readl_relaxed(gi2c->se.base + SE_GENI_M_IRQ_STATUS);
> -	} while (!(val & M_CMD_ABORT_EN) && time_left);
> +	} while (!gi2c->abort_done && time_left);
>  
> -	if (!(val & M_CMD_ABORT_EN))
> +	if (!time_left)
>  		dev_err(gi2c->se.dev, "Timeout abort_m_cmd\n");
>  }
>  
> -- 
> 2.35.1
> 

