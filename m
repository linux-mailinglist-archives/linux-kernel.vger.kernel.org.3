Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A290D55013E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382080AbiFRAQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236606AbiFRAQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:16:06 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916661AD9C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:16:05 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d123so6023492iof.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gkj3uMdCjmsHzflHOakxzyYQKVRj/sTnpglWgNUCgvI=;
        b=R6lsSQ5dAFDDxHfBx6/RJfG7mPr/fGPTiJLoHZFflQBajhfuDa6e4hxp3GVqeC8Xt6
         EQS4Y0R3LvNlgQbzsaeiCOeLETyIuZoldmmcUmXDS5hdcwic5aUOsgQ9J8V1FLTwtVQt
         0q56sLpON5p6nayE71wvi/wt3+o0MUr5MsHfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gkj3uMdCjmsHzflHOakxzyYQKVRj/sTnpglWgNUCgvI=;
        b=O+/hv4SAAP8c4IW1zn1IobtZxQj/o4MgRQUUtTiM3VJfhPYW66YKtwlQLULpws+m+E
         1oFyCC77vDwVPIkt7X7TeIMRv243ACOYVetngLMkAIg46twMJVA/rYOIoV5lVai9USdT
         OXrtx22/RdUveWP2ldWWrG7A0NJRyksNZWTmt/CNYbqG91XnEhM557/eGvIKUU2DniHT
         4oroNTA1sdtZJBNkiWklIGI9uI0Au7JjsairTf2JbShAgf/D8RwMVeit/b2oA+8yZvZv
         1k3coz/OrmiFH5JtZVYi2/qAnVMvyRR6i6enTvQr1Dkt5ayWJAEW2BpBroqR7xIKJ+o8
         /8eA==
X-Gm-Message-State: AJIora9P8JqaLaFvsKiQBnqpT9YIEcAIlrfnlDeA4oMvS3R8l8uD1iwS
        P0g7mwtZKoEwrqvyL2oX3YDVT4w2WD1SpJUxnoU=
X-Google-Smtp-Source: AGRyM1uG8NQzhN3MH83ygGObipeQS3aBl1TNyApvYCnQlBacDaq6Ta77Y+yKF8ovvdfUAyTwwHqDhw==
X-Received: by 2002:a05:6602:2d44:b0:669:ef11:523a with SMTP id d4-20020a0566022d4400b00669ef11523amr6344225iow.44.1655511364907;
        Fri, 17 Jun 2022 17:16:04 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id f14-20020a92cb4e000000b002d8cf61dfcfsm2908239ilq.59.2022.06.17.17.16.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 17:16:04 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id y79so6050919iof.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:16:03 -0700 (PDT)
X-Received: by 2002:a02:c012:0:b0:331:67b8:3d7e with SMTP id
 y18-20020a02c012000000b0033167b83d7emr6783017jai.244.1655511363436; Fri, 17
 Jun 2022 17:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220617164000.v8.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid>
 <20220617164000.v8.2.I0977b1a08830d0caa8bfb1bdedb4ecceac709a7f@changeid>
In-Reply-To: <20220617164000.v8.2.I0977b1a08830d0caa8bfb1bdedb4ecceac709a7f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Jun 2022 17:15:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V9RaRuvx+N1FXszA4vKJiUXhZfGcdEFXWPg+DGq=p9kw@mail.gmail.com>
Message-ID: <CAD=FV=V9RaRuvx+N1FXszA4vKJiUXhZfGcdEFXWPg+DGq=p9kw@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] arm64: dts: qcom: sc7180: Add quackingstick dts files
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
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

Hi,

On Fri, Jun 17, 2022 at 4:40 PM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> Quackingstick is a trogdor-based board. These dts files are copies from
> the downstream Chrome OS 5.4 kernel, but with downstream bits removed.
>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

At this point enough things keep being broken that I'd rather you keep
my "Reviewed-by" tag off for now in the next version.


> ---
>
> (no changes since v7)
>
> Changes in v7:
>  - Incorporated changes from Stephen's "Simplify!" series.
>
> Changes in v5:
> - Removed extra newline
> - Added comment that compatible will be filled in per-board

Not a huge deal, but your version history is missing a mention about
incorporating the deletion of the usb_c1 node.

-Doug
