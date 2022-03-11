Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9E04D6A68
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiCKWrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiCKWqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:46:46 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4941F2DAF4F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:37:03 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2e2ca8d7812so47786517b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DREXPNc2JSl0V5RZY2vCdvrUUa88K+pQUjqT8ymWxMk=;
        b=O5Q8bxA/KkmDCq6uqRmKbEj/kc8mUESHJC5dAzxPo/3xd3SdDKMrP2QVqRMCCgr3TH
         MocubDdpCRCus/XBr2Ilzqbxokz5l8MQJdMGCOleXY7keRw5WHYICMvC770ECBYk43MN
         jBs9nx1C5E3cOPY8PUqY1eacT+koo1SGbBuuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DREXPNc2JSl0V5RZY2vCdvrUUa88K+pQUjqT8ymWxMk=;
        b=BGH2nEbc3nijxB+TJCf3tN8ccdMk+sQ23Tigf23LhZG4Cv5fghpHMDaX0OH3EmhLBT
         tCLqyVn7or8nNviDDvy4hpLmJuPL1pENTp9q2igtDAPVjZWiqAzucHr2iwAppUTG5mWj
         NgWvXToByGQlweEqBvRvp4QpfQXw2H01fKcr4mszJSFEgs+1kwISy+BMshpF0SGukgYN
         7AiwvYbc6LgaUCM+k1U6b8RbjbxtugycpCQweEEgJgawh17+MQuhxOdZf9mDCoeBuUJR
         3BoDQI4LiwP3dOyjoLp3KlUEgnZUvuH9bd8a7VEey3otNvxcTfKzgiN6XDEgCzgX5gNx
         NeDQ==
X-Gm-Message-State: AOAM531HnhsbBjGyXdomvoQCA9/NwZ5CPIe2i47hj7o4f2fsqx9iqiT0
        jNiJGRAyPEKUC8kbuMZgAYwFM24RjvqUTAje/79KiQ==
X-Google-Smtp-Source: ABdhPJxD9C+lmjCFUuGqD3d+t0UpXnibKp2g1hAFOkt/GuhNL0o7REY2rjJEqu0+69tDgnz526pRiNrNgibT2VMGHTc=
X-Received: by 2002:a81:74d4:0:b0:2dc:5a9f:c830 with SMTP id
 p203-20020a8174d4000000b002dc5a9fc830mr10697375ywc.32.1647038222492; Fri, 11
 Mar 2022 14:37:02 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi2a=Tc3dRfQ+037PG0GHKvZd5SEXJxBBbNspsrHK1zNpQ@mail.gmail.com>
 <CAOUHufb=GQaX_2Bp2YfY4ntBZj8iwb8z9mvxUFXw+KkySRu+KA@mail.gmail.com>
In-Reply-To: <CAOUHufb=GQaX_2Bp2YfY4ntBZj8iwb8z9mvxUFXw+KkySRu+KA@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 11 Mar 2022 14:36:51 -0800
Message-ID: <CABWYdi3iJ45pSgj-OrxATVXR7-MHb3DZ-UkERPvo9L=h_qtzgA@mail.gmail.com>
Subject: Re: zram corruption due to uninitialized do_swap_page fault
To:     Yu Zhao <yuzhao@google.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
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

On Fri, Mar 11, 2022 at 2:30 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Fri, Mar 11, 2022 at 12:52 PM Ivan Babrou <ivan@cloudflare.com> wrote:
> >
> > Hello,
> >
> > We're looking into using zram, but unfortunately we ran into some
> > corruption issues.
>
> Kernel version(s) please?

You can see 5.16 in dmesg output. I've also replicated on 5.17-rc7 and
5.15.26. The latter is the LTS version we use in production, where
coredumps and rocksdb corruptions were observed.
