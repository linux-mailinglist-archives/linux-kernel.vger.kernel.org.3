Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4149D533C25
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiEYL7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiEYL7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:59:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3027649
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:59:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ds11so19539373pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bBzKMMaiGL+EGEsjuc4MBX5f/qXIyEgcNNQtA6G0IvA=;
        b=W7qA8nhtY4E/Qs4zv/J+F2PtRVpVlxLTKZVl2y60rx5UXgTH2ir4JJQ4cbSwj/ka4Z
         rO3CyrijViPOhV/36HeqmSVxnym2O37IK10d0zhVBpBzZHKacaXQx1+fndmIU+betlvC
         iw6iu8+QfLGop+S1pacmy1CzRbKaSavv6qIFG+iLzCi0XSIRqXbUP+gXyGp+lVF+z14F
         36mEXTSjCD48u0oeV8RJ8CZcOVFWI6ZF3GLUHy9XoSh8gGflwQ04Uzb8TH2aqfQtcVHZ
         VpUMdEQbdzBoZSc/35me/V6E0Lm1H1LFQFBqhXSgfPRuNT5CutAP7Z35vIBGkL+FLptM
         UD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bBzKMMaiGL+EGEsjuc4MBX5f/qXIyEgcNNQtA6G0IvA=;
        b=5w2c6dfq3a1r5bFekrOc3TOrcLJA/r0chKb+j7cdVe4hP+sUgr/Z9xpZj/nBGnWQgW
         umA7sYk0XltBlMIq/Qk/d/MvL+waQZ48jSPc8RoN0R5JEHfK1cNr0Le1pGQim9dZ/ioj
         GORZkE4Wd8qOWpNppLspAdYNmVPxC6wifZJZzBx5poSuizs8GIg4oPcckk0uQp+Dqzlq
         T3tcQnKpe/PL23U5hrwFu6OWPxHISuLe8RhPI4+zyKHBtcA+SRM5JPQzqAo1zcBaoAyu
         WrztpeYR+3kPDt8cRPpOhqe5ORNwTbQoWQc9EA7oPDlLe/SJgwGM2B67Lckkqa5ftAjc
         d9zw==
X-Gm-Message-State: AOAM530qa2yoyxSAGBJHrAdWpUmy2qk4aqIjXT+2NoH6Zrw18UZzcZyy
        JHpp6zY/p6VYazAgROunQP7rqQ==
X-Google-Smtp-Source: ABdhPJxeRiRhJV7jRC/kDWa0f137Mc2dpQgBTgEXJ4ruDmxrqVeRSF0WsLz70rU8W/p4GmkxSZaWfw==
X-Received: by 2002:a17:90a:1b4a:b0:1e0:a104:b730 with SMTP id q68-20020a17090a1b4a00b001e0a104b730mr4353940pjq.160.1653479954347;
        Wed, 25 May 2022 04:59:14 -0700 (PDT)
Received: from localhost ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090a4a0f00b001cd4989fed3sm1424770pjh.31.2022.05.25.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:59:13 -0700 (PDT)
Date:   Wed, 25 May 2022 19:59:09 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 10/11] mm: lru: add VM_BUG_ON_FOLIO to lru maintenance
 function
Message-ID: <Yo4aDaiADXqFnbk8@FVFYT0MHHV2J.usts.net>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-11-songmuchun@bytedance.com>
 <Yo01ghDEu4KcYKpH@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo01ghDEu4KcYKpH@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 03:44:02PM -0400, Johannes Weiner wrote:
> On Tue, May 24, 2022 at 02:05:50PM +0800, Muchun Song wrote:
> > We need to make sure that the page is deleted from or added to the
> > correct lruvec list. So add a VM_BUG_ON_FOLIO() to catch invalid
> > users.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Makes sense, but please use VM_WARN_ON_ONCE_FOLIO() so the machine can
> continue limping along for extracting debug information.
>

Make sense. Will do.

Thanks. 
