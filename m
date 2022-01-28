Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABBB49F36C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346329AbiA1GS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:18:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37838 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346348AbiA1GS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:18:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F156F1F391;
        Fri, 28 Jan 2022 06:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643350704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMfToN4L0dUMr2pJfbRWuj6YwPTswSuGxOhHjizvdP4=;
        b=xTDlbNa5sfjQgAp30gVh31W3sRMfFsNBGIMgMh2rkM65NDInx5esFQvM61Ncntsv3sCF3V
        qVQsyOqLbitDDTQ73RjBZ+cT702pRtEcICtPwgCZ5FxFq9u9W3qIfxORtZ0e1teuxH6MgG
        680fJM/n6JMrjR9IXy5ftTvT4yWKIok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643350704;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMfToN4L0dUMr2pJfbRWuj6YwPTswSuGxOhHjizvdP4=;
        b=f9Hqjfq490G0ny3/Yvb4n89c5XFRWqpJejBR0xMPtjVCibneueSnpyQ4jw+NbMai2lrpZI
        +oFQxce9r94fyCAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E03E113671;
        Fri, 28 Jan 2022 06:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o36ONrCK82FeLgAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 28 Jan 2022 06:18:24 +0000
MIME-Version: 1.0
Date:   Fri, 28 Jan 2022 07:18:24 +0100
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
Subject: Re: [PATCH 1/6] mm, memory_hotplug: make arch_alloc_nodedata
 independent on CONFIG_MEMORY_HOTPLUG
In-Reply-To: <20220127085305.20890-2-mhocko@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-2-mhocko@kernel.org>
User-Agent: Roundcube Webmail
Message-ID: <8a4e5e8981ed3b1b7860273991f1da7b@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-27 09:53, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> This is a preparatory patch and it doesn't introduce any functional
> change. It merely pulls out arch_alloc_nodedata (and co) outside of
> CONFIG_MEMORY_HOTPLUG because the following patch will need to call 
> this
> from the generic MM code.
> 
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs
