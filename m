Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7467852AE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiEQWXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiEQWXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:23:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063934CD5D;
        Tue, 17 May 2022 15:23:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id n10so176348pjh.5;
        Tue, 17 May 2022 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e1pWMCgBviY11E7PKryYO1nXt87Yr/reQMp8Kk+5kvg=;
        b=GyLFU443PaMI0LYXccQ6xTFEe0FAFeKT5j+xLBdobHYlJccRr0wYD1SULa+0LJ15pj
         CbRXEM4fkhZtwS0vQ3U3VTeaDGY+LJ+7aKRlCmQCHpTctdWeKYYtZewVfGe8xd5dGora
         a2326aWXbHXwoeRNpiKaQiNGIkT8fjjcoMUvV0zYgsNEiTQq8kzk0XwzAGY9UhMGZkVG
         oqOHHAMm1erKkxCFKqTrZ29hcu4REYCGyCFw+VPNGFk/6cm4tOWAyOdcEm+R9cov7T7w
         ua1LeRrX7QsrrypjviQSZokWZn1BshVMJaVq8mnOst44zk1gXTAHU8DOJL7UuNTJQnj3
         61sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e1pWMCgBviY11E7PKryYO1nXt87Yr/reQMp8Kk+5kvg=;
        b=owwOALXnVwtCZUOXBQVfMC3LUt/9oYDWvLOpwVcH2lz47tXEnArpeOCvyV2s+OrBBz
         San0wD3UoCzS171NUjXbjBssErBlIHue5iSK9ynoN+qLQAiVF/xCSsvEAZ7qXKlh7UzM
         qcjS2pDIiFbcp5pIqFngVSFq+Raypl45RkkUEcfw4hxxlsrYd6voirQoyTmVR2KDHExm
         HQgtafLYQ7pVbx2gwPDftFxC762atoeAMUefcowDsONM0XJKcbm0evwBdr0cQXKgzY8U
         SAW+0Wd9aDVgS9Ft+41qoqSehEyUROdkwNIHFFDoRf2H4q1WixFrCBfiWdsVi58QBkjU
         Hbrg==
X-Gm-Message-State: AOAM5310elamjpiRzRPMOPui3wybAXPvwBfJ5iy/cBQ5aX1uLuho66Oz
        O9kyTYHwx7LhRtdX8WfvuxE=
X-Google-Smtp-Source: ABdhPJw7+oocr4KRLhZyU1jJUHnJ1T6v3nxM4zdgPK/CSu9aTWwC6DRkyPOHiHR0RbT6tuuSq4thYw==
X-Received: by 2002:a17:902:e850:b0:15f:3641:9cf3 with SMTP id t16-20020a170902e85000b0015f36419cf3mr24720729plg.30.1652826193434;
        Tue, 17 May 2022 15:23:13 -0700 (PDT)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902a38b00b0015e9d4a5d27sm131394pla.23.2022.05.17.15.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 15:23:13 -0700 (PDT)
Date:   Tue, 17 May 2022 15:21:00 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] bitmap: Fix return values to be unsigned
Message-ID: <YoQfzJGaDF5BQ7E4@yury-laptop>
References: <20220517212234.868181-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517212234.868181-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 02:22:32PM -0700, Kees Cook wrote:
> Hi,
> 
> As mentioned in the last patch:
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
> This splits up the patch into the bitmap and nodemask halves, and drops
> a needless change to the random node helper.
> 
> I note that Alexey and Rasmus touched on this area in the past, fixing
> up node ids to be unsigned:
> 
> ce0725f78a56 ("numa: make "nr_online_nodes" unsigned int")
> b9726c26dc21 ("numa: make "nr_node_ids" unsigned int")
> 33c4fa8c6763 ("linux/nodemask.h: update bitmap wrappers to take unsigned int")
> 
> If anyone else would like to carry this, please let me know. I'm happy
> to carry it in my tree.

I think it should go thru my tree, if no objections.
 
> -Kees
> 
> Kees Cook (2):
>   bitmap: Fix return values to be unsigned
>   nodemask: Fix return values to be unsigned

Can you please also add patch for tools?

Thanks,
Yury

>  include/linux/bitmap.h   | 14 +++++++-------
>  include/linux/nodemask.h | 38 +++++++++++++++++++-------------------
>  lib/bitmap.c             | 28 ++++++++++++++--------------
>  lib/nodemask.c           |  2 +-
>  4 files changed, 41 insertions(+), 41 deletions(-)
> 
> -- 
> 2.32.0
