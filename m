Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DF54BC42C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240834AbiBSBKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:10:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiBSBJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:09:58 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D58C182073
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:09:41 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id u12so8793260ybd.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IksLXADFvek17WHYJzvzDkWH8Xrf5A13V9P+cnSi+SY=;
        b=QknuN3t2etfBlMwfjPB/UPSQCQ0LVnPGFMiarCqXbfbNgjg8e1RANjcj9iK4bGaIfb
         1hSse3eusSQSspzhTQu+PcDa39zv173j766XbDRNqlRWGkbSoAewLjMo0qOSniyUcqVE
         aTF2dm1gj6DQkodZBOH1WrtzLzy4VTFwCKeedOBkNCqKRTh7QhQnMZpjYzs2CeSl8lpR
         BpchsefaJtLDs/pS7dr89hLeN8PUvjVu8j+2iKs/7i3ab17bxym8XKI/xA5e2uWX2I7d
         GyOi3M0TRW+qjEwW+lsrMCr9JClkE2YzqI6WaAk+/nsCRvvvHAFeer+DFyWVWwGuULO9
         jwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IksLXADFvek17WHYJzvzDkWH8Xrf5A13V9P+cnSi+SY=;
        b=nl0n3mQt2YnphyVoKOo2ZEnRjVKstQeF5VhfsXSJaOYv3/T4/bDUs+ace6fhROqJhc
         UU23oZkEb8QhNBgw65xfUucqxC7gsb9KGLGK+xdC0q+3rrbPml34FwJ+2twkF40mqBkJ
         25LHe2COelzsO+yUeJZq3jd2W7nCdF30Zq5DspCr8JSSFzvbuwR7ljHUrIVZiDj8/9gS
         0zv1jOf7W9H0cPJkuXvMexSmsrlbjx3l0s3KX+2erG9WERZBSEpMQ60M6HNhuLSaOvbT
         r5IKM9n1nmWMenitDYMPodMTWTJgEcK/mr9NThT9TEtNNa0nvRSO8r0zvGl1FI3TbhFA
         YUeg==
X-Gm-Message-State: AOAM533x2C56UzbsponKyXxZ0n4v58eFyLh5cgSRgxGFVoDa35UzykMQ
        bXAof3fs9UNtsjnHiUWSpZ46D83ZmBj9C6LT034AVQ==
X-Google-Smtp-Source: ABdhPJxnVQXIGzqxSnP+rJkrDiBnc0niqDv58FRFwY/m6IlTDGePMZDxAFNtpNafQUQgJlAVGkgWf3wVGh5aW6jBjaQ=
X-Received: by 2002:a25:a50a:0:b0:61d:720e:2748 with SMTP id
 h10-20020a25a50a000000b0061d720e2748mr9679977ybi.492.1645232980562; Fri, 18
 Feb 2022 17:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20220217131737.10931-1-mans@mansr.com>
In-Reply-To: <20220217131737.10931-1-mans@mansr.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 19 Feb 2022 02:09:29 +0100
Message-ID: <CACRpkda-_1xQbE9=+Zx2bJ9Cgu=RSk8LqK3i1HJbO9iU-x9kbQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunxi: do not print error message for EPROBE_DEFER
To:     Mans Rullgard <mans@mansr.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 2:18 PM Mans Rullgard <mans@mansr.com> wrote:

> Avoid printing an error message if getting a regulator fails with
> EPROBE_DEFER.  This can happen if, for example, a regulator supplying
> one of the main banks is controlled by a PL pin.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Patch applied, thanks!

Yours,
Linus Walleij
