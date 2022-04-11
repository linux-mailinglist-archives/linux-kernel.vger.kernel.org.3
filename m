Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B74A4FB289
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242974AbiDKEDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 00:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiDKEDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 00:03:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5796B18D
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 21:01:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id h10so1795745pfr.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 21:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qv+7Hl4RSuglMyoHnp4oUvoCdTwgerBcrHKS09aDebw=;
        b=pfckYdUcNIyvu8Skv2MxHOHvHeke7kwM64kCROBJONypWCLcJPc4qA3eraClb2vSuk
         U/I8SaKKJ7ic6/Pc5Pez8gyYHSRJa9XAlKe/mJj2pKSVBX+WU06nmXpP8YYURjot4eEB
         V8yGSN7d16/7OLKzhZabhfMQ4pOiqp2822p1gyLuUPmxWsNPuXysTAezUfebBOzl02tt
         PI9oXb61hAbBv18GhAtDTqMyyncmh3gzKaIDmBD3NVJh+EYyB+QsS/W88io2gHspvkso
         jV3o20kK2EdaiYJGYHNtAVf7L9Uu5MSnkspSYrzzAcgIkc+qXVqztAF++ebvlBxc8kvo
         W6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qv+7Hl4RSuglMyoHnp4oUvoCdTwgerBcrHKS09aDebw=;
        b=nX7Wy8aTRDQqFLeinlBteVPZWK7b7dtVJR19F0Hnv1oYEkva1j2MjrTo/YBLcLb4gP
         6uvhfMxDj2CbhOyxy3t/87iXAGV/bNIGeNicsiYAKB9gZwA5t2sZELnceKcl3flORTVr
         8DPONfU1X0Z/1KDWs1/AP+qqZdMZK7R/42cG6sfNmkYlDT9TdJ7QhzD5lNTrnblznN0H
         m/Vm44d/6Cvf42RPeHQTBbdUcqhTKOH9x3qTbtQWHNC7+4VLdLKo9c7cv8KWqz4fUsXp
         36ioANB5tplPbA63Mlir21xhXrN8d29fxafY1V1c9GFM2CCbrnIlz4CUwvbm2H3nANFZ
         V82A==
X-Gm-Message-State: AOAM533tnZT0vN3gFu1zRCc3CbMdpe1yvg85jvusofj410Rh3IKRumZt
        GAsctMrRErM3V9S1rXh1l73G1A==
X-Google-Smtp-Source: ABdhPJxQEAqMDqqzt26Ds89IfS4APasNiBQZrqAD/35nAo6s+tB/SZmB/l1XG4JozFTGYHLcVfuGSA==
X-Received: by 2002:a63:7c06:0:b0:398:31d5:f759 with SMTP id x6-20020a637c06000000b0039831d5f759mr24923035pgc.513.1649649659878;
        Sun, 10 Apr 2022 21:00:59 -0700 (PDT)
Received: from localhost ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id hk16-20020a17090b225000b001ca00b81a95sm19269628pjb.22.2022.04.10.21.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 21:00:59 -0700 (PDT)
Date:   Mon, 11 Apr 2022 12:00:55 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Jiyoup Kim <lakroforce@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: remove duplicate flag in allocate_slab()
Message-ID: <YlOn97p0dFEcr+h9@FVFYT0MHHV2J.usts.net>
References: <20220409150538.1264-1-lakroforce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409150538.1264-1-lakroforce@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 12:05:37AM +0900, Jiyoup Kim wrote:
> In allocate_slab(), __GFP_NOFAIL flag is removed twice when trying
> higher-order allocation. Remove it.
> 
> Signed-off-by: Jiyoup Kim <lakroforce@gmail.com>

LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
