Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A1547DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbiFMDVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiFMDVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:21:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E534205F2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:21:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so7584264pjm.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qbAkkO2zSW3z0Q8/BVx6T9JB6N1UA+DX5z/rLPoFpPg=;
        b=1NGXFsXFPUAUMfe9N4JthX1ALkYAWYMsOuYDyQtcQeW8WNFwZlcHItd6XrM+lng3UI
         Rt8zNF+zxAVQWenqcclBqxhu/Xxcn8j6sBXL0Vs/E0KHyZDDP8ejdsufZhWWAEQx8IUF
         aPs9uCjcBNIjeaM3oRwnjC7VxRpdjBRyJDmBA3koSCVptEqjkDJAp/clVapRzZK7ivQt
         vvIiT7jbLJuwAp1rHkKsK8q/MFc8GsBuxLrD/3Rh6x7b8DZ/wsoFLkc7jS2kZdxRtLkQ
         JbuYUgDS79x7n4D6hVdrAFjYjrBaho7I6QHY9iGc3X+OP24M9FH+2CgJEl9gSFtl/hNL
         54jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qbAkkO2zSW3z0Q8/BVx6T9JB6N1UA+DX5z/rLPoFpPg=;
        b=VXgzRYlv3x+mX1QEuHrRrEmhYWc7EC1RFjLmJ29IXJ8w3ENY7eLe6/Cq+jn2HJ6ThR
         VrNlDK17Q0TNAR3A1GRb7SjRqvZCpk8B4XGvCLvHoqoPlVfRxkDfEczvhXLnNuuumpwy
         p/rzkcMJtxhatLN6h+2Eggxu8UjOPI5W0GFhxkDZhW2VFnVG4nr0lcMi9zsRAE8CI5b1
         Mn+pJu5D46oaJPsdZe2fYCxDE74T9kjZuy/QziE5QDmdWrWbl06DAAEFWeQSPXtBgYGC
         aaGuN1DRa7yzNgnvuEuXwRB8Kg0SdmRJGCO4IVYsAfMCgtDfph02pPzEhbDyU0SHK+eA
         foFw==
X-Gm-Message-State: AOAM533vIfe7AVQ2ozXlOIIGy5D3yS5X2wziTYxgBCuQ8nxOJXqAsiU0
        hbWIFrSHUu/Y17NB1oLZ0atHwQ==
X-Google-Smtp-Source: ABdhPJzqH8tH9ELakOc22/fn6gukK9gQTVOUDUaR4Qen3wkF/IolOLy916cLAPA6O/e/2Leo1Zot5w==
X-Received: by 2002:a17:902:f612:b0:14c:e978:f99e with SMTP id n18-20020a170902f61200b0014ce978f99emr56667491plg.23.1655090500604;
        Sun, 12 Jun 2022 20:21:40 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id i3-20020a62c103000000b0051008603b66sm3967995pfg.219.2022.06.12.20.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 20:21:40 -0700 (PDT)
Date:   Mon, 13 Jun 2022 11:21:37 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/slab: delete cache_alloc_debugcheck_before()
Message-ID: <YqatQWUmB+Z7BxK3@FVFYT0MHHV2J.usts.net>
References: <20220605152539.3196045-1-daniel.vetter@ffwll.ch>
 <20220605152539.3196045-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605152539.3196045-2-daniel.vetter@ffwll.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 05:25:38PM +0200, Daniel Vetter wrote:
> It only does a might_sleep_if(GFP_RECLAIM) check, which is already
> covered by the might_alloc() in slab_pre_alloc_hook(). And all callers
> of cache_alloc_debugcheck_before() call that beforehand already.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Nice cleanup.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
