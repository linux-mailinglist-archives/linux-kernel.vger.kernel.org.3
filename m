Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E56E4CC700
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiCCUUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiCCUUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:20:32 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5EC17225B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:19:46 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r11so2516559ioh.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 12:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QxBQvmNYn7HAW7yQ5a0LeAHw4p+eKRld8cXEiNzs7zM=;
        b=jA0oMxRjOzhZbOPT8f1nKhtCik430a+ObBSgmQM71X2ciLiAotO+xE6XCWalZhlKpN
         N25yY9DFe4gQhm+I58pFnfWzzeQp2U3KCgyczW2EWBQvf1KH4cgClSixIY45fnSB82F3
         ZrENHAV329qT8KSkszpe7NCVjHFfjxCl1XW4Rmau1RDZTwlA/avkBiEyliKOstMrscEs
         WQYq7y1V4a6rMMK5O+A4PUFhwn4P0Wk2FATnj1Hv9D/01uc9JDhWIeJ1xN+RBXvtTn4f
         YL13w0e/Ll4SV5yR+U3UOcauu+/OIMGnVgjadvS2IGwFlS603zjpvVqhX5ur3siRNgFa
         ay1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxBQvmNYn7HAW7yQ5a0LeAHw4p+eKRld8cXEiNzs7zM=;
        b=ZCY1L+OxHYfpo2L0HnBW5V2UdndauCDv8KDw9dTH29pxI0+X0bcWL5x4NUEAWfCM7g
         U3eGxy/k/C2RLDG9FGO3F2hURNrAnwCY3iPcPYAsF95m696FCZCEdtbaWj58FJX8EPRs
         YypO2Xe8haG1sBUaQikpHZ7LVFQQ2FY+sv+uwci7JDaCFdRIikd0/uq2+7U6uF2ySEaG
         odverNQJOoL9rnFKx2mOzRZImmU8pEEGd/lR2I+8QuOnHgwzsSsymqBK1mFYX46Nz/vR
         EW/JhhbHeByT90a0U590K0ocyQrNgyPI4/gFzynoFYqvIcdmaHmrclNdRfQiRHfi14z2
         Eieg==
X-Gm-Message-State: AOAM531CHinV2WdQgWDau1145QxKo1CLi0Ers9pk1AjftcabKjfz7Bed
        inRMg2pk+ka1vzzrkpyE/OIGJpnRd7L7H5tNvHw=
X-Google-Smtp-Source: ABdhPJxl9aRNtr8n7gcU9vxUYXT+Y5U3mHqCohstKvStpaWTNkqymth7ywS8Me/NFnDQdG34tsDHAtihZSf9YZQ7ZsY=
X-Received: by 2002:a05:6638:168b:b0:314:7a8d:19d4 with SMTP id
 f11-20020a056638168b00b003147a8d19d4mr31013569jat.199.1646338786230; Thu, 03
 Mar 2022 12:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20220303173935.100622-1-cmirabil@redhat.com> <20220303173935.100622-4-cmirabil@redhat.com>
In-Reply-To: <20220303173935.100622-4-cmirabil@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Mar 2022 21:19:35 +0100
Message-ID: <CANiq72=vTm-_MwPMREr5Z61022AEQzcOs+kTgdtz6zgoFpazGA@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] drivers/auxdisplay: sensehat: Raspberry Pi Sense
 HAT display driver
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        fedora-rpi@googlegroups.com, Miguel Ojeda <ojeda@kernel.org>,
        Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
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

On Thu, Mar 3, 2022 at 6:40 PM Charles Mirabile <cmirabil@redhat.com> wrote:
>
> +       u8 temp[8][3][8];
> +
> +       for (i = 0; i < 8; ++i) {
> +               for (j = 0; j < 8; ++j)
> +                       temp[i][0][j] = display->vmem[i][j].r;
> +               for (j = 0; j < 8; ++j)
> +                       temp[i][1][j] = display->vmem[i][j].g;
> +               for (j = 0; j < 8; ++j)
> +                       temp[i][2][j] = display->vmem[i][j].b;
> +       }

I assume the hardware uses only rgb555, right? I think this is OK, but
please consider if it would make sense to read a 8x8x3 bytes matrix
anyway, even if some bits/values are ignored/discarded.

> +       struct sensehat_display *sensehat_display =
> +               devm_kmalloc(&pdev->dev, sizeof(*sensehat_display), GFP_KERNEL);

Missing some error handling, e.g. here and in `dev_get_regmap`.

Also, if `sensehat_update_display` could return an optional error, you
could also fail if the first update did not work (assuming it is
supposed to work), or maybe warn (if it can fail for some reason but
it does not mean future updates would fail).

> +MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");

Please consider if you should/want to appear here alongside Serge.

Cheers,
Miguel
