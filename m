Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6644BA679
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243464AbiBQQ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:56:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiBQQ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:56:13 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F244F2B3551;
        Thu, 17 Feb 2022 08:55:58 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id j4so5046373plj.8;
        Thu, 17 Feb 2022 08:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5FGTn5ILMijaIv0wSwcthiNL1OS6vJs5ba0cv9M5p0=;
        b=Ybcw3sQgwaFlXLabS3GZovVUzkaWyxbsGVmBxa0VuMneh68dUAQKaQHuy51dlb0EYr
         BRc/L2Nvr65Zu/zJLoBYHnoQXV+ZeOqxKEA13cB9E2KQJALJO0oVUzu3Howla4pHDwou
         07B0y3PD0Ff9xqqLqSxpZBY6DswddqR5EmcnipwwcC0T95ITVODS82ThtT+smfknvRqC
         7p5jgqsxt1yJqlwk0UkVCNXWjII0H2YxAmv7TuS+YUmBRcEj+t2C8n3QMg7VhgWZCReN
         OteA/5v9Lnqfhr5eZAWA6DJxCyM/5ZzIu62SPRKhF6nkInWHPToO6rHjpL57FUJxoRl6
         dmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5FGTn5ILMijaIv0wSwcthiNL1OS6vJs5ba0cv9M5p0=;
        b=p2MHOyaHNJHPuqGp+984ISAgkaDkF+xH+U0HeATEUsnrabH43Xc2FJIrDqWvbTWCIy
         /D4ELPoJZmf7l/4BI39Q5t0Mq7ZAcqKRCru4SpIqVya1E9V5HJl0r/QBNgk7iRarvy/h
         X6FvzcbOFaPtgSbjuOaQ/ZNyY+d8wamiuJRi1rDyWXSePgayK+SdPVVpW6AHQrT9iPwD
         HllNvF2mJuDYskgkNLRoW5Pvsrnqw+P4zhNh1J9QCt2cZRbiaImwLRI+1crq4sYtdzq2
         OXjUmV3RRsAZH9SjKri0kMAaRL1soz1dSNQSAK7KtApexQzikBeYlM1RX/dizI8LdnyV
         Fq3g==
X-Gm-Message-State: AOAM532S2IkbklejKpT+Y2E3oAZXUgFco7SWHptxahL8AfF9XP1Ysr8r
        J2WkPTb7IIkk/J+F3HiyuUHwzc5EzCtFKCPyrT0=
X-Google-Smtp-Source: ABdhPJxphQ5kFT6Qc/Ioi+eXnWMbYvH9a5F8olBh+E/kNXYn7yD1lZj1szFMRdyE+lYkU9FGxip4qdxvX6MBM+6QYm4=
X-Received: by 2002:a17:903:22c6:b0:14d:8a9b:a9ad with SMTP id
 y6-20020a17090322c600b0014d8a9ba9admr3687557plg.141.1645116958446; Thu, 17
 Feb 2022 08:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20220210224933.379149-1-yury.norov@gmail.com> <20220210224933.379149-30-yury.norov@gmail.com>
 <CAPDyKFqvYhPTenGEH=LZyJXb5rJKbyeds4rH+aRN=u6JH_eJ5A@mail.gmail.com>
In-Reply-To: <CAPDyKFqvYhPTenGEH=LZyJXb5rJKbyeds4rH+aRN=u6JH_eJ5A@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Thu, 17 Feb 2022 08:55:47 -0800
Message-ID: <CAAH8bW9X4HGNDW9xY1zA8d0O0ty7kh_zcOKBDu88FL8uWEFAkA@mail.gmail.com>
Subject: Re: [PATCH 29/49] memstick: replace bitmap_weight with
 bitmap_weight_eq where appropriate
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Jens Axboe <axboe@kernel.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shubhankar Kuranagatti <shubhankarvk@gmail.com>,
        linux-mmc@vger.kernel.org,
        Shubhankar Kuranagatti <shubhankar.vk@gmail.com>
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

On Thu, Feb 17, 2022 at 7:39 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 11 Feb 2022 at 00:55, Yury Norov <yury.norov@gmail.com> wrote:
> >
> > msb_validate_used_block_bitmap() calls bitmap_weight() to compare the
> > weight of bitmap with a given number. We can do it more efficiently with
> > bitmap_weight_eq because conditional bitmap_weight may stop traversing the
> > bitmap earlier, as soon as condition is (or can't be) met.
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Acked-by: Shubhankar Kuranagatti <shubhankar.vk@gmail.com>
>
> Applied for next, thanks!

Hi Ulf,

This patch depends on patch 26/49 "bitmap: add bitmap_weight_{cmp, eq,
gt, ge, lt, le} functions"
from this series. Can you  make sure you applied them together? Or I can
apply it later.

Thanks,
Yury
