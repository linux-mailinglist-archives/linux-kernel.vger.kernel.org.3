Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C094A5553
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 03:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiBACml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiBACmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:42:40 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891D2C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:42:40 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m4so49381810ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LSd1fDrOzA4Dpcv+XNORtddH3JxeWWMsppEtjfZhhrw=;
        b=BYaxG+0tXuPpIfa6C23ZIGmte2gD6VJFdpAmSvBZ3N0s/kODdzYUEF8RUj1vuSLPTo
         h/+AfGAsiL2Q0Oj/pY3+lN8kmgeBvSK0wxB9jvIxnOmJkqP9r1dJnjY6HQgQZeUsLMhq
         gUKoXIgsK9MxqgVhoGt1YfH1yj5mIID8NoXrE4fxz/rTFbw4Cvo4Rze23vokUbW2PB0W
         3gcDO1ebPicdTyzmCPzFHE07oSancb+5aQADB47a0PRoziULZAsbBc/o1hgJt36GBKds
         CXoOwb6+BLlInbqx0/ylFWpY3FIUFxusx1PCJr6eU5cLUdxPIcuXdv+9xbaiYy9OX0Wy
         jOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LSd1fDrOzA4Dpcv+XNORtddH3JxeWWMsppEtjfZhhrw=;
        b=MwVzNU+jsk2XqwHKJBM97qEStdBU32BDS/bbmBz9SgeE7Eq0/qbcdel33iqRU18S0W
         RjpE77oRYyZLoi39LKvTpm0oFn3N073iiEljO2NAS+tqGAFRNeZpX+DhMgcHT0t0iVbv
         NoNDKsMeKovHd3rMghhgP0VXI8WO/LCmfPhwTgIEvCwv6BCQAHM1KwCbVDsi/wdr8q7M
         JAv0JXTyxsV0ZqpXTutperM4OkUesM5/OSl27/HwT7iOUy4kl7Z9dy3uJADuK/fbU9n0
         8/ivYwJDmM269pfIpfxMWiqcXyHP/f10XQPmMPbJbczxssRoheJhhQbNaW4B0tc1zo/Z
         unNw==
X-Gm-Message-State: AOAM530unPh1BlqkT2EsxAO6AwSlyIuxsKk35yFekZozr1lbxX6xSFVe
        g2g9rXR5OWI/rVANWzUbUBE=
X-Google-Smtp-Source: ABdhPJyuN1wfBF6igMEAFuxiSZEGqTTJ6jx591QRlEMlgkDxs4u+SaRp29ssmVnlRUCdqfOPxPRtQQ==
X-Received: by 2002:a17:907:1c0b:: with SMTP id nc11mr19037817ejc.665.1643683359160;
        Mon, 31 Jan 2022 18:42:39 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a7sm18823701edr.34.2022.01.31.18.42.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Jan 2022 18:42:38 -0800 (PST)
Date:   Tue, 1 Feb 2022 02:42:38 +0000
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
Subject: Re: [PATCH 4/6] mm, memory_hotplug: reorganize new pgdat
 initialization
Message-ID: <20220201024238.ihq477dgayy6oxeg@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-5-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085305.20890-5-mhocko@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:53:03AM +0100, Michal Hocko wrote:
>From: Michal Hocko <mhocko@suse.com>
>
>When a !node_online node is brought up it needs a hotplug specific
>initialization because the node could be either uninitialized yet or it
>could have been recycled after previous hotremove. hotadd_init_pgdat is
>responsible for that.
>
>Internal pgdat state is initialized at two places currently
>	- hotadd_init_pgdat
>	- free_area_init_core_hotplug
>There is no real clear cut what should go where but this patch's chosen to
>move the whole internal state initialization into free_area_init_core_hotplug.
>hotadd_init_pgdat is still responsible to pull all the parts together -
>most notably to initialize zonelists because those depend on the overall topology.
>
>This patch doesn't introduce any functional change.
>
>Acked-by: Rafael Aquini <raquini@redhat.com>
>Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
-- 
Wei Yang
Help you, Help me
