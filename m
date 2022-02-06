Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435B34AAF5B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 14:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbiBFNLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 08:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiBFNK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 08:10:59 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B19C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 05:10:58 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id r8so18863448uaj.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 05:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iScy5PVQQp5zcHLmQtmJMBYZvDFPbaH4SggLAANygi0=;
        b=qA39hxj3DmJSrB5Jd4ShiDXwRtToy+5uPonMnKczBj+3fpRyNySLKqhdzhWwNN4QBb
         FlpNni9652dC2cjtIk/iEzcNuBanzGOIRVtgtwjAd+rNCVSh+Ov3Bb49hgKSSChLSDGH
         4RGoPIUn68Tk7/qAxGXX8lt9LLDYrq1acJUyNQNgkenzluTnnFaFFXGxg/2H/LcIztYS
         ODpIdFOxNL1b1vc6MRfYxgJIJGf9cFMuRIdtlYQQLoF+JS8CcPQMF4M4bSSRREcLE3sm
         i83ndYG+OmATsc9PN85gypvp58Daa7afBGlpstatnMZvpBHHH+F1hNw4LHhgAlJ4sa97
         3uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iScy5PVQQp5zcHLmQtmJMBYZvDFPbaH4SggLAANygi0=;
        b=GEHHHziekyFIW8yIqcV93H7dEWeE2YFEVZXJQsFjtanRvEjQe4LjT0taEJDCKzTtXz
         Cyu1fgyGHdxJyu6xJr00PDfwssiA1uqcZ24exRAGh2KL37Bn0c3YL89h9qe21zkbdKdM
         Qcj9t0mQICpbcIoR/MMfjQ168Nbpkl4xSGp/12Azq0Woi8UTW8MflsbZRTkQmmXdFhr5
         nx5vy4XKI87/T/VaFeVaLIZHz7MREcTvU6FYSnH93Yz+unyDCS8hXTKFEfBq7G07ciRA
         OLqsx4Hlvvm7d9N7r/YLbROdhs+s/C2Z4aCFRow+2D4jJCn6O6BshFe+ir6Zq2FO6ZTO
         XHyg==
X-Gm-Message-State: AOAM533Fr30iSu+ONdGSREvS4baJhF/o2+ITTz3VMBqPYV4JNrhV5Swg
        +yRtPQAJL+XVqBl+BXqQl67PudCjL3KnR8JA8Xo8K+kVUGE=
X-Google-Smtp-Source: ABdhPJyuLyOIA8XoHNWRIa+k8mhuYxKIoWtzMTZFB6xRuHqICNwRs+tJ/KCpzaFWNH8pVJKxRD4uyDLfD6RWb7qs7Q8=
X-Received: by 2002:a67:b00e:: with SMTP id z14mr3217362vse.57.1644153057985;
 Sun, 06 Feb 2022 05:10:57 -0800 (PST)
MIME-Version: 1.0
References: <20220204195852.1751729-1-willy@infradead.org> <20220204195852.1751729-72-willy@infradead.org>
In-Reply-To: <20220204195852.1751729-72-willy@infradead.org>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Sun, 6 Feb 2022 13:10:46 +0000
Message-ID: <CANe_+UghN93pX+WDPTv-bn8ffz-9fDWiOwtSAe1bAC+vN6GEFw@mail.gmail.com>
Subject: Re: [PATCH 71/75] mm/readahead: Add large folio readahead
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Fri, 4 Feb 2022 at 20:00, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Allocate large folios in the readahead code when the filesystem supports
> them and it seems worth doing.  The heuristic for choosing which folio
> sizes will surely need some tuning, but this aggressive ramp-up has been
> good for testing.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/readahead.c | 106 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 99 insertions(+), 7 deletions(-)

...
> +static void page_cache_ra_order(struct readahead_control *ractl,
> +               struct file_ra_state *ra, unsigned int new_order)
> +{
> +       struct address_space *mapping = ractl->mapping;
> +       pgoff_t index = readahead_index(ractl);
> +       pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;

Not sure if can be called for an empty file, but do _page_cache_ra()
has an explicit check for i_size_read() == 0.

> +       pgoff_t mark = index + ra->size - ra->async_size;
> +       int err = 0;
> +       gfp_t gfp = readahead_gfp_mask(mapping);
> +
> +       if (!mapping_large_folio_support(mapping) || ra->size < 4)
> +               goto fallback;
> +
> +       limit = min(limit, index + ra->size - 1);

Cheers,
Mark
