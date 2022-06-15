Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7236054C4F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347443AbiFOJpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346676AbiFOJpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:45:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D164A457A4;
        Wed, 15 Jun 2022 02:45:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x5so15307014edi.2;
        Wed, 15 Jun 2022 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Az0IhgLrluMj3GRMffnnHU8dn9q2U05jVmkW4Ha7TmE=;
        b=AAdkjP7lcrPBx8gbayY/ZnxUVDiPwnG7RR/E+4eAm/ZkE5RPmKMfJILidca5QQG9Pp
         0xxBOBvj5R5ENPB0HcUNSO2lqBA32wLjJgbyhQKiNM9HVCJiC8wxO3GMATzu8EaEQS+O
         0IJVXu8bnIUmjuHC5D5t6HvBzdo4l2jOLpSqBYBMLSiWzRdYj+RyXSIMGgTomCw/A7dc
         NoNOI5vlPg3qYbBtXhrE1rNIwprT3x6WT9lbI3rTIjXDmp03khoVmMIflnqHuz80eCMc
         hC15UYCHEZftLZ4bf2G6WVJKnfQoHx2B6AxXIhXVt70pf7t1tnRjysjSU4rjAeHtBgUw
         wHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Az0IhgLrluMj3GRMffnnHU8dn9q2U05jVmkW4Ha7TmE=;
        b=x1F7eh0DvLtNpB9pzL+q7A4cZ6qmYTxi7HUBnpS5416tB8vMBPvmQu7m1TZ10LuVLS
         h/+jHau+DmBcy2K52U1eLLbyDGNiTyFN+Danm1m2x60FUXxVLZh+FoUd83y+kyE3v58m
         tWn8kUt06BZWSCmflKTU+sqxHPrX7KGbLMTm5sr3R5leEs7gDHzVbKvxCAVDQZzYPdtc
         0VC5q9CiegZeA1OMeW2yKDxbwxBdAuPWaprmDX25rtLuI7/z+YMq/dwa3h16lG/MdZsZ
         HXqNQjEhw0W7dwDTkOmkNeu+RBZmfLZ3FlnxyaI1Od8510RhC7CL4QBUePWpXT02WdLl
         YEVw==
X-Gm-Message-State: AOAM533t4JDOx7Q5ZGDhI86GD7bmdtHKTuH1d//3iu/wGoh1Y/LLsPCQ
        QAkZq0feaqumtH4++Twe1VI2DZ5VO1272FQP3eU=
X-Google-Smtp-Source: ABdhPJxof2Sz5oKQSk9HGgbwC1neNDYJeVkSg4FYD0XcviuLrBhBP3hRVoRp/nnzwuYiqDs8yDRpnVsVgEaVnHTxTB4=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr11526488edr.209.1655286331287; Wed, 15
 Jun 2022 02:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654118389.git.william.gray@linaro.org> <a2dca9435f7f1f727c696a1faa0ab9e27927f9f3.1654118389.git.william.gray@linaro.org>
In-Reply-To: <a2dca9435f7f1f727c696a1faa0ab9e27927f9f3.1654118389.git.william.gray@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 11:44:54 +0200
Message-ID: <CAHp75VepZ8P_cqnN8qJ_Wb=xM0LW3y-a22tv1otDReFSqRDFYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: stx104: Implement and utilize register structures
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Jun 6, 2022 at 4:27 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> Reduce magic numbers and improve code readability by implementing and
> utilizing named register data structures.

Can we consider using regmap APIs instead?


-- 
With Best Regards,
Andy Shevchenko
