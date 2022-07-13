Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07862573E29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiGMUuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiGMUuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:50:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF182C113
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:50:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id z23so5399654eju.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahgWcY0Qhtt2gptPxS6Knb/YUD/M/kyPSyAouT+Dg5Q=;
        b=eWyzJ3DkQPO8/Ucp2ZtR+aYlDD2nT9ApRtgzzfquSIYkokAIYRl2vW5b6bt/Xwhfra
         YQI4Qfok3pGM9xg+494aKlrf4c/au02ChfkaI2ab6CUK47+sfbQuj+0F8SkDyDqEUYxc
         kEmSkZbf4Ya4CAZSLIIzXiikXy/Wr2/bBFVmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahgWcY0Qhtt2gptPxS6Knb/YUD/M/kyPSyAouT+Dg5Q=;
        b=hUOVr2t1EY9VPdV0R3SLLT9I81wSy6bwrlPL+5CqQMkJZoFNWWbG7ucgogkr9Xq79b
         iQAooAIUA4UHdLmfz+EcJGoFtCCf4Kt5PgrCZ/gCdPpsktozQqkW8D2ZeQkhFf08vnzC
         blQ0/m4Gtb+b0A8ZkJVq8/OzPkZvYKYmb7Qy6DLUfkTS0yABP2OGmDJl5O8MlLgxh8iR
         a3wrk8WQ2HI/TY5MQhSYmQwBEiiI1XgpzsST8ehNLV6TnTnoNvGJ/lLpbEJ7r6T6RwHQ
         d820mXi3VQW93lZU9NgJvScgVTDSZ8Epk7ZDoz/ZAWtDifo9KVj2G/Q4cDSxziDQTbF1
         4ICQ==
X-Gm-Message-State: AJIora+7EwcyEyh2YCgW9qVXI/IIKd4DjFJaNyNDzyf17c6Tg8XOeO2w
        u65VASOVatSHrm52XGQ0TmNOnQrsRGFANQWD3sg=
X-Google-Smtp-Source: AGRyM1ufkhU/o/5IZ7X6LapPaDOW6X3tf5nNukaXA9mZ2w1bALqJkXNQzhYdiMcvfZDAGgj1rlW7sw==
X-Received: by 2002:a17:907:1dde:b0:72b:11ae:700b with SMTP id og30-20020a1709071dde00b0072b11ae700bmr5181983ejc.520.1657745419565;
        Wed, 13 Jul 2022 13:50:19 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id fp17-20020a1709069e1100b0072a55ec6f3bsm5345113ejc.165.2022.07.13.13.50.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 13:50:17 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id ay25so7221741wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:50:17 -0700 (PDT)
X-Received: by 2002:a05:600c:354e:b0:3a1:9ddf:468d with SMTP id
 i14-20020a05600c354e00b003a19ddf468dmr11442317wmq.145.1657745416681; Wed, 13
 Jul 2022 13:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
In-Reply-To: <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jul 2022 13:50:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBDup4LrJBr2WPkT09e_zk8g+Uq-5P-q5+THZ4jeoWVQ@mail.gmail.com>
Message-ID: <CAHk-=wgBDup4LrJBr2WPkT09e_zk8g+Uq-5P-q5+THZ4jeoWVQ@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Wed, Jul 13, 2022 at 1:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> It does, but I can't imagine that the drm or ppc people would be happy
> about it.

When something has been reported as not building for five weeks?

I have zero f's to give at that point about their "happiness".

             Linus
