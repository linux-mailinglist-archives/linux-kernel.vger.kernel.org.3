Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1536149ACD8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376659AbiAYHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S248970AbiAYEDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 23:03:12 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C0FC061394
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:41:46 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so607031pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=NefrKzx5OHKKvYYf1TiO3FvEJzN+eja5s5Q735QU1F0=;
        b=hQBTs3rPEaX5QpMhGJN0sQ1KIvn0GCl7Ol7ejuwTF4A8bAYknvdCviHNLZ2J7WURPU
         7J411kY6kdxD5njmZAbInNsypAC/jukuL/Fc1TU+7ByEu7bsLqZl1iU4XEat6Vrfk4wi
         EHHMLFDJS5km0IEUXAO9Mty8aOqT4FF8MxUbD01sNJaQ3fiFgKVwWa/2dFfdEC9VMauL
         eEZmOUYJITLEQDTN8XjGXbgfTWn9erMQxRhNaAofRKQmFxar0KImFrYedGHcE+WElgfO
         z78aBat3R2A7j99osBhvSALy6qYnr/XDCeQp+b3zBjJ6ANjLScbli0FpYKg0a00VboQK
         b34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=NefrKzx5OHKKvYYf1TiO3FvEJzN+eja5s5Q735QU1F0=;
        b=7x/5xW1FUYfnFjAY41Sl01UQ3VNgu73Oa98T2M8UYvPRu/h3zDxVEPQhyYhtcBOK7c
         U3U2tEFwTjpZq8T2dXe3/ch0urV8PtJBHoSM2OrtUCA+ql8+GXF5zXQc3BisBpjbOsam
         G57DMMFuJxxKoc7GFQXxE5/ST+WqGBoyfk8rX3JFmkzN8MtYcFSOdqcRvnOgP9+EWExi
         tOXP65TO0pHxlB4uZayr8VkfrNBkLjrbAUjSShYqWWln3h9xODfTjBmW4AVUmUsak5DI
         8A326qBv73RDiZWG0P6kDy6FwjTQMvh+6TB1G+4wPFO9aIoJZdJizaMOcxlpMYgL+kd/
         UR1Q==
X-Gm-Message-State: AOAM530TWupD0LVkJ+/K7OoHyVVPqEt7vJ+G9JqPo7chn96STHOEeTpX
        rwXYJ1Wi+WMhE9y7gKEVTsT8NQ==
X-Google-Smtp-Source: ABdhPJzY2YXYLCkrS4vtJeyIT+l3DZOSE+RZqG87uCqApw6tGl6rk3GXgFX62r1zW7xY1DkqAl2eMA==
X-Received: by 2002:a17:902:e88a:b0:14b:3aa4:4d17 with SMTP id w10-20020a170902e88a00b0014b3aa44d17mr9876178plg.160.1643071305403;
        Mon, 24 Jan 2022 16:41:45 -0800 (PST)
Received: from [2620:15c:29:204:1f99:bd65:fcbb:146c] ([2620:15c:29:204:1f99:bd65:fcbb:146c])
        by smtp.gmail.com with ESMTPSA id me4sm471426pjb.26.2022.01.24.16.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 16:41:44 -0800 (PST)
Date:   Mon, 24 Jan 2022 16:41:43 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Zi Yan <ziy@nvidia.com>
cc:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        Lars Persson <lars.persson@axis.com>
Subject: Re: [PATCH v2 2/2] mm: fix missing cache flush for all tail pages
 of THP
In-Reply-To: <5D9B52E1-A74B-4964-AACF-ADB91536C4C0@nvidia.com>
Message-ID: <91608087-a650-bf1c-a225-7afd63adf63d@google.com>
References: <20220124051752.83281-1-songmuchun@bytedance.com> <20220124051752.83281-2-songmuchun@bytedance.com> <4d5044e7-cac9-b6e6-1467-59ea6010b0f5@google.com> <5D9B52E1-A74B-4964-AACF-ADB91536C4C0@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="447496086-858381783-1643071304=:26091"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--447496086-858381783-1643071304=:26091
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 24 Jan 2022, Zi Yan wrote:

> >> The D-cache maintenance inside move_to_new_page() only consider one page,
> >> there is still D-cache maintenance issue for tail pages of THP. Fix this
> >> by not using flush_dcache_folio() since it is not backportable.
> >>
> >
> > The mention of being backportable suggests that we should backport this,
> > likely to 4.14+.  So should it be marked as stable?
> 
> Hmm, after more digging, I am not sure if the bug exists. For THP migration,
> flush_cache_range() is used in remove_migration_pmd(). The flush_dcache_page()
> was added by Lars Persson (cc’d) to solve the data corruption on MIPS[1],
> but THP migration is only enabled on x86_64, PPC_BOOK3S_64, and ARM64.
> 
> To make code more consistent, I guess flush_cache_range() in remove_migration_pmd()
> can be removed, since it is superseded by the flush_dcache_page() below.
> 
> The Fixes can be dropped. Let me know if I miss anything.
> 

Yeah, I don't think the Fixes needs to exist here because there doesn't 
appear to be an issue today.  We likely need to choose one of the two 
paths from above to handle the flush only in a single place.
--447496086-858381783-1643071304=:26091--
