Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD23B4B11B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243637AbiBJPaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:30:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243625AbiBJPad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:30:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C831B3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:30:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C54C61F399;
        Thu, 10 Feb 2022 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644507032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MVgiEFREX1O1RYr6L2jCxGTAckkdJ9S53te9ojdXMrg=;
        b=lJ2hJJ/ssfwaFl5Y+SGMKdqm8MB1iZd7YZYRIbgYCxyTD4gPuC3rV1QLMxiYomPDM81eFc
        LNwUKRogHiDRwiyAgdKwja8RKa1P4crhLW3kOCPL/M5HXuuZNUvImRAWoL+uer+9HT4Xq+
        +pm0PCRNiSzHh0YfucZnb+LIWA6M2SY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644507032;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MVgiEFREX1O1RYr6L2jCxGTAckkdJ9S53te9ojdXMrg=;
        b=hCNfQ8iprhyVXleHcSrGsA+pH/OtngQHdhcVn8spqhNvHrmcW00NaC6OTbgrWFjQkOIIRW
        cSSvo9ycF7rbR5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77D0013BD6;
        Thu, 10 Feb 2022 15:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iyynG5gvBWILFAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Feb 2022 15:30:32 +0000
Message-ID: <5363cc40-e4ae-d1fd-9f94-fc61811e70ac@suse.cz>
Date:   Thu, 10 Feb 2022 16:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 03/13] mm/munlock: delete munlock_vma_pages_all(), allow
 oomreap
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
 <8dddb3d4-361-da5-538-3f3ae1b326b@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <8dddb3d4-361-da5-538-3f3ae1b326b@google.com>
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

On 2/6/22 22:34, Hugh Dickins wrote:
> munlock_vma_pages_range() will still be required, when munlocking but
> not munmapping a set of pages; but when unmapping a pte, the mlock count
> will be maintained in much the same way as it will be maintained when
> mapping in the pte.  Which removes the need for munlock_vma_pages_all()
> on mlocked vmas when munmapping or exiting: eliminating the catastrophic
> contention on i_mmap_rwsem, and the need for page lock on the pages.
> 
> There is still a need to update locked_vm accounting according to the
> munmapped vmas when munmapping: do that in detach_vmas_to_be_unmapped().
> exit_mmap() does not need locked_vm updates, so delete unlock_range().
> 
> And wasn't I the one who forbade the OOM reaper to attack mlocked vmas,
> because of the uncertainty in blocking on all those page locks?
> No fear of that now, so permit the OOM reaper on mlocked vmas.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
