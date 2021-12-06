Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2B2469903
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344362AbhLFOeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:34:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33054 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242092AbhLFOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:34:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB88A1FD34;
        Mon,  6 Dec 2021 14:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638801037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tN/iqyWnZru3JPCqJs6+9C/FsJPPKztl4fqJS+TgZEU=;
        b=T8dxQvhnLxUvNVroAo8OR3e6lzhpkWbisHOZNfzGdFkvq4Z3XAuyAaq5n682R1ShMKhJ/2
        DR+52p17iI2WvMglfCoQLPpDKc/F+zr/TjEeGTFrI+OUZKOm/6h1W/qs4S2vymxd6vG21E
        S5TbbaFhv248V1NYRvxJ1oZ+w5cUdp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638801037;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tN/iqyWnZru3JPCqJs6+9C/FsJPPKztl4fqJS+TgZEU=;
        b=y46nzwhgTF9jWtbtOXbB4eGojstljE6z9LHzv5wNqbyJgCkbgbX6LFBgWKYMO8qKYrfd/V
        vCpg9N8syivM6MCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4B5713C32;
        Mon,  6 Dec 2021 14:30:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YwqUJ40ermFVPAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 06 Dec 2021 14:30:37 +0000
Message-ID: <f2c695f0-9621-a7be-82c3-8850dc8ca3e3@suse.cz>
Date:   Mon, 6 Dec 2021 15:30:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vdavydov.dev@gmail.com, raquini@redhat.com
References: <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
 <Ya3r3C/OpnK7OBPt@dhcp22.suse.cz>
 <840cb3d0-61fe-b6cb-9918-69146ba06cf7@redhat.com>
 <Ya3yZWkj2wGRWDMz@dhcp22.suse.cz>
 <51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com>
 <Ya4K0+XCmv3NBmwQ@dhcp22.suse.cz>
 <05157de4-e5df-11fc-fc46-8a9f79d0ddb4@redhat.com>
 <Ya4Y07Iu2ygj5zwZ@dhcp22.suse.cz>
 <d4f281e6-1999-a3de-b879-c6ca6a25ae67@redhat.com>
 <Ya4cUQpLJHnm3jyK@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
In-Reply-To: <Ya4cUQpLJHnm3jyK@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/21 15:21, Michal Hocko wrote:
> On Mon 06-12-21 15:08:10, David Hildenbrand wrote:
>> 
>> >> But there might be more missing. Onlining a new zone will get more
>> >> expensive in setups with a lot of possible nodes (x86-64 shouldn't
>> >> really be an issue in that regard).
>> > 
>> > Honestly, I am not really concerned by platforms with too many nodes
>> > without any memory. If they want to shoot their feet then that's their
>> > choice. We can optimize for those if they ever prove to be standar.
>> >  
>> >> If we want stable backports, we'll want something simple upfront.
>> > 
>> > For stable backports I would be fine by doing your NODE_DATA check in
>> > the allocator. In upstream I think we should be aiming for a more robust
>> > solution that is also easier to maintain further down the line. Even if
>> > that is an investment at this momemnt because the initialization code is
>> > a mess.
>> > 
>> 
>> Agreed. I would be curious *why* we decided to dynamically allocate the
>> pgdat. is this just a historical coincidence or was there real reason to
>> not allocate it for all possible nodes during boot?
> 
> I don't know but if I was to guess the most likely explanation would be
> that the numa init code was in a similar order as now and it was easier
> to simply allocate a pgdat when a new one was onlined.
> 9af3c2dea3a3 ("[PATCH] pgdat allocation for new node add (call pgdat allocation)")
> doesn't really tell much.

I don't know if that's true for pgdat specifically, but generally IMHO the
advantages of allocating during/after online instead for each possible is
- memory savings when some possible node is actually never online
- at least in some cases, the allocations can be local to the node in
question where the advantages is
  - faster access
  - less memory occupied on nodes that are earlier online, especially node 0

So while the approach of allocate on boot for all possible nodes instead of
just online nodes has advantages of being generally safer and simpler (no
memory hotplug callbacks etc), we should also be careful not to overdo this
approach so we don't end up with Node 0 memory filled with structures used
for nodes 1-X that are just onlined later. I imagine that could be a problem
even for "sane" archs that don't have tons of possible, but offline nodes.

Concretely, pgdat should probably be fine, but things like all shrinkers?
Maybe less so.

