Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD325ADC9E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 02:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiIFAjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 20:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiIFAjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 20:39:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455E767C97
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 17:39:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id nc14so19864464ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 17:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ivEohVEMDuEFcckLs8OQpxO/9FHYT4jYn/AxNYf6vu8=;
        b=pIzXrZU+X+7HUd3iBNZXN4JqOOw/UtMz3hgaS95jmVNeDgF3/aJQyPI5k0oSUfmRQF
         T9ZwB9eTGWcRPaNpQWRtsjwo/AuVygUK+scRpSNNRHIp/oviZ6VYmH4xqodVfP/h6vXr
         IXrGcwTpW/OrOi64N1IyzISHmH2mEeFESg0dEY1YePgniQw6GhpGq/mj3k8+/3dAbL0Y
         2ZpMoMZoBsTfc9enxKhFqwOZtIs7epU2MIKwmHfaJCTk6YGQuw8XtfD+7Ob7XzP2NP83
         +4Hq8iamXbb/AHlpuzrAbxaZm6ah+gD81uF1JSFeXGv3JTmbX/o9zoE01Ez49OqfwFBL
         mljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ivEohVEMDuEFcckLs8OQpxO/9FHYT4jYn/AxNYf6vu8=;
        b=etgr9oVDf4/IyT3pn2GbcRvO/KAn5niXyPqwxnHHMvXG+97Jp7REPxW7UUHvQxxOjY
         LDO/GoOEQC4/oBut/WSVyNmPiBWkr8+8hQwQ7yXKsbrf8ceHagPNqxNAgfRYxQ1BhZIL
         dOCU6W7laGSQtagBjpg30HfAEnbOjgaB9o3C9HSkEYwzGctMkCaj4i+kXMnneVIrowBl
         IttxfWKb1r6CSuEJwINC/lIG8eHb+yQUOGJkeCl5qBVPpRcoggvc4WL0PMXQRV62FG0E
         sLUfrZy73u8lpTPlqfbwghXzrX88Qs+4+IqmwcawE5L4NInYiWa5U+fLep/KP12N1MBn
         IA1w==
X-Gm-Message-State: ACgBeo1xYwhyLWh69mCQ8Y3K6yzGGJbCFMtvi9uvYoNIus+E3j3+oE8N
        HGFwBHIBG7N65e5O0TwPibgrPPggBWzNOmypc9zKWA==
X-Google-Smtp-Source: AA6agR7mqkEH8/Rmie4pmWbrKTZEE91yNr9whESntX3R7t4nnIlExrBMlCN8WkYqqBVKM9XZS1qTK/srt6yxDNIa/rA=
X-Received: by 2002:a17:907:9627:b0:741:8d57:f335 with SMTP id
 gb39-20020a170907962700b007418d57f335mr27592422ejc.7.1662424754810; Mon, 05
 Sep 2022 17:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220902232732.12358-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20220902232732.12358-1-rick.p.edgecombe@intel.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 5 Sep 2022 20:38:37 -0400
Message-ID: <CA+CK2bDjoWNw_0WC_qAhzw9BRVPgbBAcs0=sUb3qcqhyVyvaDQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Check writable zero page in page table check
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rock,

Good idea to add a check for write access to zero page. Can you please
also update Documentation/mm/page_table_check.rst ?

Thank you,
Pasha

On Fri, Sep 2, 2022 at 7:31 PM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> The zero page should remain all zero, so that it can be mapped as
> read-only for read faults of memory that should be zeroed. If it is ever
> mapped writable to userspace, it could become non-zero and so other apps
> would unexpectedly get non-zero data. So the zero page should never be
> mapped writable to userspace. Check for this condition in
> page_table_check_set().
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>
> ---
>
> Hi,
>
> CONFIG_PAGE_TABLE_CHECK is pretty explicit about what it checks (and
> doesn't mention the zero page), but this condition seems to fit with the
> general category of "pages mapped wrongly to userspace". I added it
> locally to help me debug something. Maybe it's more widely useful.
>
>  mm/page_table_check.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index e2062748791a..665ece0d55d4 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -102,6 +102,8 @@ static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
>         if (!pfn_valid(pfn))
>                 return;
>
> +       BUG_ON(is_zero_pfn(pfn) && rw);
> +
>         page = pfn_to_page(pfn);
>         page_ext = lookup_page_ext(page);
>         anon = PageAnon(page);
>
> base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
> --
> 2.17.1
>
