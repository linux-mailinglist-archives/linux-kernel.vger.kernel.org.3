Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A04457BCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiGTR27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiGTR24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:28:56 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B61D6F7E9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=BdJWXweqyGQCfeqjgnpozbgFrJmoxkwreT6XvGPN9cU=;
        b=TPW5xqoQKc9bBVSk7wAQi68wlUj2/qo7KL5bIP6XvWSMptbqaa0t3LwFKdw0KIouFKJelqGmkV6hN
         p4Jq75Dz00Lvz7yPLYNvWFgn4OkYRcP06rQVBugi/DsTbE6VvL+CFZUA5oi5sjfCkgL1prCGRp/zs4
         5tS5R7I6NrP44EIq3c96wANrQSFMsUi5wZehdHAJxQyu1NMrLqATTShMEAbaKpFqFMouqnGdWNjXkd
         iOnviH1g6lKRnDp8heD+G4bFXIA2i1JV0oVrtOUVX0edQB4d3xF4eBRQOZ/dp1dPRtxhh2JiOgL7IK
         7zJcr81oUyp0qbX1QIan8jXTMTJ/7Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=BdJWXweqyGQCfeqjgnpozbgFrJmoxkwreT6XvGPN9cU=;
        b=9/77iI4g8nLFFpDP3kcwwe2k8lEWk0/rWegn9g5uN/ccefisW4YicrTn3v29GrqyemjbNf6EUnTFj
         Yh+rDeoBQ==
X-HalOne-Cookie: 2fd1a0ace96f55cc674a3b3f8564ed9a1b8f418a
X-HalOne-ID: 6cf369b5-0851-11ed-823f-d0431ea8bb10
Received: from mailproxy1.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 6cf369b5-0851-11ed-823f-d0431ea8bb10;
        Wed, 20 Jul 2022 17:28:53 +0000 (UTC)
Date:   Wed, 20 Jul 2022 19:28:51 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     daniel@ffwll.ch, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, tzimmermann@suse.de, mripard@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH drm-misc-next v5 3/4] drm/gem: rename struct
 drm_gem_dma_object.{paddr => dma_addr}
Message-ID: <Ytg7U/+SX0LSAmku@ravnborg.org>
References: <20220720153128.526876-1-dakr@redhat.com>
 <20220720153532.527458-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720153532.527458-1-dakr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 05:35:31PM +0200, Danilo Krummrich wrote:
> The field paddr of struct drm_gem_dma_object holds a DMA address, which
> might actually be a physical address. However, depending on the platform,
> it can also be a bus address or a virtual address managed by an IOMMU.
> 
> Hence, rename the field to dma_addr, which is more applicable.
> 
> In order to do this renaming the following coccinelle script was used:
> 
> ```
> 	@@
> 	struct drm_gem_dma_object *gem;
> 	@@
> 
> 	- gem->paddr
> 	+ gem->dma_addr
> 
> 	@@
> 	struct drm_gem_dma_object gem;
> 	@@
> 
> 	- gem.paddr
> 	+ gem.dma_addr
> 
> 	@exists@
> 	typedef dma_addr_t;
> 	symbol paddr;
> 	@@
> 
> 	dma_addr_t paddr;
> 	<...
> 	- paddr
> 	+ dma_addr
> 	...>
> 
> 	@@
> 	symbol paddr;
> 	@@
> 	dma_addr_t
> 	- paddr
> 	+ dma_addr
> 	;
> 
> ```
> 
> This patch is compile-time tested with:
> 
> ```
> 	make ARCH={x86_64,arm,arm64} allyesconfig
> 	make ARCH={x86_64,arm,arm64} drivers/gpu/drm`
> ```
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
