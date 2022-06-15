Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C4554D4B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350247AbiFOWnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbiFOWnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:43:41 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1363954BD7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:43:40 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id h21so3533728uaw.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XObwvEIRFeSUPWlsccqJL2V2/Mvgt3nETnC1b9HKa8=;
        b=S2S/srd6++j7u7iD7ddlh75/PimyvVkw3xD/iReZx2VdakC+JjCSDBCASxeIHuv3V1
         v+/dVFIS1Utv6mw9teyrxzcYyDxI7VofJ4oyO6GAUplv10+0M5XXrevWfmgSicsnWWFP
         6a6FoXCgRLMDABe7hpmFkTJhwRj0JvpEG3N2C8lQkn9FQRrl6IdGuOIT6e7rjyomtpAc
         NfI6pE8pnIpMEJpgG0lC/bDDw9h0VMc9QWZG8Gs4Iz0i4IEe1pH4oSzcPrQJRgNBrKnm
         dkeBB4ax2K9f6UGVaK/PjM8jJyuxd2rJVuAu+hDcAdGOqwH/JM8t7kJbxnI80FPQaK3E
         UlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XObwvEIRFeSUPWlsccqJL2V2/Mvgt3nETnC1b9HKa8=;
        b=T87wxEEATyJjeV5Ijhw8Knhw1nDLgvO0JpisqhaXfyIlj40Lx0W3hNr2uDbx43ySv7
         cNwWEgXnuuORoD668FQgsOqRoAuqRJET7b1xq15giyGHp5B6lGGQ/Uzl5JwMrprbz8Kv
         WIj9xNrorQSJc9uo9ABkHT6BtgG8fG78KJHFTn7yAYD6wqdgmzF6Rc37pBZXlsmE/npP
         hoJzYM5RuWAP6Q2z3ge4yLERb9gp+aZmGbXaC36NtyGenvqYNbmgvi2kCqxbUDBhIYKG
         nN/gECR2yZvsUqZmptv+1L4By11hknYlw6V12dA9SYGQlBII7TFEVQ7rtkkid6tjqR6H
         ys1g==
X-Gm-Message-State: AJIora9E9e76suYrtNXlBpwPByP+EGisr9VjOpRC9/5XByq0yOpcWzUk
        UauyyTRo0mWuWeuOEslCgVhbBzd8f/wgsPEYHyi58A==
X-Google-Smtp-Source: AGRyM1sJtiK4/NKr4JQEU3uA4VG/CjXI1G2Sh5Ajk9EO+Ng8ddNV3vNXEvLWkGBvxbnZlQvEuR4WKiIkRwH7f2u+jdc=
X-Received: by 2002:ab0:5781:0:b0:37b:de3d:5d4e with SMTP id
 x1-20020ab05781000000b0037bde3d5d4emr1042184uaa.1.1655333019050; Wed, 15 Jun
 2022 15:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220613125622.18628-1-mgorman@techsingularity.net> <20220613125622.18628-8-mgorman@techsingularity.net>
In-Reply-To: <20220613125622.18628-8-mgorman@techsingularity.net>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 15 Jun 2022 16:43:03 -0600
Message-ID: <CAOUHufZwT+x3UG9guoyheUsR6rhvqMSH-n+-zWzdFUiO4_ZtCQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal spinlock
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jun 13, 2022 at 8:54 AM Mel Gorman <mgorman@techsingularity.net> wrote:
...

> +#define pcpu_spin_trylock_irqsave(type, member, ptr, flags)            \
> +({                                                                     \
> +       type *_ret;                                                     \
> +       pcpu_task_pin();                                                \
> +       _ret = this_cpu_ptr(ptr);                                       \
> +       if (!spin_trylock_irqsave(&_ret->member, flags))                \
> +               _ret = NULL;                                            \

I'm getting "BUG: sleeping function called from invalid context" with
mm-everything-2022-06-14-19-05.

Perhaps missing a pcpu_task_unpin() here?

> +       _ret;                                                           \
> +})
