Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C575476B1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbiFKQ5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236770AbiFKQ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:57:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7422E18388
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 09:57:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq6so3476186ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W83l/pLxbVmfdY4Bh3kAV9FBhPiwp545eDF2N1BjQ/0=;
        b=QZFxcEKrwiT/RpVaiTi05b84+BOEJXjGP0UMn3IqGzce/BDk93ukoGPtqbDYlqaeML
         WwwEbRGvqg0gN2HFDwZCwSPNECNvzPHHpYwbsRW/PpLrRQpmpYITmQ292c5X/16X6nAB
         XC3OXxSNmfDTBC0Q369g5kF7e+6gGX27oEtkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W83l/pLxbVmfdY4Bh3kAV9FBhPiwp545eDF2N1BjQ/0=;
        b=5gyzzZl50Vq6IdDC1EceUQx98Q0D8g5QcWJn2Wd7yWlKBW+T1iq5a5p/Ncww3zc1Tq
         YLmvOApCol8EqwsweUuf71IUh43TgOZB0qEXKbojbl8TDaVgsUDv1Zv06w8CuVMJdcI+
         hTYZlpwK6PmU5YG5fiI8PJ98TX1kIFzw8mwe64SmU0AWFpeZxuAbb12YRwcBVAOJNo+k
         d3ps5LGh+VZLpMy5CRN5lgZTpi+2iNFSvXb+1mn3spWQhZJ9La16DJbKeYK+Vla697do
         uY6vUzPIDjB7/TWL+S5nbYzbKrFIsha6DBTQ5TpzwEbmlmN1fdkIfjZnBhj8XqK1q6ga
         8WGw==
X-Gm-Message-State: AOAM5311u8pXgD2iHhZUL5HeazLssdUhvdg14bEkR3u0sZ8eFrZB9lgv
        mJ1SXKs8mJ1Wq+ohlUy74uYH2n/TlM5wIMz+Ars=
X-Google-Smtp-Source: ABdhPJw1yk86w1avlefK1oY0ZivbFqzbFTdLNbiI1sinTMrC9m2tA9Hx+6Kxd/Bw+8Z1q3o9hI9/uw==
X-Received: by 2002:a17:907:1c18:b0:711:c83b:8a14 with SMTP id nc24-20020a1709071c1800b00711c83b8a14mr29410785ejc.379.1654966634664;
        Sat, 11 Jun 2022 09:57:14 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id m6-20020a50d7c6000000b0042dd60352d1sm1704712edj.35.2022.06.11.09.57.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 09:57:14 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id z9so909352wmf.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 09:57:13 -0700 (PDT)
X-Received: by 2002:a05:600c:591:b0:39c:4544:b814 with SMTP id
 o17-20020a05600c059100b0039c4544b814mr5603093wmd.118.1654966633270; Sat, 11
 Jun 2022 09:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220611182119.4e115fba@canb.auug.org.au>
In-Reply-To: <20220611182119.4e115fba@canb.auug.org.au>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 11 Jun 2022 09:57:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X2cwr_s3bQJk0hOb88-zPrZR-2fKxP8yKSAy9vuKFtzQ@mail.gmail.com>
Message-ID: <CAD=FV=X2cwr_s3bQJk0hOb88-zPrZR-2fKxP8yKSAy9vuKFtzQ@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the drm-misc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 11, 2022 at 1:21 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the drm-misc tree, today's linux-next build (htmldocs)
> produced these warnings:
>
> Documentation/gpu/drm-kms-helpers:241: include/drm/display/drm_dp_helper.h:377: WARNING: Unexpected indentation.
> Documentation/gpu/drm-kms-helpers:241: include/drm/display/drm_dp_helper.h:378: WARNING: Block quote ends without a blank line; unexpected unindent.
>
> Introduced by commit
>
>   69ef4a192bba ("drm: Document the power requirements for DP AUX transfers")

Thanks for the report. Fixed by:

https://lore.kernel.org/r/20220611095445.1.I534072d346b1ebbf0db565b714de9b65cbb24651@changeid

I'll plan to land it as soon as I see a Reviewed-by.

-Doug
