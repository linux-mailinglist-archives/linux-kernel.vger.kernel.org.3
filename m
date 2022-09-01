Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F305A9FC3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiIATSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiIATSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:18:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2CB8983A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:18:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 90CAE33755;
        Thu,  1 Sep 2022 19:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662059910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UFcrc/UJOT2kK6zHMZQySOwNe/Miq+xxPRe6+0lgG/k=;
        b=QzrCF2VvdUGGEdAHTIYe+W8NaZ02hQLHwMvfPQVoUSuUDjN0RbEvycquJq6nki301gknLP
        z5xDtdb8MxPFGkyfe4df8UB8Ym4ieIT3yRshjHzu5oKl1v2Qe0NWhNxJDTKIvJQAMkPXgV
        FxtluHEcLtfnCR6sM0z7ZXfyJhfzHbQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 721C313A79;
        Thu,  1 Sep 2022 19:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LYfVGIYFEWOEWAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 01 Sep 2022 19:18:30 +0000
Date:   Thu, 1 Sep 2022 21:18:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: reduce noise in show_mem for lowmem allocations
Message-ID: <YxEFhVcKS8gBeIcf@dhcp22.suse.cz>
References: <YwScVmVofIZkopkF@dhcp22.suse.cz>
 <Yw29bmJTIkKogTiW@dhcp22.suse.cz>
 <efa7bebf-b977-dea1-de1a-cbdaffaa165b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efa7bebf-b977-dea1-de1a-cbdaffaa165b@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-09-22 16:14:39, Vlastimil Babka wrote:
> On 8/30/22 09:34, Michal Hocko wrote:
> > [Cc Dan]
> > Dan has brought up[1] that the use of gfp mask has confused his static
> > analyzer which assumes that GFP_HIGHUSER_MOVABLE implies a sleeping
> > allocation and that wouldn't be a great idea from the panic path. I
> > would add that most callers of this function would be really bad to
> > allocate.
> > 
> > The report itself is a false positive but it made me think a bit about
> > this. Even if the check is too simplistic I guess it resembles how many
> > developers are thinking (including me). If I see GFP_HIGHUSER_MOVABLE or
> > GF_KERNEL I automatically assume a sleeping allocation down the road.
> > And who know somebody might add one in the future even into show_mem
> > because the gfp parameter would be too tempting to not (ab)use.
> > 
> > My original intention was to use a natural allocation speak but this can
> > backfire so maybe it would be better to give the argument its real
> > meaning and that is the high_zone_idx. This is cryptic for code outside
> > of MM but that is not all that many callers and we can hide this fact
> > from them. In other words does the thing below looks better (incremental
> > for illustration, I will make it a proper patch if yes)?
> 
> Yeah, looks better to me this way. Thanks!

Thanks for looking into this. Unless somebody objects I will send a
consolidated patch early next week.
-- 
Michal Hocko
SUSE Labs
