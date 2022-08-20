Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8492B59AB22
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 06:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242444AbiHTEJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 00:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbiHTEJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 00:09:52 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7948DBFC6B
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 21:09:50 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t8so6746129oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 21:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=DFnPv3BCa7+XeLpbAr4ZTUKfcP7J9Jr+QvahQGLI9GE=;
        b=pT7pc8FZs+WXWRlCiRCNZeertVApYopt8u3Rktj++J+F5CVH65mkvv2AVZhAUAZ5na
         FTTugiyR7PWmHGwUwYBAdEien8O6H8MhLp4Mvy0Kn7ZFRkutXlWCens390MHEwdGCVgT
         2UPavxFFWN23yzxg/jggvO2LbkzKI0y6jYbK2SaA/f1Ii0E4uW8WRgTDbQrJSMaE8rsu
         UGh/U9PbTQErjyu0nm/szQAA7sAuarWD+m5Luo4CkMOTE+BZfm6Q+iTai3PWI+WxlmIM
         GWtDIi2UIhegnwdVzJdIGsmD7CimqMJQYvttUilbXC8DP/o/mUSLvs/HfT+qJs1oR4Fp
         vDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=DFnPv3BCa7+XeLpbAr4ZTUKfcP7J9Jr+QvahQGLI9GE=;
        b=7yaolbcfSXItZNjg7B+6ZVZmcdQf/Z/CNIs9oMpBIz/Wvo+hruSW0BmlapE2+5ErXW
         6mp3z2CW3IPkCmbGk/T/ReiDV1bqe40jqmyeOKnyk7nz2OSl1wjJveZjXW2N5BkIgvlR
         9V4gVh4cgW3z6ksRta6DV/Q7N/IeRzXuLxTFbQdR82qZ9kLiiKqGHdrP07AOoJxHb+aK
         /Kjb7+QbAT9gxJ69ziq1cbVP4N39NaWhbqWU+hbzU0JJLhqjZKi2YOP1OoYyhIHtC5vj
         2k18W3jiLlt0E2Q/RHpQdOXSLUEu9C3AxqnspHIxqnVQVpWBXBNFkcgWwTZE7Zeqa7mJ
         MVXQ==
X-Gm-Message-State: ACgBeo0aNvCf0JEJHiRbS5x9Q8ss3yGZvPH4xyAdIxpcyIFzovbw34Lf
        n9zc+JhCx3musDQsboD5gmRRow==
X-Google-Smtp-Source: AA6agR66ORyTpy6wPM1zTQxRjWLFiDfl0P5mKwizRb4AhDcOIlpZwEzYZl28CEk5jxX3xsuKmXwAng==
X-Received: by 2002:a05:6808:6c4:b0:342:9cf1:fb1 with SMTP id m4-20020a05680806c400b003429cf10fb1mr6762286oih.259.1660968589847;
        Fri, 19 Aug 2022 21:09:49 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y14-20020a9d460e000000b006370c0e5be0sm1640450ote.48.2022.08.19.21.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 21:09:49 -0700 (PDT)
Date:   Fri, 19 Aug 2022 23:09:47 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Message-ID: <YwBei45gx4oVqSql@builder.lan>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org>
 <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
 <20220814210104.GA690892-robh@kernel.org>
 <Yv1y9Wjp16CstJvK@baldur>
 <CAE-0n53AjJ_G6yZoTALWpKvZUdF+8nFZ+TQh=Ch=8xgdMVqDkw@mail.gmail.com>
 <CACeCKadP-AZ8OU4A=7CrwAz7yuLvMvjvAcw7K-FORFmkMvx7cA@mail.gmail.com>
 <YwAIGf59H9iKUhXF@builder.lan>
 <CACeCKadt3aoz8MZvy+tGHCxiHOPty4cLcG7AGS+oMEVnREt4sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKadt3aoz8MZvy+tGHCxiHOPty4cLcG7AGS+oMEVnREt4sw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19 Aug 17:55 CDT 2022, Prashant Malani wrote:

> On Fri, Aug 19, 2022 at 3:01 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> >
> > You can't physically connect 1, 2 or 4 lanes of DP from a DP chip to
> > your usb-c-connector at the same time as you physically connect 0, 2 or
> > 4 lanes of USB from a USB PHY.
> 
> I apologize in case I'm misunderstanding, but why is that not possible?
> anx7625 allows that configuration (2 lane DP + 2 lane USB going to
> a single USB-C-connector)
> 

Right, but you can not connect 4 lanes DP from one chip at the same time
that you connect 4 lanes USB from another chip.

> Since the discussion is to support various conceivable hardware configurations
> That same anx7625 can support 1 1-lane DP (or 2 1-lane DPs), and 1
> 2-lane Type-C output.
> The cross-point switch allows for that level of configuration.
> 

We're talking about the static configuration here, where you describe
which component are connected together. We can not dynamically switch
the Devicetree representation around to match what the Type-C controller
negotiates.

> > > So, how about 4 endpoints (1 for each SS lane) in the usb-c-connector port@1?
> > > That should support every conceivable configuration and bridge/PHY hardware.
> > > and also allows a way to specify any lane remapping (similar to what
> > > "data lanes" does)
> > > if that is required.
> >
> > Wouldn't that prevent you from handling orientation switching, given
> > that the graph is static?
> 
> It depends. If the end-points from the usb-c-connector
> go to the same switch, then it should allow orientation switching
> (anx7625 allows
> this). The port driver would just tell the orientation switch(es) attached to
> it that we are in NORMAL or REVERSE orientation.
> 

But why do you need to express the relationship between these 2
components with > 1 link in the graph?

> The graph is static, since the hardware line routing between components
> doesn't change (e.g SSTX1 from the Type-C port is always routed to Pin
> X1,X2 on the switch hardware), but that is what the switch is for.
> Note that in this case, the expectation is that
> the switch driver only registers 1 switch (it can figure out that all
> 4 endpoints
> go to the same Type-C port).
> 

Why do we need to express this with 4 endpoints and then implement code
to discover that the 4 endpoints points to the same remote? Why not just
describe the logical relationship between the two components in one
endpoint reference?

> The limitation to orientation switching would depend on how the
> hardware is routed.

Regards,
Bjorn
