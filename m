Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7800F48B8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbiAKUg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiAKUg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:36:56 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E69C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:36:55 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m4so1003544edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhTc2fZPRf49402IZJZrD0G7GSgDTNNYfixj1K2wtCE=;
        b=OnO/1NBECg49FscHQiUJJsI8kyhIwulL1CMWTPj8c0arPJ6mcuNDGMP5Z05+RZhGTw
         8Qh32WeUSDrvpb5ZBfUM3ESbcIof4lmsWcUQjW6k/+74HYvPJHnWn/a2ppJXhT7w2/D9
         JIMurhESR3+nOenjxbC56gH0WvfIU30WlZzUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhTc2fZPRf49402IZJZrD0G7GSgDTNNYfixj1K2wtCE=;
        b=P6VrP20zoBLSZqS17AVEkivx2uBt4XV4NnnLYk3E5kJqP+IgW26oZBEKjHssxyb1Xg
         q5+D0epLE9EvqLfD88YQyWJXJuK3Ai712sL5JMz8ubDmOQaDOm7omdklm4PJt1Rn6Zl3
         hEZlyStgk0ABunicHa2TlYYJ/KlxMnfC1qXZqxNbtAd715cHaVBjUVGZvfik0wflGInT
         fSdMZZiXRbFgvmXxAb6/QAagcmqcsRuo0BQwMaZjshQBiKdNU0JHHYRsjL/DUJLBU4aa
         BRxv4Ofa3LWF4pppQyYruJcBrcnO8ni6QS86tAPDPLK0R6KU4hN9h9Xu118qoV48wtCa
         hqrA==
X-Gm-Message-State: AOAM531XGMG+gkrE1pkce2Dn+Y4+SMJHMBrENfwQDYokIdpHquzXWiXg
        h+nirmau/wdRWX1adE6bTynoXzs7eNRcswYafMI=
X-Google-Smtp-Source: ABdhPJzKR8ptVlpklPwEkNvSowiumfxJsrztEZm+xlmNs7ECndUl6NyDMMIdOkVrhkrsYqbIHet7WQ==
X-Received: by 2002:a17:906:9912:: with SMTP id zl18mr4873850ejb.348.1641933413949;
        Tue, 11 Jan 2022 12:36:53 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id d1sm3965241ejo.176.2022.01.11.12.36.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 12:36:52 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id s1so412449wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:36:51 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr5154363wrp.442.1641933411136;
 Tue, 11 Jan 2022 12:36:51 -0800 (PST)
MIME-Version: 1.0
References: <20220111155255.745428-1-brgl@bgdev.pl>
In-Reply-To: <20220111155255.745428-1-brgl@bgdev.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 12:36:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1RUc-41K=XTQavnkuLg2=oe8r8LWBocWWWXhM77=2gw@mail.gmail.com>
Message-ID: <CAHk-=wg1RUc-41K=XTQavnkuLg2=oe8r8LWBocWWWXhM77=2gw@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: updates for v5.17
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 7:53 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> The gpio-sim module is back, this time without any changes to configfs. This
> results in a less elegant user-space interface but I never got any follow-up on
> the committable items and didn't want to delay this module for several more
> months.

Yeah, I think that was the right choice.

I actually did spend some time looking at the configfs code, and it
just worried me. It may have been clever, but there was no real
serious user that would have used it outside of this gpio use-case,
and the games it played with the dentry layer were scary. With no real
maintainer for configfs, and no VFS person willing to work on it, I
think it was a dead end. With that in mind, the fewer fancy configfs
users we have, and the fewer reasons to use it, the better.

            Linus
