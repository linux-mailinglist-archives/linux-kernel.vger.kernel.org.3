Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587A549F7C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347972AbiA1LBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:01:40 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53360 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiA1LBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:01:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2354C212BB;
        Fri, 28 Jan 2022 11:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643367698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37Gsm1IqUIMRo4Ici9RHiEuf636sDOjp3AogAz570Po=;
        b=cEk3twzyuE6Nz+5y6wQg/HcYfRSOj4+j9PVbl1sf4M9PNND4lTW7+JO1UDKH8YgtLtRIjP
        ymZiBLT+5NIDKxB8wWjyllHQskNs0HB3GJ7cZ5JlmIRkwo1cYBy3X7TEsaZ6G0E5ffm/6n
        z9S8K6wMNjRXoF6g2VR80n7h05FucOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643367698;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37Gsm1IqUIMRo4Ici9RHiEuf636sDOjp3AogAz570Po=;
        b=4nK/NldkHONsuvlQ6D0XMHMjLKSP1YNEu5IdYj4NrjoZ33MCyaV9259pv6JrrvnFA4m+5F
        T5iCIAz3iho0+CAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D9B813A83;
        Fri, 28 Jan 2022 11:01:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S7O7AhLN82HzLAAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 28 Jan 2022 11:01:38 +0000
MIME-Version: 1.0
Date:   Fri, 28 Jan 2022 12:01:37 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 6/6] memcg: do not tweak node in
 alloc_mem_cgroup_per_node_info
In-Reply-To: <20220127085305.20890-7-mhocko@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-7-mhocko@kernel.org>
User-Agent: Roundcube Webmail
Message-ID: <b2ec940495fe4480bab793707bd6558f@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-27 09:53, Michal Hocko wrote:
> From: Wei Yang <richard.weiyang@gmail.com>
> 
> alloc_mem_cgroup_per_node_info is allocated for each possible node and
> this used to be a problem because not !node_online nodes didn't have
> appropriate data structure allocated. This has changed by "mm: handle
> uninitialized numa nodes gracefully" so we can drop the special casing
> here.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs
