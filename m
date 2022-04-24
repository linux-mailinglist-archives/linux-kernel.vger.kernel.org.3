Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F5650D4C6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiDXTSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbiDXTSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:18:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329E414080
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:15:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h12so18739662plf.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=jsx4mhumyN262gUb7FrEPxMNx1chS7GsJEszWuM5D/A=;
        b=Wo51Oxn2QBu17Kg6Ckcp5bmLU8e+B4E8VD8j14crRBfjC86gG/U1y40DNw22nLBdRX
         hV0rVVJD+P/GTrAmldnks0n0noeDYEERzQ3zwbYMJ6rRnXHfqLFcvKYAWyDZw3DwyXi9
         BkPFym80fDvv61vi+J+CuqFvcB8Udk0iGnFEQRTHn8tNCu6/+8r8dJ4YYR/5y+SM1PV/
         cJvPrj+seMmvsTSESZQxqCh6r8Ycz6Yal/aiqAE0z0T1okFQwoGINm6SwcmDqLGt2mQn
         8nouGyPlhLb08BxvHN70GpQsLelVKBZ3RChs1GvrmCELqRdyxPuFb08t1LCRzEG7/Qr6
         6Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=jsx4mhumyN262gUb7FrEPxMNx1chS7GsJEszWuM5D/A=;
        b=OO/6sbbC3rOhFLAY+beT1A5ax44c4aCB7gM3tJCTH3kK7I41NMlawnvTRVK6jpF5lj
         sp58HHObBzj/ElBDh35TmzWDaIvrXV/FmYKzZ4sFon3VSj4txfV8TUltqupIlJhmN3O9
         WE5i0kG45cw3SCohfhRpVv8RDeRvAiH8GAoltOx26aSmTJ+IcIj2xJr3L2OsSR2S0n5d
         +ERpNvtMWMr7FVzxlmmBbFUJVf/VrWvy3suPdELlXCijvDK1XtAgfGETaRSRoT5MsVqm
         lhkXLPCJ88BT0JMGA+/xmAqo6o8KDdfcWxG7/x28ALMGjORLykKMceXofm6ZPiJuFvgy
         Ap1w==
X-Gm-Message-State: AOAM533dumg3R64VoK2z7VcEie5YvWeh+WotXn+qu1/Yvfj0DpP2BA4A
        on0WsPvIzNLda6kX0mrvsYUjKQ==
X-Google-Smtp-Source: ABdhPJxErEZvneHieQ1EqeKHlqIJ3de1/bJPxlpbuZEV4KrBg6XGSmnIkPJFh+dSRl0AfqymrzMBow==
X-Received: by 2002:a17:90b:1e49:b0:1d2:9d82:8bb1 with SMTP id pi9-20020a17090b1e4900b001d29d828bb1mr27937373pjb.226.1650827720436;
        Sun, 24 Apr 2022 12:15:20 -0700 (PDT)
Received: from [2620:15c:29:204:d4fc:f95c:4d79:861f] ([2620:15c:29:204:d4fc:f95c:4d79:861f])
        by smtp.gmail.com with ESMTPSA id c9-20020a63a409000000b0039912d50806sm7313352pgf.87.2022.04.24.12.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 12:15:20 -0700 (PDT)
Date:   Sun, 24 Apr 2022 12:15:19 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Peter Collingbourne <pcc@google.com>
cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vbabka@suse.cz, penberg@kernel.org, roman.gushchin@linux.dev,
        iamjoonsoo.kim@lge.com, Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3] mm: make minimum slab alignment a runtime property
In-Reply-To: <20220422201830.288018-1-pcc@google.com>
Message-ID: <5cb2b96c-4f5e-d278-534a-d9e1ea989cf@google.com>
References: <20220422201830.288018-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022, Peter Collingbourne wrote:

> When CONFIG_KASAN_HW_TAGS is enabled we currently increase the minimum
> slab alignment to 16. This happens even if MTE is not supported in
> hardware or disabled via kasan=off, which creates an unnecessary
> memory overhead in those cases. Eliminate this overhead by making
> the minimum slab alignment a runtime property and only aligning to
> 16 if KASAN is enabled at runtime.
> 
> On a DragonBoard 845c (non-MTE hardware) with a kernel built with
> CONFIG_KASAN_HW_TAGS, waiting for quiescence after a full Android
> boot I see the following Slab measurements in /proc/meminfo (median
> of 3 reboots):
> 
> Before: 169020 kB
> After:  167304 kB
> 
> Link: https://linux-review.googlesource.com/id/I752e725179b43b144153f4b6f584ceb646473ead
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>

The command line options are described by 
Documentation/dev-tools/kasan.rst but it doesn't look like a update is 
necessary.  I think the assumption today is that if we're using kasan=off 
then we aren't doing the alignment.

I do wonder why kasan=off is not at least mentioned in 
Documentation/admin-guide/kernel-parameters.txt and perhaps for all other 
kasan options point the reader to Documentation/dev-tools/kasan.rst.
