Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB78568812
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiGFMNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiGFMNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:13:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1E52A42A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A2DD6091A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 12:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7099DC3411C;
        Wed,  6 Jul 2022 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657109570;
        bh=QHpLGHyLyN/b6QbnN5swFE8qHq/MeprwbhETMjBS7NE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+SyMH5mpkB1jQPKZy9F50UjS50/4YjeuHJYjvUv2DYwxnaaKls/y4hMo4epqHQ+N
         nXrqLg8WAxiBDcR11EcnsHO0IbItEPu5p7bBpjq8G89OEtSjQt4Fm4QXcy+WnWsu9U
         g0YLb967hCr+xPt/Vttjvc0yZSs/BvlXv29Hmu+G+6UFEDpYEke0PySivW5fQgKgTV
         4qS84j6q4oBPrq5AtZyYOuhM0R3HsDmnB/7jsYvQUwhHTVM0viUzMMnE/e6OqTjdPg
         HC68cCRm/klseXQQvbL3fUPZi4XeCgH1HESUml55uM8B6ODnI2rjHiTziS3/w6l49R
         WPafFdUDf6wzA==
Date:   Wed, 6 Jul 2022 13:12:44 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com, mst@redhat.com,
        jasowang@redhat.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        chenxiang66@hisilicon.com, thunder.leizhen@huawei.com,
        jean-philippe@linaro.org, linuxarm@huawei.com
Subject: Re: [PATCH RESEND v5 1/5] iommu: Refactor iommu_group_store_type()
Message-ID: <20220706121244.GH2403@willie-the-truck>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
 <1649071634-188535-2-git-send-email-john.garry@huawei.com>
 <20220706120059.GE2403@willie-the-truck>
 <5ab934ff-0b16-0b55-e0f1-36366cd33e84@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab934ff-0b16-0b55-e0f1-36366cd33e84@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 01:03:44PM +0100, John Garry wrote:
> On 06/07/2022 13:00, Will Deacon wrote:
> > On Mon, Apr 04, 2022 at 07:27:10PM +0800, John Garry wrote:
> > > Function iommu_group_store_type() supports changing the default domain
> > > of an IOMMU group.
> > > 
> > > Many conditions need to be satisfied and steps taken for this action to be
> > > successful.
> > > 
> > > Satisfying these conditions and steps will be required for setting other
> > > IOMMU group attributes, so factor into a common part and a part specific
> > > to update the IOMMU group attribute.
> > > 
> > > No functional change intended.
> > > 
> > > Some code comments are tidied up also.
> > > 
> > > Signed-off-by: John Garry<john.garry@huawei.com>
> > > ---
> > >   drivers/iommu/iommu.c | 96 ++++++++++++++++++++++++++++---------------
> > >   1 file changed, 62 insertions(+), 34 deletions(-)
> > Acked-by: Will Deacon<will@kernel.org>
> > 
> 
> Thanks, but currently I have no plans to progress this series, in favour of
> this https://lore.kernel.org/linux-iommu/1656590892-42307-1-git-send-email-john.garry@huawei.com/T/#me0e806913050c95f6e6ba2c7f7d96d51ce191204

heh, then I'll stop reviewing it then :) Shame, I quite liked it so far!

Will
