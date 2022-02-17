Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1244B9A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbiBQHtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:49:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbiBQHtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:49:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F014D27F29A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645084137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pdAg90pUxF/1MvitVVB0BXYLg+OihYbOUilPPPcMHmA=;
        b=XC7HvrXHVp1kw6JM5ZLtBJJX1bKyS6Tj78xRxGGE2IQJaHGUPZaOlpCoqT9wfFnsaXebxe
        B/Sbyzn+0wM9numjFZguOg/xSfQcxH2+fb8ZyipC37QS/K8dnMu+i10LVNxDUz4yN8CzPg
        88krr2RbbXKRLpgzHkCPdayVZtQbyBE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-Jjsow2NeONe1qPZ5_XFJbg-1; Thu, 17 Feb 2022 02:48:55 -0500
X-MC-Unique: Jjsow2NeONe1qPZ5_XFJbg-1
Received: by mail-ed1-f71.google.com with SMTP id y13-20020aa7c24d000000b00411925b7829so2867932edo.22
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=pdAg90pUxF/1MvitVVB0BXYLg+OihYbOUilPPPcMHmA=;
        b=GwDceiamDH+HBl1R3Om209lBHKHb6gLGQKMFuch/w5ceX0jz+uf98+vWxREIO2Xwxl
         0Pj5ce7jgUqsKEUqApj43SBrj9btGgYjUnUP5zBJwCHu5YAjzv+IyFGZjasDd2UgtZn4
         RnYrudAdfCFkkUajjf1geQf36UpT8oa8WSgoB311HoiSjrZLbLg5HKsNogSGT+IcJZF6
         DVY04Tz4qYtP58/APp9MNDbMNDzr60Gax0ulmix4uU8CJOzTnLA9GuLh/TmZzOuOx6/p
         GcqnKOgt9Rh4dOkUQ+euhaDVrnJuhwFc/J/LqwO1Oj1G01Ub9TUy+hPrkQMK7p4LlM5C
         MwZw==
X-Gm-Message-State: AOAM530u688NenGg7T3Euv5bjiq9wSDmS3rSQ5EfcobpligeL32DYYYN
        IOc1uOEFlwe/LbNNXW2Jsh5We0VCchqSTiIxbsNvtjcVHnjw8RDkW+TASccVE/c1FCeEh5uA/U6
        x2Hkub0ofG6XR5CZeoh8PmSby
X-Received: by 2002:a17:906:2a1b:b0:6ce:a15b:a561 with SMTP id j27-20020a1709062a1b00b006cea15ba561mr1401060eje.403.1645084134108;
        Wed, 16 Feb 2022 23:48:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxVRA0gZHCxAgTIvc/bzkL1W2xJ8UxU08IwpSm4JuYYAe+CPYKxstWgqdBgzO7BNytpAy/Ig==
X-Received: by 2002:a17:906:2a1b:b0:6ce:a15b:a561 with SMTP id j27-20020a1709062a1b00b006cea15ba561mr1401050eje.403.1645084133820;
        Wed, 16 Feb 2022 23:48:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c711:b800:254c:2d22:aab2:20a? (p200300cbc711b800254c2d22aab2020a.dip0.t-ipconnect.de. [2003:cb:c711:b800:254c:2d22:aab2:20a])
        by smtp.gmail.com with ESMTPSA id q14sm2885329edd.54.2022.02.16.23.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 23:48:53 -0800 (PST)
