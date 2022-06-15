Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271B054D53E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348658AbiFOXYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242403AbiFOXYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:24:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC99710FD8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:24:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z17so7085146wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oh0CzsBK6XYUSBqF1cQtOHLaqbDSnG4wCRRP0RL1GWY=;
        b=fwryWYy1j3kluVUxxG5tFQ3vYHpbqs9hgx4Jdj1WImsyQmO4FTGFa4hM1VabxWcMms
         WojO6BK3Hsd5ZpJMYnTmbFv4nRhloIV5aNQRFeEz0P1QQaZ3IO8tgbpGhzb7hee9RpiY
         76/9VoY0DBWkGkLyYJ7Ja5vJIarHTKlwS1eUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oh0CzsBK6XYUSBqF1cQtOHLaqbDSnG4wCRRP0RL1GWY=;
        b=CHxCmV1o5CELXK2SbddwdFlqdgXXH6nSvgVcQWRvVi9MHE6k2VaVGBK2e9yrfk/hGO
         GmoqphmDOgL5moJzrJGvEcSLjcBLhO/utFQa8YO16oXabyQYBAMRnlB2T9vv1Mj9ufjC
         nlD3J33xECaGVMMxxU1G1NmzTi07kVb4ghWqmIcCvgCbRhlMHMxtwfVAIxaetuVxKVjs
         jlm9BLVDhbiGJKFk8nDjWOrSTxambNjWD9EgAI7RODyFrae/OBgVZ3pIm2aounG39GRQ
         qAQI8j5K4w14RDC2eZ5lG34HgE8HVUvz4lKt5FlsappohIS1DPT8N4nNOFN0/2LNsgiE
         v26w==
X-Gm-Message-State: AJIora+/4gkcwJj+ni/Z0EZ9vOyaE5sFfaTEApYo2LxHW4ys76fyyioZ
        +xAsla0uoUdcLw4DGV+tbAhks587tiCM+6enrz0z8Q==
X-Google-Smtp-Source: AGRyM1uj+gBu25gwQLFPBOZ5+Eln6z2RnmnhA3J7SVFKR/uvc0t7ylrZdMgeetRsu5LbUjgJ+JRDWKcrmpPXtYwXnNw=
X-Received: by 2002:a05:600c:3792:b0:39c:6667:202 with SMTP id
 o18-20020a05600c379200b0039c66670202mr1876308wmr.104.1655335483162; Wed, 15
 Jun 2022 16:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
 <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
 <CAD=FV=XAYUx9OKLxThQxYr02ZE+7Rjw0VnSsxg7kfPCBG38FZw@mail.gmail.com>
 <CAODwPW_6A3kcmTLHVnH19bdYKpVBadAcDk5g-qxuju04uPRcMg@mail.gmail.com> <CAD=FV=UzsbwSbTc7LtsTj=wxj8A1MqmkVFt0XBrTdQ8pEhde=A@mail.gmail.com>
In-Reply-To: <CAD=FV=UzsbwSbTc7LtsTj=wxj8A1MqmkVFt0XBrTdQ8pEhde=A@mail.gmail.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 15 Jun 2022 16:24:29 -0700
Message-ID: <CAODwPW9DiWF2ffwBnw2rNhcV8rre=BzO9deEY_qXGvkWCPwe4A@mail.gmail.com>
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
To:     Doug Anderson <dianders@chromium.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, then what you have seems OK. Personally I guess I'd find it a
> little less confusing if we described it as "num-chips" or something
> like that.

Yeah, we can do that too if people prefer that, that just means the
firmware writing the entry needs to do that math. But while it makes
the chips thing more obvious, it makes it less obvious what the actual
memory channel width for the memory controller is, so I think it's
sort of a trade-off either way (I feel like reporting the channel
width would be closer to describing the raw topography as seen by
memory training firmware, and leaving interpretations up to the
kernel/userspace).

> They do have different sets of values valid for each property. The
> properties are annoyingly not sorted consistently with each other, but
> I think there are also different sets of properties aren't there? Like
> I only see tRASmin-min-tck in the LPDDR2 one and not LPDDR3.

Okay, I haven't looked closely into the timing part. If there are
notable differences, let's keep that separate.
