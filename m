Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B7748D9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbiAMOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiAMOgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:36:17 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7492CC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 06:36:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id C737F1F459C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642084575;
        bh=EAzk6FY/7dS3FWywqUQJ/Bm6/lfzjy70ybyrDi9wJGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/v26arCErviEi3hhOjx7aIkkT2lhk08QUonexMFfmABunRc6cPy8o8UufG81zKbD
         GOU3Wbp9tBkjwltSKN/kkHX+U0XED0bDi1uibdI7I6xUO5s4U01BduUi/ZpX5Fwd5i
         XclOFxT1fTsuQvUPb3SPfa+C+WjEVpXFlJ3qyG4BnzBMgBDNOLA4V/WIljcGfyJ/N9
         Cr6zRL47rHQi+xUHUFqkM4OdQlQ3+AIvy+EdQSac13PR4nIeTHomeTV6lfnHKkeANu
         L4pDRxNzqMK3Hk1HYkE2BwUBSPuBlTZHjAB4/33fJgN7grmiygYh/dsb1Jp2xadKu+
         hOUmyzuugqaig==
Date:   Thu, 13 Jan 2022 09:36:07 -0500
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panfrost: Merge some feature lists
Message-ID: <YeA412iKn2bEynPl@maud>
References: <20220109170920.2921-1-alyssa.rosenzweig@collabora.com>
 <20220109170920.2921-3-alyssa.rosenzweig@collabora.com>
 <c34845c7-481b-91c1-d2ae-e239324f8364@arm.com>
 <Yd8qFqkTqzdUzOxc@maud>
 <023dbd83-0719-462b-3f41-6527cee45374@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023dbd83-0719-462b-3f41-6527cee45374@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>> Note that this leaves some unmerged identical Bifrost feature lists, as
> >>> there are more features affecting Bifrost kernel space that we do not
> >>> yet hanlde.
> >>
> >> NIT: s/hanlde/handle/ ;)
> >>
> >> Do you have any features in mind that we're missing? The list looks very
> >> similar to the kbase one. And anyway it is simple enough to split again
> >> if we need to.
> > 
> > Just IDVS group size. For some reason I thought there were more when I
> > wrote that commit message. It's split to avoid churn in that patch.
> > 
> > Logically, this series should contain three patches, with the IDVS group
> > size enablement patch at the end. That was the series I wrote and
> > committed to disk. For review I split it out, since the feature clean-up
> > can land now, while the (RFC) IDVS group size patch needs
> > testing/benchmarking.
> > 
> 
> Ah, of course! That makes perfect sense, but somehow I hadn't managed to
> connect the two.
> 
> I've fixed the typo and pushed to drm-misc-next. And I'll wait for your
> benchmarking on IDVS. Do I get a few minutes break before the Valhall
> patches need reviewing? ;)

Thanks for the push :-) And yes, I'd like to get Valhall userspace up to
shape before trying to shovel code into the kernel ^^ There are some
errata that kbase works around that I haven't implemented workarounds
for yet, and I'd like to figure out how to hit those so I can test that
the workarounds are correct. (Particularly thinking of the dummy job
workaround / GPU hang issue)
