Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FB65A5C52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiH3HBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiH3HBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:01:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A2F9F77A;
        Tue, 30 Aug 2022 00:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87B49B816AA;
        Tue, 30 Aug 2022 07:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FD5C433D6;
        Tue, 30 Aug 2022 07:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661842863;
        bh=1m8t3XQYq2uVxf9hIZZQ7ueuqje2AiVRqFHNHbPJSVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbQLeUv1wrIEeCeDusHAqgn20ilbVFg38RzUBjY3XCBvhC7gvFbpdxoOB1daufk3q
         uWiLWIjwoMw5re0DiTvYJElcLl/Tq2jgmmIwne4LMNkqmRNwIqvR0CfX11Vbp+DtO+
         n/dGxrL7CYGzi1hxsF2YQFAzBm/2cEHKFgzeDY+udVqelXAa90GLI6WK6Pao9enHyg
         JiyNBB3Qv7gYobpGlyp1QhiE0W6d//d72v4rrFve6f8vhqauChOjMarwFgLgWKIZbz
         G6u7ZkAPWmC0AqblXc7DydMfWDwJoleW6cN0QFHVZsnz+ZLe4LSItDdgPL6fJyH1zf
         jFZ5BbFTn4ocg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oSvFH-0007Sc-Ga; Tue, 30 Aug 2022 09:01:11 +0200
Date:   Tue, 30 Aug 2022 09:01:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/30] phy: qcom,qmp: fix dt-bindings and deprecate
 lane suffix
Message-ID: <Yw21t1SUGjCcUuuw@hovoldconsulting.com>
References: <20220714124333.27643-1-johan+linaro@kernel.org>
 <Yw2a44l9a6zz5qTJ@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw2a44l9a6zz5qTJ@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 10:36:43AM +0530, Vinod Koul wrote:
> On 14-07-22, 14:43, Johan Hovold wrote:
> > When adding support for SC8280XP to the QMP PHY driver I noticed that
> > the PHY provider child node was not described by the current DT schema.
> > 
> > The SC8280XP PHYs also need a second fixed-divider PIPE clock
> > ("pipediv2") and I didn't want to have to add a bogus "lane" suffix to
> > the clock name just to match the current "pipe0" name so I decided to
> > deprecate the unnecessary suffix in the current binding instead.
> > 
> > To be able to add the missing child-node schema and handle device
> > specifics like additional PIPE clocks, it quickly became obvious that
> > the binding needs to be split up.
> > 
> > This series clean up and fixes some issue with the current schema before
> > splitting it up in separate schemas for PCIe, UFS and USB and adding
> > missing parts like the child PHY provider nodes.
> > 
> > The MSM8996 PCIe PHY gets its own schema as this is the only non-combo
> > PHY that actually provides more than one PHY per IP block. Note that the
> > "lane" suffix is still unnecessary and misleading.
> > 
> > The final patches add support for the updated binding to the (recently
> > split up) PHY drivers. Included is also a related combo PHY cleanup.
> 
> This fails at patch 2 for me on v6.0-rc1, please rebase and resend

Are you sure you haven't applied anything to your local tree that causes
this?

I just tried fetching the v3 series from lore and it applies just fine
on top of 6.0-rc1.

Note that if you've added a new compatible string locally, the second
patch which sorts the compatible strings is likely to fail to apply.

Johan
