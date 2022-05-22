Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08DE530143
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 08:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbiEVGih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 02:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbiEVGi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 02:38:29 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B704163C
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:38:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id bo5so11068254pfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=63w6MmKKarIOHYX+K5PAEKcR1bSxb1g9RSGqBi4nt8U=;
        b=Wx+SmgtailJYnAhwvCnC+y1AuVwXo46QNLoLpoUb8rjVzBy5xo17x6lY2EmUp6sVHu
         l8rGunXcntC+8LTB0b38OVBedUWlQ47Xv+fYt8y2hIK2D9iH7/CRngOu9kSVBGc6TXFL
         7RR9Zbl4Se+3YzKL9QmEf0AjB3Au30OSZlbshIcHneNizPzLdf4qfKySRtWPH6eV1RaD
         dCWHf2/vyiL69waPlmn2Ld3st9Y0kgrihwiSDETjrQ5145s8fQdluLTJ/0ltDMOY/OTR
         oRtt0ry2h3Xz7CDwMzplhnN0OtOJ3ZmREN/4PdnvTXgPq9UEFWaLcwwACBJihbNQeMim
         japQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=63w6MmKKarIOHYX+K5PAEKcR1bSxb1g9RSGqBi4nt8U=;
        b=UWMtp9JZwmdQ4cSuLKLGbnWMiUuHn9fScGxhL4y/sh5qiEmVuT3winIXw1QcezyVLt
         bEUhyssjE0FVJF86YIXhmDaaOI/PTQnHG4Jo87byYARmRe/iO47WRNgNA9DxLQaOlD91
         X8MsAAONtreL0F/xnbcw6tCiPUq2+8tldSejSd0WhWbZ8zpTYVNrjaDcBgRvMtNEXoUJ
         JdpcFtYWleC7NRZfdSl+ZXjjkdsop/jeeenVxMYmPGIiCZ7kkSbRM+G06BunbKI372Qd
         sOXaTLN9vhwK3bbYDa8gAUbCUUYkT6QxaDl3cTbwaS4KAVKCnB//lv5Z7tJ8Wi6J0Ttb
         VCPw==
X-Gm-Message-State: AOAM530zvbqAdi+ZeXS9GiwH4GZTqIh68P6oBtIbCs8vLen8C3SUtugl
        roFMDK2n82iiPzmqknBYIn26Tg==
X-Google-Smtp-Source: ABdhPJyPgv2iVQpJ6evav+1kuZZv/Jsj382BjCK/UoWqPhAihMGhNLl0bmXOsZNbznk/KBMm7ROnOw==
X-Received: by 2002:aa7:86cb:0:b0:518:3e92:f78b with SMTP id h11-20020aa786cb000000b005183e92f78bmr16689664pfo.61.1653201507382;
        Sat, 21 May 2022 23:38:27 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id n89-20020a17090a5ae200b001df6173700dsm4549568pji.49.2022.05.21.23.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 23:38:27 -0700 (PDT)
Date:   Sun, 22 May 2022 14:38:24 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH mm v2 3/9] memcg: enable accounting for kernfs iattrs
Message-ID: <YonaYCdTkxoyz815@FVFYT0MHHV2J.usts.net>
References: <Yn6aL3cO7VdrmHHp@carbon>
 <e5a8bbc2-3d97-d016-f2ba-4b2b3073a9d3@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5a8bbc2-3d97-d016-f2ba-4b2b3073a9d3@openvz.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 07:37:59PM +0300, Vasily Averin wrote:
> kernfs nodes are quite small kernel objects, however there are few
> scenarios where it consumes significant piece of all allocated memory:
> 
> 1) creating a new netdevice allocates ~50Kb of memory, where ~10Kb
>    was allocated for 80+ kernfs nodes.
> 
> 2) cgroupv2 mkdir allocates ~60Kb of memory, ~10Kb of them are kernfs
>    structures.
> 
> 3) Shakeel Butt reports that Google has workloads which create 100s
>    of subcontainers and they have observed high system overhead
>    without memcg accounting of kernfs.
> 
> Usually new kernfs node creates few other objects:
> 
> Allocs  Alloc    Allocation
> number  size
> --------------------------------------------
> 1   +  128      (__kernfs_new_node+0x4d)        kernfs node
> 1   +   88      (__kernfs_iattrs+0x57)          kernfs iattrs
> 1   +   96      (simple_xattr_alloc+0x28)       simple_xattr, can grow over 4Kb
> 1       32      (simple_xattr_set+0x59)
> 1       8       (__kernfs_new_node+0x30)
> 
> '+' -- to be accounted
> 
> This patch enables accounting for kernfs_iattrs_cache slab cache
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
