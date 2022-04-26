Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EFC51003D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347891AbiDZOVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237465AbiDZOVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:21:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313D21BE89
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:18:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t6so22258390wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QSMHNNrnsR8koCz4I/MAVE7jHgZ2vngvdAnPvXcE8V4=;
        b=eF1ZX99hrvwLGKFjWE2bHa7BOo4o0mgiL/eES/8mpJX35PfkcVvjN/iGyFrlng7SBO
         FgDcCp8z180yemEF8GvoPl59axKEttX2xhP7wLwPpYZGkbbUFz1vuOCIzwX0GJRodj0F
         LZkyXAfnvOJ4/ry/8fwIDtyeTNIYunqEFKimy5fukW5ZLU6ml7KmraiLnZOMFtkHxr/I
         8ziCWAPPYkmfOOqhFD3LQQG3JAYCz5G6Bd07ooNr7WkXCx9+PS4S9HNt1doYS6mi0bvj
         bza/jgka4UtlgK14BJDPisJspfCq6jEhznRqtDRAwiWmMUXHmVFdB3YpQwmux3/Uv3G/
         2JDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QSMHNNrnsR8koCz4I/MAVE7jHgZ2vngvdAnPvXcE8V4=;
        b=dnKLAGDfkO+jEREtvrXedYxdSRX912OMYNVgVR97Wo5Eh0dVlGHeF3UtpHQqg5gUii
         F46hm4lkj3qT3nyLtvDtfN+VDK6ITluYEHi0FuQSXIEn69jX46hYlEFc5CyCVn7LNGyD
         Mprw+TpF5FW7K5Tn1L86UDrZHio8ztm+gzx0eskND8yG1Bf0ZROk47dzuEdCQX3uY1Uy
         /Qc4uT73JjQeOkho05iHqtkOEJYDgVwwbsYkK+RYFPFwev4HuJhLaNf5Vnlfvu2gjDN3
         19M35nf40tPWqDoE9VQ6qdvIp3G22Pe3PHof8q0OhFxOqQ/OnE1SPhBDzca+iVzUwt7+
         hBIA==
X-Gm-Message-State: AOAM531vMdNtrfc2FQPB7IBk2jqYrMdyQbJPNG4fYWa8b32RT/WLxyUO
        uFVlAF2/oD+NDWb0f92zbYsYwA==
X-Google-Smtp-Source: ABdhPJw68HazkcGoyCsJQjRqFg3wV2ekNgFAHyBXGKpvoB4V9/rxPcE/2CSldmD2q5Z6eFQk3rS66A==
X-Received: by 2002:adf:f346:0:b0:20a:c23f:fb14 with SMTP id e6-20020adff346000000b0020ac23ffb14mr18701627wrp.25.1650982693829;
        Tue, 26 Apr 2022 07:18:13 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r3-20020a5d6c63000000b0020a94e82a3dsm11969254wrz.64.2022.04.26.07.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:18:13 -0700 (PDT)
Date:   Tue, 26 Apr 2022 15:18:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daisuke Nojiri <dnojiri@google.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2] mfd: cros_ec_dev: Only register PCHG device if present
Message-ID: <Ymf/I4WAF8CmEqQM@google.com>
References: <20220419000408.3202635-1-swboyd@chromium.org>
 <Yl4Au/O/am/ZbX9J@chromium.org>
 <CAE-0n507D9W5BFfG2vXqN1cqvnrQKLbLw7YejGb5_kH+7X62sw@mail.gmail.com>
 <CACeCKac83uiwdAf2RWqc9DxEft2+BSBn5Kp5PMR23UGKJyk5KQ@mail.gmail.com>
 <CAC0y+Ajf2GTG=ir=gu9T5Q1TXBHMC5qzzA_MEzWAvW5D71Yv8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC0y+Ajf2GTG=ir=gu9T5Q1TXBHMC5qzzA_MEzWAvW5D71Yv8g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022, Daisuke Nojiri wrote:

> The patch v2 looks good to me.

Please place your reply in-line. Top posting is generally frowned upon.

Also, please reply with a *-by (Reviewed-by in this case).

LGTMs do not carry any weight and will not be applied with the patch.

Thanks.

> On Tue, Apr 19, 2022 at 7:59 AM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > On Tue, Apr 19, 2022 at 7:55 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Prashant Malani (2022-04-18 17:22:19)
> > > > On Apr 18 17:04, Stephen Boyd wrote:
> > > > > +             retval = mfd_add_hotplug_devices(ec->dev,
> > > > > +                                     cros_ec_pchg_cells,
> > > > > +                                     ARRAY_SIZE(cros_ec_pchg_cells));
> > > > > +             if (retval)
> > > > > +                     dev_warn(ec->dev, "failed to add pchg: %d\n",
> > > > > +                              retval);
> > > > Tiny nit: Can this fit in 1 line (100 chars[1])?
> > > >
> > >
> > > I'm matching the style of other lines in this file (this is copy
> > > pasta). I'll let the maintainer decide what to do.
> >
> > Quite a bit of that code predates the char limit update, but OK.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
