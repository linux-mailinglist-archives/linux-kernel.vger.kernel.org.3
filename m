Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48994C7789
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbiB1SXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiB1SXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:23:06 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EE9D7616;
        Mon, 28 Feb 2022 10:01:26 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d28so16763892wra.4;
        Mon, 28 Feb 2022 10:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OuGGTGuRIE8usjIvuhTwZdZ+bQXhsBG1NshUB/XmMvQ=;
        b=BIr7I+Ke1z/B1XyFd1SZEZAA7IpEwziRbFuLK8crUxYaPxl3NmzbrTbajm8wsBVGhL
         xEcI9VSLUpkOwaJVnG9cNKyseBq40pGrC30v01hoZ6J0VveiKbWWrWcme+jubwft3tVw
         g2bbTmpq7tuX7rOB2JlIGFZvH1NKf2z/93iwyvdXAhkTf9Haw+VUGNmYv119pgBrN/q5
         YGdDFcEWZuRHtbzfjNNXNu7PKqiarFPoat28khSj0ECaay4di7NbXbVyLt6IVTNsTZlw
         67W/msTLzig3DvBSkK8gPJGtaCykJxXyd6Gsmu1TgQ85df56Zyu/9geTESD87bm3X0Ob
         vi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OuGGTGuRIE8usjIvuhTwZdZ+bQXhsBG1NshUB/XmMvQ=;
        b=UlB4URmzqdGwXy7GXWErnWIjj/A+JSxXR6GMdfnW44DG2HQtGJsb+nQanij3GD9DDU
         H2/eouMUzP0DpOngUOjWlNldwHfHi29sYbssjjASKQ1jBQTdAmsVCAIE76eYt4o33qsl
         +6abt8Ntz3zx3z44n6lgOtsWZEQGriuz/AbKl39fjDIu602Xp6u9RP4lUyNSiykUtlO/
         UY47O4mRROHeWGD45haQS9n9gtLwrzoRPPYpe39vzt4rwtgxrsatS9HmNCk2OilXmR68
         V9OgaDAg6lE5ugsLDA9m7kOJIUVd7bLooC8D+EG2CfUbSSd5iTbYIgN/6dHnRR/JLu28
         NZ3A==
X-Gm-Message-State: AOAM533BIww8dSWA2tENU2S/If0E9wu1v/MZ3vkGDspK3ZO7612qhoSt
        JWOEPUHFRYeqgXBM9JcLlyE5WIRWdWKCpA==
X-Google-Smtp-Source: ABdhPJz/JSS05A/Hdl3RiJ9ixIT19NUl8QYWHKPwe98s181rWLVJTVQPr7RrIAjjcwMeeazx20oIKg==
X-Received: by 2002:a05:6000:156a:b0:1ed:ab73:e248 with SMTP id 10-20020a056000156a00b001edab73e248mr16829738wrz.292.1646071284032;
        Mon, 28 Feb 2022 10:01:24 -0800 (PST)
Received: from elementary ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id o12-20020adfa10c000000b001efb97fae48sm5354362wro.80.2022.02.28.10.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:01:23 -0800 (PST)
Date:   Mon, 28 Feb 2022 19:01:21 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, maxime@cerno.tech,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: switch to devm_drm_of_get_bridge
Message-ID: <20220228180121.GA14354@elementary>
References: <20220221073339.10742-1-jose.exposito89@gmail.com>
 <CAE-0n50cW4-xzabNjb0mHLCgUYj+Mcp3_XxYrYf9AVuZO_9qKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE-0n50cW4-xzabNjb0mHLCgUYj+Mcp3_XxYrYf9AVuZO_9qKg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 09:07:49PM +0000, Stephen Boyd wrote:
> Quoting José Expósito (2022-02-20 23:33:39)
> > The function "drm_of_find_panel_or_bridge" has been deprecated in
> > favor of "devm_drm_of_get_bridge".
> >
> > Switch to the new function and reduce boilerplate.
> >
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > ---
> 
> Dmitry is rewriting this code in a larger series. This patch is
> superseded by that work.

Thanks for the heads up Stephen, it is indeed superseded by [0].

And thanks for the review Maxime.

[0] https://lore.kernel.org/dri-devel/20220211224006.1797846-3-dmitry.baryshkov@linaro.org/

