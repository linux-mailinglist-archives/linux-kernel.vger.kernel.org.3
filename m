Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC614A5529
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 03:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiBACNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiBACNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:13:36 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC68C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:13:36 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j2so30645018edj.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z5a1UA3AmbqOXaqFeyJhuFNz4swNgX216lj5ZDFGhKs=;
        b=golD3uou61gyyuK2ClpPfQPeMByIwIfGy+a7BC6fFu9rrj/T68DWSrynlXOEWwUtX+
         5dN3KFTradKVC9DShueDJciw/xAndf4MaR2jxNfJpz0RRaYkEmZyQLpB7va6Jls1ipEv
         XVyggpJaVrEYUCoffC6KcQg2evhZdKFHt35YjbGvTpUwoo4sOHQKy7XHnOvp0bqmKKRE
         xFokZaJXFcOQIDPvUJ2C/OGdlTSOC8JJoBm/0AA8mZJdLVEWMVrtgdJo1QwQzllKQ6oE
         mU4K/0SPD/tn2xVKtPv24/3MtQ9s883pGnZll+50x6ZlN5bmtKkZRyf5VI/oXw564NCa
         2qTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=z5a1UA3AmbqOXaqFeyJhuFNz4swNgX216lj5ZDFGhKs=;
        b=PU7CLQVceDy3yFNrzJ/I95fH9stUCLukBy74LUx/QFaqEg8i47JUyoycT42NtkKrc6
         A9+yuCA1ZX+fP+b1TkrMONxD/vt80nkAThwHfAFfoJkNMF2Sot32slasBK6KgqG3Tu8+
         gUoNmECWvmbEPSPaFEHI618wCpPbePDGXWsvtyxXmw3+wBqVKuHKoJ4EVCrZuCmha73e
         wbBHZmUoXaPiPGupHMCn1OwnqwmGC+Wp1f2MGdi4FJJge6MMehtQ2SUOTb6AQ22w6Et5
         lcCma/oYbX/BDtiBUMa6NVGT995XmY4N3p3v7zXVK8jjWJY3CkihY3LZAdd8e3n3r+G8
         3TlQ==
X-Gm-Message-State: AOAM5312221PjUpMlpP+0oTiFKKCcZy3GY0qNceYA9haX1ChZWrtn5fT
        rtprduV+icPhDVS8Zyjfok8=
X-Google-Smtp-Source: ABdhPJyBB5jGiaCXsb4tSAGZp9HZi3+G9kvqf9xVjsmhxEdAvhQWT2R8Xl4sPkuB05u88Wz4K8dPyw==
X-Received: by 2002:a50:fd14:: with SMTP id i20mr23453496eds.122.1643681614916;
        Mon, 31 Jan 2022 18:13:34 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id w25sm18618783edv.68.2022.01.31.18.13.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Jan 2022 18:13:34 -0800 (PST)
Date:   Tue, 1 Feb 2022 02:13:33 +0000
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
Subject: Re: [PATCH 1/6] mm, memory_hotplug: make arch_alloc_nodedata
 independent on CONFIG_MEMORY_HOTPLUG
Message-ID: <20220201021333.tyw5fxsvymqxudsp@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-2-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085305.20890-2-mhocko@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:53:00AM +0100, Michal Hocko wrote:
>From: Michal Hocko <mhocko@suse.com>
>
>This is a preparatory patch and it doesn't introduce any functional
>change. It merely pulls out arch_alloc_nodedata (and co) outside of
>CONFIG_MEMORY_HOTPLUG because the following patch will need to call this
>from the generic MM code.
>
>Acked-by: Rafael Aquini <raquini@redhat.com>
>Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
-- 
Wei Yang
Help you, Help me
