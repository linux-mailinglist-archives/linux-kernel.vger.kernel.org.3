Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E581458E760
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 08:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiHJGku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 02:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHJGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 02:40:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEDA61127
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 23:40:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A8BD37EA8;
        Wed, 10 Aug 2022 06:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660113643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TF9qkQ4HKALrlOe0bqxeqVLGWf0XkDPHOA6absoSUU8=;
        b=TQ5V2ram9Sy/U/dQ1+Qi0p6rBWXsR9MFymsIcZUb/kbkfrKot57G+IMLtDM0fxGNIWk5sk
        8Wx5hidMIAoOMycZx7Qn0lnD/nE/lgGheHBvjxJaPyi1URKStlQJY3kc1dc64EIE4WPxDU
        hUqZ1+CLW5WuXiy7N7nrfeBqbT29Hgk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 164DB13A7E;
        Wed, 10 Aug 2022 06:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /C2RAutS82KVPgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 10 Aug 2022 06:40:43 +0000
Date:   Wed, 10 Aug 2022 08:40:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <YvNS6iuWnoJjXin7@dhcp22.suse.cz>
References: <YuqNToCACD8kKBG+@MiWiFi-R3L-srv>
 <YuqOrJKcgfamdXkk@dhcp22.suse.cz>
 <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv>
 <YuqX0OAItlMDfRUV@dhcp22.suse.cz>
 <YuunCO2lsLDWTGw+@MiWiFi-R3L-srv>
 <Yuu1EyC95XL98XNI@dhcp22.suse.cz>
 <Yu0OWLbzLxCkSGVJ@MiWiFi-R3L-srv>
 <Yu1VTAxd9/jP/iEk@dhcp22.suse.cz>
 <YvJ/V2bor9Q3P6ov@dhcp22.suse.cz>
 <20220809183252.d168b5a8be31fff5aeef1b3e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809183252.d168b5a8be31fff5aeef1b3e@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-08-22 18:32:52, Andrew Morton wrote:
> On Tue, 9 Aug 2022 17:37:59 +0200 Michal Hocko <mhocko@suse.com> wrote:
> 
> > we have a system complainging about order-10 allocation for the DMA pool.
> > 
> 
> I'll add a cc:stable to this - if future users like the patch, so will
> current ones!

Technically speaking this is not a fix so I am not sure the stable tree
is really a great fit. On the other hand I am definitely going to
backport this to older SLES kernels because we have had at least 2
reports where this has been brought up for clarification.

That being said, no objection from me.

-- 
Michal Hocko
SUSE Labs
