Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE1955131C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbiFTIoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbiFTIop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:44:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C31E9A;
        Mon, 20 Jun 2022 01:44:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D5CFC1F383;
        Mon, 20 Jun 2022 08:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655714682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMXO29bS5Q5WlYmqVACMoUiiETrgWHmM6SWuoP7+kKk=;
        b=lP9zx3xPKJLxlJpBtp1BMFWIfqYN19uwvucIIYapP9tnNRt001tMLdLVdX5Auq/B7OpdNK
        ICULE3T252YKMFmyGXMaiBHQu0D+Y3wbC8hgjCjiuKFLfO+ysv3XMJJdGlyQRk5CmGh6z5
        IheflEFXNcTl67Nohect5VcFvKupEV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655714682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMXO29bS5Q5WlYmqVACMoUiiETrgWHmM6SWuoP7+kKk=;
        b=OXh9d08JY4cPZuhYh4bghTRS6B4Iaz6hpajRV8YXITxOpgsVKp5mBAdN5nBqdtYrSM3eP2
        Ms1Tw9nvVP1aWLAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3796313638;
        Mon, 20 Jun 2022 08:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7mreCnozsGLQLAAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 20 Jun 2022 08:44:42 +0000
Date:   Mon, 20 Jun 2022 10:44:40 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        corbet@lwn.net, mike.kravetz@oracle.com, paulmck@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v4 2/2] mm: memory_hotplug: make hugetlb_optimize_vmemmap
 compatible with memmap_on_memory
Message-ID: <YrAzeHbYt1mAs9ue@localhost.localdomain>
References: <20220619133851.68184-1-songmuchun@bytedance.com>
 <20220619133851.68184-3-songmuchun@bytedance.com>
 <YrAgUtV6wD6CIrad@FVFYT0MHHV2J.usts.net>
 <226243a9-b4f5-182e-1a5b-7b8d5c28f3b3@redhat.com>
 <YrAv18GnMOcQaAxz@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrAv18GnMOcQaAxz@FVFYT0MHHV2J.usts.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 04:29:11PM +0800, Muchun Song wrote:
> > > Although it works, I think PageVmemmapSelfHosted() check for the 1st pfn's
> > > vmemmap page is not always reliable.  Since we reused PG_owner_priv_1
> > > as PG_vmemmap_self_hosted, the test is noly reliable for vmemmap page's
> > > vmemmap page.  Other non-vmemmap page can be flagged with PG_owner_priv_1.
> > > So this check can be false-positive. Maybe the following code snippet is
> > > the solution.
> > 
> > How could that happen for pages used for backing a vmemmap?
> >
> 
> It cannot happen for memmap_on_memory case. Howwver, it can happen for other
> cases. E.g. the 1st pfn (of boot memory block) whose vmemmap page may be flagged
> as PG_owner_priv_1 (if PG_swapcache is set). Then, the check is false-positive.

If this can really happen, which I am not that sure tbh, maybe a way out would be
to just define a new page-type as we did in previous versions of memmap_on_memory.
In that way we would not for flags, but for its type.

But as I said, I am not entirely sure about the potential fallout of what you mention.


-- 
Oscar Salvador
SUSE Labs
