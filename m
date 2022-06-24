Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE555A128
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiFXSdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiFXSdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:33:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344462CDD3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:33:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jb13so2791532plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oZ+PpXvy2HxH++/ByJ0VVMt+4yKLSRLx88VrFeNzIf8=;
        b=nA5+j7K4V1TeMU2VczYYBNc4/mcWom0eUMDJWyRm33LxD1nD0Aeh7+Q2NUnmNdPtgl
         UXKvgNFSq/DMeu0dC20Qas3Q5S3H/9+gnhsDKRwrY5dzq8IjNFsVb41QVkkNiXM0NlsO
         v8jHwQ42PqHQoT25NHzmOhgKmEYBrjfqOjd/463jUTrlXrpxZzvKMVzVZ76yI/xYoLEj
         lbikU+utia+4sMhmD8LZgJSbe63M47Oa9cRi1JWzb/YL6BnPs69iXaHbv8W+z4NtTAJF
         WewoSwmZ9QMZDT0SPMwlNdwtMZ9EnEfcnPjJ6tF4gYlsfb4oa5Q8zK9nKJu7medf2SsL
         IdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oZ+PpXvy2HxH++/ByJ0VVMt+4yKLSRLx88VrFeNzIf8=;
        b=C6Uu55cOTyGUARMOwr5ZcJQ9EvSMDxUSkZDrEhvNPivBZkyeVBrya26L2pm4mo07W1
         2vLmqXt7l5pOK21H5J9O10jMq5zYfa+gk59uF23opeosfKMnJUG2odJtApwAIT6mVy09
         iHl0AQ0j3pDZMpVlJaRgFvxJGE3bzns3+cNGU+KARkgeGbE9IQKoGHzzziBA5iHw95fx
         gUgWyf7+wXfCu+P6vtGIMSvLHHBmq2DOm+JiKaGuRZW/amCeK6MbdiYvz2cN6SUIsNic
         /RmqOTwVIFBAshkHWjG2jxHfew9urRNQEtiSVsAKImLl+S13tGCXVw3dPC+hli61xtyz
         P7vA==
X-Gm-Message-State: AJIora9wUapiBU+Oqw9SLntNBzPyhoDZ60QD/CWuxrK3GH8PjV3v1iRW
        YgFb0lH6g6Y7W36besiztcF1TA==
X-Google-Smtp-Source: AGRyM1vmADn1bRiiefpdVyhETEib+mO4UBD8Q29ysfnoIqn4shDh+D+q+ww6pK6n2M3sWQxY/pf99A==
X-Received: by 2002:a17:90b:1115:b0:1ec:72f2:77df with SMTP id gi21-20020a17090b111500b001ec72f277dfmr239976pjb.105.1656095580017;
        Fri, 24 Jun 2022 11:33:00 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id h6-20020a17090a3d0600b001eab99a42efsm2091467pjc.31.2022.06.24.11.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:32:58 -0700 (PDT)
Date:   Fri, 24 Jun 2022 11:32:55 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        shy828301@gmail.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] mm/huge_memory: use flush_pmd_tlb_range in
 move_huge_pmd
Message-ID: <YrYDVzT48IhLhwKQ@google.com>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-2-linmiaohe@huawei.com>
 <YrQInzK5g/NJMmSA@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrQInzK5g/NJMmSA@FVFYT0MHHV2J.usts.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jun 14:30, Muchun Song wrote:
> On Thu, Jun 23, 2022 at 01:06:12AM +0800, Miaohe Lin wrote:
> > ARCHes with special requirements for evicting THP backing TLB entries can
> > implement flush_pmd_tlb_range. Otherwise also, it can help optimize TLB
> > flush in THP regime. Using flush_pmd_tlb_range to take advantage of this
> > in move_huge_pmd.
> > 
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> LGTM.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedace.com>

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
