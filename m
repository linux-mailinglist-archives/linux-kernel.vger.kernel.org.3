Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8750A5578E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiFWLoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiFWLoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:44:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2964BFCC;
        Thu, 23 Jun 2022 04:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FCDFB8222E;
        Thu, 23 Jun 2022 11:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B01C3411B;
        Thu, 23 Jun 2022 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655984660;
        bh=P1iWsP2UtAywzqCwCm4D9qSKvP6DUbZa5icNk1SrGNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8qDmauth47YOiRfp6Rh3MqIoSEYVFaCufAmzk7nn5WulII7hc6YBIxCjkiDRWjgr
         jY/qgkpk3unKgdicobjFx1jtu4JBKiHYySeTr7++3fyARaGXbN3CoFgAK6h3lGiIdH
         OKz1rpA9wqqqz83H7JBbA1xpm2qDXsVI+qsboEXZjUTeE1aLt+aXIm48Gi37rJW/TN
         1yhUjDx5gcpYQptvsm1SoaI0d5wt5r8y32eqlwc/3RkRIpWmHMjg/g20Jc+MIn8ndI
         8TWKio/NQgsXlLHA7LAH1uDAUXWBOSVOozwy7dXoMqetlUdohNuMyb1JKc7aqpLau9
         LiwnDE0AtXixg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o4LFx-0007p9-NJ; Thu, 23 Jun 2022 13:44:17 +0200
Date:   Thu, 23 Jun 2022 13:44:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] clk: qcom: gdsc: add support for collapse-vote
 registers
Message-ID: <YrRSEbR5OnjbZNZ1@hovoldconsulting.com>
References: <20220520100948.19622-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520100948.19622-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:09:45PM +0200, Johan Hovold wrote:
> Recent Qualcomm platforms have APCS collapse-vote registers that allow
> for sharing GDSCs with other masters (e.g. LPASS).
>     
> Add support for using such vote registers instead of the control
> register when updating the GDSC power state.
> 
> Note that the gcc-sc8280xp driver has not yet been merged. [1]

The sc8280xp driver has been merged so this series could go in now.

Bjorn?
 
> [1] https://lore.kernel.org/all/20220505025457.1693716-1-bjorn.andersson@linaro.org/
> 
> 
> Johan Hovold (3):
>   clk: qcom: gdsc: add collapse-bit helper
>   clk: qcom: gdsc: add support for collapse-vote registers
>   clk: qcom: gcc-sc8280xp: use collapse-voting for PCIe GDSCs
> 
>  drivers/clk/qcom/gcc-sc8280xp.c | 21 +++++++++++++++++++++
>  drivers/clk/qcom/gdsc.c         | 28 ++++++++++++++++++++++------
>  drivers/clk/qcom/gdsc.h         |  4 ++++
>  3 files changed, 47 insertions(+), 6 deletions(-)

Johan
