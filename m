Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F1858F8F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiHKIZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiHKIZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:25:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482BF13DDE
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:25:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EFA2437183;
        Thu, 11 Aug 2022 08:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660206316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kWKkak9v2ps7Zu0KlR7ytisVCQ4O5+05LJWZ1J59LX4=;
        b=DlgeBEuvQlAL+hiENKPkfbSkL/SfHqusREcp2ldByrXpOrKH6jP4w2hp3MCSffkjwCaOwq
        dUXScyGjT4oP5hUhqTkAboyQfMur5Pjhqte8cNZYRim0m9sfH/5GfDmZGCnP/e/OuuMsRy
        y0XWrCmq16RTbVx+nVzOx0Z8NaL3YVo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEB0213A9B;
        Thu, 11 Aug 2022 08:25:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eys9MOy89GKLUQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 11 Aug 2022 08:25:16 +0000
Date:   Thu, 11 Aug 2022 10:25:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <YvS87E6Vx/3PvMPr@dhcp22.suse.cz>
References: <YuqNToCACD8kKBG+@MiWiFi-R3L-srv>
 <YuqOrJKcgfamdXkk@dhcp22.suse.cz>
 <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv>
 <YuqX0OAItlMDfRUV@dhcp22.suse.cz>
 <YuunCO2lsLDWTGw+@MiWiFi-R3L-srv>
 <Yuu1EyC95XL98XNI@dhcp22.suse.cz>
 <Yu0OWLbzLxCkSGVJ@MiWiFi-R3L-srv>
 <Yu1VTAxd9/jP/iEk@dhcp22.suse.cz>
 <YvJ/V2bor9Q3P6ov@dhcp22.suse.cz>
 <20220811073840.GE13886@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811073840.GE13886@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-08-22 09:38:40, Christoph Hellwig wrote:
> On Tue, Aug 09, 2022 at 05:37:59PM +0200, Michal Hocko wrote:
> > Here we go again.
> 
> And just as last time I think this is the wrong thing to do.
> IFF we actually need the pool and we can't allocate it we want this
> warning.
> 
> But order-10 seems very larger for the 31-bit ISA DMA zone, so we might
> want to look into calculating the pool size based on the zone size
> instead.

No objection for a better size tuning from my side. I find it 
I suspect you will need __GFP_NOWARN to be used for downsizing the
request size for all attempts anyway.

-- 
Michal Hocko
SUSE Labs
