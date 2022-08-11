Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCDA58F8EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbiHKIUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiHKIUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:20:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2931939
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:20:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1CF8F34BA4;
        Thu, 11 Aug 2022 08:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660206044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YZetXLpzcTKbFkMzOEX40sJUJiI9GurrJooi8cd7cfI=;
        b=ZbKokfQ94V88OnI61JcgxJpcxehiN9Tqlhr3kLftXjPI6l/O0rtQCZSIg2KKd2/Z3C7ylx
        5PfKLsHLxNc04AjnczLXW9L4kOQ5FCLifu28fIWLOE2eImHRrTZn3I2xeBW0+ao4FKFv7d
        wHVA7R+O+AVIaU5iUATiJuL1hvPizgk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D904413A9B;
        Thu, 11 Aug 2022 08:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hHDXMNu79GJGTwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 11 Aug 2022 08:20:43 +0000
Date:   Thu, 11 Aug 2022 10:20:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <YvS727RgUrpR4ueT@dhcp22.suse.cz>
References: <20220325122559.14251-1-mhocko@kernel.org>
 <Yj28gjonUa9+0yae@dhcp22.suse.cz>
 <20220325164856.GA16800@lst.de>
 <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz>
 <YupFSpXOrcfXJNya@dhcp22.suse.cz>
 <20220811072817.GB13886@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811072817.GB13886@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-08-22 09:28:17, Christoph Hellwig wrote:
> On Wed, Aug 03, 2022 at 11:52:10AM +0200, Michal Hocko wrote:
> > OK, so I have another machine spewing this warning. Still on an older
> > kernel but I do not think the current upstream would be any different in
> > that regards. This time the DMA zone is populated and consumed from
> > large part and the pool size request is just too large for it:
> 
> I can't really parse the last sentence.  What does "consumed from large
> part" mean here?

Meminfo part says
Node 0 DMA free:160kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB

So the zone has 15MB of managed memory (by the page allocator), yet only
160kB is free early boot during the allocation. So it is mostly consumed
by somebody. I haven't really checked by whom.

Does that exaplain the above better?
-- 
Michal Hocko
SUSE Labs
