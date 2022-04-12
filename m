Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD704FEB02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiDLXrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiDLXrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:47:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89B12CC8C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:35:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d15so396125pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=v3LmgCFYjJTtgy2P/sVi0E16CrjX+gEYqyGQNLsRn+4=;
        b=WF/gxV4Uzq+1Ie+JART8CiACqUetITjYYftWV6JzqUCORfdhubyUb5jExhtOFxoxN/
         Z5yb6G4gjmKkJ4FgHguSnih2sQW6cauW1RiaJQMVp7G05cWN2Ea4SmDVsDe6EwqpLCr/
         COalLlnFXB4OoUMPlxzQTvBWQeD5Tl5nfFV4jmYIVYDUcLLX7vl52Y2Dok9cXu/terpo
         3pxuStP/tE7ZsQ0BfML0wQXhtyr8kLERv2H1UQUj3Ln5A2D9v3PAzb9Xgslaba0BkSes
         BBEfilcWGopjWK/DLHyYEHAT0IT/q7/NUfttAmPS4IswCBdUtLxoY/N+Rb1EXZUFIhGS
         9LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=v3LmgCFYjJTtgy2P/sVi0E16CrjX+gEYqyGQNLsRn+4=;
        b=jLtKrrsKHpir9MUD0srtEGQrknMY4OhNfzK5KjVWpnM0xox/RaNQKgcVeslZjfr8ht
         BKyZhMEYzSr+CzFpzUg1gJqUvtHnHZ9yfJP77Hd5dFxW4WNU+eCseeo3fSCMEwKIA4iT
         /w47G1svEMrA7AMvv+puUz1O8py710a9d6b3z3qIHeiGOt2Fuoz4nRknvH/FPlsPmu8W
         CvLeWymXLXK4EV0byzHn/py8dWcIV+qqsJbPr0Zwgdbvps4iIRXCZQp9sZKvkGSE3nU9
         IubMaxPgXGQdFiaFjVIZfn8Cpd6J1anANlTIxa+uGJWw+Zo0JtjhTWaJyYLNM14Pbnc3
         78kw==
X-Gm-Message-State: AOAM532kNvCPF9F/6fWyCTHDDNdjNmT8ki4BCxMq2tGmO5gX43wb+hjU
        AFxct7IbihkgVuR9FDD01fpLJQ==
X-Google-Smtp-Source: ABdhPJz/mXbbbncHMs7aYHE5yX2Gf+irBnmESeOYzYPCGTcqSEOVSMz7JDK47tpFFlazpajv502rNQ==
X-Received: by 2002:a17:903:4c:b0:158:8e21:213d with SMTP id l12-20020a170903004c00b001588e21213dmr4386023pla.108.1649806504282;
        Tue, 12 Apr 2022 16:35:04 -0700 (PDT)
Received: from [2620:15c:29:204:1a89:45ec:16da:55dc] ([2620:15c:29:204:1a89:45ec:16da:55dc])
        by smtp.gmail.com with ESMTPSA id f23-20020a635117000000b0039d4f859738sm3859103pgb.71.2022.04.12.16.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 16:35:03 -0700 (PDT)
Date:   Tue, 12 Apr 2022 16:35:03 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     JaeSang Yoo <js.yoo.5b@gmail.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>,
        Christoph Lameter <clameter@sgi.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: remove unused parameter in setup_object*()
In-Reply-To: <20220411072534.3372768-1-jsyoo5b@gmail.com>
Message-ID: <89e4e3a4-111e-18fb-3542-acc45b8431cd@google.com>
References: <20220411072534.3372768-1-jsyoo5b@gmail.com>
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

On Mon, 11 Apr 2022, JaeSang Yoo wrote:

> setup_object_debug() and setup_object() has unused parameter, "struct
> slab *slab". Remove it.
> 
> By the commit 3ec0974210fe ("SLUB: Simplify debug code"),
> setup_object_debug() were introduced to refactor previous code blocks
> in the setup_object(). Previous code used SlabDebug() to init_object()
> and init_tracking(). As the SlabDebug() takes "struct page *page" as
> argument, the setup_object_debug() checks flag of "struct kmem_cache *s"
> which doesn't require "struct page *page".
> As the struct page were changed into struct slab by commit bb192ed9aa719
> ("mm/slub: Convert most struct page to struct slab by spatch"), but it's
> still unused parameter.
> 
> Suggested-by: Ohhoon Kwon <ohkwon1043@gmail.com>
> Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
