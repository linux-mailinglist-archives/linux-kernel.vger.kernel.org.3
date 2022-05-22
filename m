Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE6953026D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbiEVKao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 06:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiEVKak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 06:30:40 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9EF3C4A4;
        Sun, 22 May 2022 03:30:37 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id l82so6313591qke.3;
        Sun, 22 May 2022 03:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flUjSOL8jzsTLGzNGG4aRYZ3gOkmaTV1EbLGclXSu1o=;
        b=gvSciXPezHSav3XeGMzqlNnZOsyt+SbrnV3k9DQHNIyue31Gb+TbFLVBfcUIgPXPej
         zggrsb+LT5lprakqGJrE50HR4q6RMK5c5E2C8qwrKX11pD0iSJznMV28leTwJHZ56h5U
         gZqJ7TYHcG1fpgHU614mPR707YTxCrtN3z3PE1rLQVqkaX4EwER4vKH4RYF4OIgSSkAZ
         Lx9cvRUdC689B49BiM6rD/6Ax16UuZQozr1eA/fm/lozoliRNSYJww807nVx2Q2cDbPI
         2/mNDhxJ5MeKWM8gbD47ZFmCfhhUdSS6zVzwf0hmnDxCTFEgCXP0KehGyVf4m9uGSvzO
         /U2g==
X-Gm-Message-State: AOAM530gpwQdJdOkDSzWEzzmE+oQ7YJ3+kCZ6+c28RT0wKO1AiWy6h7i
        Ssf9sU2uMWOwtIiVCaXJn+yjRgyGCoBKpw==
X-Google-Smtp-Source: ABdhPJyPezFjsQ57Ik1Yi+cCusxHehUmA3ZdCiwFpnAfoF+cxxi8moochi2BV+z+QFW857gIx8mGsA==
X-Received: by 2002:a05:620a:370c:b0:6a0:999:21c6 with SMTP id de12-20020a05620a370c00b006a0099921c6mr10846590qkb.644.1653215436935;
        Sun, 22 May 2022 03:30:36 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id x4-20020ac81204000000b002f3e153f47csm2594152qti.0.2022.05.22.03.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 03:30:36 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id x2so20489120ybi.8;
        Sun, 22 May 2022 03:30:36 -0700 (PDT)
X-Received: by 2002:a25:e04d:0:b0:64d:6f23:b906 with SMTP id
 x74-20020a25e04d000000b0064d6f23b906mr16858388ybg.380.1653215436251; Sun, 22
 May 2022 03:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220521195942.645048-1-trix@redhat.com>
In-Reply-To: <20220521195942.645048-1-trix@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 22 May 2022 12:30:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVELy4M2Xog+NykEpb=k5sw+B1iYzC6O1Otsz75qMWBRA@mail.gmail.com>
Message-ID: <CAMuHMdVELy4M2Xog+NykEpb=k5sw+B1iYzC6O1Otsz75qMWBRA@mail.gmail.com>
Subject: Re: [PATCH] xen: remove setting of 'transp' parameter
To:     Tom Rix <trix@redhat.com>
Cc:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 3:22 AM Tom Rix <trix@redhat.com> wrote:
> cppcheck reports
> [drivers/video/fbdev/xen-fbfront.c:226]: (style) Assignment of function parameter has no effect outside the function.
>
> The value parameter 'transp' is not used, so setting it can be removed.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
