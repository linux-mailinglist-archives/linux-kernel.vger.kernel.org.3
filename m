Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87638524A30
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352582AbiELKWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242164AbiELKWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:22:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B565F8FC;
        Thu, 12 May 2022 03:22:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q4so4427908plr.11;
        Thu, 12 May 2022 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E6IZ0JJc5m0aq/8SHpdc4cXSMXVdXk6ybd09b5VcxZo=;
        b=jaFXXvhZgi7pQZsqjsiN7ExzaMY4FC6PbyviRfgj/rI7KDPpqiKF9Qe22s4IFcdYTK
         NpkPijwPubv/q+KLP0JReczZ/9WN+qRePp1iuXyYkbrAXRTEJgcMz2QB8pk9hHuMKkcR
         GxyOZ26Qjydr63nnOCxvkS17Yep7Ee8XYQc8WlrD6+oaGpdC9GWt7Pgz1HpoVJIlYbS6
         cpjHl3sBz7SOylii3OGzR+zQZjtZrg4/5Eoc4ZGe4AOli4wXXbDJ45398Z3H8b/WGBSh
         oEQC+mSJXJAFgQ/HGjQ2Sns9FVfrdsHcE3u3cSZJck5vs5LEBo5C1daxDT0MaJs1XPk5
         +Vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E6IZ0JJc5m0aq/8SHpdc4cXSMXVdXk6ybd09b5VcxZo=;
        b=utaACJ9fSEzMHKy86otzp/NefYFJ7imXYZ9TOXRTuBXw4XUIuo5HrGiPo47LQ5H003
         TtdCk4UzgRIqop1Mf604+VF0opqT0c8jIgA8K3EeK0zpdm5q9Z68IWECNmV5zsS24t0D
         PvfbozJq946Fps2PG0e6mWULgo2KnoCrSHn6961S1b6QWkCLQJBGtQijHMIuXc5UhC31
         WU8z84dOXwlVGpO79eLQhYI/8Lr2Q+FTmd1GpEh6LJ1O/QlgreRvZlaCB29vSbH5JR82
         4XTELNkgg45pBQd0yKVCru3AqHVcc8xdAFBwdgM5MCTZkMRi+BpMP2fYkwIL3ZDYuRJy
         o2CQ==
X-Gm-Message-State: AOAM533BBM+c9PJK6wreOw5op/IN3GRrQmKK5TylNkJSDiZDyqc6zCj5
        qn6R4lJAybwhROkUUAUFds4=
X-Google-Smtp-Source: ABdhPJx9KgymB6uUxieDp/mDnUNHiGy5kalJZ9YWcy7lBuxrC8hrqDib6NY00rXn8txCLkcXS3TznA==
X-Received: by 2002:a17:90b:2243:b0:1dc:3f08:8316 with SMTP id hk3-20020a17090b224300b001dc3f088316mr10371638pjb.194.1652350953722;
        Thu, 12 May 2022 03:22:33 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:ad76:8fc:e2ba:172])
        by smtp.gmail.com with ESMTPSA id h11-20020aa786cb000000b0050dc76281fcsm3334694pfo.214.2022.05.12.03.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:22:32 -0700 (PDT)
Date:   Thu, 12 May 2022 03:22:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
Message-ID: <Ynzf5jEIECLmELK7@google.com>
References: <20220429233112.2851665-1-swboyd@chromium.org>
 <20220429233112.2851665-2-swboyd@chromium.org>
 <CAD=FV=VX8EEgkeLgKwyKvjztcjbA8UhKOUpTr-sS1_Ec=QcWbA@mail.gmail.com>
 <CAKdAkRSOtAD6u_cwKhHeMLgz5dC2hfPvVvqmj+17b4i-nspfgg@mail.gmail.com>
 <CAE-0n50Y8tZD9Djn9TVaAiHxehFJ2cZKZ1Z09piDk47uw3nK+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n50Y8tZD9Djn9TVaAiHxehFJ2cZKZ1Z09piDk47uw3nK+Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Sorry for the delay with my response.

On Mon, May 02, 2022 at 01:41:33PM -0700, Stephen Boyd wrote:
> Quoting Dmitry Torokhov (2022-05-02 10:43:06)
> > On Mon, May 2, 2022 at 10:00 AM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > That goes against the recently landed commit 4352e23a7ff2 ("Input:
> > > cros-ec-keyb - only register keyboard if rows/columns exist") but
> > > perhaps we should just _undo_ that that since it landed pretty
> > > recently and say that the truly supported way to specify that you only
> > > have keyboards/switches is with the compatible.
> > >
> > > What do you think?
> >
> > I am sorry, I am still confused on what exactly we are trying to solve
> > here? Having a device with the new device tree somehow run an older
> > kernel and fail? Why exactly do we care about this case?
> 
> Yes, we're trying to solve the problem where a new device tree is used
> with an older kernel because it doesn't have the driver patch to only
> create an input device for the matrix when rows/columns properties are
> present. Otherwise applying that devicetree patch to an older kernel
> will break bisection.

Well, my recommendation here would be: "do not do that". How exactly
will you get new DTS into a device with older kernel, and why would you
do that?


> 
> > We have
> > implemented the notion that without rows/columns properties we will
> > not be creating input device for the matrix portion, all older devices
> > should have it defined, so the newer driver is compatible with them...
> >
> 
> Agreed, that solves half the problem. This new compatible eases
> integration so that devicetrees can say they're compatible with the old
> binding that _requires_ the rows/column properties. By making the driver
> change we loosened that requirement, but the binding should have been
> making the properties required at the start because it fails to bind
> otherwise.
> 
> My interpretation of what Doug is saying is that we should maintain that
> requirement that rows/columns exists if the original compatible
> google,cros-ec-keyb is present and use the new compatible to indicate
> that there are switches. Combining the two compatibles means there's
> switches and a matrix keyboard, having only the switches compatible
> means only switches, and having only the keyboard compatible means only
> matrix keyboard.
> 
> It sounds OK to me.

Have we solved module loading in the presence of multiple compatibles?
IIRC we only ever try to load module on the first compatible, so you'd
be breaking autoloading cros-ec-keyb on these older kernels. I think the
cure that is being proposed is worse than the disease.

Thanks.

-- 
Dmitry
