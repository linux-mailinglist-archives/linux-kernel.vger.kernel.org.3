Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3570589724
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbiHDEq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiHDEq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:46:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3528B57235
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 21:46:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o22so8383822edc.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 21:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mlcDetprCkAQhT6bsYk6vsCpr9ieC7YbTXG3pKPT178=;
        b=NATqAhWVYYxpEe5PSX9aiNEYl+Z4tAuqTnY5zZIVSEVZGGwRLsr9CUj7FknwBfLaWc
         hqeY9YV2yHq4tbscB29uwNsOxM7jPKEbpOi5Ih9Qe2ss/Wmn9oW4JLHsNqQGpC3KjTIn
         SLYlwHxk2zPRltowSR+VdW3KZFmIbK1B+137E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mlcDetprCkAQhT6bsYk6vsCpr9ieC7YbTXG3pKPT178=;
        b=w6vcjLe0CguNe/CLRJV07Xkq4aSFev1LyJJBkqzXGj3elUo1QbaQXEqp2GkOYZKtLH
         alPNDfQBR0DIwOgdYGq5lDyFcoYx9ydiDO0tnPrn4RdJOrccSLh+wMq6nXnWx7vVAi+Y
         pyRRSRGsBJHiMP6rlQG2BAdLF/99ujprNggDnCXnZf9ZRSO2rwg15OdmqJCEMQa6P2nu
         ZzucA9u4KKJalUZoX9ZGgbSYAU+g7W1FEa8XBOkArxIe0EhiIccOKbu0WbCLg4P1nlVL
         Z0xUjn/3WyZEynoqBl9ROUYPw04TMfHb0+FpTvgrUbl9+qRdQyLLMY3gxLxYgQdOGyPL
         1Ljw==
X-Gm-Message-State: ACgBeo2ywOjg2LPSP6YPthJEibqo+loKNFxCh+GwiPKrIp6Z5i9cywyK
        UvmjPPO1mK0QUN1Af23Jp9eVs3IRatqkiIfF
X-Google-Smtp-Source: AA6agR6sRZbEpC+5kEsE5IXhybCnN/1fAOIE4nMqEKKHVDRyXvmFukG8a0hTaRGpzY6Y52zVEFmIyw==
X-Received: by 2002:aa7:da4b:0:b0:43d:cc2e:c097 with SMTP id w11-20020aa7da4b000000b0043dcc2ec097mr147004eds.188.1659588412546;
        Wed, 03 Aug 2022 21:46:52 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id fw16-20020a170907501000b007306d3c338dsm4625554ejc.164.2022.08.03.21.46.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 21:46:51 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id h13so4589628wrf.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 21:46:51 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr61283wrw.281.1659588411328; Wed, 03 Aug
 2022 21:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
 <CAHk-=whXSt2N0GcoPC6XxXXLMpXm-34ua+X4AhPsLoqBcF6Xqg@mail.gmail.com>
 <CAHk-=wj8UHvjsVPohpRA1RJo1upyKoSnjcsys+=vbRVbpPvBMg@mail.gmail.com>
 <CAPM=9txsYE1zFDW+ehHQv138DoeT1Fw6hfzfPa4czvXGSjefjw@mail.gmail.com>
 <CAHk-=wj+yzauNXiEwHfCrkbdLSQkizdR1Q3YJLAqPo6AVq2_4Q@mail.gmail.com>
 <CAPM=9txkjJg5uArn1ann7Hf+JFCukQFGwqv+YHAx97Cdxezs_Q@mail.gmail.com>
 <CAHk-=whWcektQzPJgSPa2DC3wMPxgLh8fJVQWeo8i99XMXPjfg@mail.gmail.com>
 <CAPM=9twUvRoVcWHhBH7yuDDVj8K8aM0APQ8Yx3cx19keLJP8Gg@mail.gmail.com> <CAHk-=wjbfAuN1eV+F0wWFsWEaMmJsT2p3DXnUvxo7bQ-xJwKCQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjbfAuN1eV+F0wWFsWEaMmJsT2p3DXnUvxo7bQ-xJwKCQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 21:46:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wih3NEubvTye4URZOmLYu6G+ZT9cngepo0z++ogCWUymQ@mail.gmail.com>
Message-ID: <CAHk-=wih3NEubvTye4URZOmLYu6G+ZT9cngepo0z++ogCWUymQ@mail.gmail.com>
Subject: Re: [git pull] drm for 5.20/6.0
To:     Dave Airlie <airlied@gmail.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 9:27 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll do a few more. It's close enough already that it should be just
> four more reboots to pinpoint exactly which commit breaks.

commit 5d945cbcd4b16a29d6470a80dfb19738f9a4319f is the first bad commit.

I think it's supposed to make no semantic changes, but it clearly does.

What a pain to figure out what's wrong in there, and I assume it
doesn't revert cleanly either.

Bringing in the guilty parties. See

  https://lore.kernel.org/all/CAHk-=wj+yzauNXiEwHfCrkbdLSQkizdR1Q3YJLAqPo6AVq2_4Q@mail.gmail.com/

for the beginning of this thread.

            Linus
