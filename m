Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA29A549C07
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344986AbiFMSow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344877AbiFMSoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:44:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F0CDE316;
        Mon, 13 Jun 2022 08:17:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m125-20020a1ca383000000b0039c63fe5f64so3311257wme.0;
        Mon, 13 Jun 2022 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CxEVhulkT4pSVVwXU2sr40U8DsgeEjl1fZ9K8bvOkec=;
        b=EkqGJhO7UoEpuADq42dtRnnUgh+XctbfGO+G58/gw4a8XBXDu1pbvpzkP2jaapAeQ3
         YHmDhLDmrNJbm2rtIVjeoctWIilnBWH4rWcpyoYoYekw2GYv1bWM9Dql6BRxyvy65c9o
         nzNwkfdRxQhV3uAKErZbX6+19lp2/qjfdvsHE36m3dpP72v/3tbx7+WKsg3Ny7sH5Hay
         QV6f4DDBxWI/N6KP0yrHMN/Li2ghHIcQJLWfkqnEq4acijU4WPChWjRTvBxGsVyYKx8v
         Ry17rDs4mVWtEsArjMioo9Fw1j7w4of6QtKDzVg5saSEzePQnZ12IC56/BvKEfpG9twO
         My7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CxEVhulkT4pSVVwXU2sr40U8DsgeEjl1fZ9K8bvOkec=;
        b=tk/5S5ATiCcwI5ag0SkirHQ0rArwfr1ZLa1hPBPDcbdee1uLGq9Cvjx1WnbZdTd3rq
         tO94OO3m33QNzBwd4TGiYVqGGLRhQmMX2DdsnvowQcLN+011I+/0doBJu7BYUG20iLnA
         3Y1vo3+4ynWkgPOXi0cWOMf7q4O7L/eNXrNDifZO9kzeABM7SEDyfhuaZ+GIU2THXTLX
         WR2S/dPV56AP+unwfQjxHxpdCkJ0LHJbBIUH/vS9waei++3CtJy+3ttCvApah0FbG/8w
         yNOIFCS0qghm5RJ3/tqNC9jeAxglq7lWiV/KqTYr2app+M1nQdvYJXqfjHA8mYOw9z2g
         fz+A==
X-Gm-Message-State: AOAM530m5otx7DhVjtWV0DQNrrlK028/2vk4rI5qDCrtr71M300xE1fV
        cY1XUsBpKoSNR752gP528JY=
X-Google-Smtp-Source: ABdhPJzZYU2kxK4eUimUtj60AQJ4K9MdzwxUjqic6Ph/tmfCfIaqYIL7wGT2YEi+7lwHQXZOX6UcFA==
X-Received: by 2002:a1c:cc05:0:b0:39c:7477:3f24 with SMTP id h5-20020a1ccc05000000b0039c74773f24mr15369449wmb.190.1655133472561;
        Mon, 13 Jun 2022 08:17:52 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id m4-20020a056000008400b002102cc4d63asm10595788wrx.81.2022.06.13.08.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 08:17:52 -0700 (PDT)
Message-ID: <62a75520.1c69fb81.8de59.2dc6@mx.google.com>
X-Google-Original-Message-ID: <YqdUc1oAxxgRyLzC@Ansuel-xps.>
Date:   Mon, 13 Jun 2022 17:14:59 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] mtd: nand: raw: qcom_nandc: reorder
 qcom_nand_host struct
References: <20220609132344.17548-1-ansuelsmth@gmail.com>
 <20220609132344.17548-2-ansuelsmth@gmail.com>
 <20220609170722.GA5081@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609170722.GA5081@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 10:37:22PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jun 09, 2022 at 03:23:42PM +0200, Ansuel Smith wrote:
> > Reorder qcom_nand_host to save holes in the struct.
> 
> You forgot to reorder other structs also as I requested :/
> 
> Thanks,
> Mani
>

Hi, I run this commit with pahole tools and it didn't reorder anything
else aside from what i already reordered. Am I missing something here?

> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/qcom_nandc.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > index 1a77542c6d67..7fbbd3e7784c 100644
> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > @@ -431,11 +431,12 @@ struct qcom_nand_controller {
> >   *				and reserved bytes
> >   * @cw_data:			the number of bytes within a codeword protected
> >   *				by ECC
> > + * @ecc_bytes_hw:		ECC bytes used by controller hardware for this
> > + *				chip
> > + *
> >   * @use_ecc:			request the controller to use ECC for the
> >   *				upcoming read/write
> >   * @bch_enabled:		flag to tell whether BCH ECC mode is used
> > - * @ecc_bytes_hw:		ECC bytes used by controller hardware for this
> > - *				chip
> >   * @status:			value to be returned if NAND_CMD_STATUS command
> >   *				is executed
> >   * @last_command:		keeps track of last command on this chip. used
> > @@ -452,11 +453,12 @@ struct qcom_nand_host {
> >  	int cs;
> >  	int cw_size;
> >  	int cw_data;
> > -	bool use_ecc;
> > -	bool bch_enabled;
> >  	int ecc_bytes_hw;
> >  	int spare_bytes;
> >  	int bbm_size;
> > +
> > +	bool use_ecc;
> > +	bool bch_enabled;
> >  	u8 status;
> >  	int last_command;
> >  
> > -- 
> > 2.36.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
	Ansuel
