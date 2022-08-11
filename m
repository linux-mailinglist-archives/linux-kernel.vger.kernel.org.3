Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEC458F874
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiHKHis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiHKHip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:38:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012091D1A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:38:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 32A3768AA6; Thu, 11 Aug 2022 09:38:41 +0200 (CEST)
Date:   Thu, 11 Aug 2022 09:38:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <20220811073840.GE13886@lst.de>
References: <YupFSpXOrcfXJNya@dhcp22.suse.cz> <YuqNToCACD8kKBG+@MiWiFi-R3L-srv> <YuqOrJKcgfamdXkk@dhcp22.suse.cz> <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv> <YuqX0OAItlMDfRUV@dhcp22.suse.cz> <YuunCO2lsLDWTGw+@MiWiFi-R3L-srv> <Yuu1EyC95XL98XNI@dhcp22.suse.cz> <Yu0OWLbzLxCkSGVJ@MiWiFi-R3L-srv> <Yu1VTAxd9/jP/iEk@dhcp22.suse.cz> <YvJ/V2bor9Q3P6ov@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvJ/V2bor9Q3P6ov@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 05:37:59PM +0200, Michal Hocko wrote:
> Here we go again.

And just as last time I think this is the wrong thing to do.
IFF we actually need the pool and we can't allocate it we want this
warning.

But order-10 seems very larger for the 31-bit ISA DMA zone, so we might
want to look into calculating the pool size based on the zone size
instead.
