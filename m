Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D21E529B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbiEQHwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiEQHwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:52:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952813336C;
        Tue, 17 May 2022 00:52:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 096EA21F58;
        Tue, 17 May 2022 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652773959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Ld3gfS/GkRdwRqnbgW3T6n5zLeUyB6RrpS/DHnDz9I=;
        b=yembhjILv7EzLAVzkuhekIlyZw8FSiu18w6aWNDYb9qjtPjCvk6EavjIOduCYKcIxeltBT
        24vuYynDeGNim7Qx+kS8hvBH/1N4R7jSf/u0xSID/ChWtewkAXJD4NQMZnBDN6jqILEDQe
        BAMM/3dtgzmmq83eFo69woW6YHgdP5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652773959;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Ld3gfS/GkRdwRqnbgW3T6n5zLeUyB6RrpS/DHnDz9I=;
        b=1vDhTW5q004P0rbkJDzYq0PtFSUKwj2JDXPGvVt/C9GJs8r6Y4mxsGaiHqrTCJaiI5OsI/
        EZ9+GC2K3D0wG0Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B0E613305;
        Tue, 17 May 2022 07:52:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rruwC0ZUg2LEAgAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 17 May 2022 07:52:38 +0000
Date:   Tue, 17 May 2022 09:52:36 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v12 4/7] mm: hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Message-ID: <YoNURLcKtffT+5BH@localhost.localdomain>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
 <20220516102211.41557-5-songmuchun@bytedance.com>
 <YoIptjs65NgT1/ed@localhost.localdomain>
 <YoI9pdLzB/V9Kw1y@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoI9pdLzB/V9Kw1y@FVFYT0MHHV2J.usts.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 08:03:49PM +0800, Muchun Song wrote:
> On Mon, May 16, 2022 at 12:38:46PM +0200, Oscar Salvador wrote:
> > On Mon, May 16, 2022 at 06:22:08PM +0800, Muchun Song wrote:
> > > --- a/mm/sparse.c
> > > +++ b/mm/sparse.c
> > > @@ -913,6 +913,13 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> > >  	ms = __nr_to_section(section_nr);
> > >  	set_section_nid(section_nr, nid);
> > >  	__section_mark_present(ms, section_nr);
> > > +	/*
> > > +	 * Mark whole section as non-optimizable once there is a subsection
> > > +	 * whose vmemmap pages are allocated from alternative allocator. The
> > > +	 * early section is always optimizable.
> > > +	 */
> > > +	if (!early_section(ms) && altmap)
> > > +		section_mark_cannot_optimize_vmemmap(ms);
> > 
> > Because no one expects those sections to be removed?
> > IIRC, early_section + altmap only happened in case of sub-section pmem
> > scenario?
> 
> Right. The commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> has more information.
> 
> > I guess my question is: can we really have early_sections coming
> > from alternative allocator?
> >
> 
> We can't. The early section does not consider partially being
> populated currently.

Then, IIUC, we can forget about the early_section() check?


-- 
Oscar Salvador
SUSE Labs
