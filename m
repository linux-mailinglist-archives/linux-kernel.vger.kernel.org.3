Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B244DCC0D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbiCQRKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbiCQRKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:10:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD93C6827
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:08:46 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x34so6204188ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29J3WNDJWG+0dPTcDT5HM1sZZoS3aj5OjFfUpwYnn9I=;
        b=lHIWpPHfEecJ2nKBKKKowWuaUA/jOW0RqB/VtVUwveFqAJLISEhF8orq4qPkY9ZDGd
         dLu7MaZd6loBSNr8djqu0QERIhHvgQMsc2K1zr9G3/otkVzGqJKqnf5/9Ttol7fY5b3z
         aO5tEe1TaUYT+uQSICj7yrn89uyGgps0qb+v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29J3WNDJWG+0dPTcDT5HM1sZZoS3aj5OjFfUpwYnn9I=;
        b=409nYcEeYByN0m1Bh52BMhtmXtc+K424ViT7hhmKc1L1iBa93kZSDZafuYSjYGwucX
         E6ZaX+xKOmK6V9XNdA+KINXjJm2N1cMPFP9uCWYIo+qmyzV2kizgaNW8cXwdi0C1faDX
         5bPUDKRx6cZespuLBD17ld2m50a/mk2utUnSpCKBWYbhpLOn3mQ5i3h+AlKQl/TRpVNN
         U8uHT4dufsf915Py8bndcmGktwIwcRHIWyj02hwJgieV9At8wwABP8s8htIHgM7a8hYW
         S7HFsnzqwx20Z5noF9R8FGheSxld5cxC+2bueGQnbhJBKJH71vM3yzoYVQRgP811kvtc
         +agQ==
X-Gm-Message-State: AOAM532IBl1myoMc8/i5ScLWFrAefqgfeeDxSGNiDw3QLnpPU8Kxgz6S
        aRou+H15e+0/Aj2JBHhgq5VnILAO7leRo6E7
X-Google-Smtp-Source: ABdhPJwl0EvaOw0jlp4cpBwPhwCCgu/23LAtovhHl3W7FVMzqeB3e2AG8e1qrgJUYjq9Piw72wI1eQ==
X-Received: by 2002:a50:cccf:0:b0:410:ba4e:65fd with SMTP id b15-20020a50cccf000000b00410ba4e65fdmr5662791edj.31.1647536924447;
        Thu, 17 Mar 2022 10:08:44 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906d20e00b006cee22553f7sm2671533ejz.213.2022.03.17.10.08.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 10:08:43 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id a1so6877280wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:08:43 -0700 (PDT)
X-Received: by 2002:a5d:6f04:0:b0:203:ed96:8212 with SMTP id
 ay4-20020a5d6f04000000b00203ed968212mr2550648wrb.679.1647536922913; Thu, 17
 Mar 2022 10:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
 <20220316172814.v1.2.Ib0fbb7e5218201c81a2d064ff13c9bc1b0863212@changeid>
In-Reply-To: <20220316172814.v1.2.Ib0fbb7e5218201c81a2d064ff13c9bc1b0863212@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Mar 2022 10:08:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XxuQkWNkCRhFRDQ_7cuyCu0tf5cdHaFKsi3a7L8XNtgA@mail.gmail.com>
Message-ID: <CAD=FV=XxuQkWNkCRhFRDQ_7cuyCu0tf5cdHaFKsi3a7L8XNtgA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] arm64: dts: qcom: sc7280: Add 'piglin' to the
 crd-r3 compatible strings
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 16, 2022 at 5:28 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> With newer bootloader versions the crd-r3 (aka CRD 1.0 and 2.0) is
> identified as a 'piglin' board (like the IDP2 board), instead of 'hoglin'
> Add the compatible strings 'google,piglin-rev{3,4}'. The hoglin entries
> are kept to make sure the board keeps booting with older bootloader
> versions.
>
> The compatible string 'google,piglin' (without revision information) is
> still used by the IDP2 board, which is not expected to evolve further.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
