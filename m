Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0473E5A0D94
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbiHYKMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240685AbiHYKMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:12:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85502AC251;
        Thu, 25 Aug 2022 03:12:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2BBEB8282F;
        Thu, 25 Aug 2022 10:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83E4C433D6;
        Thu, 25 Aug 2022 10:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661422319;
        bh=51cmz70G4BeiX7nm5zNcJKbWlVHoA55PYktAZNJPetk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NgBG2iwUb/IH2sLJbyCh82WvxTE4BRhbAvVN5DBEEtDXa8X8Ze4yx0eRkW15mrrk7
         I7WmMRAVA8ou0WFBUje491gw2ZSwPT7VuJa1TleI4pyftYUzjHwmOvxAyOoyRSvgU7
         37ms+FyLZwMokuCDXMQ0w7T8yM6Wpt945ygiFBzoI/u1sEOKj/1XMVwmc3IryOSxzM
         83+my5vHG+GT5qzApxJqUbTJ8k8GLRmWMk8/FlvKLzCn/0LuALRT+y2BLinY8U/dbk
         nJhU83Y9jslLFfJcMyrhjPfVxtPX+vkrarHIml3wILLdWe6mdf8pDtaRn5HusCzSDK
         MrckkHf1Ju5sw==
Date:   Thu, 25 Aug 2022 12:11:54 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/device: Fix up of_dma_configure_id() stub
Message-ID: <YwdK6seZfCTuDO4M@lpieralisi>
References: <20220824153256.1437483-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824153256.1437483-1-thierry.reding@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:32:56PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Since the stub version of of_dma_configure_id() was added in commit
> a081bd4af4ce ("of/device: Add input id to of_dma_configure()"), it has
> not matched the signature of the full function, leading to build failure
> reports when code using this function is built on !OF configurations.
> 
> Fixes: a081bd4af4ce ("of/device: Add input id to of_dma_configure()")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  include/linux/of_device.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index 1d7992a02e36..1a803e4335d3 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -101,8 +101,9 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>  }
>  
>  static inline int of_dma_configure_id(struct device *dev,
> -				   struct device_node *np,
> -				   bool force_dma)
> +				      struct device_node *np,
> +				      bool force_dma,
> +				      const u32 *id)
>  {
>  	return 0;
>  }
> -- 
> 2.37.2
> 
