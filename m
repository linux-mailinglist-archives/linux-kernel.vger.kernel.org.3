Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26E64A93DE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 07:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbiBDGOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 01:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiBDGOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:14:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80BAC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 22:14:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC4CB61BBC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 06:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6810DC004E1;
        Fri,  4 Feb 2022 06:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643955273;
        bh=li8IqOB+eBXhVu+8z/DC1IgTMtm33NS2CSzOCQJeEpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ipvCzyyoWfoUHI4nJ7SF9swy4p5Hm3iiQqR3DxPCAFbfwUwPSg18lefYzC6EFPT3J
         HHlcbOUJmDI65vWiTbebolqGOg3MsEroORsoRwNQJwCr+HjSmBzeuF0XjbM3zYT0hb
         P1yS3TPWW8FvbFbhb9bMKFlWgVIcOUqeeOMCBfMB2fz9K5VRNAuFnBfiEoQ14VjHAr
         CxwCqDjht7yOD8qeg1qC2W03/GYbrnVFFXCajCcgVVPYaxzHRI2DjP2XiDexnS0kos
         2Aara09eqIQvLyPrFPC3bN2l0MVFK8wo9BLv8EWSfD7i3kPDW9ImGWj8sF9kCPw3Dm
         L6Po48sMbc92Q==
Date:   Fri, 4 Feb 2022 11:44:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: cadence: Sierra: Add support for skipping
 configuration
Message-ID: <YfzERMrPh+TrXr9x@matsya>
References: <20220128072642.29188-1-a-govindraju@ti.com>
 <YfqT444YoGBIturt@matsya>
 <1d5c41a8-24aa-3cfb-fff0-c2695102aa91@ti.com>
 <YfseaJADVocxqnOu@matsya>
 <3444e347-2603-6f5b-94de-09642c41fc27@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3444e347-2603-6f5b-94de-09642c41fc27@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-02-22, 11:25, Aswath Govindraju wrote:
> Hi Vinod,
> 
> On 03/02/22 5:44 am, Vinod Koul wrote:
> > On 02-02-22, 20:14, Aswath Govindraju wrote:
> >> Hi Vinod,
> >>
> >> On 02/02/22 7:53 pm, Vinod Koul wrote:
> >>> On 28-01-22, 12:56, Aswath Govindraju wrote:
> >>>> In some cases, a single SerDes instance can be shared between two different
> >>>> processors, each using a separate link. In these cases, the SerDes
> >>>> configuration is done in an earlier boot stage. Therefore, add support to
> >>>> skip reconfiguring, if it is was already configured beforehand.
> >>>
> >>> This fails to apply, pls rebase and resend
> >>>
> >>
> >> On rebasing, I am seeing no difference in the patch and I am able to
> >> apply it on top of linux-next/master commit 6abab1b81b65. May I know if
> >> there is any other branch that I would need to rebase this patch on top of?
> > 
> > It should be based on phy-next which is at
> > 1f1b0c105b19ac0d90975e2569040da1216489b7 now
> > 
> 
> I have posted a respin of this patch after rebasing it on top of
> phy-next. One aspect that is not clear to me is, phy-next branch does
> not have the following commit which is present in linux-next master,
> 
> 29afbd769ca3 phy: cadence: Sierra: fix error handling bugs in probe()

This is in fixes
> 
> When the respin of this patch(v3) is merged with linux-next/master
> wouldn't it cause merge-conflicts?
> 
> May I know how would this be handled?

If need arises (we have a dependency) I would merge fixes into next and
then apply patches. Cover letter of the patches should mention that

-- 
~Vinod
