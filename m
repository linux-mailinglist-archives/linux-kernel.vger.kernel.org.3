Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BFE4E2261
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345385AbiCUIpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345384AbiCUIpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:45:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BBFA6E01;
        Mon, 21 Mar 2022 01:44:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r22so8265719ejs.11;
        Mon, 21 Mar 2022 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lpgJcQdQlBKAJYFJUSYY7ENfFRbW3QOjTcnst1b23M=;
        b=CWPo3d5beAFi/UiV+IWMpdt78DyU/9MJzLK3lNa04df0EE06LvE4lz4FQOTOM3TZy6
         AH56S6r8MfL9caVU9TH2RO4K2sEa4yOCv4VufRUgG1M7xLsuzMCKBnyVoPMx99rQsLeR
         4aQ6lg3Wr83UO5CqqVk5abLXYyPUfp9q+eOWMwL2waJpYPZ65SVQ1f01JkW6jq2ygI+R
         03bU5Sc3maA6cZSI7z/UsurAtN3bMua7X+KHpQbklpQCPZlALRmbyGZ26ihc6KWYn9uj
         P9gAppYEZszxBCDPd3ocsITbXyQbUHiLy3bzxjrP59lwX0maUfbOnUrY/316dY5vLgWv
         NK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lpgJcQdQlBKAJYFJUSYY7ENfFRbW3QOjTcnst1b23M=;
        b=Zuik0G2Vptklw4Y1VB4XYKICnRXaHjxe37sT0EUBOrvLgBjs0bULvQDiH3xmTwjVrI
         QqqzDW4ae0viBea9yvJTV4OSlo0+e1PtAM8HVtG0Cat2jhMEAfbyZl8Owcz/AQTipJvZ
         7XXalCFglGQ2tPellcvsF3vPYcYlDPeO5aFAniPa9xE61Hcbz8XOp7vbbXooIwyZJzg+
         a1nVsCShAUD++XjJO2FRDO8iMftvLb3bDnDKDcx9N/ZGzSEmch45wdIaIvPIj9dDc7Fy
         D3TNjY0Lnn7BqYdknXPpSE4OsH0ukNwxqwr5m15InW7cookr9zJYihGdIBQefpRrEmqh
         9UWg==
X-Gm-Message-State: AOAM533DgPwVFuTi2HsfK0yr4hpRiz50GDDwtQKIGLeYjcAcVmKOeBmh
        FUdZRYgh75m5GA3nELKJE45bA7BXnGFpRgIPwKM=
X-Google-Smtp-Source: ABdhPJw0yOoZV9tCsQCU9FcO9hVJ+gXGJWgl+6vviQZRZWHo3w4UwOaPPlf89/5QoTP3fccok7G+gWlYzOR6iVlg/6o=
X-Received: by 2002:a17:907:162a:b0:6db:b0e8:9721 with SMTP id
 hb42-20020a170907162a00b006dbb0e89721mr19530083ejc.579.1647852255424; Mon, 21
 Mar 2022 01:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220319181023.8090-1-jagathjog1996@gmail.com> <20220319181023.8090-5-jagathjog1996@gmail.com>
In-Reply-To: <20220319181023.8090-5-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Mar 2022 10:43:04 +0200
Message-ID: <CAHp75VenpFcXxpnNC40SEXvsCO7tjPrgA2_8nkiVbNZnerny_A@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] iio: accel: bma400: Add separate channel for step counter
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
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

On Sat, Mar 19, 2022 at 8:10 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:

> +       {
> +               .type = IIO_STEPS,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +                                     BIT(IIO_CHAN_INFO_ENABLE),
> +               .scan_index = -1, /* No buffer support */
> +       },

> +

One more thing, seems like a stray blank line addition.

>         IIO_CHAN_SOFT_TIMESTAMP(4),
>  };

-- 
With Best Regards,
Andy Shevchenko
