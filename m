Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9635573E85
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiGMVGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiGMVGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:06:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAF832DAA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:06:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so1946348wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXn5oDwMb0xuw+PILzCO5qMpKXG5QVz4wpHuw1O0gsE=;
        b=X9kiEQUab8rteAT9VGn1URzny7q0+kH5Ht2cv32Mfe05yDYpBoTX3gTJiytYqBxzJc
         6R1Mlcf88akA01DhUF9yduv3FZEcPGba9obzRCuUYh1S7wnVGowhouRjEFpSfyz7saU7
         V2E5kx/SE8JF5hyziwgDcSjgdGVA1Y+89PumkfMHFeVaMM6QsayJWxXroO06VZIv2X09
         U0tpvnLmE5VrIo91kvK2JQK4zXSbKutrWhd8//E9HAEqNgphpfHFswjBMQFqvQUD/rA2
         nC1fz+aXoYujyGUB7JFogy01uGHw0DoU6MpKUpL1KF1DQxr3gI1zLoyz+Ul537PCeVJh
         cXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXn5oDwMb0xuw+PILzCO5qMpKXG5QVz4wpHuw1O0gsE=;
        b=lwZ0IWdWWmjl58B0ECSCssbbNvf56QbZbQdLtllN1uY6xWfD5FIaw1jRArNTRGjW5u
         iicdYXdlB/QaIB3Ye/R4QN4SOazbvrNSp6owjcONldJAbyBnLD8PtPz3UAY03yfrx7JT
         aHN3oVi2v4zkUq1ZjahV8IFaZms3UBP4linM76V0AwpImxZjx81nesKwJBVSjR1gzgTy
         MawTrFu56QoUkZ5L77OEd3LTxwTrxaAtelfz2uRmAQtKpaW/yfHhZ2OG93Myu82CxIpi
         F+KtFFOokH0r6lY7avTEMAYUg5A6sKZj++7dWPF713vq86605jtVlwIwM9S7BtlnQug0
         ihPQ==
X-Gm-Message-State: AJIora8j8c4awVJ0eBjvZhooB6L9jZerMzKH0QH13/GySmk6yJoo4Fz4
        Z3SljXzL8OVLq96acfo0kiyu3PSn29MfGv5JWcqt
X-Google-Smtp-Source: AGRyM1vNK3vGkIvLIHfKclPPAqwZi5akMiOCCS7jWO0SkmibdDFj8QMtaX8m56HqaO9xZWWS5o+H1/8iDRnwwM86/O0=
X-Received: by 2002:a05:600c:1c0e:b0:3a2:ed0a:420f with SMTP id
 j14-20020a05600c1c0e00b003a2ed0a420fmr5554204wms.85.1657746358823; Wed, 13
 Jul 2022 14:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220713204623.5443-1-wsa+renesas@sang-engineering.com> <20220713204623.5443-9-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220713204623.5443-9-wsa+renesas@sang-engineering.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 13 Jul 2022 14:05:48 -0700
Message-ID: <CANDhNCoXjW8iOBj7ZvBC1O7J0om=qUsYmiuBJ8BA+2PK_3-weA@mail.gmail.com>
Subject: Re: [PATCH 8/9] selftests: timers: clocksource-switch: add 'runtime'
 command line parameter
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 1:46 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> So the user can decide how long the test should run.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  tools/testing/selftests/timers/clocksource-switch.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
> index 5256e6215980..a1d0d33738b6 100644
> --- a/tools/testing/selftests/timers/clocksource-switch.c
> +++ b/tools/testing/selftests/timers/clocksource-switch.c
> @@ -124,14 +124,18 @@ int main(int argc, char **argv)
>         char orig_clk[512];
>         int count, i, status, opt;
>         int do_sanity_check = 1;
> +       int runtime = 60;
>         pid_t pid;
>
>         /* Process arguments */
> -       while ((opt = getopt(argc, argv, "s")) != -1) {
> +       while ((opt = getopt(argc, argv, "st:")) != -1) {
>                 switch (opt) {
>                 case 's':
>                         do_sanity_check = 0;
>                         break;
> +               case 't':
> +                       runtime = atoi(optarg);
> +                       break;
>                 default:
>                         printf("Usage: %s [-s]\n", argv[0]);
>                         printf("        -s: skip sanity checks\n");

Ah, one minor nit:  Should the -t option get documented here in the
usage output?

thanks again!
-john
