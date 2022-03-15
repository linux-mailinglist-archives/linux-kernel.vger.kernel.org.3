Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5392A4D9373
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 05:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344813AbiCOEzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 00:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbiCOEza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 00:55:30 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2C2369F2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 21:54:18 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2e57826a10bso30414307b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 21:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXJSsqX5oGMRLxCD3m0yp+eu9UGao+wbB29wVMzrfDc=;
        b=EA6b8UuoTWXdRSlRV5mh8W1fHVA4d42jxkR8q1H9pK86FIFRXOeITtTRgQKWy4ZO/b
         BwkQBRbpqjpc+7u6hJUWkF+cIa+5Qdz3J45ZD0aqtcnz1NBbdVmraFAoSSygX9ZRgfTA
         cS0LHPehSfXi+Gin/xJJeX+mnxPkeQHs5q8Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXJSsqX5oGMRLxCD3m0yp+eu9UGao+wbB29wVMzrfDc=;
        b=uQoNXcOYLflVWUZ/mywZADQb+KIVZt8O6LdAw3oNzgHdR+D7Nwi1M8RzEBnSc1mSBh
         8XTJakvjNnFazhNUCkY8ERywFvUF9Oobg3CDgnhjbtt40V1pUwuLbA5rKfbKwbfobUia
         xZ4TghGjCgp+UiAwwS2P/BSFIROmPSzWQLQkiaSQLBX+RW1Ab4GG21hWPQgKRk0p+L2q
         moZjUUu5RInZnOIy46cT3272ujH1n4XP2aiTiVpVcKV77fglxyFy0aIcYXOzDA6EkUoK
         0yUSn1b2DMAdcZWOi2nnrnlsnMsO5ioDbxBRTArPq5O/K3jx5xInwjOCl8Ml5N4m/otm
         DgRw==
X-Gm-Message-State: AOAM533o5Byig93a+vl3YJh57r3q3J0jBTLaNCI6g/rH2TeEXy6kMeMX
        Ar5j/TLhtbdm/bcX5y63DEVmHWa7eiNHLrn3bvPXEw==
X-Google-Smtp-Source: ABdhPJz2SgRn+t7pTNQk1P53uQ6Gw/tiRpztmikitCBJr10puSNwrdsCdzGbvIo6hORFxP0civv3NJ7ivrsybtlxJ70=
X-Received: by 2002:a81:1404:0:b0:2dc:c5:c540 with SMTP id 4-20020a811404000000b002dc00c5c540mr21532780ywu.379.1647320057450;
 Mon, 14 Mar 2022 21:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
 <Yi/EdMA8re7PCNeU@google.com> <CABWYdi2-2ijsA2r+3_p5AoiBGt=ke7saULVum=Din3jJut_LFQ@mail.gmail.com>
 <20220315043422.1846-1-hdanton@sina.com>
In-Reply-To: <20220315043422.1846-1-hdanton@sina.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 14 Mar 2022 21:54:06 -0700
Message-ID: <CABWYdi1zbc5pN28AKA31cGkD---7ODAOKQ7Tp=d=jhYScHDNFw@mail.gmail.com>
Subject: Re: zram corruption due to uninitialized do_swap_page fault
To:     Hillf Danton <hdanton@sina.com>
Cc:     Minchan Kim <minchan@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 9:34 PM Hillf Danton <hdanton@sina.com> wrote:
> Can you test if the race comes from the diff below wrt zram_free_page?
>
> Hillf
>
> --- upstream/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -392,11 +392,6 @@ int swap_readpage(struct page *page, boo
>         if (sis->flags & SWP_SYNCHRONOUS_IO) {
>                 ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
>                 if (!ret) {
> -                       if (trylock_page(page)) {
> -                               swap_slot_free_notify(page);
> -                               unlock_page(page);
> -                       }
> -
>                         count_vm_event(PSWPIN);
>                         goto out;
>                 }

I tried it without the previous patch (the one commenting out
swap_slot_free_notify in end_swap_bio_read) and it still fails.
