Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3DB4FB277
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbiDKDxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiDKDxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:53:05 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1D537A26
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:50:52 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2db2add4516so151816007b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3zaQImLi0FzFBRmnFmLjG6HOawbZnSP9X2yOV3cxE4U=;
        b=p0wYNrWXbajDvZhjMlVAkw/+L8hLevOGmZtPSYERL7Iy5/5Rm6lIL5TzW2HVTTocg1
         Ov2DlGOZ3EofzM1oTCaPip+4Fo92sPsVTrhKfjyDwWUw8SxtkbDJNudCpCiplMt/1yhF
         2iHSVUiRIJJv+PO8Mzt173Nhyk7tQDGc8ByCpN0jEKdOcOBArU9HhbEM5iyApL5nmOel
         q3UrEU/5LTuWETFAwZteyJ8AY3j+XvMYrG9rBnUU2K0gO3otI5JYTxUTeAI2MED76wAe
         qoh0rkZEobOKqNlUEYVtTzxJvxdwcHU+D+nBL5/T+PdqV+Rhhn7e9q5/FZy8yHEnCJGr
         8grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zaQImLi0FzFBRmnFmLjG6HOawbZnSP9X2yOV3cxE4U=;
        b=7ClYfRsbnVayYop9hfXQYDyJ0hdY2alf7hUsuxR+KuAKRJd+TGFX1klm7ufhzTinrs
         NUjlqXxpNsDpVMZIL/B7OPrAr3qmbwa9RuxNr31IFhPaUSlj8WqqjSaSCuhFQx6BY/yI
         FGagi27/QV5c+G+qE7R3f08FlRDcaweBbhi9J5vIz196xJ2CIYRHYYiBgrUQGRTV2Qc3
         +7qWxceojqwZCgKqmaIgv9PIs0nkS3YYM1yL0uuwDSsHL4Xq28GKDby5FAL14DtMv+lk
         eChmlVpcTq1jn9WN8D7N3aYntbqkOTLX/RPVedP0/YuvBsaNdPKJQ05K4oU1iiKqMiJr
         rRIA==
X-Gm-Message-State: AOAM531pjZvI9lv6S4kQLeVGsFwkHWDAMJyiZLH8epQRk6yPyFw6QCLt
        MCdBVRuAP5nf9mnAj+M59p+uSIVElM/6SPPw+ki5BQ==
X-Google-Smtp-Source: ABdhPJzhLxDy+AFwGDCZdKwANIGl4tMzfwmBe3gjOWrYkaQfibluIQLxEFevjriCH95pbr43GfpdL3R0UWbjNbuJs+s=
X-Received: by 2002:a81:1c1:0:b0:2eb:7369:dd09 with SMTP id
 184-20020a8101c1000000b002eb7369dd09mr25754598ywb.35.1649649051525; Sun, 10
 Apr 2022 20:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220409144239.2649257-1-jsyoo5b@gmail.com>
In-Reply-To: <20220409144239.2649257-1-jsyoo5b@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 11 Apr 2022 11:50:14 +0800
Message-ID: <CAMZfGtXH_AdzSea6eTJk==LQXB40iN0wFP6cry8=OpDGgY0dtg@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: remove meaningless node check in ___slab_alloc()
To:     JaeSang Yoo <js.yoo.5b@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ohhoon Kwon <ohkwon1043@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 10:43 PM JaeSang Yoo <js.yoo.5b@gmail.com> wrote:
>
> node_match() with node=NUMA_NO_NODE always returns 1.
> Duplicate check by goto statement is meaningless. Remove it.
>
> Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>

LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
