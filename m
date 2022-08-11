Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2BD58F888
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiHKHnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHKHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:43:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1F28E987
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:43:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D67568AA6; Thu, 11 Aug 2022 09:43:46 +0200 (CEST)
Date:   Thu, 11 Aug 2022 09:43:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <20220811074346.GA14956@lst.de>
References: <20220325122559.14251-1-mhocko@kernel.org> <Yj28gjonUa9+0yae@dhcp22.suse.cz> <20220325164856.GA16800@lst.de> <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz> <YupFSpXOrcfXJNya@dhcp22.suse.cz> <YuqNToCACD8kKBG+@MiWiFi-R3L-srv> <YuqOrJKcgfamdXkk@dhcp22.suse.cz> <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv> <YuqX0OAItlMDfRUV@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuqX0OAItlMDfRUV@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 05:44:16PM +0200, Michal Hocko wrote:
> Unfortunately generic kernels cannot really know there is any
> crippled device without some code to some checking early boot (and I am
> not even sure this would be sufficient).

But we can know if we need the pool, which is only when AMD SEV is
enabled.  So we could add a check and skip allocating all the pools
including the GFP_DMA32 and GFP_KERNEL ones.  I can look into that.
