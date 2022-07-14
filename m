Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B76F574660
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiGNIMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiGNIMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:12:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D712B190;
        Thu, 14 Jul 2022 01:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93A7BB823B9;
        Thu, 14 Jul 2022 08:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EF6C34115;
        Thu, 14 Jul 2022 08:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657786369;
        bh=Ta1vn2x5HVKuOgcfwWuXxEO6fu8hsyoTtGuIzVqCGVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZBnkvI26oawo/yamxGpGKg5YjDbIrkv/So6Jx6C3QXiQxCeQqny/o2DMAjo2mtgp
         Xg7vuGcREtW8Ye2dbqmWuHSPo156X6S2QqfHpxcH96Da6+Sk8V7nL9xJyG4MXdYM96
         PJhPysDIcOhOK86wAK/bPJVqf2wl9xJ9UusaQKWlZGHgWZhggo1SxpBgI1NgzTLF91
         wzENR4I+VbEqOtNXJm3CJ8GvbFhM6aaGi55lyeeFVLoIWkrIOlZvTVjddSzpUyM5Jq
         OdjLLne4ZD67QQVHAMO2b4aXJMPsG+0XY2dmkNTMOtIe/GIimaWjVIvRzl0sSbTpXh
         XBjXDWNpo4HAw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBtxs-0004Iw-Qa; Thu, 14 Jul 2022 10:12:53 +0200
Date:   Thu, 14 Jul 2022 10:12:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/30] phy: qcom,qmp: fix dt-bindings and deprecate
 lane suffix
Message-ID: <Ys/QBPJmkWO6O3Fw@hovoldconsulting.com>
References: <20220707134725.3512-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707134725.3512-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 03:46:55PM +0200, Johan Hovold wrote:
> When adding support for SC8280XP to the QMP PHY driver I noticed that
> the PHY provider child node was not described by the current DT schema.
> 
> The SC8280XP PHYs also need a second fixed-divider PIPE clock
> ("pipediv2") and I didn't want to have to add a bogus "lane" suffix to
> the clock name just to match the current "pipe0" name so I decided to
> deprecate the unnecessary suffix in the current binding instead.
> 
> To be able to add the missing child-node schema and handle device
> specifics like additional PIPE clocks, it quickly became obvious that
> the binding needs to be split up.
> 
> This series clean up and fixes some issue with the current schema before
> splitting it up in separate schemas for PCIe, UFS and USB and adding
> missing parts like the child PHY provider nodes.
> 
> The MSM8996 PCIe PHY gets its own schema as this is the only non-combo
> PHY that actually provides more than one PHY per IP block. Note that the
> "lane" suffix is still unnecessary and misleading.
> 
> The final patches add support for the updated binding to the (recently
> split up) PHY drivers. Included is also a related combo PHY cleanup.
> 
> Johan
> 
> 
> Changes in v2
>  - squash split + cleanup + example patches (Krzysztof)
>  - deprecate clock-names instead of dropping suffix (Krzysztof)
>  - deprecate reset-names instead of dropping suffix (Krzysztof)
>  - flatten child reg if/then schemas (Krzysztof)
>  - add back optional vddp-ref-clk to all bindings even though it likely
>    only applies to MSM8996/98 UFS (Krzysztof)
>  - add missing sc7180 schema to USB binding
>  - misc clean ups
>    - shorten or drop descriptions
>    - drop quotes around $id and $schema (Krzysztof)
>    - use maxItems with clock-output-names
>    - combine two USB clock+reset schemas
>  - add Reviewed-by/Acked-by tags

Any further comments to this series?

Vinod, I noticed there was a conflict when rebasing on linux-next due to
commit 85d43a69db2d ("dt-bindings: phy: qcom,qmp: add IPQ8074 PCIe Gen3
PHY binding").

I'll send a v3 so you don't have to do the resolution, but I figured I'd
wait a bit in case there are any other changes that need to be made.

Johan
