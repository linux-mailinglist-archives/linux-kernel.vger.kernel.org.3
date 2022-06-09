Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B9F544974
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbiFIKsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243033AbiFIKse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:48:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B71D14015;
        Thu,  9 Jun 2022 03:48:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39D0DB82C04;
        Thu,  9 Jun 2022 10:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD59C34114;
        Thu,  9 Jun 2022 10:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654771710;
        bh=fzrWexAskT7761OX6YVLpBV0uk5ZpeEoL980M4D3UYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4tHsGIzjTjEj6emD016kI2+9negOY8WK6XJwW/Czy9mjKVCilf0dspL6QLJFZWMe
         m/CXhgKNyia+kNN0KG6CRloxkv7yPn49QagcfAqgIyRDAf24xpG/aXzFzZ1i78HO7y
         AYVe/KlZWI8JRsW2V9sjLlbXWu6RqSdy4uLMHQpAnWg5uuH00l8FwYEd4suhPZkSU6
         boPl/mJpnbPGuJDl0zt1eGK25+lf73zfFT1bJR3f0nfcGAufXq9qGYHuxiUywTFBsN
         7wM8DR015BDwak8YJkABHrI2Yqjkvpri32Rh8KX/rXAkY2rJm1sQ/cr+RkeiAo/id0
         aJOkyEuolb2YA==
Date:   Thu, 9 Jun 2022 16:18:18 +0530
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
Message-ID: <20220609104818.GE2758@thinkpad>
References: <20220608001030.18813-1-ansuelsmth@gmail.com>
 <20220608001030.18813-4-ansuelsmth@gmail.com>
 <20220609072240.GB2758@thinkpad>
 <62a1caf0.1c69fb81.a67af.bdf8@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62a1caf0.1c69fb81.a67af.bdf8@mx.google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:26:53PM +0200, Ansuel Smith wrote:
> On Thu, Jun 09, 2022 at 12:52:40PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jun 08, 2022 at 02:10:30AM +0200, Ansuel Smith wrote:
> > > Reorder qcom_nand_host to save holes in the struct.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > 
> > If this patch gets moved to 2/3, you could save few changes. Also, do the same
> > for other structs as well.
> > 
> > Thanks,
> > Mani
> >
> 
> Since 2/3 already had lots of changes didn't want to put a struct
> reorder in it since it does touch also other values. Tell me if I should
> squash the 2 commit.
> 

Not squashing but I mean to move this patch before the driver change (1/3), so
that "codeword_fixup" can be added in the correct place.

Also move the respective Kdoc comments.

Thanks,
Mani

> > > ---
> > >  drivers/mtd/nand/raw/qcom_nandc.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > > index 06ee9a836a3b..110f839c9e51 100644
> > > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > > @@ -475,11 +475,13 @@ struct qcom_nand_host {
> > >  	int cs;
> > >  	int cw_size;
> > >  	int cw_data;
> > > -	bool use_ecc;
> > > -	bool bch_enabled;
> > >  	int ecc_bytes_hw;
> > >  	int spare_bytes;
> > >  	int bbm_size;
> > > +
> > > +	bool codeword_fixup;
> > > +	bool use_ecc;
> > > +	bool bch_enabled;
> > >  	u8 status;
> > >  	int last_command;
> > >  
> > > @@ -490,7 +492,6 @@ struct qcom_nand_host {
> > >  	u32 clrflashstatus;
> > >  	u32 clrreadstatus;
> > >  
> > > -	bool codeword_fixup;
> > >  	int nr_boot_partitions;
> > >  	struct qcom_nand_boot_partition *boot_partitions;
> > >  };
> > > -- 
> > > 2.36.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
> 
> -- 
> 	Ansuel

-- 
மணிவண்ணன் சதாசிவம்
