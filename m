Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786624F9BC0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiDHRgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiDHRf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:35:59 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35C410EC6F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:33:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h19so8970580pfv.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWTSCwpL+LxZEat1kSOLm6Y66SA98WkOuLuTeDHbBOY=;
        b=nyWjfBinfU86kLldN3MGvMLwWrnhwfPR7k3pKGK6ZNsNrVc0CELrTiP949H5bQLeKk
         IIx70qDFZ24FFVi50jCdiqYk5PxY6EirxrfP3+2GeVwvXKvmxoL1tpfA3mCtx9t652tQ
         FioOOz5cTDqtA/FDPfLsXnSo+D7RMi8LBgsJLdS+9OGm5Ml6D4xUUlQJK05L8ylzI4U8
         jp1TnZAsC8/tm7zC9jeg61D1O5s8m3sMU39yfi9EWCXXVz9aWLrujOuwSxVO2T1ptbem
         v2KUAd4rhVgK56n2ggF2FaGzTrB+P4Y6U0oYn7N6gOpQkYfpOfv538XRpdNB9GVUOdaY
         KnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWTSCwpL+LxZEat1kSOLm6Y66SA98WkOuLuTeDHbBOY=;
        b=kvSARhT8BwOkpAr7GqpuGv5jUkzx+MxcLVBsO9JvoxuMj/b9x8sfK/ujIDeTvBMMiy
         03U0xD9ux9Uns+ZjO1i5ikuDwTtH9Eyu0KrcoNXPGjS96CDdzFQPauFCoHa1NAErDkfo
         jDunsJMRdJGfFrgIJrGC6PvR8siAQ7pQo3qBiFX9qU1O0m7HUaY+7ZX8p0TsJJbL2ONd
         qrzA8E9MvI7uaTvQA+JNadQTez3ok0/zZOXBE+3lDg4y8I6i8/DFl9FSv31hRCUHoamp
         tDWXNoDGUKuX5+Tix+D4Zdj3xUFYolJ0SBrI299JkkhrbrPR1EACG89CiJ6XMY4tbLwl
         yXvQ==
X-Gm-Message-State: AOAM5300x1I3VMlbs5cP+/HxXgz1sxcGyW/FnnVpG6R71Nj28XV4IOUQ
        Iylu8G8pNW6n6AnZnIMG5Bog59grnogc6T/rv0k=
X-Google-Smtp-Source: ABdhPJxF5AIdyZ+ydJ0RBeGeKXy3z0SVAB7XnzwvpqXcdsd3dszavCZTo3rjZDGS1c+jBUdGlD3JBbCm8pYSME7spg4=
X-Received: by 2002:a65:6951:0:b0:381:f10:ccaa with SMTP id
 w17-20020a656951000000b003810f10ccaamr16018673pgq.587.1649439234602; Fri, 08
 Apr 2022 10:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220407130352.15618-1-linmiaohe@huawei.com> <20220407130352.15618-3-linmiaohe@huawei.com>
In-Reply-To: <20220407130352.15618-3-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 8 Apr 2022 10:33:43 -0700
Message-ID: <CAHbLzkpuPTy4fKM43O-AHbhv_Cvf_SSUrnBoZ=auwt=t-6wc3A@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/memory-failure.c: minor cleanup for HWPoisonHandlable
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 6:03 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> The local variable movable can be removed by returning true directly. Also
> fix typo 'mirgate'. No functional change intended.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/memory-failure.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 2e97302d62e4..bd563f47630c 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1180,13 +1180,11 @@ void ClearPageHWPoisonTakenOff(struct page *page)
>   */
>  static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
>  {
> -       bool movable = false;
> -
> -       /* Soft offline could mirgate non-LRU movable pages */
> +       /* Soft offline could migrate non-LRU movable pages */
>         if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
> -               movable = true;
> +               return true;
>
> -       return movable || PageLRU(page) || is_free_buddy_page(page);
> +       return PageLRU(page) || is_free_buddy_page(page);
>  }
>
>  static int __get_hwpoison_page(struct page *page, unsigned long flags)
> --
> 2.23.0
>
