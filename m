Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495084A555A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 03:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiBACps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiBACpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:45:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D27C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:45:46 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id p12so31039823edq.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9pymwQ4UaO9NJdRwfISQ/doC+zND8ys6m5SL5hlKdWc=;
        b=D2N5jrvCbkgD4eEcmCb4sXQlnCGhluE6NJuCrFMtCZvSvQxASza+HsCjH9EF8Jr7m8
         I4tqExuqGalC7lTVerNy1mO3uk0wy7nDTzcoLlxeeGRr6gSf7NlVVWV/+55OqAZ6Eybw
         OaSriJcF4o60/8ZP/GuKOxGULaFcMYicbRvvYObVNXq3pmoMT4Bu9RABrhbIJMlYXBvO
         pom6sjKsLT89k5UBHEY5dPrNKwy1YOnPUrjMmSgQjwVs8y9rWTREFd74xA+z67uPcHlh
         RxCoRquRdJWtdo6zbkiprgE12gPXokWCIxkJ2S+3vcX4HsKo+pSIkHxM7XgBRZmn5BgR
         Qv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9pymwQ4UaO9NJdRwfISQ/doC+zND8ys6m5SL5hlKdWc=;
        b=ZPpD5hil08tO0ZzA1s77w8kzj1yRkTzSiM0BQ4smJsfyfuVnArJnTqW/N2KWL0rBDa
         N2CKNzqvWY8M2zml4iKKKxjP0WFthVrWbnpISiQsNlOW4Nrh01sPSB8eiR8L2nLURHrq
         mzIEJNv5EgVfN+FcNhteqk2yCaVRXTDH76I5P884+rR7WZCyC6qfE4LBkqbZZwCtJULX
         6IT2w2CrK9Y5iMIBZ+75zSaAU+4xjXHJ9kah/U+NA/QwhZ/aD1fJPkTDVcsbhnR3GqFw
         Netd3ners9MkkxAedkI+eeIklUYsw4HV7zgykRKel98mfWcIZtgwzOTN8zAaE8PI4g7a
         2duA==
X-Gm-Message-State: AOAM531UglDN2FQWRXfQ1p3ytI7zR1tdmGg8IqaiMmSu8ZnutaMIwwS0
        fTz7K+9atyTouZesWZcFSAw=
X-Google-Smtp-Source: ABdhPJwa/D6V+1WOnfhB9eejzTwFe7KQvCa4HK1P9rpgB4guQhcugBxzqLpco46A8DGE3Iajp0Y23A==
X-Received: by 2002:a05:6402:f19:: with SMTP id i25mr23234265eda.91.1643683545623;
        Mon, 31 Jan 2022 18:45:45 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v23sm14245723ejy.177.2022.01.31.18.45.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Jan 2022 18:45:45 -0800 (PST)
Date:   Tue, 1 Feb 2022 02:45:44 +0000
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
Subject: Re: [PATCH 6/6] memcg: do not tweak node in
 alloc_mem_cgroup_per_node_info
Message-ID: <20220201024544.p2iqj2mz7bgq4pf3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-7-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085305.20890-7-mhocko@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:53:05AM +0100, Michal Hocko wrote:
>From: Wei Yang <richard.weiyang@gmail.com>
>
>alloc_mem_cgroup_per_node_info is allocated for each possible node and
>this used to be a problem because not !node_online nodes didn't have
                                   ^^^ a typo here?

				   !node_online nodes is enough?

>appropriate data structure allocated. This has changed by "mm: handle
>uninitialized numa nodes gracefully" so we can drop the special casing
>here.
>
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: Michal Hocko <mhocko@suse.com>

-- 
Wei Yang
Help you, Help me
