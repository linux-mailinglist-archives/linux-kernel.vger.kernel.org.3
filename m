Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC90453943A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbiEaPqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345837AbiEaPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:46:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8631132;
        Tue, 31 May 2022 08:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8D085CE16A2;
        Tue, 31 May 2022 15:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA6AC385A9;
        Tue, 31 May 2022 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654011998;
        bh=28hNyHGSDpZHs0jrlZm4DevaiKS1Dgov9Cghpq4OuQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNYFRHksLYtUcCAcZ7Buwq9ttW4S4yXcIn65uSfG/yW7ZUq04CMK8dwJoYjmXP2Dy
         rXfdQhC5MvbakIbjSye0D4OfqBhFz0k0NR/zTliFhCGaMqiy3MXwkUixzciVR56ag0
         mgO3/6kt6UHQ4Rnw5GnMOw7m1UBe0zJ6z+pmNro2OjVpor9BwZIV6ovTEbfP0wy7eE
         B7y9Bm2zHTBfEM3gvdPrtkDwQfdJv1Zz8VnYK/WEHqwb9D87bY1QR0uPAZc9vNbMRw
         G5CjSrSef4K/vaTzdrxxlVW82I6yhQ8vqEymj5K+2sLUgnLpmy9Mxf97Ie/yOQ5NgL
         CNQsT4KLKq9cg==
Date:   Tue, 31 May 2022 16:46:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] iommu/qcom: Use the asid read from device-tree if
 specified
Message-ID: <20220531154631.GA25502@willie-the-truck>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-2-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527212901.29268-2-konrad.dybcio@somainline.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 11:28:56PM +0200, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> As specified in this driver, the context banks are 0x1000 apart.
> Problem is that sometimes the context number (our asid) does not
> match this logic and we end up using the wrong one: this starts
> being a problem in the case that we need to send TZ commands
> to do anything on a specific context.

I don't understand this. The ASID is a software construct, so it shouldn't
matter what we use. If it does matter, then please can you explain why? The
fact that the context banks are 0x1000 apart seems unrelated.

Will
