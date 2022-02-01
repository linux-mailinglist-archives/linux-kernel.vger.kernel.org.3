Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF34A5557
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 03:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiBACnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 21:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiBACnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 21:43:21 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF30C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:43:21 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id p12so31029446edq.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 18:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XqF1rJaFoyxOeMUVfeClBKFbeB8Ygd43YBU7XBvjBqU=;
        b=ZOLvp2d/7YIAQYAdX3NspDgY3X82A39Fk4642eFRdULLvuVPHUSHzmup3Y2V8jwNOQ
         EnrYZ0RxDiSVao8f6U2iDV2+HkLqjlDOJRLuqogudscUQJAR8datn8x1bWKzqp79V86x
         xkwVl3mL9ElZLsvtQVGbPHkDQfvFMwLlFwcDDP5w4jXfp71m2Gi5Up1MWGhgtz0EgmhA
         CQmxiEjWe18fE2c/VZacJyWar/NySfCQG8GbxMBv1Sj6yoC547i0KZQWEZpTOZx8S6y2
         CvXOiNf2LKQcvLgZqO1aWMBivO0Rh8ioVKANaqCApQeObYFs+aC/V7YBxjrL9VEZhUkt
         VO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XqF1rJaFoyxOeMUVfeClBKFbeB8Ygd43YBU7XBvjBqU=;
        b=YVAElFWr4LlgWhsMiDb2zuIStvGEYh7z29EbX/XPeOJstb9wliug6qKLgDnbuUMQN1
         WwmjLD/4BhvWV2Di5bvX1Ipy9aR+mT9SswYwhdbccdX0Pga7D68jLQXeqQwXjPfaiPxL
         WRzLMqsGJ9pdowPbXgdxRlVHpcjar1B/k1dlO4hDVkMP02Y5Swq/8+5pNMa+cweRTDxh
         Nzo4zvP3q3LcstTZcTzhBmi/olf4CUOW3/vEYXC0GnQ0VKqE1uA48/65KXoA3oCgXDtU
         L5F4+lyNYE7moaqKfEpzFCoeEsBUjtMSuv/yQ9RXMaR0cl+nxcCJf7GfojepTuuG4Tk3
         3LNg==
X-Gm-Message-State: AOAM532nuNeHGtQFQGfTEWZ0FBFzHcXQwrTqtYRBI+4tA6sjJWISWd0x
        HPNjNn/9r8ENpiv20t8puxY=
X-Google-Smtp-Source: ABdhPJyI/L7A8l+kLye8rlYfaD5skghTVAICvHtFbxbJj9C+ZhJPvXZkzKLSVcEcvHjTM15c5gkuCQ==
X-Received: by 2002:aa7:d1d4:: with SMTP id g20mr23404764edp.296.1643683399795;
        Mon, 31 Jan 2022 18:43:19 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id k23sm14053747ejr.65.2022.01.31.18.43.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Jan 2022 18:43:19 -0800 (PST)
Date:   Tue, 1 Feb 2022 02:43:19 +0000
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
Subject: Re: [PATCH 5/6] mm: make free_area_init_node aware of memory less
 nodes
Message-ID: <20220201024319.5p3dhud5x3efs4f7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-6-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085305.20890-6-mhocko@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:53:04AM +0100, Michal Hocko wrote:
>From: Michal Hocko <mhocko@suse.com>
>
>free_area_init_node is also called from memory less node initialization
>path (free_area_init_memoryless_node). It doesn't really make much sense
>to display the physical memory range for those nodes:
>Initmem setup node XX [mem 0x0000000000000000-0x0000000000000000]
>
>Instead be explicit that the node is memoryless:
>Initmem setup node XX as memoryless
>
>Acked-by: Rafael Aquini <raquini@redhat.com>
>Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
-- 
Wei Yang
Help you, Help me
