Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A725A5CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiH3H2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH3H23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:28:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E5D9E100;
        Tue, 30 Aug 2022 00:28:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19133B816A3;
        Tue, 30 Aug 2022 07:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E838C433C1;
        Tue, 30 Aug 2022 07:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661844505;
        bh=GkSxClK7X/1FOfc/IipCQ3oAZda94OTJaGgo+09EP6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htlzUsY7BuuVeY8cN7HRgMPs5r4IhWo13h8mkKsiKlNpAFGx52qSdlktD8K+tFmnI
         ogjr1hfmEpJtpdDOUX+jEafafS8ikAXP4a5LBtoGixmJwVURpiplt4jkd6PPJgfgKk
         /pzF37qaFmZ9shK8UQHshdIU9vblhLQSBsk2e2XCKXCAWrnayNxMjChLY7eQrVUstx
         wNHel7csuqFHth2pLSS+SgRP4iDwdxSStywWmBt47LhoGj36BkptsMqcDh2SqGxt52
         UXheoJ6dOGPX/q3UXMAjVBqz9Afg/ciINLkzxjtVHotxkbR4pXbgORwNnBPoF8uWPg
         658A/2W+blq7A==
Date:   Tue, 30 Aug 2022 12:58:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan@kernel.org>
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
Message-ID: <Yw28FdhYSv4x0a6B@matsya>
References: <20220714124333.27643-1-johan+linaro@kernel.org>
 <Yw2a44l9a6zz5qTJ@matsya>
 <Yw21t1SUGjCcUuuw@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw21t1SUGjCcUuuw@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-08-22, 09:01, Johan Hovold wrote:
> On Tue, Aug 30, 2022 at 10:36:43AM +0530, Vinod Koul wrote:
> > On 14-07-22, 14:43, Johan Hovold wrote:
> > > When adding support for SC8280XP to the QMP PHY driver I noticed that
> > > the PHY provider child node was not described by the current DT schema.
> > > 
> > > The SC8280XP PHYs also need a second fixed-divider PIPE clock
> > > ("pipediv2") and I didn't want to have to add a bogus "lane" suffix to
> > > the clock name just to match the current "pipe0" name so I decided to
> > > deprecate the unnecessary suffix in the current binding instead.
> > > 
> > > To be able to add the missing child-node schema and handle device
> > > specifics like additional PIPE clocks, it quickly became obvious that
> > > the binding needs to be split up.
> > > 
> > > This series clean up and fixes some issue with the current schema before
> > > splitting it up in separate schemas for PCIe, UFS and USB and adding
> > > missing parts like the child PHY provider nodes.
> > > 
> > > The MSM8996 PCIe PHY gets its own schema as this is the only non-combo
> > > PHY that actually provides more than one PHY per IP block. Note that the
> > > "lane" suffix is still unnecessary and misleading.
> > > 
> > > The final patches add support for the updated binding to the (recently
> > > split up) PHY drivers. Included is also a related combo PHY cleanup.
> > 
> > This fails at patch 2 for me on v6.0-rc1, please rebase and resend
> 
> Are you sure you haven't applied anything to your local tree that causes
> this?

Pretty sure :-)

> 
> I just tried fetching the v3 series from lore and it applies just fine
> on top of 6.0-rc1.
> 
> Note that if you've added a new compatible string locally, the second
> patch which sorts the compatible strings is likely to fail to apply.

At that time no, now I think I have patch or so ... Tree should be
pushed in a bit, you can check

-- 
~Vinod