Message-ID: <a52c6fff-cf25-2ff1-ab96-41c934eff91d@redhat.com>
Date:   Thu, 17 Feb 2022 08:48:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm/pages_alloc.c: Don't create ZONE_MOVABLE beyond the
 end of a node
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org
Cc:     jhubbard@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ziy@nvidia.com
References: <20220215025831.2113067-1-apopple@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220215025831.2113067-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.02.22 03:58, Alistair Popple wrote:
> ZONE_MOVABLE uses the remaining memory in each node. It's starting pfn
> is also aligned to MAX_ORDER_NR_PAGES. It is possible for the remaining
> memory in a node to be less than MAX_ORDER_NR_PAGES, meaning there is
> not enough room for ZONE_MOVABLE on that node.
> 
> Unfortunately this condition is not checked for. This leads to
> zone_movable_pfn[] getting set to a pfn greater than the last pfn in a
> node.
> 
> calculate_node_totalpages() then sets zone->present_pages to be greater
> than zone->spanned_pages which is invalid, as spanned_pages represents
> the maximum number of pages in a zone assuming no holes.
> 
> Subsequently it is possible free_area_init_core() will observe a zone of
> size zero with present pages. In this case it will skip setting up the
> zone, including the initialisation of free_lists[].
> 
> However populated_zone() checks zone->present_pages to see if a zone has
> memory available. This is used by iterators such as
> walk_zones_in_node(). pagetypeinfo_showfree() uses this to walk the
> free_list of each zone in each node, which are assumed to be initialised
> due to the zone not being empty. As free_area_init_core() never
> initialised the free_lists[] this results in the following kernel crash
> when trying to read /proc/pagetypeinfo:
> 
> [   67.534914] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   67.535429] #PF: supervisor read access in kernel mode
> [   67.535789] #PF: error_code(0x0000) - not-present page
> [   67.536128] PGD 0 P4D 0
> [   67.536305] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
> [   67.536696] CPU: 0 PID: 456 Comm: cat Not tainted 5.16.0 #461
> [   67.537096] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> [   67.537638] RIP: 0010:pagetypeinfo_show+0x163/0x460
> [   67.537992] Code: 9e 82 e8 80 57 0e 00 49 8b 06 b9 01 00 00 00 4c 39 f0 75 16 e9 65 02 00 00 48 83 c1 01 48 81 f9 a0 86 01 00 0f 84 48 02 00 00 <48> 8b 00 4c 39 f0 75 e7 48 c7 c2 80 a2 e2 82 48 c7 c6 79 ef e3 82
> [   67.538259] RSP: 0018:ffffc90001c4bd10 EFLAGS: 00010003
> [   67.538259] RAX: 0000000000000000 RBX: ffff88801105f638 RCX: 0000000000000001
> [   67.538259] RDX: 0000000000000001 RSI: 000000000000068b RDI: ffff8880163dc68b
> [   67.538259] RBP: ffffc90001c4bd90 R08: 0000000000000001 R09: ffff8880163dc67e
> [   67.538259] R10: 656c6261766f6d6e R11: 6c6261766f6d6e55 R12: ffff88807ffb4a00
> [   67.538259] R13: ffff88807ffb49f8 R14: ffff88807ffb4580 R15: ffff88807ffb3000
> [   67.538259] FS:  00007f9c83eff5c0(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [   67.538259] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   67.538259] CR2: 0000000000000000 CR3: 0000000013c8e000 CR4: 0000000000350ef0
> [   67.538259] Call Trace:
> [   67.538259]  <TASK>
> [   67.538259]  seq_read_iter+0x128/0x460
> [   67.538259]  ? aa_file_perm+0x1af/0x5f0
> [   67.538259]  proc_reg_read_iter+0x51/0x80
> [   67.538259]  ? lock_is_held_type+0xea/0x140
> [   67.538259]  new_sync_read+0x113/0x1a0
> [   67.538259]  vfs_read+0x136/0x1d0
> [   67.538259]  ksys_read+0x70/0xf0
> [   67.538259]  __x64_sys_read+0x1a/0x20
> [   67.538259]  do_syscall_64+0x3b/0xc0
> [   67.538259]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   67.538259] RIP: 0033:0x7f9c83e23cce
> [   67.538259] Code: c0 e9 b6 fe ff ff 50 48 8d 3d 6e 13 0a 00 e8 c9 e3 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
> [   67.538259] RSP: 002b:00007fff116e1a08 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [   67.538259] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f9c83e23cce
> [   67.538259] RDX: 0000000000020000 RSI: 00007f9c83a2c000 RDI: 0000000000000003
> [   67.538259] RBP: 00007f9c83a2c000 R08: 00007f9c83a2b010 R09: 0000000000000000
> [   67.538259] R10: 00007f9c83f2d7d0 R11: 0000000000000246 R12: 0000000000000000
> [   67.538259] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
> [   67.538259]  </TASK>
> 
> Fix this by checking that the aligned zone_movable_pfn[] does not exceed
> the end of the node, and if it does skip creating a movable zone on this
> node.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Fixes: 2a1e274acf0b ("Create the ZONE_MOVABLE zone")
> ---
>  mm/page_alloc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6d31..a1fbf656e7db 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7972,10 +7972,17 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>  
>  out2:
>  	/* Align start of ZONE_MOVABLE on all nids to MAX_ORDER_NR_PAGES */
> -	for (nid = 0; nid < MAX_NUMNODES; nid++)
> +	for (nid = 0; nid < MAX_NUMNODES; nid++) {
> +		unsigned long start_pfn, end_pfn;
> +
>  		zone_movable_pfn[nid] =
>  			roundup(zone_movable_pfn[nid], MAX_ORDER_NR_PAGES);
>  
> +		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> +		if (zone_movable_pfn[nid] >= end_pfn)
> +			zone_movable_pfn[nid] = 0;
> +	}
> +
>  out:
>  	/* restore the node_state */
>  	node_states[N_MEMORY] = saved_node_state;


Sounds plausible for me

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

