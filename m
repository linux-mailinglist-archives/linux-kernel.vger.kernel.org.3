Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6A58F86F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiHKHfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiHKHfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:35:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD178E0EA
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 00:34:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1616868AA6; Thu, 11 Aug 2022 09:34:55 +0200 (CEST)
Date:   Thu, 11 Aug 2022 09:34:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <20220811073454.GD13886@lst.de>
References: <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz> <YupFSpXOrcfXJNya@dhcp22.suse.cz> <YuqNToCACD8kKBG+@MiWiFi-R3L-srv> <YuqOrJKcgfamdXkk@dhcp22.suse.cz> <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv> <YuqX0OAItlMDfRUV@dhcp22.suse.cz> <YuunCO2lsLDWTGw+@MiWiFi-R3L-srv> <Yuu1EyC95XL98XNI@dhcp22.suse.cz> <Yu0OWLbzLxCkSGVJ@MiWiFi-R3L-srv> <Yu1VTAxd9/jP/iEk@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu1VTAxd9/jP/iEk@dhcp22.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 07:37:16PM +0200, Michal Hocko wrote:
> GFP_DMA is a misnomer. It doesn't really say that the allocation should
> be done for actual DMA. GFP_DMA really says allocate from ZONE_DMA.

Yes.  But in practice that either is to do DMA of some form, including
the s390 variant not using the dma api, or completely stupid cargo
cult code.

> It
> is my understanding that all actual DMA users should use a dedicated dma
> allocation APIs which should do the right thing wrt. address constrains.

Yes.  And we were at a point where we got to that, but it seems somewhat
recently a lot of people added completely stupid GFP_DMA kmallocs in the
all over the crypto drivers.  Sigh...
