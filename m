Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8AD56839D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiGFJaW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Jul 2022 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiGFJaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:30:16 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9F31FCC5;
        Wed,  6 Jul 2022 02:30:15 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id g1so10587966qkl.9;
        Wed, 06 Jul 2022 02:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X0E6/6svoPI75a545bMY+0MRF9DfMtB/2WCtrH+xzXg=;
        b=dWhcuHDGkGtlPwbcV9QkyJH7vDpq0f5o61/9NX0A4FMjRkiycSLa1eH81sDeZ3d7iK
         pIRZwOGE+FBlQeokgBqLPqMZP4kiSEjud6zyffDP6IA0y+Zw37lMMHSf5Yacvwg8lqXx
         GB5YnGzXY7OaFcmSifWWeTTIAWvRPyVASNJRSk1AhN1TsfajgFTPl47g+JvA6bQBsg+y
         1QgWzoQGdX16tsV7p5JIl+Eum7vbRgQbsvig+vU5Y1igDe7wZgFRVf/2vSoDaFyDnr/c
         OvfGbhF0W9uXoY8lYrWJzAmYIovdPC0SF6eAzGSCKF63ClrYeAQeEn3dtuYPTNPo2YjA
         2pQA==
X-Gm-Message-State: AJIora9F6kfKYlX+ev4R7bTf0suokup69bYQzk4P8kNBqRs49gpQQtQO
        bgaR5zdnaw/k9DRQaIToHaLGrETGp6oInA==
X-Google-Smtp-Source: AGRyM1vGV7o6RQZlab4G2AQVlXCgTDTub6lLSHHbaelRliHYDhTTqSgd26bCVQUit9nk3DL8AbxVdA==
X-Received: by 2002:a05:620a:1929:b0:6af:3370:2d0 with SMTP id bj41-20020a05620a192900b006af337002d0mr25335542qkb.683.1657099813998;
        Wed, 06 Jul 2022 02:30:13 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id t6-20020a37ea06000000b006b53fe19c41sm248975qkj.14.2022.07.06.02.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 02:30:13 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id c143so17811820ybf.3;
        Wed, 06 Jul 2022 02:30:13 -0700 (PDT)
X-Received: by 2002:a05:6902:701:b0:66e:a06d:53d7 with SMTP id
 k1-20020a056902070100b0066ea06d53d7mr788860ybt.604.1657099812787; Wed, 06 Jul
 2022 02:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220527115345.2588775-1-amadeuszx.slawinski@linux.intel.com> <20220527115345.2588775-3-amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220527115345.2588775-3-amadeuszx.slawinski@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 11:30:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVnXGg4T3j5n9PUg6i60-vza1bjNiVp9wqNSqHccMc=-Q@mail.gmail.com>
Message-ID: <CAMuHMdVnXGg4T3j5n9PUg6i60-vza1bjNiVp9wqNSqHccMc=-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] m68k: bitops: Change __fls to return and accept
 unsigned long
To:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Vineet Gupta <vgupta@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 1:53 PM Amadeusz Sławiński
<amadeuszx.slawinski@linux.intel.com> wrote:
> As per asm-generic definition and other architectures __fls should
> return and accept unsigned long as its parameter.
>
> No functional change is expected as return value should fit in unsigned
> long.
>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.20 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
