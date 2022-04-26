Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC1550F992
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348271AbiDZKFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348357AbiDZKFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:05:24 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA9868FB9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:25:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id bo5so17445860pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o+Ta1rYC4XzgSBxhpB0c8sQLq8UGlcT6xt5ODkQbkQo=;
        b=0YIeF2ZAA6Bz11BbIkTaGNdZbAAGqhcO8Mfw6ABDn+OpxksHQQhz1GDiiqSLYGghQC
         3nv3WGqy4h5+ZUXp1xITbpDo9XK3aQR0Tb0hiQkzRt8TIun2g/jG2DGAfxKMyIkpdNSW
         Vu4cFO287vmzQ2PfdSOpgNY6i7Asd9mI4I/RX80dxzVv6gneDwHotHudeU/iBQLeE7DE
         jEApzYtLLyHf36DBHqDJF8YtlXpvVkIIfeT3QP2RNQMkjlXEYDb9EtEobw5EbSOTm6YD
         60QIeqAGTDyWNfNR+inP90SH2UYqXmTxIuZLJHdq3FBAWiBcpb5c4LK3ZQ4/COUrVqMr
         o8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o+Ta1rYC4XzgSBxhpB0c8sQLq8UGlcT6xt5ODkQbkQo=;
        b=AoTt6EMQSa5i3n4F/g0oEr5evBXtN45ihttSeIPh3ONKCqG+7flTHhVx+xpICMKse3
         cP/H8I8a5FbeyegNvEzswNuGkNBqp3qGG8MGrt++IatGrqaPKugzM/55uVCYWAPEmNUw
         IGraEUHeMqYGMTyAwgNZy+gHq+Qt5jgs1W66DGWgBXtqhh4XEOdDZ+HpEbDwYdNlLmEL
         wUgGfLRCE8NCxNbb5zshOpUwWkRGGofpOxjHtXhHjZX3hRusHpsQCYrH2VcvG2+h3ebe
         As4Z4oP+heMnp0HvcDaGto64VeNhmaQBimEU8G2xelPnUvYiaEgpe3BokJeSpLz74hSv
         GtlQ==
X-Gm-Message-State: AOAM532gTT184MhRuV1Xcen1l20VZYlcgBZYHc9w9WbxKr8A3Q77w/jO
        1xyTP8c16n/x2EnY3wUFqGlMpA==
X-Google-Smtp-Source: ABdhPJwmGwgasacrYyvp7VYrJteThiRtOydpsibMixp9x/XRgEK8KlC87ROV2hG1Cd3gVBK2ni05XA==
X-Received: by 2002:a63:894a:0:b0:3ab:23c7:33ff with SMTP id v71-20020a63894a000000b003ab23c733ffmr9601378pgd.245.1650965144401;
        Tue, 26 Apr 2022 02:25:44 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a000acb00b004f35ee129bbsm16002825pfl.140.2022.04.26.02.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 02:25:44 -0700 (PDT)
Date:   Tue, 26 Apr 2022 17:25:40 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Rientjes <rientjes@google.com>
Cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, smuchun@gmail.com
Subject: Re: [PATCH] mm: slab: optimize memcg_slab_free_hook()
Message-ID: <Yme6lFrVj8FHegjN@FVFYT0MHHV2J.usts.net>
References: <20220425035406.9337-1-songmuchun@bytedance.com>
 <74f6b949-f9f-deb1-2786-47c92a619fd8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74f6b949-f9f-deb1-2786-47c92a619fd8@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 12:42:23PM -0700, David Rientjes wrote:
> On Mon, 25 Apr 2022, Muchun Song wrote:
> 
> > Most callers of memcg_slab_free_hook() already know the slab,  which could
> > be passed to memcg_slab_free_hook() directly to reduce the overhead of an
> > another call of virt_to_slab().  For bulk freeing of objects, the call of
> > slab_objcgs() in the loop in memcg_slab_free_hook() is redundant as well.
> > Rework memcg_slab_free_hook() and build_detached_freelist() to reduce
> > those unnecessary overhead and make memcg_slab_free_hook() can handle bulk
> > freeing in slab_free().
> > 
> 
> I agree that for the SLUB case the code flows better after this, but I'm 
> wondering if you have any numbers to share on how much better this is once 
> we've avoided the virt_to_slab() calls?
> 
> IOW, I'm struggling to figure out if this is code cleanup or a performance 
> optimization.
>

I think it is both. The numbers are listed in another thread [1].

[1] https://lore.kernel.org/linux-mm/Yme5zE8ZU%2FFN63Av@FVFYT0MHHV2J.usts.net/T/#m7e5c4ae3e92128781664b3396ce300c8076a5b63

Thanks.
 
