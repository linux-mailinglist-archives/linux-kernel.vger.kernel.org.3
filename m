Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634544B0C70
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbiBJLfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:35:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbiBJLfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:35:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC61001
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 03:35:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8FF211F37B;
        Thu, 10 Feb 2022 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644492919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANTjimFiWNIfsY0w4OX0/8i+2aewvIuwbua8f0UJFaI=;
        b=lRmymzO2d51OA3bDvHKy/IPvIcnTe/YIDfHvRvNd2SaAKZl+VxoIMuonUb4MFFQ66D9s79
        ew7b9QeF2fJ4LHcXYXtQ+rby0FHOWRQZYDMaa+IMkRt4G5Y4wqSdPEUTmUWa9HVR/c2nU1
        AqA0yrEKgoARlY/VpQLy1HOXLZKjN3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644492919;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANTjimFiWNIfsY0w4OX0/8i+2aewvIuwbua8f0UJFaI=;
        b=Cy1VlFzFsoqm953pN7vhg6u7WCNGOP1U4Df40zX0qyJh1yO6f05c8LFuziuiYVEHZHYJ0y
        T0t6BkinF91SSGAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57F6913B53;
        Thu, 10 Feb 2022 11:35:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hCLHFHf4BGKTEgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Feb 2022 11:35:19 +0000
Message-ID: <1699e1b3-0508-4561-a7ec-052f382ca3c8@suse.cz>
Date:   Thu, 10 Feb 2022 12:35:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
 <2b5eee76-183f-bd97-2e9d-f5ff8df63db@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 02/13] mm/munlock: delete FOLL_MLOCK and FOLL_POPULATE
In-Reply-To: <2b5eee76-183f-bd97-2e9d-f5ff8df63db@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/22 22:32, Hugh Dickins wrote:
> If counting page mlocks, we must not double-count: follow_page_pte() can
> tell if a page has already been Mlocked or not, but cannot tell if a pte
> has already been counted or not: that will have to be done when the pte
> is mapped in (which lru_cache_add_inactive_or_unevictable() already tracks
> for new anon pages, but there's no such tracking yet for others).
> 
> Delete all the FOLL_MLOCK code - faulting in the missing pages will do
> all that is necessary, without special mlock_vma_page() calls from here.
> 
> But then FOLL_POPULATE turns out to serve no purpose - it was there so
> that its absence would tell faultin_page() not to faultin page when
> setting up VM_LOCKONFAULT areas; but if there's no special work needed
> here for mlock, then there's no work at all here for VM_LOCKONFAULT.
> 
> Have I got that right?  I've not looked into the history, but see that
> FOLL_POPULATE goes back before VM_LOCKONFAULT: did it serve a different
> purpose before?  Ah, yes, it was used to skip the old stack guard page.
> 
> And is it intentional that COW is not broken on existing pages when
> setting up a VM_LOCKONFAULT area?  I can see that being argued either
> way, and have no reason to disagree with current behaviour.

Yeah I think it's consistent with the two usecases stated for VM_LOCKONFAULT:
https://lore.kernel.org/all/1441720742-7803-1-git-send-email-emunson@akamai.com/

> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
