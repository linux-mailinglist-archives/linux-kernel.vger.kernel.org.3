Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63C25A1F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 05:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243959AbiHZDYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 23:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiHZDX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 23:23:59 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6A5CE339
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 20:23:57 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x24so392983lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 20:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JNP1ORV9yRRuz9LjK0bjG2dgT1656BFJx85PdWV1CB0=;
        b=ZMoWy8eAx5EI8FJVjwa+6rX5EVAh3w5+u04QN8Zyok5BHhD+EjpBybcYjuWIg/KcRr
         wCaTfhxHzAqOiKg07LR6pGr9X/PwaynUYAaS/uCdbH3vBauGbdEkumJ8e7ZaRjzRpmCD
         j61Ge/4iGQedwgE4VFuh5OR17cll96aSRsosa3e3KTSwCtpiDq24i7t7TsCFRZh1i231
         eOzwE/BGSBtvYH7iabyB/o3B8ip5/XHLW3Dp+gcTSoLS4jJXaJXNlf6HZ3Up5EekdluM
         GIuTExtecTKCnHPfohhHJlpTtLFdDdNj7VEHGvJUjQNxTBlN3hXI8FW5sdsmA9qxxBxe
         +XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JNP1ORV9yRRuz9LjK0bjG2dgT1656BFJx85PdWV1CB0=;
        b=gdPBC9zdjiDr50cAvDv6sQSmZv4gvhUOJglVTIdBAWpZ8F/Kyb8sq/OROfgRCRLh6X
         auJ4Sfm65wd1V+Vd0sUt6WCVZS2liqvCxCM/CEMSdBuEo5iQw4XGkqPTLFHL1KMNd8nJ
         rbyEiFIqUvENZWcOb6QdCAzAvFO2UQvQllJt7sxFAeVAkw0C5PlMfSirk1KDM4L3+Rmu
         xGumPubjz0/mYaxlXL3Ib3mjjoLovxyLlNOwzYbTmMcXDcYChn0j+V0TYy86Haf83bEY
         mNCL5rhL1AEj9sd7/0rGjgdZ/sV389C6Y5lB7nP89aq9ynEybzaYyE0d+CwFiBqFeIf4
         Cu8A==
X-Gm-Message-State: ACgBeo1pFSqpBk3QRRcWhHQJIA3FoiEi3UjPNaeaMxiQx18IM+fRCXBX
        3O7Sua4m3hfUPa/SNjqP4D70SUtUBjd2JAWc4gimTqcy
X-Google-Smtp-Source: AA6agR5jQr8H/RRm3ko/w/rAnGml/+TaNwQF/PWDo91XGn4YL9OJT46UXewMJmM29wAoiSk+nFPzffJHV1KlczMEF0g=
X-Received: by 2002:a2e:beaa:0:b0:25e:34d0:4d57 with SMTP id
 a42-20020a2ebeaa000000b0025e34d04d57mr1811616ljr.329.1661484235492; Thu, 25
 Aug 2022 20:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <1661483530-11308-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1661483530-11308-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 26 Aug 2022 11:23:27 +0800
Message-ID: <CAGWkznH=Gwr_TDF3=fv+_ZH5P4QN6JXEAtH4DAzNus20pHxyeg@mail.gmail.com>
Subject: Re: [PATCH] mm: skip reserved page for kmem leak scanning
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 11:13 AM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> It is no need to scan reserved page, skip it.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/kmemleak.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index a182f5d..c546250 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1471,7 +1471,7 @@ static void kmemleak_scan(void)
>                         if (page_zone(page) != zone)
>                                 continue;
>                         /* only scan if page is in use */
> -                       if (page_count(page) == 0)
> +                       if (page_count(page) == 0 || PageReserved(page))
Sorry for previous stupid code by my faint, correct it here
>                                 continue;
>                         scan_block(page, page + 1, NULL);
>                         if (!(pfn & 63))
> --
> 1.9.1
>
