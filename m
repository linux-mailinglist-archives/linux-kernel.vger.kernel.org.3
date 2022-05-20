Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D530B52EC08
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349134AbiETMXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349273AbiETMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:23:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B00316498F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:23:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5BF621BD8;
        Fri, 20 May 2022 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653049379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C55mA7Gcdj6mV5Wh6tOYntZbioSd1fH8dLwGmuS/9aw=;
        b=h6D0ikPKhhJQ2bvLnSJWEQNqQ/s1NiEdAOK4vk3m/DR9/sNKkX/hZ2xRsaNmAhib7rypXR
        7OzYKcPQG55MzIw2/LniYnQNChudwQ7wpP6zDuAkvlVWSMlGaMcxwmcdS+usHfrBjeCCty
        x26oNmmTKBvysdApyUmNqwlmO0GeUy8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653049379;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C55mA7Gcdj6mV5Wh6tOYntZbioSd1fH8dLwGmuS/9aw=;
        b=EM51IkLUUliO6PAFaRMUPUHvBxvMqTA4Aag1UCKGtUvCjCmVuQAjiGqg6Dc7yxrn/mkvUz
        ziJtrOh8Hc/uFjBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8125F13AF4;
        Fri, 20 May 2022 12:22:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DMqzHiOIh2JpRAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 20 May 2022 12:22:59 +0000
Message-ID: <408b79d9-e96a-b961-1565-93bf11e54909@suse.cz>
Date:   Fri, 20 May 2022 14:22:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        =?UTF-8?Q?Jakub_Mat=c4=9bna?= <matenajakub@gmail.com>
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, riel@surriel.com,
        rostedt@goodmis.org, peterz@infradead.org, david@redhat.com
References: <20220516125405.1675-1-matenajakub@gmail.com>
 <20220517164403.nabrtbkezex7uof4@box.shutemov.name>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH v3 0/6] Removing limitations of merging anonymous VMAs
In-Reply-To: <20220517164403.nabrtbkezex7uof4@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 18:44, Kirill A. Shutemov wrote:
> On Mon, May 16, 2022 at 02:53:59PM +0200, Jakub Matěna wrote:
>> This is a series of patches that try to improve merge success rate when
>> VMAs are being moved, resized or otherwise modified.
>> 
>> Motivation
>> In the current kernel it is impossible to merge two anonymous VMAs
>> if one of them was moved. That is because VMA's page offset is
>> set according to the virtual address where it was created and in
>> order to merge two VMAs page offsets need to follow up.
>> Another problem when merging two faulted VMA's is their anon_vma. In
>> current kernel these anon_vmas have to be the one and the same.
>> Otherwise merge is again not allowed.
>> There are several places from which vma_merge() is called and therefore
>> several use cases that might profit from this upgrade. These include
>> mmap (that fills a hole between two VMAs), mremap (that moves VMA next
>> to another one or again perfectly fills a hole), mprotect (that modifies
>> protection and allows merging with a neighbor) and brk (that expands VMA
>> so that it is adjacent to a neighbor).
>> Missed merge opportunities increase the number of VMAs of a process
>> and in some cases can cause problems when a max count is reached.
> 
> Hm. You are talking about missed opportunities, but do you know any
> workload that would measurably benefit from the change?

We do know about a workload that originally inspired this investigation of
feasibility, but it's proprietary and will take a while to evaluate the
benefits there. We did hope that a public RFC could lead to discovering
others that also have a workload that would benefit, and might currently use
some userspace workarounds due to the existing limitations.

> The changes are not trivial. And rmap code is complex enough as it is.

True, it was one of the goals, to see how complex exactly it would be. And
an opportunity to better document related parts of mm as part of the master
thesis :)

> I expect common cases to get slower due to additional checks that do not
> result in more merges.

Stats so far have shown that merges that this enables did happen, only a few
percent cases didn't. Of course for many workloads the extra merges will not
bring much benefit. One possibility is to introduce an opt-in mode (prctl or
madvise?) for workloads that know they would benefit.

> I donno, the effort looks dubious to me as of now.
 At least patches 1+2 could be considered immediately, as they don't bring
extra complexity.

A related issue which was brought to our attention is that current mremap()
implementation doesn't work on a range that spans multiple vma's. The
multiple vma's may be result of the current insufficient merging, or
otherwise. And it's tedious for userspace to discover the boundaries from
/proc/pid/maps to guide a mremap() vma by vma. More sucessful merging would
thus help, but it should be also possible to improve the mremap()
implementation, which shouldn't be as complex...
