Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C695A64B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiH3N2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiH3N1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196BA1704F;
        Tue, 30 Aug 2022 06:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9CA161222;
        Tue, 30 Aug 2022 13:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3847AC433D6;
        Tue, 30 Aug 2022 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661866067;
        bh=TXqpwipXrCFOXYs0SO/ATLTbv3osWwnARbMr/g5ctNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNdpqT1IdHN1TLHTOO196v77WO1akxWlNCXfJzbBJpYfHDDoyu2dzvf211+4gRAX1
         0XZjUR+w9GRpqAJBu516p9ytYp6sJ/cP6q9oJqUvMm1Z2RYBP4/h31E7Iai3zITRB1
         sAlTeA+9/LIh3K02Z3s1PyhlpR2Ci/W0c8gOMd8MTMpHy+oVyN950kzCzMyrtRzF3Q
         Q8c4O7FiILy3d6xNUm9lOakdQ3VVRVDOrPX3dMAVu2K+NqkZgnw7Ay7Jt/20fFp5y9
         4Rzls+9aoS9Cjkeeh1u9YxOohkBvWyufgyDPjueuRtEQpwxGaSE6wOypqCpxMuWbWG
         yDgctJRueQ0Cg==
Date:   Tue, 30 Aug 2022 18:57:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/30] phy: qcom,qmp: fix dt-bindings and deprecate
 lane suffix
Message-ID: <Yw4QTrLDmTaoaYJ5@matsya>
References: <20220830112923.3725-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830112923.3725-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-08-22, 13:28, Johan Hovold wrote:
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

This applied fine, will push after tests run

-- 
~Vinod
