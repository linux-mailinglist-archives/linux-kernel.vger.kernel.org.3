Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF77C547CE4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 01:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbiFLXAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 19:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiFLXAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 19:00:14 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA243AA7D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 16:00:13 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id y187so4097055pgd.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=BhZn/YLFjWinGYE1K2OdXmxZD2HyQtebUnbRlvHaipU=;
        b=XQOLh4+5+zhk/9/MVE0hLR0CVKMMlJnhmGFB4iF9a7Ts+6PJ1RuGMXMh3quuBWdtTA
         /kfkAIu/0FNCipUjpi/sBkdUbbMGF68n/2NvBiyEfkRgfH3xKgMm2JkTrg5G9z6dWjec
         sQQ8yQ7EjzRdLeMsrSGINKasA2RSjC4mf/ZmPwA5n1w10+R44nmkZgRI9iZh0vf/UX+u
         B1BTPD+9Dfj1pqeKt8pO6dI+BJeRBynD/9Luk5WqGxOYMHNAoNX8f1q+N6zdq5AXHitN
         BRgeB6blgia/AqqKqGbAsKXG1XOqA1/bVL1RQZaLaEJaBrtKCPVkJCS3voZlu6umMWrx
         31HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=BhZn/YLFjWinGYE1K2OdXmxZD2HyQtebUnbRlvHaipU=;
        b=dn9nWcFsCKA1/0ZpBuRF2XxDgFvt6Izqvx/D0JkIbFAckOFsLyQGnafLIgmmfVhql2
         OmU2Sd3H866EJDu7wXm9IsZ5tNgDl6f64Olgh/dgRN9q/+FQfgaZvpsekiJg7coY3Lpo
         Uxn8EmyExW+4c08zvMAVRrDYU5drG/jJTM/FCvHwqWRqmf7cApiagBIn/rZDdrPxlXJw
         URUDLa6ZXdmoZBsy25OYkxr2xhw5BeR3iWUqzTfSqMcYRzj4pmcNB6aLRbS/iDyhjFbp
         U31Lj2AW2+2zSh6HlZBsMY3tVnuonfZ757C2DYI5iE6PacMv/pAdieapV9XiGQieIn5y
         Kf0w==
X-Gm-Message-State: AOAM531/0xRcvp1GHieVMWMRyOKdfUzGn9DJoishU4jtKKVN+rEBWRcF
        5d+sqSKS7DJLRMYQoFfSpuViBA==
X-Google-Smtp-Source: ABdhPJzpinCR6bQlEKm2X/IvwQ/rLqYYh2mcFdKHwTBVhXMpZRq60C9GAK/pHt07LiGbo9ydZ5OG5Q==
X-Received: by 2002:a63:210e:0:b0:3fd:9c07:7670 with SMTP id h14-20020a63210e000000b003fd9c077670mr34791757pgh.222.1655074812274;
        Sun, 12 Jun 2022 16:00:12 -0700 (PDT)
Received: from [2620:15c:29:204:c274:b6da:d4b1:cf53] ([2620:15c:29:204:c274:b6da:d4b1:cf53])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902821500b001641244d051sm3531337pln.257.2022.06.12.16.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 16:00:11 -0700 (PDT)
Date:   Sun, 12 Jun 2022 16:00:11 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/slab: delete cache_alloc_debugcheck_before()
In-Reply-To: <20220605152539.3196045-2-daniel.vetter@ffwll.ch>
Message-ID: <79fc4112-bc2f-c5f5-2e4-975324b69316@google.com>
References: <20220605152539.3196045-1-daniel.vetter@ffwll.ch> <20220605152539.3196045-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 5 Jun 2022, Daniel Vetter wrote:

> It only does a might_sleep_if(GFP_RECLAIM) check, which is already
> covered by the might_alloc() in slab_pre_alloc_hook(). And all callers
> of cache_alloc_debugcheck_before() call that beforehand already.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: linux-mm@kvack.org

Acked-by: David Rientjes <rientjes@google.com>
