Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1187C58F2E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiHJTTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiHJTTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:19:31 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043972872D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:19:31 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3246910dac3so151996117b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hKx1VWalS/Kw4WukWOwnOrv52qOFOeVZOoDS2/nyvSw=;
        b=nDGS9Ngr7R8HMVfZu5I+9ubbd0j2NaAEp8oNKV0QVn5OeFo1iuYRpxDtgfR1ofERGA
         Q0aIZOGzb5H0gz7tnUwtWDN0zkX7lOq4ZeY9KWI4Ggu8rFWqT7gyP/sRJMGjeU2+qp4i
         M2SX3+GDvjvzrByd4uNbKs5h6dIB+S3bNo15q14WKCUu9O1e7AEsLnIMilWNYSlM3x95
         8HvKc1ZpN6Ci3dlEaFIHqv3HgvdDzmAZmtUDRkFITKqZLAaUNkwntlWeBTbMc7dTnj0j
         54LdGXtA7MZFZ0TldAae9FeMcs0Fa3ibtNHMKCh8UJJSr67nzRNb6n150FmM3nFBkdOv
         02tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hKx1VWalS/Kw4WukWOwnOrv52qOFOeVZOoDS2/nyvSw=;
        b=iBe1k1qtCjgOH7nm3HeAF0GcVVA4BrfHIKHp1ZqD9LdBV8ga0zbJluAxJvngr/JIXi
         niSdDTsQtmNHKivhzS/qgsu2O5ahIbUyLI5e3YdQpRwPdVr5SvmQp0FClSIA73oqDI2j
         gOeOzGgbMcfW3qBAoaezpz4qF92SkamC+nt3kxhH0iZqLBJkvc6Zu38Zs8IbvJ7zKLKR
         b/CidJlO752KaIbC++qdlrlzw9YL7IhKEpLjllujcPb9sejd59evdKSOag2dw4ApfMoh
         j3veE6JsBRpgHAEVyXEUHdGiAVYn0eX9AUN1oYRMKi20khiTshZiLgC6br9fC66PWsqH
         wq7w==
X-Gm-Message-State: ACgBeo03ZYni0EYpNtvdNeomR+akEFA1cf8o81RAhIor6iBzkcpolUfB
        /TBM3sRA2L9hIuXpcJf34RxRWJjO9yyxXmq92xg3+w==
X-Google-Smtp-Source: AA6agR4pNhuhSEdQX5dtH5AS5BITIuc/wWSKN+Z/7iwgnq68yrCaELClYNgORMcTEzoHJIMq0Rf4uaPgWHmqTs3ammc=
X-Received: by 2002:a81:6e87:0:b0:323:828:2175 with SMTP id
 j129-20020a816e87000000b0032308282175mr30324091ywc.71.1660159170067; Wed, 10
 Aug 2022 12:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220808165006.2451180-1-bgeffon@google.com> <20220808165006.2451180-2-bgeffon@google.com>
 <YvG6fDHmVITsa/Kk@google.com>
In-Reply-To: <YvG6fDHmVITsa/Kk@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 10 Aug 2022 15:18:54 -0400
Message-ID: <CADyq12wAUyo4=Wya4zvD6RiVdqcwwcMqZ3xEDa1k6jVY0_o_jg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] zram: Allow rw_page when page isn't written back.
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-mm <linux-mm@kvack.org>
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

Thanks Sergey,

On Mon, Aug 8, 2022 at 9:38 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/08/08 12:50), Brian Geffon wrote:
> [..]
> >
> >       pr_info("setup backing device %s\n", file_name);
> > @@ -722,7 +707,8 @@ static ssize_t writeback_store(struct device *dev,
> >
> >               if (zram_test_flag(zram, index, ZRAM_WB) ||
> >                               zram_test_flag(zram, index, ZRAM_SAME) ||
> > -                             zram_test_flag(zram, index, ZRAM_UNDER_WB))
> > +                             zram_test_flag(zram, index, ZRAM_UNDER_WB) ||
> > +                             zram_test_flag(zram, index, ZRAM_NO_WB))
> >                       goto next;
>
> mark_idle() probably should also test ZRAM_NO_WB bit.

While we definitely can add that check in mark_idle() it actually
doesn't hurt to allow marking the page as idle as NO_WB only controls
the writeback aspect and as long as the page is marked NO_WB it won't
be written back, idle or not. Definitely happy to add it in later
versions if people like this approach in general.
