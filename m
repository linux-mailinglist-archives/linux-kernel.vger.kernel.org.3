Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7F517B02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiEBXyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiEBXxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:53:13 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F323833891
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:49:41 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id l16so9501548oil.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 16:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=f/8wAhfndevj/J1N3yBWJIasHRz86NCxkLOraqJEZ3I=;
        b=U+eozlJiuwXweZAZwZgwKg8AbtEWzgT787jSunJqgNYKFAYU2sk9jF/tussaSBzEj6
         zPONEEClbARzCV70uc7Eac8vMXYjko7CvW18CXSdgRFD6hiK9T7gZqDzUjmqV/b3PHmk
         OWScniXMFIN7XUInNcGUHP0cy2DepwEIxBsrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=f/8wAhfndevj/J1N3yBWJIasHRz86NCxkLOraqJEZ3I=;
        b=lVsmQdFEM2OJB6fODumSUTohQRvCgD1waSU1721rXc1/bWSm6SsqIK3MgNMcTzl48W
         jJIBOyYrO/6whZ24xjg66YkjXgqLAvEVy3xipCruimeRHnuzHxbOiAtXD4be1ZWAjMFF
         wyizICE99Sls8tS4uqL0mVFi2d9G4N5Rvw8KUuQJ9ZER/hdpYL5LfHv0lYooCRan7rBv
         9u0NGwaKhWL/l5PbZMN0nrCOTt66Z0Kcv1bih/fD6mdg2ecKOzN13l0Rx0X2sHGEpZBt
         uPjkUlidqWArx/NeYruJY8x5M4SWzrDZ8Oo8wnOgsSHeRpb+6YV99QiFWbPWsPZPKhTU
         nyXQ==
X-Gm-Message-State: AOAM533REMSzIvJmyEQq/ruX/eldv79hLSnCV037MckhV/xtKwvBXF41
        5/lB6619lMlKcPy2HGBrUAkuerh6rHsl15cPBAGSzw==
X-Google-Smtp-Source: ABdhPJxXlou3d6XzjcL/neLV6qpKQUgvnmAFgJDuMOTACWhPnak8bHhRAo8T3khmrzYlbcN9YD2WnbIjkQoANiagm8E=
X-Received: by 2002:a05:6808:18a5:b0:326:31ff:4232 with SMTP id
 bi37-20020a05680818a500b0032631ff4232mr249354oib.193.1651535380105; Mon, 02
 May 2022 16:49:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 May 2022 16:49:39 -0700
MIME-Version: 1.0
In-Reply-To: <CAE-0n50Y8tZD9Djn9TVaAiHxehFJ2cZKZ1Z09piDk47uw3nK+Q@mail.gmail.com>
References: <20220429233112.2851665-1-swboyd@chromium.org> <20220429233112.2851665-2-swboyd@chromium.org>
 <CAD=FV=VX8EEgkeLgKwyKvjztcjbA8UhKOUpTr-sS1_Ec=QcWbA@mail.gmail.com>
 <CAKdAkRSOtAD6u_cwKhHeMLgz5dC2hfPvVvqmj+17b4i-nspfgg@mail.gmail.com> <CAE-0n50Y8tZD9Djn9TVaAiHxehFJ2cZKZ1Z09piDk47uw3nK+Q@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 2 May 2022 16:49:39 -0700
Message-ID: <CAE-0n51hke4j6ChZ0am53FEojXF96X3K+ptOMOhdN7T7W1550g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2022-05-02 13:41:33)
> Quoting Dmitry Torokhov (2022-05-02 10:43:06)
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

There's one more thing to mention. The switches are discovered by
querying the EC. Reverting commit 4352e23a7ff2 ("Input: cros-ec-keyb -
only register keyboard if rows/columns exist") makes it so that in the
case you have a keyboard and switches you'll be tempted to define both
compatibles because you have some switches, but for all practical
purposes you don't need to change anything. The EC will still be queried
for the switches. Maybe "google,cros-ec-keyb-switches" is a bad name. It
should really be "google,cros-ec-keyb-v2" or
"google,cros-ec-keyb-optional" where we clarify that matrix keyboard
properties are optional now and are used to indicate if there's a matrix
keyboard or not.
