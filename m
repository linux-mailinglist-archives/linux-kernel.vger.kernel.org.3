Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4168F4D46CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241986AbiCJM04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbiCJM0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:26:55 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7601A63F4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 04:25:53 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z11so9047908lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 04:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqsFIaRY/TgoRkF083+IfsddSk28neU+fOzEwgSelz8=;
        b=SkF9GRN6Amd9gve917g3uYjQcjFuk1GmGmpMu33Vk7qfVtRVpuGBIXhZrO074ODRFP
         QUrGwVAIZzQRa294vznZ3IBUNlXKCFrNZcweyvGeNXzXKLJHlRq4CcYW6/ynB2A88hpG
         6Q5XWVJLar6jkaGxJlFZoyHL+gq60iAaVM+aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqsFIaRY/TgoRkF083+IfsddSk28neU+fOzEwgSelz8=;
        b=ahb9sroPWnpVFVVfDABy2lvkIf2suaQDYooVXhneDGI28sDJHG4RAJGKVqAcPwc8Pe
         8O3fV6R3+UzGpvV4EQbHl1yJDdOnue5b4zunJjW0+BAbwMo9oYx2w+T7m8luuzlR6qF6
         0vtrCTU6VindBZ4xhEj665dQIflbffRYB39JSabqWRWA9zkOkDmJ9el0EUxw+GKvxpAj
         f3IbTMufuJj/oZxbAjchGgRkE46ENOl2kee0nbFwcfYJRv9OccB2po9y665J0giO68JU
         ftvhvLtBg04oaELwLWfWiZTVEhrhqaFYrJaYhLZlYHLruLNHM57pGBXcDuqtB2FzDFb3
         szvQ==
X-Gm-Message-State: AOAM533CzaJqfIddw7eT+RNvbD8+2lil0Zb+k6VFgg6E8skkMoC2viX+
        b5cu3/AUUv4k2S2N0W2U1hNZZaKVVV3aRiMqUg0=
X-Google-Smtp-Source: ABdhPJzwDTKJygYtt9lsOT2THnMF9ljWCrwxwR7Fg28LCH0DmTeY3PgY1TA3ohc8z5WV4alruQk+Kw==
X-Received: by 2002:a05:6512:2256:b0:448:2d4c:ede0 with SMTP id i22-20020a056512225600b004482d4cede0mr2776888lfu.579.1646915151489;
        Thu, 10 Mar 2022 04:25:51 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id b23-20020a196717000000b004476449aaf9sm950507lfc.297.2022.03.10.04.25.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 04:25:50 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id g17so9155018lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 04:25:50 -0800 (PST)
X-Received: by 2002:ac2:41cf:0:b0:448:1eaa:296c with SMTP id
 d15-20020ac241cf000000b004481eaa296cmr2838919lfi.52.1646915150173; Thu, 10
 Mar 2022 04:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20220310121327.63C6FC340E8@smtp.kernel.org>
In-Reply-To: <20220310121327.63C6FC340E8@smtp.kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 04:25:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgN6bYPgaB7g0zGXQ5HnbVQ9910o9OQMBLs_S_ax4H67A@mail.gmail.com>
Message-ID: <CAHk-=wgN6bYPgaB7g0zGXQ5HnbVQ9910o9OQMBLs_S_ax4H67A@mail.gmail.com>
Subject: Re: [GIT PULL] SPI fixes for v5.17-rc7
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 4:13 AM Mark Brown <broonie@kernel.org> wrote:
>
> One fix for type conversion issues when working out maximum
> scatter/gather segment sizes which caused problems for some systems
> which where the limits overflow due to the type conversion.

Side note: 'ctrl->max_dma_len' is a 'size_t', so even 'unsigned int'
isn't necessarily a sufficient type.

Not that I see anything setting it to values that would cause
problems, but it looks conceptually like a similar problem as that
'max_seg_size' thing was.

                    Linus
