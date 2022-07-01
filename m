Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692E65632A5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiGALi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiGALiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:38:55 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AC94F671
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:38:54 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g4so3532860ybg.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMCFyvAXOapc/dC3Eev2ebRpTDIZzyvT6iXO1tfSW0s=;
        b=KJOXoy7Pc7F4xBOrMftgCGsRQojl1Tk0n6YsqC0a1aoucGV1npZYAlvKjt1yGft5HI
         gqajhuy4Aqez5HfdSMF7/mPtBOjSL7PbGSjN6IKo3RTm1KV5bCzSW9wHkzARpler+/Ap
         8YyiNKT1w23YFNd9tdNZjYWjOIxu4LqZezL5QKdyGxhO4R5DXULo9/lJcLQJyVgs1A9k
         1AlJJZXZgTmldsrteEFo6QNXjQ559HXdMSEFLGX9aR3AFa94OYEuyJROaGXuFPWXr5Rk
         o4+/nLV1Drf5AlBr2L87eOCZiMfzzPMNiYiuYSMOogCGQVV8eV3mPv0cKYkGGzqVDU6T
         v3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMCFyvAXOapc/dC3Eev2ebRpTDIZzyvT6iXO1tfSW0s=;
        b=jHK1aaz3n1nTtkWFOwZuN42p0ef63E4rOrP5MeDvod9zQkb/XXCCKruQp/eeSrn5Vg
         mZ2hAHbqLG6pbitZCmJdeEvqAxO0jC5ejY9QjJNtbdnLB23lPRjMiuPsJ+Lm57j+nfK1
         1xm7yCNKK+Q2Vf/qaJfLIgtKVVtwy1u8kAElMsG+FBkeSYvcUzW11Zb2I2aYHCf6SRUj
         hERMlPOJ5Zz70cAR7GVWHoFW94/Wh6Ow1wzNoSVON/80I5GnDFMWu9XW+qw3SHMc7X4D
         1Cu/puQHn7G2vOnMWunnytnCIKDTN+myPKjdWOQIElyZfeQxEP9pGdupHNxOS2dwAXt7
         LKKg==
X-Gm-Message-State: AJIora8XpXO32gmS8Uy0WrP7bUGGLM0gEwNZwQkxJYTjhC2zVlYvFIVI
        cjueBwo7GBEqnf25q/dJqyeQ8gJ+Wwt/8iXckust3MYFO7aPI+rO
X-Google-Smtp-Source: AGRyM1udY8SeIAZ2YxXrr19sePwsT+LiZVx1OT7o/AxH4ch8AucSeSEK5DZurvAZ/nIqvT4T7+SoYpMg31ZDkCRwOsc=
X-Received: by 2002:a05:6902:c4:b0:64b:4677:331b with SMTP id
 i4-20020a05690200c400b0064b4677331bmr14719962ybs.93.1656675533534; Fri, 01
 Jul 2022 04:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220630195103.4088-1-andriy.shevchenko@linux.intel.com> <20220701113141.GB28070@willie-the-truck>
In-Reply-To: <20220701113141.GB28070@willie-the-truck>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 Jul 2022 13:38:16 +0200
Message-ID: <CAHp75Ve5ZNCEQ2ktAmeCWT_biibnNfqamxyzzRA+zaJBv_oX9g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] drivers/perf: thunderx2_pmu: Replace open coded acpi_match_device()
To:     Will Deacon <will@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
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

On Fri, Jul 1, 2022 at 1:33 PM Will Deacon <will@kernel.org> wrote:
> On Thu, Jun 30, 2022 at 10:51:03PM +0300, Andy Shevchenko wrote:
> > Replace open coded acpi_match_device() in get_tx2_pmu_type().

> This doesn't even build for me:

Neither to me :-(

> Have you tested this at all?

It was a last minute change from __acpi_match_device() to
acpi_match_device() where arguments were swapped and obviously this
wasn't properly tested, sorry.

-- 
With Best Regards,
Andy Shevchenko
