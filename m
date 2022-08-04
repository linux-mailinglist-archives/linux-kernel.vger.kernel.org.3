Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D66858970C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbiHDE2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiHDE16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:27:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B974E854
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 21:27:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b16so16323143edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 21:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WHUvnwYFxV5A4ffpdozxVm8wDmlyhI1HeR3vH2yCyf8=;
        b=P+E9m0qAVnO//aySex5TWRd4ra/sPgEawpwF8xWegvfQGYCpZRS/jYRlzfpxNNqSUd
         w7RDXwTq0FASod8CEoIss6EInqViEippn515GWsrjnn216k79PM9oOXu/9sB5/6IoriF
         wwd02IPfL9jwDAvsJJdtPeD4Op0KQU6lOoT0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WHUvnwYFxV5A4ffpdozxVm8wDmlyhI1HeR3vH2yCyf8=;
        b=LCYAl/gunua1xJ22cX0cGD31BbUpB0IgXqpvtqH+mB3TSqzRP7eDwLh1uG09txpVVM
         0NFBDowdoQhmJiXNOxwSBvRssThfa183puVYhOYyEM54a5NI7h5Wbg7pTjns578yUJgi
         H8mzLlhtISAki7hi8EGc22MYAkOcJtX0XVe14ZS5rmmLYDwvDdegwib30Ae1hN1wa0w+
         uAxEkzOu2wPl8MWm5OqAFBQfVL8aNZnLdT2v+8ZreR7y9l2B8m/a19LSoqYwPa6048zr
         hIFG2luhaoRstU5SecyS67qK9xUGQXZSXAJV2LJI1PBiPBUkHjzxEyBYubzX2Snsh10B
         MZOg==
X-Gm-Message-State: ACgBeo3nXSk0tS/ZGLgSXCxsFBkanqjHbclZYLS8m6Bz4SkM6y9pjnM7
        8Z/3DdjrKfL+FlmqEi1Q/SkOQRkJQ4VRKP5U
X-Google-Smtp-Source: AA6agR7AWywLDGWY1xa7H6welPXprkx9sQoiau+rGeu6VM8AICsDzn5ekxdx5f5XccLE7AkUKG4W2w==
X-Received: by 2002:a05:6402:5110:b0:43d:c589:b70f with SMTP id m16-20020a056402511000b0043dc589b70fmr61416edd.103.1659587275003;
        Wed, 03 Aug 2022 21:27:55 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id i1-20020aa7dd01000000b0043d668dec21sm39046edv.38.2022.08.03.21.27.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 21:27:54 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id ay36-20020a05600c1e2400b003a4e30d7995so1887267wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 21:27:53 -0700 (PDT)
X-Received: by 2002:a05:600c:21d7:b0:3a3:2088:bbc6 with SMTP id
 x23-20020a05600c21d700b003a32088bbc6mr4655050wmj.68.1659587273590; Wed, 03
 Aug 2022 21:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
 <CAHk-=whXSt2N0GcoPC6XxXXLMpXm-34ua+X4AhPsLoqBcF6Xqg@mail.gmail.com>
 <CAHk-=wj8UHvjsVPohpRA1RJo1upyKoSnjcsys+=vbRVbpPvBMg@mail.gmail.com>
 <CAPM=9txsYE1zFDW+ehHQv138DoeT1Fw6hfzfPa4czvXGSjefjw@mail.gmail.com>
 <CAHk-=wj+yzauNXiEwHfCrkbdLSQkizdR1Q3YJLAqPo6AVq2_4Q@mail.gmail.com>
 <CAPM=9txkjJg5uArn1ann7Hf+JFCukQFGwqv+YHAx97Cdxezs_Q@mail.gmail.com>
 <CAHk-=whWcektQzPJgSPa2DC3wMPxgLh8fJVQWeo8i99XMXPjfg@mail.gmail.com> <CAPM=9twUvRoVcWHhBH7yuDDVj8K8aM0APQ8Yx3cx19keLJP8Gg@mail.gmail.com>
In-Reply-To: <CAPM=9twUvRoVcWHhBH7yuDDVj8K8aM0APQ8Yx3cx19keLJP8Gg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 21:27:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbfAuN1eV+F0wWFsWEaMmJsT2p3DXnUvxo7bQ-xJwKCQ@mail.gmail.com>
Message-ID: <CAHk-=wjbfAuN1eV+F0wWFsWEaMmJsT2p3DXnUvxo7bQ-xJwKCQ@mail.gmail.com>
Subject: Re: [git pull] drm for 5.20/6.0
To:     Dave Airlie <airlied@gmail.com>
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

On Wed, Aug 3, 2022 at 9:24 PM Dave Airlie <airlied@gmail.com> wrote:
>
> I've reproduced it, I'll send you a revert pile when I confirm it is
> the buddy allocator.

I've bisected it to 86bd6706c404..074293dd9f61 and don't see "buddy"
in any of those commits.

I'll do a few more. It's close enough already that it should be just
four more reboots to pinpoint exactly which commit breaks.

                  Linus
