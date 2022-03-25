Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BD14E7B72
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiCYThW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiCYThD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:37:03 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2126B58F;
        Fri, 25 Mar 2022 12:22:38 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h7so15002000lfl.2;
        Fri, 25 Mar 2022 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pba7oP54HKPv7rvuNO3mNof6XZxbJlFCeC12aVk0OXE=;
        b=kwIy6IhFaTatHujym71oQXoxz+i5Xr8B7K7YXVjy1gWItwQ1opyNXXop+NF1l9aJS2
         pzBuo/+uA+LVAHR7nDUHFvICyPEkZ5t7syk2ZuOaS7m2Mhdn8I7uWQwDMiytYwtx+dnW
         Zrip7Uc9q8qylF3mmXJJ+lZ+eyGquAs2dzXvNQIw/kUzydliK7pTPRqacmCh2QCWsfVw
         B4wEh4olQWOvguJc6sjgqw/DQMKhigcRZqXRct8WeVARTzM9aHsLpSdblReheJTC4CD3
         PT3t4+JjyC1uk5V3Rt/F7wyMs4ycsC9sMLnMKQGTo5aQ8vWxNy7B4ddve8rl0HY5ie8p
         EkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pba7oP54HKPv7rvuNO3mNof6XZxbJlFCeC12aVk0OXE=;
        b=FtLduTcWyoRpEBgIoQY5R2gusk+DwRlTKtW/wkFKYQejtLOXq3C+8YzhIlFOKhDITD
         3da0+DXo2LPwwyD3IomYqKLKdzJUPacf/PP4MLOp//dhr9QaerMMolMIw8skzY9XHH4r
         wwkus+fl+VOk+mC5HAd8YGhrpHjmQzQp7HRtNhOzz07yUdrjfZ73RgrbojiZpYxztBiX
         fMwRXsWHoGcOt0TbYWPq1CuJeaMgg1USifG0hN7FfXZrheSQHel+NyhEcuAkkSD2hyke
         6eTjutADloEdHtS07JYqMsZEfM79CheilIg+F+H1ZBAm0Wl5F2GTgPomPTFwk7aWyag0
         V3AQ==
X-Gm-Message-State: AOAM533KMjo8i0gRBu8blQH0bVc97Wg6fyKQlnKQaBPXdDWSoNhDVfgN
        C4F7VCh15Ps68+otRQ5qCBwpQ3aL0dLj91eXxBn+bkm/PZM=
X-Google-Smtp-Source: ABdhPJyclTqv78QfqPyJNZ2heKEpBQldstQKfe7AytnXqGbW0MlwSUx+GbZJS/LQVwYd/cNvFYeDK7a3b4Kgh/hCK04=
X-Received: by 2002:a17:906:9751:b0:6e0:5cdd:cabf with SMTP id
 o17-20020a170906975100b006e05cddcabfmr13358276ejy.38.1648232337047; Fri, 25
 Mar 2022 11:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220324162904.530140-1-steve@sk2.org>
In-Reply-To: <20220324162904.530140-1-steve@sk2.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 25 Mar 2022 11:18:45 -0700
Message-ID: <CAMo8Bf+vk+mkEAAQCirw7cdCFXx4wq7yxkM0tSP8PvpCaaacMw@mail.gmail.com>
Subject: Re: [PATCH] clk: use simple i2c probe function
To:     Stephen Kitt <steve@sk2.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 9:29 AM Stephen Kitt <steve@sk2.org> wrote:
>
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>
> This avoids scanning the identifier tables during probes.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/clk/clk-cdce706.c   | 5 ++---
>  drivers/clk/clk-cs2000-cp.c | 5 ++---
>  drivers/clk/clk-max9485.c   | 5 ++---
>  drivers/clk/clk-si514.c     | 5 ++---
>  drivers/clk/clk-si5341.c    | 5 ++---
>  5 files changed, 10 insertions(+), 15 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
