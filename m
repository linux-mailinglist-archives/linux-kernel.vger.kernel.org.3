Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E00A4B0A27
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbiBJKBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:01:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiBJKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:01:26 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8F4C02
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:01:27 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id c14so4379506qvl.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=x84sC9uSV7SvE6YCsXqiRE2h863nfks8o8GtAi2bk20=;
        b=iZ95zCDFX/WrlBSoL3NGgb6SJPZJDSzV0q00eFQecTYJbneeyTgfbWE7B8Sy2GqgYp
         mrTaZmEq/TZ1om9cDFhwnKkesoUVbZxQvVb9hL1FRo2ca2EnsL9vQ0G82qMtg4gpf+g1
         AZIVyV04hL91/HhiuKH5iydVP+eV2fgEI1bLU7+PInm1zr23WwVJQ57kZpUWoS6LejF/
         d44wWy/XBkqccS+4jcKqYBc9PcNuPcC/Ay786PPMO6O/8qnLD5pSjCl7zPmxjqLEOgU+
         wFpRZo+/DdzMBR4XfVB1kgq6ulDh8RZIqN9Tl94gJxjqT7dfv5LO6S9dUH2UNEGVtb1M
         ldOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=x84sC9uSV7SvE6YCsXqiRE2h863nfks8o8GtAi2bk20=;
        b=JAZEi6P3U7RNSQKjLBZlTWowTNtXnDNPk/pq21MFHOxC2gYVCsGerx0gpKTQrCt/yt
         oFYtjQDL5pdwTmlHWQUDmfGEqziqeUj8pBZKR0kiRLJWVgvsy9JOzjt3nVdGrbPMHq2D
         kGv56uJERAjfL0HafVgwEf5Zv59zTaBeeCj94gmtt9XFrWJUZf71dukRwHtvG59a2UxN
         99ZUIVvspuImUNAuFPA58BJzAudIm7y0jI9WMx9mj8ecu0k+XKSjvByPcdgSes+a0s4q
         O9yL2CzPHF9t18a3ZG8q84rehIVPT22PG5V09bpyylwg3U+PGfaIdTVWu9LEv2LrKnkf
         bAKw==
X-Gm-Message-State: AOAM532aEYiM/67leH5rmH4kDuDBP4tVgQuGmaBZtk62ppgRUOozaMQE
        hy47OawHqvERb41AjF99N4V9AdqeiuS3PlSvr44=
X-Google-Smtp-Source: ABdhPJyiysS2qGntUiIxJeUSzA64FCpnVdzQNUM6AuHhhBlIGWyjPoaYSJy6UyZT/JVTkYYDodc/FP/j4EPUd36Oaag=
X-Received: by 2002:a05:6214:c89:: with SMTP id r9mr4410097qvr.77.1644487287100;
 Thu, 10 Feb 2022 02:01:27 -0800 (PST)
MIME-Version: 1.0
References: <1644483715-7981-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1644483715-7981-1-git-send-email-huangzhaoyang@gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 10 Feb 2022 18:00:59 +0800
Message-ID: <CAGWkznFei0igVSRRsSHuC+dnu6PFHrQJ1kjJFE+qEV1c2c1prA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: record context on page->mapping
To:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

There are some places to modify as 'free_pages_check' for the formal
version, just RFC here to see if it is doable?

On Thu, Feb 10, 2022 at 5:02 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Since page->mapping is vacant in the pages which used by kernel(drivers etc)
> Have it record current context to help tracking the page's owner in system
> memory dump.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c595274..2757d10 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2430,6 +2430,8 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
>                 set_page_pfmemalloc(page);
>         else
>                 clear_page_pfmemalloc(page);
> +
> +       page->mapping = (struct address_space *)current;
>  }
>
>  /*
> --
> 1.9.1
>
