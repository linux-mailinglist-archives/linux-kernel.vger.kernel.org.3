Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53A14AE45C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387467AbiBHW2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386645AbiBHVBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:01:24 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE6DC0612BC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:01:23 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 192so175303ybd.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0l/46u8AZdLsXUbvuQUU485sD3pVp7EO/xSTTeL7cJM=;
        b=I6UYi9kkOMT9ddLuK3RphTOoWfxZRmyQVibkm2fFhnajqkBSlf14Q7WYN/fGMFsDli
         DE2IgaJM90B361A7HdTnYwS8c2La3jGWOSzjm2JcfQBstBkNZU++5vi1sEqHSRK3f/Yv
         MZAWCl3PHgpp8rVOCJwsvi2/nnii0OgHVhLdBejC3n1KxAp/1VrWLACdwFQxjPuWTNXk
         rKYBSYZuqVjd1RnA5Q99LfnwZADSRC2oIxTuwWNqzAEocO+OJn0qLwMkq3v3T/robeFM
         naj0UCn+AkfURPzWzOTp1GFHB4QYdTRo3pV7xDlpscDMnJ74+1tDLCZFlimNvvT3YEZn
         1OxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0l/46u8AZdLsXUbvuQUU485sD3pVp7EO/xSTTeL7cJM=;
        b=NA4jtrjxlBGxXyY8AJA90yrkQirhv7TigcaOMPu7J7NgnBXLylYhMEhNv+m+58TJFl
         E0EU86AslmbrNR58+dE/HamD4dzjiNRtSz/oU+dRgjkLCpr975RVF+ZiWiK5LA1qVxYF
         bpT8PCxN5r/mOwpmmF0pNFmVAyC0P5P4D6tut0IQaNuHJlvH90EucwNqLNvpHss7e7g1
         AXZ6PceGMlaY+Ytz66J6JS5Nu8CDCZmW66S39/DHHYmQd65RlW3u8IDetJkPU8EY+FgQ
         vR8nU/umBShn495RyEr3dXfZS3cbncXOtlHzUCz7rF36Y+enSNX9t3gTf6xhCgTodigh
         RUSQ==
X-Gm-Message-State: AOAM530ko/qKsUViEtjqagS5Ay9xNyWSovwvprBDRdGOgK2JY0k+mc51
        zsLiIM3fOtT7jPppFjgF4tl4Q8RAbVnsja9qk+yQIT1LU2WsOg==
X-Google-Smtp-Source: ABdhPJxEEHahkNZiuy7H+1EBwmPjo/Hl9B+TdeAPt4ZWDB5jM93kJLOKDwL5ViCTTyBQvySlw0bxY+shfJhBtj+ozkY=
X-Received: by 2002:a25:abaa:: with SMTP id v39mr6351030ybi.393.1644354082773;
 Tue, 08 Feb 2022 13:01:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:174d:0:0:0:0:0 with HTTP; Tue, 8 Feb 2022 13:01:21 -0800 (PST)
In-Reply-To: <YgIseIEMotD2jg83@kernel.org>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-4-martin.fernandez@eclypsium.com> <202202071325.F8450B3B2D@keescook>
 <YgIseIEMotD2jg83@kernel.org>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 8 Feb 2022 18:01:21 -0300
Message-ID: <CAKgze5a_o=+f6fE55p4D50qZSRNUEHUWBe+Fn8Fc=1RjFLfgeQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] x86/e820: Refactor range_update and range_remove
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, ardb@kernel.org, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22, Mike Rapoport <rppt@kernel.org> wrote:
> On Mon, Feb 07, 2022 at 01:45:40PM -0800, Kees Cook wrote:
>> On Thu, Feb 03, 2022 at 01:43:25PM -0300, Martin Fernandez wrote:
>> > __e820__range_update and e820__range_remove had a very similar
>> > implementation with a few lines different from each other, the lines
>> > that actually perform the modification over the e820_table. The
>> > similiraties were found in the checks for the different cases on how
>> > each entry intersects with the given range (if it does at all). These
>> > checks were very presice and error prone so it was not a good idea to
>> > have them in both places.
>>
>> Yay removing copy/paste code! :)
>
> Removing copy/paste is nice but diffstat of
>
>  arch/x86/kernel/e820.c | 383 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 283 insertions(+), 100 deletions(-)
>
> does not look nice even accounting for lots of comments :(
>
> I didn't look closely, but diffstat clues that the refactoring making
> things much more complex.
>

Yes, that diffstat surprised me as well.

I have to mention that 110 of those lines are kerneldocs and blank
lines, which is quite a lot. Also you have to take into account that I
expanded most of the function definitions for better formatting, which
also took some space.

And as I was able to focus the "hard" part of the problem into a
single function, testing can be done easily as Kees suggested and I'm
planning to do so in the next patch.
