Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7436F52C5FC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiERWH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiERWH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:07:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE95174DDE;
        Wed, 18 May 2022 15:06:18 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k16so3390308pff.5;
        Wed, 18 May 2022 15:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4rG6qTLRtp+Qy/o3xN0lJs3wPY8YgHEhLV/WzQjfOA4=;
        b=ZVEbKgaqxO90+2qR9ud8/rGbquDAMoO6D83nv+/tt/uvJJIOV6xtU//t9sncne+PRx
         1JEc6D9xrs/lmMJZ59qWI7G4PCvFCVHqV5DZDUl7U2k2AqjxAVIwfXcSok115DbuFyWV
         mN9L6kRlGTEs7l5YLztBVsOSJNST74Px7w5wE30UuHY2pPD4s7SUgMAgb/yXmQ4/UjUL
         CPkalHpsdLy4l9qHgmtJUTEKzghLvkVhUTejdqhN8Bx1hPas73K7Jb5tle1H0DrAgprU
         zvjPC/4y/fZwRMJQZDIXGIisZVgYsPq89kCgL6uxpseK52aeqoMoITwuGOelStMDhk8A
         vbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4rG6qTLRtp+Qy/o3xN0lJs3wPY8YgHEhLV/WzQjfOA4=;
        b=RzjlQZTXtel+LXyWHqD0NA0WKQ6ZIBGDiq2ILvKz2M8c4tbLpkgYsCAiiv1/Sv/k+0
         YVsgrWQB3qO3Ifgnjdfvq1N2hw0C6b41n2q83fVqn5KAa7zeJY6/in9bHFP2GcTJL5g0
         IJP2SLqPbRJk//qkA4nhnIig89iOGHxD8kmJj7d45PgQorpExBA/gmRxdasZC5QiMdKY
         7va2iLlBVBF8n9srA+wbZ8Hfab8mnnZZEaD3N3Q2LL3sFbw3/KNIgpeXCMFqaDq1AHix
         vay5RiMDg5zBGt6nTcttJDZiVbbOhWqfw11wTELIDtPBbU78owULihelhj5SZPdvUhvd
         4T8Q==
X-Gm-Message-State: AOAM533wqbs0aV1gXedovfhIezLon0Kmc4oJbmVepJ4GEIuQ1pkZfFsl
        dL8/0S6axBRJMZqybzrCPWA6ayO8mzo=
X-Google-Smtp-Source: ABdhPJzuyfa8L8oYdtY27Fs3LI5/GJqrJWA464QUwISpSXYP9MJgvA+oFA2VPdak6eJ1SxgZj8lYNQ==
X-Received: by 2002:a05:6a00:4486:b0:50d:fc41:a9a with SMTP id cu6-20020a056a00448600b0050dfc410a9amr1687533pfb.71.1652911578269;
        Wed, 18 May 2022 15:06:18 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1a53:727c:6847:3659])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78009000000b00510952c52e3sm2342418pfi.180.2022.05.18.15.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:06:17 -0700 (PDT)
Date:   Wed, 18 May 2022 15:06:15 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: Re: [PATCH v5 0/2] Input: cros-ec-keyb: Better matrixless support
Message-ID: <YoVt1/PdtMHI4RKE@google.com>
References: <20220516183452.942008-1-swboyd@chromium.org>
 <YoR+w7CSqN0aAE5b@google.com>
 <CAE-0n50KE9bkqZvCOLtCGiq3g1jYhK7zpVcVFBzinaguNhNaPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n50KE9bkqZvCOLtCGiq3g1jYhK7zpVcVFBzinaguNhNaPw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:07:55PM -0700, Stephen Boyd wrote:
> Quoting Dmitry Torokhov (2022-05-17 22:06:11)
> > Hi Stephen,
> >
> > On Mon, May 16, 2022 at 11:34:50AM -0700, Stephen Boyd wrote:
> > > This is a followup to my previous patch[1] that skips keyboard registration
> > > when the matrix properties aren't present. This adds a compatible string
> > > for this scenario so we can ease existing DTBs over to the new design.
> >
> > As discussed offlist I massaged the binding and the driver code a bit
> > and applied it to an immutable branch off v5.17:
> >
> >         git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/5.17-cros-ec-keyb
> >
> > that you can share with DTS maintainer(s) to accelerate DTS conversions.
> >
> > I also dropped the original patch as it did not make it to Linus' tree
> > yet.
> >
> 
> Ok thanks. Doug noticed some problems with the dt binding. Here's a
> follow up patch that you can squash in or apply on top.

Added to the same branch, thank you.

> 
> ---8<---
> From: Stephen Boyd <swboyd@chromium.org>
> Date: Wed, 18 May 2022 13:03:58 -0700
> Subject: [PATCH] dt-bindings: google,cros-ec-keyb: Fixup bad compatible match
> 
> This uses anyOf which is wrong. Use oneOf and move the items under the
> description. Also drop allOf for $ref.
> 
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/input/google,cros-ec-keyb.yaml           | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> index e11cbf508723..c31a02149f37 100644
> --- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> +++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> @@ -20,13 +20,11 @@ description: |
> 
>  properties:
>    compatible:
> -    anyOf:
> +    oneOf:
>        - description: ChromeOS EC with only buttons/switches
> -      - items:
> -          - const: google,cros-ec-keyb-switches
> +        const: google,cros-ec-keyb-switches
>        - description: ChromeOS EC with keyboard and possibly buttons/switches
> -      - items:
> -          - const: google,cros-ec-keyb
> +        const: google,cros-ec-keyb
> 
>    google,needs-ghost-filter:
>      description:
> @@ -58,8 +56,7 @@ if:
>        contains:
>          const: google,cros-ec-keyb
>  then:
> -  allOf:
> -    - $ref: "/schemas/input/matrix-keymap.yaml#"
> +  $ref: "/schemas/input/matrix-keymap.yaml#"
>    required:
>      - keypad,num-rows
>      - keypad,num-columns
> -- 
> https://chromeos.dev

-- 
Dmitry
