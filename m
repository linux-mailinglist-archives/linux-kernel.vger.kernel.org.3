Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CA250C5E3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 03:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiDWBGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 21:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiDWBGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 21:06:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2EFB18BD
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 18:03:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p10so17027868lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 18:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g096DpfSCcf8IWJKS1josNtXLu3tIDY7masJQNFWcAg=;
        b=AQYaKU5/J5+aM5TlCj8JWxqEyNRrWADeSBitRwGal1ELDw+cu8iXPNVIYHG5rXsFKr
         EttNL829nFI/wGAfiIXCY1eNMdjdRPK/3HU5lHecTvmamw0HZg8jKDTcyxWmvbvs+/HQ
         Zc3NjzjDRQt7nWoj0trGeL7HrH1BccrnLvfSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g096DpfSCcf8IWJKS1josNtXLu3tIDY7masJQNFWcAg=;
        b=b2xO+TtllsNJuxQ4BlCweMfkYWBsLCGixBStXtTwVpeedWP29pG7N4jjf4dvfKi3SC
         fuWaEf2igTGDTqLJ3tMl/38wj41PpiCxFs8AoOGMQ1mbetCpva4ZDFWu5GRZVMSHgSVJ
         O0ukR7zpZ/L8Ku1dUofg3TVotTQ8O2ZwArV3WJsjb5XxlImSRohRdz+FQQTlWH+cnSgz
         KcAts8T4yDfS+CZnEXBn+zvakLUnAHq16+b+STQK2StwMvu7APVkc+FEoZt6kLscK2HA
         78ZmOmICmb8HW8sOhDn3C5OEjr4/1uXw58BubSasNktOZuiMhn53P2FtaCBfVNPWuabO
         uQHg==
X-Gm-Message-State: AOAM530LJOqTgVkFUcsRx25ui/jQQ8O/Xs3iWFeHmuIypKxEG5i5ezWY
        aynIu4lhetMmNOYmUZaglrkJLkj/24jZlnrCu3U=
X-Google-Smtp-Source: ABdhPJwVN09y5xdiyE7iLB3BLAKrTDiQMdXvRGPPFqbx3bw/IF5Nnt4r3/S/zTaBqjTId8qVlESsgA==
X-Received: by 2002:a05:6512:2213:b0:471:c296:b659 with SMTP id h19-20020a056512221300b00471c296b659mr5077137lfu.24.1650675799382;
        Fri, 22 Apr 2022 18:03:19 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id e9-20020a196909000000b00471924f1f01sm410800lfc.228.2022.04.22.18.03.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 18:03:17 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id h11so11533744ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 18:03:17 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr4454046ljg.291.1650675796759; Fri, 22
 Apr 2022 18:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220422131452.20757-1-mario.limonciello@amd.com>
In-Reply-To: <20220422131452.20757-1-mario.limonciello@amd.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Apr 2022 18:03:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-F2KtXkQueVJRNqWr7O737NzN=8mYA_r-h-16=VxLQA@mail.gmail.com>
Message-ID: <CAHk-=wh-F2KtXkQueVJRNqWr7O737NzN=8mYA_r-h-16=VxLQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Fix regression in 5.18 for GPIO
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Gong Richard <Richard.Gong@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 6:15 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> This patch is being sent directly to you because there has been
> a regression in 5.18 that I identified and sent a fix up that has been
> reviewed/tested/acked for nearly a week but the current subsystem
> maintainer (Bartosz) hasn't picked it up to send to you.

Applied.

I'm not sure the "cc: stable" makes much sense since the bug was
introduced in this release, but I assume you added it because the
problem commit was also marked for stable.

The "Fixes:" tag should take care of it, but I left that cc:stable alone.

           Linus
