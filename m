Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E243B46BECE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbhLGPNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:13:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238661AbhLGPNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638889785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R245khe8xk07RNyH0EVz6ZGFqepWH2fvgXb9UQjIJSY=;
        b=CR+8PHTXpsImIqg9FMwxImFH/Rzxqrf/Y1Ajl9qmMIy/o8OkPuH9aozlf/4udNHQMgC/Wg
        rGN27mYBpql+qGtWTybV4c8MpjdPXHFeE8F1gbsGlgaLsHi38jYnwxcszM/45j7NPsCKa3
        ldlSV72oDsRblsT3tm90QAoPDIwcSpg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-by5SCjUDPI2vtws_qjfChw-1; Tue, 07 Dec 2021 10:09:42 -0500
X-MC-Unique: by5SCjUDPI2vtws_qjfChw-1
Received: by mail-wr1-f71.google.com with SMTP id d3-20020adfa343000000b0018ed6dd4629so3083979wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 07:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=R245khe8xk07RNyH0EVz6ZGFqepWH2fvgXb9UQjIJSY=;
        b=omNjThtgIc6gCeiBknYnBe+e6rrZQqhPP5woFtF+qheECCoTJTaoKncNxiXaIyNEG9
         s+mZBM28CDSe88g9S6TrUg9RNiBvk108K6Vy8UEFcHtOAYpKLDlGUdRocKZyAafBdloI
         pYVogVDNyhTUUgk8kIiCj55QcEMdkI6C9nqdTx4nEFsT2t7BbHdbCKxiRdHokMNLmjRP
         IkMsebyVIv+0Tnu7kYGBlC3haRTwZ7cfrPplxIYiY48Vw1koZEz/lM4S6daO7Bvckccq
         wC1cyTGhe3kAlcCVylaYJA93dHDoGFSuN5BYW4wi33iLMmU1F1vv1BcNWKPpg/IHMH+o
         Gj6g==
X-Gm-Message-State: AOAM530C/O37uoJ6OuuNw9Mn0RVjpfaEBwYAe6NnqcjOJu+MTtNoN40r
        HUj0SYj+qeiHvCer/wW9YPFK4YBD7rnPJlRudkobQqkflUYvcP2Jk6/FBZbjg9kVsWI6nSVoK+a
        NdXuVlWjY2CwI3qoWN2aWjMB4
X-Received: by 2002:adf:df0b:: with SMTP id y11mr50895479wrl.181.1638889781562;
        Tue, 07 Dec 2021 07:09:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXXWyseqL9/W2Gvac7QFnbIgZaUx6fF5pn8ANZ1qKu/BbVDPYxGE2dYV1lAqjltt8gZjUXuw==
X-Received: by 2002:adf:df0b:: with SMTP id y11mr50895445wrl.181.1638889781333;
        Tue, 07 Dec 2021 07:09:41 -0800 (PST)
Received: from [192.168.3.132] (p4ff23e57.dip0.t-ipconnect.de. [79.242.62.87])
        by smtp.gmail.com with ESMTPSA id m17sm14723297wrz.22.2021.12.07.07.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 07:09:40 -0800 (PST)
Message-ID: <77e785e6-cf34-0cff-26a5-852d3786a9b8@redhat.com>
Date:   Tue, 7 Dec 2021 16:09:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] mm: fix panic in __alloc_pages
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <YYrGpn/52HaLCAyo@fedora> <YYrSC7vtSQXz652a@dhcp22.suse.cz>
 <BAE95F0C-FAA7-40C6-A0D6-5049B1207A27@vmware.com>
 <YZN3ExwL7BiDS5nj@dhcp22.suse.cz>
 <5239D699-523C-4F0C-923A-B068E476043E@vmware.com>
 <YZYQUn10DrKhSE7L@dhcp22.suse.cz> <Ya89aqij6nMwJrIZ@dhcp22.suse.cz>
 <1043a1a4-b7f2-8730-d192-7cab9f15ee24@redhat.com>
 <Ya9P5NxhcZDcyptT@dhcp22.suse.cz>
 <ab5cfba0-1d49-4e4d-e2c8-171e24473c1b@redhat.com>
 <Ya9gN3rZ1eQou3rc@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Ya9gN3rZ1eQou3rc@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.21 14:23, Michal Hocko wrote:
> On Tue 07-12-21 13:28:31, David Hildenbrand wrote:
> [...]
>> But maybe I am missing something important regarding online vs. offline
>> nodes that your patch changes?
> 
> I am relying on alloc_node_data setting the node online. But if we are
> to change the call to arch_alloc_node_data then the patch needs to be
> more involved. Here is what I have right now. If this happens to be the
> right way then there is some additional work to sync up with the hotplug
> code.
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5952749ad40..a296e934ad2f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8032,8 +8032,23 @@ void __init free_area_init(unsigned long *max_zone_pfn)
>  	/* Initialise every node */
>  	mminit_verify_pageflags_layout();
>  	setup_nr_node_ids();
> -	for_each_online_node(nid) {
> -		pg_data_t *pgdat = NODE_DATA(nid);
> +	for_each_node(nid) {
> +		pg_data_t *pgdat;
> +
> +		if (!node_online(nid)) {
> +			pr_warn("Node %d uninitialized by the platform. Please report with memory map.\n", nid);
> +			pgdat = arch_alloc_nodedata(nid);
> +			pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
> +			arch_refresh_nodedata(nid, pgdat);
> +			node_set_online(nid);

Setting all possible nodes online might result in quite some QE noice,
because all these nodes will then be visible in the sysfs and
try_offline_nodes() is essentially for the trash.

I agree to prealloc the pgdat, I don't think we should actually set the
nodes online. Node onlining/offlining should be done when we do have
actual CPUs/memory populated.

-- 
Thanks,

David / dhildenb

