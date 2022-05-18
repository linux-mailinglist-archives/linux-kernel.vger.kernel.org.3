Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9DB52C5E0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiERWDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiERWDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:03:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE715BACD;
        Wed, 18 May 2022 14:55:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ds11so3386647pjb.0;
        Wed, 18 May 2022 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KM1eXTiTl5yuttLrQLp0SvlyssgNat2NOVrSe7NxjGw=;
        b=o4n5aTNjF/u4if8Lr3OS7bHsgZIvG1FCdJXW1XsanajWZ7TA98MqoY1TOevBMF3JHq
         Cymd+V0oOgILdZtTNw9qinTGyGITGwR4CErE7hRG2tAgWOP/6xE9S+6y31YVQiY9bExG
         KWouDXNqiXQtYjD3UtlzO4YVz5adDiKtaF3mC5qffjddZBeCb/mQrmTcf4IKBfxXxngV
         f/sv6PEdMSUuhSPG2RWrobH9BiOLlnRplkrhcJVK8DzSr+XjDd3XGYR1tEyvqAIW5Hhe
         NkMF6gnRPDKWxcgOEtY3PE/NCic/qnZhw4VbgibDOYl1Hr9mjihzBIcg3CpGJUZRN1Qn
         lkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KM1eXTiTl5yuttLrQLp0SvlyssgNat2NOVrSe7NxjGw=;
        b=U41InmvzeRh8j4gt/bZ0fqSf4MMVS4l0Hq45FHOzV28Xg4WqbGj2KvbrtfKlKQrsh7
         FltVxiWeIHtl6GtuqtM3pzGIVZEIN1mFnCXPjvm2tuNDIaysthDT1H9LATPPzfq18D/A
         3GaPm1TNdEJChngYvQkZqLKyjYfv08JEv5JSt1RYmL1rz89CcMEVcwm/WF4LZ0XLVreM
         Tg+D2kwSZ59C3gfsBqfsAedUcVB67gMTiL2aYSlr/pxofCvMJBsbLbcXiJCVNQ8m7eWP
         3yK6qUrQdj4MqOEga7v5stwQBu1scJh55haCOVF7AhBbznUZndXoMLf2O7EW0b88av2u
         hdvw==
X-Gm-Message-State: AOAM532A0v9rLZeOCwtlAjSwhILB1aQ9tcQMyBb6kYQXKp13eHqs4wdF
        eLg8gWMj9vA+/qy/jaXg7dM=
X-Google-Smtp-Source: ABdhPJwfb/uBX1lO7XaWsHjBvhjxhn8kXGOrh0WF/jltFB138/jfo3D4tWbXmxzwCpKjmdDA57+vjQ==
X-Received: by 2002:a17:90b:1955:b0:1df:a48e:4597 with SMTP id nk21-20020a17090b195500b001dfa48e4597mr1538151pjb.187.1652910937087;
        Wed, 18 May 2022 14:55:37 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id n9-20020a629709000000b005180df18990sm2431142pfe.168.2022.05.18.14.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 14:55:36 -0700 (PDT)
Date:   Wed, 18 May 2022 14:55:36 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/2] bitmap: Fix return values to be unsigned
Message-ID: <YoVrWLJwIfJJugxP@yury-laptop>
References: <20220518205223.2908736-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220518205223.2908736-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:52:21PM -0700, Kees Cook wrote:
> Hi,
> 
> v1: https://lore.kernel.org/lkml/20220517035411.31144-1-keescook@chromium.org
> v2: https://lore.kernel.org/lkml/20220517212234.868181-1-keescook@chromium.org
> v3:
>  - Update missed int variable to unsigned int
>  - Update tools/ bitmaps code to match
>  - Adjust whitespace a bit
> 
> Rationale repeated from the last patch:
> 
> Both nodemask and bitmap routines had mixed return values that provided
> potentially signed results that could never happen. This was leading to
> the compiler getting confusing about the range of possible return values
> (it was thinking things could be negative where they could not be). Fix
> all the nodemask and bitmap routines that should be returning unsigned
> (or bool) values. Silences GCC 12 warnings:
> 
>  mm/swapfile.c: In function ‘setup_swap_info’:
>  mm/swapfile.c:2291:47: error: array subscript -1 is below array bounds of ‘struct plist_node[]’ [-Werror=array-bounds]
>   2291 |                                 p->avail_lists[i].prio = 1;
>        |                                 ~~~~~~~~~~~~~~^~~
>  In file included from mm/swapfile.c:16:
>  ./include/linux/swap.h:292:27: note: while referencing ‘avail_lists’
>    292 |         struct plist_node avail_lists[]; /*
>        |                           ^~~~~~~~~~~
> 
> 
> I note that Alexey and Rasmus have touched on this area in the past,
> fixing up node ids to be unsigned:
> 
> ce0725f78a56 ("numa: make "nr_online_nodes" unsigned int")
> b9726c26dc21 ("numa: make "nr_node_ids" unsigned int")
> 33c4fa8c6763 ("linux/nodemask.h: update bitmap wrappers to take unsigned int")
> 
> -Kees
> 
> 
> Kees Cook (2):
>   bitmap: Fix return values to be unsigned
>   nodemask: Fix return values to be unsigned

Applied on https://github.com/norov/linux.git : bitmap-for-next.
Thanks!

>  include/linux/bitmap.h       | 25 ++++++++++++------------
>  include/linux/nodemask.h     | 38 ++++++++++++++++++------------------
>  lib/bitmap.c                 | 30 ++++++++++++++--------------
>  lib/nodemask.c               |  4 ++--
>  tools/include/linux/bitmap.h | 17 ++++++++--------
>  tools/lib/bitmap.c           | 20 +++++++++----------
>  6 files changed, 68 insertions(+), 66 deletions(-)
> 
> -- 
> 2.32.0
