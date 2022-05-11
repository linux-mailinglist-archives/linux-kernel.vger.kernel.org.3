Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB35523D46
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346729AbiEKTRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242629AbiEKTRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:17:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E353D493
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:17:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w24so3717460edx.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0rLYZTGM9tABUfYW7kAK/fqq3Ax7YNevFHH/XCjFGs=;
        b=eCbRkCpG+1uv8o7qRy4S8ofMtbzrfrNObimViXJYOfvi54JNTAr6JFhhlnpgtpAcS+
         VN1OH3CnIDFz9Ap8QJJbmVusIA88+j05i4dmbpolhuHRtJjOf6pV7NrV6W8AIKtloJuO
         Epo1XPPLAfd3d4t/rIpKYoMleVpcQa62xi+gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0rLYZTGM9tABUfYW7kAK/fqq3Ax7YNevFHH/XCjFGs=;
        b=L9JtPLpzeoximmVC2GzimFBO8hk1UkWKpTcOqrStYgyfBFRxvFu9nPJOv600CTMWKr
         9eDng2enM0sCBaVD2XjCqDSEP3Gv4rfa4KdT5s1rJRNx4AI+thCk8ge7mi9KvdZLdvUR
         66COKGeq+zLn3jOY8B2T2EiHwdAXwTQg/YZLHYMUBT9cc+EI0f7YbWx+hKbbF1L8id/Q
         2x1lqzeDgtpv8SqCHfU9lKJLWueM1xPq96GrGMwD3lA6iilyjTCvp2ypyb7xITaXAhV8
         Y1OuwjuKMn9UbI7g1g4AuX/gODEbLx54E4chxguk4tle3G8VT+GfRAt0aLeA9tCb6smZ
         L61Q==
X-Gm-Message-State: AOAM533MEugwkFFCLRoJPsr3ra64dPfz/1y304/thaAy4DXCEYsdOu8x
        nHkc27qqXdNGM0LxuTyB/LLdaEl0SNS4ceElRVw=
X-Google-Smtp-Source: ABdhPJxPbkUXEOcWc6CxCHwFmjYe4sg8Oogrm+XfoPnYE12Hd5DuXzdlTAA7tX+Xg6uuHpq9oyn4Aw==
X-Received: by 2002:a05:6402:1941:b0:413:2b5f:9074 with SMTP id f1-20020a056402194100b004132b5f9074mr30455131edz.414.1652296657945;
        Wed, 11 May 2022 12:17:37 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id j23-20020a1709064b5700b006f3ef214e6esm1272869ejv.212.2022.05.11.12.17.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 12:17:37 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id v12so4270299wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:17:37 -0700 (PDT)
X-Received: by 2002:a5d:6dad:0:b0:20c:4dc1:e247 with SMTP id
 u13-20020a5d6dad000000b0020c4dc1e247mr24044515wrs.274.1652296354621; Wed, 11
 May 2022 12:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220510070140.45407-1-tomeu.vizoso@collabora.com>
 <20220510141329.54414-1-tomeu.vizoso@collabora.com> <CAPM=9tzLR-wsLhg2ikGjoK06s-ju5XWa1rtPPiUpN=pwD1vgtA@mail.gmail.com>
 <CAHk-=wg8YgH1h3wrm9CtXff7rSewa+NE0Z5upb1GOE8XiTL9HA@mail.gmail.com>
 <CAF6AEGusO9XAqHNatJLgV+wpVoyyLg1vHtUsnSkAxJeV7n3WNg@mail.gmail.com> <CAHk-=wjbE0f2AGroB1Hy=fx2fh7cRpS0wNdB46Ybk14Mb0b5Jw@mail.gmail.com>
In-Reply-To: <CAHk-=wjbE0f2AGroB1Hy=fx2fh7cRpS0wNdB46Ybk14Mb0b5Jw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 May 2022 12:12:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjy4DY_ya8TBs9W2wLWHibBiHMQW2T43DQR1SGRkqD=gw@mail.gmail.com>
Message-ID: <CAHk-=wjy4DY_ya8TBs9W2wLWHibBiHMQW2T43DQR1SGRkqD=gw@mail.gmail.com>
Subject: Re: Adding CI results to the kernel tree was Re: [RFC v2] drm/msm:
 Add initial ci/ subdirectory
To:     Rob Clark <robdclark@gmail.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 12:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The kernel tree might have just the expected *failures* listed, if
> there are any. Presumably the ci tree has to have the expected results
> anyway, so what's the advantage of listing non-failures?

.. put another way: I think a list of "we are aware that these
currently fail" is quite reasonable for a development tree, maybe even
with a comment in the commit that created them about why they
currently fail.

That also ends up being very nice if you fix a problem, and the fix
commit might then remove the failure for the list, and that all makes
perfect sense.

But having just the raw output of "these are the expected CI results"
that is being done and specified by some other tree entirely - that
seems pointless and just noise to me. There's no actual reason to have
that kind of noise - and update that kind of noise - that I really
see.

                Linus
