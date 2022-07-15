Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF649576719
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiGOTGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGOTGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:06:47 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DAB140D9;
        Fri, 15 Jul 2022 12:06:46 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31cf1adbf92so55893677b3.4;
        Fri, 15 Jul 2022 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFwGq4zP7sMWIqfULI0wjsQQstAjuSy+M6RRWlswEvQ=;
        b=Czl726T+mE3HwXxVVk+rPFsb2arxv6IWYHPQprekCRduGuLE8D2rAV/xAO95h2xDhz
         GZXjVmPvM6RFKBcsRgIAaSIxsCdnsck5fKM/kXyuGwcYGa0jgc6MH7hXYObKXDLGzmFc
         BBJWfIVnzvZ8I89g7vx7QCi8+OYAKiyQdvyCDcjYv69aCatuIMICmILDOKGIt7Yg6St+
         /yvInyDVpQxRsYK20RiT52xgPUXCYhAjvnCRIZ8b+dfNWlaQuQ8rCP+yy2d8wcmvA6i9
         L/auVDKLRmYwd91bH9rziLGUS0c1GgnPq5jzd15APIA5di1Gpa7z+fi89JrcabsMTO8s
         JI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFwGq4zP7sMWIqfULI0wjsQQstAjuSy+M6RRWlswEvQ=;
        b=gWRSvV6BHs5RiILLrah+UJsfaXvXTt3332OL92K1LJMtsbJH8TEfwopxR3RLPqQcmB
         yF0zJx+4Bck8bnVyJuful5qmAzYaeDsZfcDJPMY6cGgjozb7jddQt3S6ikQ4MGnpPjke
         h6lkmNUtENTZCkSYqulOTmN3AW2eEW7I/C6bahc54jk7wxTPlsj3JE+UijFFBMsstveY
         cNfvYxuo8w5G2978AEhRvTFhxOHMqz4lgeUQMoH8pB4Fzb9y6OwEGvmQhBmo+0WD4tne
         qRR0GECwkZvyqCBxu4AVtWd4vkIRkKHCjYMHn3wJs0QbrFIQOYr+x5Em0zGU1iaN8qY+
         jDsA==
X-Gm-Message-State: AJIora91rwKKqUWLeftiOO8NZSJsViulG9qHis/Nneu8udYMRzW/niPp
        IEYEGaXYnel6AwYrJ6xKlWprTdwi3NhOSqqgQr8=
X-Google-Smtp-Source: AGRyM1uv+CSgcVker05L/9IC/iwc5wq2VZIhyy5WINvmwElfCozCQRwE52yNr4rTsGvDF2wkcZtfliBllSPBIxAVv3E=
X-Received: by 2002:a81:1d49:0:b0:31e:1f9:cd75 with SMTP id
 d70-20020a811d49000000b0031e01f9cd75mr2981454ywd.195.1657912005852; Fri, 15
 Jul 2022 12:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220715140729.136234-1-tsbogend@alpha.franken.de>
In-Reply-To: <20220715140729.136234-1-tsbogend@alpha.franken.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Jul 2022 21:06:08 +0200
Message-ID: <CAHp75VeCpUt1HVGnr1C3aKKgRFyo5qzW1aTiPyxSCdzFL=2EoA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: remove VR41XX related gpio driver
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 4:22 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> Commit d3164e2f3b0a ("MIPS: Remove VR41xx support") removed support
> for MIPS VR41xx platform, so remove exclusive drivers for this
> platform, too.

Removing code? This is always the best change ever!
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(Also may be applied to the v3 of this patch)

-- 
With Best Regards,
Andy Shevchenko
