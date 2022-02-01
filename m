Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F064A5552
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 03:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiBACl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiBAClz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:41:55 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE10C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:41:55 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id h7so49390376ejf.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o+aNazM92DpchyM2fptN7BUFRXkWjezucT0stoL0ipM=;
        b=Tcd/oRvHBzzZewL8wbSRs0n2QUG6q4SMMfSwuxSP4LVbmDVHyh4Ie7anUyNyxxW7Q4
         QswsnH0dFPkvXVyyGqDB/235lIqcPs9kXcuu4+dQXs8ywtHH82qMHQaW+MbZDg7hc0Kp
         PKuyOCEyq7YcN+uHXx2zUU7htCTgU63fYHKkcq1Dz5nj1Tay8FySEwy9Jvb+eVNHeD5r
         NfoVVWZNi/Qn1KAR1UdvARqBwL499XJ3GtenMyOw0XnYpt+XuYo9g6N+cp4703Cew+6n
         TisZdLekqzSIPfWawz02ooqsk3ebtk8+FdI2kb/Xcjkj/ILcx5XOWRxwqJpqc7E2gjuW
         7aDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+aNazM92DpchyM2fptN7BUFRXkWjezucT0stoL0ipM=;
        b=MGEC8/8QiOUSMIURdzqKG9C/BN6dVpnUQinVuq4Q+Ln/rfa9e4FVA7erLb4RRZb2Yo
         Z38OU3/3cu53NKQ6K9ztxD4SJxOauHfJJAUoIz/f2EMdI5hPf6IL7rl5aOysqc56VSJk
         w7xDaduIOYDDx0FavB8dIyDDOy5t2JVUZMhoQV5FAlm6w/pCv/7MFNq2SAyAjnnFZsMe
         qXnLbexJMgqUPPO8HSSJ6v+izyCY8OyPhL2cMWu14cXTlA+PWsAn/xXE/iSokGgaJN0u
         K5s3BOoSdGlvdU0J34aKW2DR3MzwbpnDyuTwGIRxZ/f9YZl3U7196anXlckWjIOS+KiT
         u4Wg==
X-Gm-Message-State: AOAM533bCYeqgCP0zElErH/roty/LAibDtnUYHTZbR741eopfHVYp9lx
        53S4fI6Wai7dPcE4e3vJf4atXpqkDu4=
X-Google-Smtp-Source: ABdhPJzYqv1vgovmdPPLB4hXAVGSzSDZt5gDd3jOAh2KUerPN9Y55dKa0R39LxalcjdM2uu8dmviMQ==
X-Received: by 2002:a17:907:60cf:: with SMTP id hv15mr18907361ejc.702.1643683313812;
        Mon, 31 Jan 2022 18:41:53 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a11sm18670116edv.76.2022.01.31.18.41.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Jan 2022 18:41:53 -0800 (PST)
Date:   Tue, 1 Feb 2022 02:41:52 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 3/6] mm, memory_hotplug: drop arch_free_nodedata
Message-ID: <20220201024152.uqksmmethxs4q2pe@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-4-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085305.20890-4-mhocko@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:53:02AM +0100, Michal Hocko wrote:
>From: Michal Hocko <mhocko@suse.com>
>
>Prior to "mm: handle uninitialized numa nodes gracefully" memory hotplug
>used to allocate pgdat when memory has been added to a node
>(hotadd_init_pgdat) arch_free_nodedata has been only used in the
>failure path because once the pgdat is exported (to be visible
>by NODA_DATA(nid)) it cannot really be freed because there is no
>synchronization available for that.
>
>pgdat is allocated for each possible nodes now so the memory hotplug
>doesn't need to do the ever use arch_free_nodedata so drop it.
>
>This patch doesn't introduce any functional change.
>
>Acked-by: Rafael Aquini <raquini@redhat.com>
>Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
-- 
Wei Yang
Help you, Help me
