Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29354C2C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiBXMwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiBXMwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:52:32 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B989E20C197
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:52:01 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l1-20020a7bcf01000000b0037f881182a8so3422338wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1y26t3z5KmogzVzaRXh0xZ8+wk/glRrMhjsYhZ6NNpI=;
        b=l2A1dmVsQ69rlhJLpwmjB2fa5bCE62/fs+1myFe5KswaVzqgXHDHZY7BxwuN52LfTn
         ymTtWt2+ah81VG9+r5VUl5lNt2WVOVR6Tq11NsK8KqEpv9JqtUt2MDK5I/tWDCl9RnPj
         vdgtWMbOrNX+Mmjry8sGIgAq5kCtZ+cnHNaZTQXMvjzd5SYbmelX7LpVgIgWahuqvk4D
         RHlYhGzcC/oZ/IaL80XYnes0EJhMDujLWZPB1eKIAS4TjUxGK9P8pOwIMdElCbMzRA0k
         ZFCpcCz0AgM4QtJKVREFOeObRlFPS6X3vG+EaQs7fne0jrOwx6In2PQ01gHTP9i4ro4X
         /FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1y26t3z5KmogzVzaRXh0xZ8+wk/glRrMhjsYhZ6NNpI=;
        b=ciyqjlIZe7rVTMkmR6VJQDv5NQk4Pr/S3PCv9KhjfNONb0siC7L1MUHitz/JIIixJW
         LB5CeFrZhA1AOmqqYQaLN61UUOFKubuHzbZKJS2Mfc9hnRX16OmpxBGvJbRsGoI0sSoF
         URyDcODYpzXzdZLPc0+srn5yHPY7BCpwhsfSZuaOyR6h6+X5s2//DlVJxSZqoeCXd2yb
         AScXwhdFb67uoQPI73tSxI3PlX2Mgmmypt/i6+fRBoNe5ud4vhfaZQ1PuyKQzTQYSt+o
         NnZ1ZFriLEpDaXJ4+bwZC5v3IPr0zNQP39+w/tqTNWwE5tQYR6iZ2E6Y35wtzQHJeLwJ
         WQfw==
X-Gm-Message-State: AOAM532OdcpkZg3plzvHLh5hD6Lb4u9hVuiruu+NijZttLZwgAXNU+s5
        LylbekB2gXM0sIxWb3egWP1kLg==
X-Google-Smtp-Source: ABdhPJxx0eBVNp8nFphGUFZsIuvZMVUId0v9AZP4IrgzocOtHXpv/ScIaresc8g3bEGwUO/d7+aBPg==
X-Received: by 2002:a05:600c:4f83:b0:37c:d057:3efe with SMTP id n3-20020a05600c4f8300b0037cd0573efemr11320753wmq.143.1645707120272;
        Thu, 24 Feb 2022 04:52:00 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c6sm2538733wmb.25.2022.02.24.04.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 04:51:59 -0800 (PST)
Date:   Thu, 24 Feb 2022 12:51:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: pwm: google,cros-ec: include generic
 pwm schema
Message-ID: <Yhd/bXqehm98C/Jo@google.com>
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
 <20220214081916.162014-2-krzysztof.kozlowski@canonical.com>
 <Yhd9CjAbI7MJu56L@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yhd9CjAbI7MJu56L@orome>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022, Thierry Reding wrote:

> On Mon, Feb 14, 2022 at 09:19:13AM +0100, Krzysztof Kozlowski wrote:
> > Include generic pwm.yaml schema, which enforces PWM node naming.  Keep
> > the old name in bindings as deprecated.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml    | 4 ++++
> >  .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml          | 5 ++++-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> Applied, thanks.

Super, thanks T.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
