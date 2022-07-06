Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EF556937F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiGFUn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiGFUnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:43:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B586B25EAC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:43:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r18so20699865edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6IjbWUyuxXN/2Vz82xepsrw85CD/sF05r/fiHZLXM8k=;
        b=YZrPYpJhxLWB5f/Qs9r/UOJZiV8QcW8RRvijsTzoLF7IgifrWe3N2+IaT06Gahwgjt
         kVTdBtFGAEOD6g19KwTkjCXD/tb3cZRdzmMaw1ock7s6rpYZXFOCaewm6wJkIhTMKuto
         1nFXBT47x7yT1UQv86cKBBJfUvAyy9S0/cY1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6IjbWUyuxXN/2Vz82xepsrw85CD/sF05r/fiHZLXM8k=;
        b=p3fQSAe2wWDw1x5DLzNGHAOkBM1A1QptxxweztM6QbIhns7e0yPQM1kJf5AV7mgAI4
         dVyJhTcbu9vbWl+jD0x9U7q4Tw4kvfxKODs7SlpL7chib13PFkZITcb5NRe8S9ATaqRp
         M2GKYdJvPYjxwjFA/kui1JsPGbDEBSAFLnd7ujQYOOP0KNDXt8Qjc6eHqn9oZqA1C1qU
         ii5Iu9uD/aW6N1DawTFB0KcBuwE0S2EbyHmBrM7OxXtUC5vEurZuBP+h9AFtJOIxQUqp
         zQQOZH5p8GBh3yDTbvZGrpnr1siTf+Bd/M/KcAXD3XQY+xnNT/DHo/WQC/xjw1un+rSR
         NfjA==
X-Gm-Message-State: AJIora88Xbi1Nmbb7hh9HHVMp8iEvvD9d6I59ak13DO7R4IQAcSX6Rka
        YmtgrWiIi+oy5GOE6benW830z8GXdtW2ftXe
X-Google-Smtp-Source: AGRyM1tskgWRnqIlbqS/jnoF9cThrL6Y6IjhDsPbmgm0mOfbje7w5RyU/lMc6898Jv+Rp9snrK3Mjg==
X-Received: by 2002:a05:6402:90a:b0:439:c144:24cd with SMTP id g10-20020a056402090a00b00439c14424cdmr33727964edz.209.1657140200043;
        Wed, 06 Jul 2022 13:43:20 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090613c500b00722fb3c99bcsm17755896ejc.203.2022.07.06.13.43.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 13:43:18 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id a5so8927838wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 13:43:17 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr40248383wrr.617.1657140197404; Wed, 06
 Jul 2022 13:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <1657102611-20067-1-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1657102611-20067-1-git-send-email-quic_srivasam@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Jul 2022 13:43:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UaUnZfWsXGQx6PoVQ5qqtsq10Dnui1v0Xn0S5Y-YgwRw@mail.gmail.com>
Message-ID: <CAD=FV=UaUnZfWsXGQx6PoVQ5qqtsq10Dnui1v0Xn0S5Y-YgwRw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Move wcd specific pin conf to
 common file
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        quic_rohkumar@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 6, 2022 at 3:17 AM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
>
> +/* PINCTRL - BOARD-SPECIFIC */

It's not really "board specific" since this is actually a file that's
included by multiple boards.

Maybe just use the header "PINCTRL" for now. Everything here is just
adding pull/drive strength/slew-rate info to existing pinctrl
settings. If we ever have more than that and want to separate into
different sections we can always adjust later.


> +/*
> + * Methodology for gpio-line-names:
> + * - If a pin goes to CRD board and is named it gets that name.
> + * - If a pin goes to CRD board and is not named, it gets no name.
> + * - If a pin is totally internal to Qcard then it gets Qcard name.
> + * - If a pin is not hooked up on Qcard, it gets no name.
> + */

This file doesn't include "gpio-line-names" so you don't need to
include documentation about it.

-Doug
