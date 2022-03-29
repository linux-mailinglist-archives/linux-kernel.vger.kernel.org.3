Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8428D4EB5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbiC2WMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiC2WMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:12:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82E182DAF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:10:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p10so26791003lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NszAzyCxeqCYVF4rcK1etWk+lEs38VK5zvRzeDlGh0=;
        b=KQCd+gO4PoDRepPTc/MgjHeabBWTTOlSRI+8rzh47UsJNwJP7SFfBYTTvHx+cKjOOd
         p03PYtz4rTHsrzEpQTzkyaguV5RxijqsK56lFbbMBqKt2a7k7JnkkaG/F1bNe0YGVTDC
         3vc3jh+wUG1YiwvUk0ww6Wo9c1zmM0yvafCWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NszAzyCxeqCYVF4rcK1etWk+lEs38VK5zvRzeDlGh0=;
        b=iH6H/nkS/gDkYBdhKjSR+i2PQeRnhKtROxcsQ2ga7KNFAjStTQMHQHZfwgnyWi7VQt
         gUiBbyWjXHjVFLyeQVBnxq82zEKPHi0v3wuA6SPkL3IgEomXaqF6DukL8czm+Lhlncp6
         8MwYbWEaIWdWXgxzuH2Dr4Ixqc2PLI2/ro7hWjeCfO2AtS45aYQ2fHz83Ym+g5vXwzlk
         cMWhnht7dwH1czzpy995cWolPOQ+/UR7JAPtOkef6+xrIe77ZaELGQSNilGGD+xzXxNF
         Et/mkL2pGkVvvLmnAHNy3z9RsXZf+tuRMSB3KG1du/Fo/NIrR6kkTColzOikt1eg4ofb
         tdxw==
X-Gm-Message-State: AOAM533RBKrPymZVkbVtz0msxiAGQjnHqeUaYAu7bYYZVrj1hxEtRiO5
        HZl3OIAcsq5lQzB+8LjPYoq1uj6chMMq4C6W
X-Google-Smtp-Source: ABdhPJytdiH5LFVa5u9KhM2AlfefMYARJnSxBOe2ZSNAbHmPQSGw5WsS+NzF07HFMZZyT14asgqVdw==
X-Received: by 2002:ac2:5602:0:b0:448:5388:c602 with SMTP id v2-20020ac25602000000b004485388c602mr4494137lfd.50.1648591847789;
        Tue, 29 Mar 2022 15:10:47 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id r9-20020ac25f89000000b0044a1008c5d7sm2121994lfe.234.2022.03.29.15.10.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 15:10:46 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id w7so32680256lfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:10:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr4470007lfb.435.1648591846330; Tue, 29
 Mar 2022 15:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <Yj19RH3qpzQsIV/O@shikoro> <CAHk-=wgoeUc15-8Wu8U=4FnwhgmyU3C13R107oigbmJRpi_sZA@mail.gmail.com>
 <YkIF9OqbZQ8yinz8@ninjato> <20220329142642.11692e8f@endymion.delvare>
In-Reply-To: <20220329142642.11692e8f@endymion.delvare>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Mar 2022 15:10:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqC1OU_a_r80-1EdwSc2SFY0m-V9u6XXr24_C3_XaNcw@mail.gmail.com>
Message-ID: <CAHk-=wgqC1OU_a_r80-1EdwSc2SFY0m-V9u6XXr24_C3_XaNcw@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c for v5.18
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Terry Bowman <terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 5:26 AM Jean Delvare <jdelvare@suse.de> wrote:
>
> And this is how I came to the conclusion that, despite the weird
> feeling that there are too many conditionals in the i2c-piix4 driver,
> there's nothing smart that can be done to get rid of them, and we just
> have to live with them.

Thanks for the very complete response. Color me convinced.

              Linus
