Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC4496F8E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 02:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiAWBi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 20:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiAWBiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 20:38:55 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAD4C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 17:38:54 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id h7so11155297ejf.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 17:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m/fg+Cb4wDp7iNWM7oVV+58T48PKg0h6xI3fPgfiRSo=;
        b=P8sOP+2W9PtC+V+wWqhP/jAN2yYpvjOknX6lYysCBbSGfITlqncg2Qxn/9a34Hqbkd
         iiBhJZgasiSi+saCtxqX/zokOf6SEa7yfVgWEjKQ0Vqhlob2cObxJ/i6uGkaDO0bJdML
         CnRvkt4wrenEAqg3f7p58WQnTK/KfEo2A3TjuNNRy0daeC9P0KPV5sycLPhqYmnG770f
         8fwNjKlY13mcVVS+KMgQNLswVbnNwGYtZbDsw1zIZKgimsasYhfUg7UM/QhuhYGk3nXs
         Njh6DbYGa17H9NMXUf5PEKO2AOogabb3f0uW/qczwncn6Xy4SUEhkEAYJK7a8nGAI8+M
         LGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=m/fg+Cb4wDp7iNWM7oVV+58T48PKg0h6xI3fPgfiRSo=;
        b=7Gq6Hc/qrl5uKQnNSxxEbbOAqgt2wqD2vvwH24AXwGZWUb3s1uxCRdH476AhVdHWny
         ifDWUOSJqpcgADBnki0dDhWbIgu+BMH7mchnOWouqNuFKkG1FJXocY77uva5YxUAE7W8
         5lQXgMShq0XhkfGFVFuLk0gKsoPw5IXIt8UO4LA0k1ZKqyCoBs1NxzcVeL+ZbYd1UCIW
         jOzfYMZDloo5FnDmjRzYfWYph1CM5wMYkmdC/rkrFjr69eS4bsb+poBko7bECSX0GauX
         gYptdTBUQzpq8y/FULn4A34WlZO9GHYhfQHIUQytZmMQkJuJR5WpZtAALI/snUHrnGnG
         4VPA==
X-Gm-Message-State: AOAM530JfLt0dblWivmaQJahoSN/GY70wWlRKzXcIPDNUfiq7/hkxYau
        CGA3Yv1PUpLC1fKhyHCi2+M=
X-Google-Smtp-Source: ABdhPJwRXeV0WGKPf7qKxufXjCeHU+2hEqvXA8KjlTCCe8vJ3VHDUMJEPvkzEfApgtFT6p+zpWc1Fg==
X-Received: by 2002:a17:906:64f:: with SMTP id t15mr8244487ejb.218.1642901933421;
        Sat, 22 Jan 2022 17:38:53 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e12sm2503388eje.18.2022.01.22.17.38.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jan 2022 17:38:52 -0800 (PST)
Date:   Sun, 23 Jan 2022 01:38:52 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        peterz@infradead.org, vbabka@suse.cz, will@kernel.org,
        linyunsheng@huawei.com, aarcange@redhat.com, feng.tang@intel.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Message-ID: <20220123013852.mm7eyn3z26v3hkc2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
 <Yde6hZ41agqa2zs3@casper.infradead.org>
 <20220107134059.flxr2hcd6ilb6vt7@master>
 <Ydi6iMbSZ/FewYPT@casper.infradead.org>
 <20220107160825.13c71fdd871d7d5611d116b9@linux-foundation.org>
 <YdjfsbAR0UlwyC6b@casper.infradead.org>
 <20220108081340.3oi2z2rm3cbqozzt@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108081340.3oi2z2rm3cbqozzt@master>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 08:13:40AM +0000, Wei Yang wrote:
>On Sat, Jan 08, 2022 at 12:49:53AM +0000, Matthew Wilcox wrote:
>>On Fri, Jan 07, 2022 at 04:08:25PM -0800, Andrew Morton wrote:
>>> On Fri, 7 Jan 2022 22:11:20 +0000 Matthew Wilcox <willy@infradead.org> wrote:
>>> 
>>> > > Hi, Matthew
>>> > > 
>>> > > Would you mind sharing some insight on this check?
>>> > 
>>> > It's right there in the comments.
>>> 
>>> Well I can't figure out which comment you're referring to?
>>
>>         * WARNING: bit 0 of the first word is used for PageTail(). That
>>         * means the other users of this union MUST NOT use the bit to
>>         * avoid collision and false-positive PageTail().
>>
>
>I know this requirement on bit 0 of first word. But I don't see the connection
>between this and the check of page->compound_head and folio->lru.
>
>This is more like a internal requirement on struct page. There are 8 struct in
>this five words union. And this requirement apply to bit 0 of first word of
>all those five struct.
>
>To me, if folio has the same layout of page, folio meets this requirement. I
>still not catch the point why we need this check here.
>

Hi, Matthew

Are you back from vocation? If you could give more insight on this check, I
would be appreciated.

-- 
Wei Yang
Help you, Help me
