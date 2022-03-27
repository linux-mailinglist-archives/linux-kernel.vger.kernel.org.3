Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C4A4E89D3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 21:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbiC0Tre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 15:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiC0Trd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:47:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA283BBF7;
        Sun, 27 Mar 2022 12:45:54 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so24666721ejd.5;
        Sun, 27 Mar 2022 12:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yu665j/iElCvxD/UYxHqm5c8k6YEsd7NiQqb8GTsgY0=;
        b=KqNM7ZRqeFz0N3q1HofbMepFBhGhkPZEX2pEiTIGKIqO0orEAOR5VjWQjPhuozAr2N
         v465OrGrgywHmFmuoT/8ctLa4/JPZ12VnByr93go6JSgXgCyYDjqOKVVuhxLztNm9Vw1
         iSPRym5vYC5Z3J7zbaFFIHHvKIv4T6d+HCqzApaDEWRIdtPVn9p5yIdDqwTXZl+IpgCm
         S1Ew02JqqV6psB3hkP0ppIExTe/HElDrMx7YTMCVGSDfyrBy19hcFw+jshXbXKq8GNhe
         Apbr8O/DohUD8D8VdCzH3aHw65UslstOCinsVZQcu85ZSH6Tx8w9Gl3FoXm4yVpIcUq8
         FhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yu665j/iElCvxD/UYxHqm5c8k6YEsd7NiQqb8GTsgY0=;
        b=L4tD0U4Ej3CPmZHY3ixHUAvvq95POVgZmsG2RzqbTPyHqJIcuGyzg21gshuHJ1AR3l
         krY6uhYHKf6ALbKsT4euz1yhjVZshmbVSpCejzsgPDxzz7IkWP8tv9RbYndQ5lxj5P5F
         13k7rpnxOX5HPXW7HWs/abgz2CH+HTiBTJapq37gUOR56Cs+VEJZtR79J4VzAqU8uvhP
         9cF0O2NQN2i3PQRab1tkToo6Fv3fnO+JbdTC+6/MiC4d+ssALWx4P53C7CIrto9SARyd
         IkPAFQRKUlZvUfbj5rMma7Lefy27KdhP6djknBSAokryUPJ4lxEk1757UjFea3HF1VQJ
         lJyQ==
X-Gm-Message-State: AOAM533Ft7x6z6BgAGZJ+kI+3F10u98+eDHMAYgthghDfkAx41oUN4w4
        0JYbHsrB34NJ0QgXoRhfBXWwfxmkn/fMXFLVH1LRxpfPYgc=
X-Google-Smtp-Source: ABdhPJwOVM5eau3At52wi0bjCHtgeIN0Dv5BJDW1M8yNRA3OcpJmT+BXnd9fOJwhCUmQKknTEUBY8VEkbxHSXyFouPg=
X-Received: by 2002:a17:907:e8d:b0:6e0:19e7:9549 with SMTP id
 ho13-20020a1709070e8d00b006e019e79549mr23624761ejc.44.1648410352643; Sun, 27
 Mar 2022 12:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220326194146.15549-1-jagathjog1996@gmail.com> <20220326194146.15549-4-jagathjog1996@gmail.com>
In-Reply-To: <20220326194146.15549-4-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Mar 2022 22:45:16 +0300
Message-ID: <CAHp75Vdx3ZWFc9Xa7AhLGM=-4AzfamEqTkZxvBeu=Hu4KF7pSg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] iio: accel: bma400: Add triggered buffer support
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

On Sat, Mar 26, 2022 at 9:41 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Added trigger buffer support to read continuous acceleration
> data from device with data ready interrupt which is mapped
> to INT1 pin.

...

> +       struct {

> +               __le16 buff[3];

In my (mostly review) practice it's rare that sensors operate in LE mode.
Please, double check that.

> +               u8 temperature;
> +               s64 ts __aligned(8);
> +       } buffer ____cacheline_aligned;

-- 
With Best Regards,
Andy Shevchenko
