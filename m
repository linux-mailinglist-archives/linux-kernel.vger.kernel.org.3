Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCFB54EC85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378827AbiFPV11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiFPV1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:27:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530EE60D97;
        Thu, 16 Jun 2022 14:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E246861DF6;
        Thu, 16 Jun 2022 21:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A43C34114;
        Thu, 16 Jun 2022 21:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655414843;
        bh=MDQjp5WMGZSOfSbLFcG9B/11ruGs/FqwL7Riz8wGMLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPmYysL9DniOlN+7Uj5VaibWCEj0i76aLzyEp5MgHggzEsUCU+atcN+zJVKM1LnPm
         tIJ7qw/N34h0YC5JPZH/Gn1riRbLPp3wfih8vcsu1/SOwb+i0ExVtdoa0xOdsNnwb1
         xAac20M1UEpD+IYRgKzLmLx9g9eSteRc3826EBLFJVnl1+TpMQBkQy6SZQy/yl4cOs
         +VW17ModtPkpTVgT9tDJLKs7Z02D2/yEW9fVlISHgx89ryAL3Vd+kMRqfQvWd6xAXj
         gzNFvBPYWCK0B3NeQH8lthae2s5G8yjQRhGzwyFr4L1vHI3RzAiLYigbDZ4rmT0Dfw
         K3ZQJ5aGAFXpg==
Date:   Fri, 17 Jun 2022 02:57:22 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] mtd: nand: raw: qcom_nandc: reorder
 qcom_nand_host struct
Message-ID: <20220616212722.GI2889@thinkpad>
References: <20220615000612.3119-1-ansuelsmth@gmail.com>
 <20220615000612.3119-2-ansuelsmth@gmail.com>
 <20220615171132.GA3606@thinkpad>
 <62aa76ad.1c69fb81.7e2d3.0c8e@mx.google.com>
 <20220616163751.2b5962df@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616163751.2b5962df@xps-13>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 04:37:51PM +0200, Miquel Raynal wrote:
> Hi Ansuel/Christian,
> 
> ansuelsmth@gmail.com wrote on Thu, 16 Jun 2022 02:18:08 +0200:
> 
> > On Wed, Jun 15, 2022 at 10:41:32PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Jun 15, 2022 at 02:06:10AM +0200, Ansuel Smith wrote:  
> > > > Reorder structs in nandc driver to save holes.
> > > > 
> > > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>  
> > > 
> > > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > > 
> > > Thanks,
> > > Mani
> > >  
> > 
> > I'm sending v8 with a different Sob so I'm not adding the review tag (in
> > v8).
> > In short the new Sob is what I will use onwards, wanted to keep the
> > Ansuel reference but it was suggested to use Christian Marangi and
> > nothing more. It's just a name change and we are the same person and
> > nobody is stealing ownership of the patch.
> > Sorry for the mess.
> 
> Mmmh strange, but okay. You are supposed to contribute with your real
> identity, not under pseudonym anyway.
> 
> Also, you could have kept Mani's R-by in v8 but anyway. Mani, can
> you resend them?
> 

Done!

Thanks,
Mani

> Thanks,
> Miquèl

-- 
மணிவண்ணன் சதாசிவம்
