Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E895C5394E6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbiEaQT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346097AbiEaQTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:19:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100C598590;
        Tue, 31 May 2022 09:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9C53B810EE;
        Tue, 31 May 2022 16:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D2CC385A9;
        Tue, 31 May 2022 16:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654013958;
        bh=C7JqPHYdDIfIV1hFpEuC1J6B7QEItv7CaH7EVzTRasE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7uCs1jy8TG74D+Nj32f4BthpKKQvR+72bqpZXJZDojOu/Ri4D//ChSLI2vkj884B
         k35ZMlm5UJfSwDAtNkaERyfhCvFvZXDpAthbHc4HkQ7W03zyQPBFHoKp7stXu318GC
         5VM4zAwxH7TtP3LB1s/bzGOH8e9Lq2vjBfscQPE3016J1EHU4Nqji9R8xT3oCFM7zr
         HGeViJPNgdB51Kq1EoXhNEyKiBj2Ya4ArkH46ly3m4pxnzPNywvMEU2/pM4mGnrLa2
         psUMVuVTbOqTI27e5Hs7HKH8fpB6H+JgeeIjB7UTyNZkdBfYSv+/9JLpw/iQ0xyJfZ
         r4XR05x5qaAjg==
Date:   Tue, 31 May 2022 17:19:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Martin Botka <martin.botka@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        jamipkettunen@somainline.org, Andy Gross <agross@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] iommu/qcom: Use the asid read from device-tree if
 specified
Message-ID: <20220531161910.GE25502@willie-the-truck>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-2-konrad.dybcio@somainline.org>
 <20220531154631.GA25502@willie-the-truck>
 <CAF6AEGsWsHfQZnszG=NgP0BufxO-DP4LwvsAYkrz2wRhcJuOXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGsWsHfQZnszG=NgP0BufxO-DP4LwvsAYkrz2wRhcJuOXw@mail.gmail.com>
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

On Tue, May 31, 2022 at 09:15:22AM -0700, Rob Clark wrote:
> On Tue, May 31, 2022 at 8:46 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Fri, May 27, 2022 at 11:28:56PM +0200, Konrad Dybcio wrote:
> > > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > >
> > > As specified in this driver, the context banks are 0x1000 apart.
> > > Problem is that sometimes the context number (our asid) does not
> > > match this logic and we end up using the wrong one: this starts
> > > being a problem in the case that we need to send TZ commands
> > > to do anything on a specific context.
> >
> > I don't understand this. The ASID is a software construct, so it shouldn't
> > matter what we use. If it does matter, then please can you explain why? The
> > fact that the context banks are 0x1000 apart seems unrelated.
> 
> I think the connection is that mapping from ctx bank to ASID is 1:1

But in what sense? How is the ASID used beyond a tag in the TLB? The commit
message hints at "TZ commands" being a problem.

I'm not doubting that this is needed to make the thing work, I just don't
understand why.

Will
