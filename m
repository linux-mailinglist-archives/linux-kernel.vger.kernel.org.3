Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE1D500064
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbiDMU6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiDMU6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:58:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A8B674F7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:56:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bv19so6390219ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGJeViK+7nvO370X+XWsM6u8Nu1Bs+YHak1Y1XG2ND4=;
        b=Nmnntj/LVIwy3oeOLpeN9QoktVn4Gy5cYRHXFCyvkB7XueSKlPJszbhcdG9U78y2ad
         u8YKGSNTvuIK1Qs6RbcqVntnhyfwD1HecmNzit4QEsVJrFYQOt1JO7DP2DBYKh7p/2KM
         tIkfENteINhIIpwXj6yI7S3FGN7rNsZJLO5rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGJeViK+7nvO370X+XWsM6u8Nu1Bs+YHak1Y1XG2ND4=;
        b=2sui5tgvsqHL3mXQ7E8QHLf0WeACxX4OovJ9xZaHhc0zAgOLAxKmvEiVBkripAPaFp
         /Gunx245OF5ygjEqxk6QkGd7erPhtirV6uMqn/ixe0qmv4IhhHkRvJT2t4AK/4TcY63r
         CgSzgJ8Giaa9oC39KiihXcleeO/gBIliSzpA1mi9ygcnUM+woIBJYcja86pdGndCRu7S
         oxqI0MVMH96qbAl0UUhkJbWllnQzvTPluiA5eXLFZu//RNXcP6k6x6TmAuoADQ9BJmYf
         VjEfmHaSV8JV4cKji7Lv0M1PlmPDjwn7HQ9P9HIBzhtQExMAUKqUR4KssB8dMXaIAFlk
         K2Kw==
X-Gm-Message-State: AOAM530FgRXkbj56VtS6yjlKJ6jY0RGhu05WB9692JG72/aGZxlOEjDX
        zeK1ykkNAr6rgNCXwd4dM3yEBcmD+FmE2U7i
X-Google-Smtp-Source: ABdhPJy58C6rww833KTZHY7Mu7dYOGSl3jMoYsqX42hh/5EeaUf02s8n8/4DW9NiTK1IaxXWPozs7A==
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id hd14-20020a170907968e00b006dbaed543c8mr40785833ejc.636.1649883369915;
        Wed, 13 Apr 2022 13:56:09 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402000400b00412d60fee38sm15002edu.11.2022.04.13.13.56.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 13:56:09 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id b19so4303281wrh.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:56:08 -0700 (PDT)
X-Received: by 2002:a5d:64ce:0:b0:208:fff6:22cb with SMTP id
 f14-20020a5d64ce000000b00208fff622cbmr89950wri.301.1649883368489; Wed, 13 Apr
 2022 13:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220412220033.1273607-1-swboyd@chromium.org> <20220412220033.1273607-2-swboyd@chromium.org>
In-Reply-To: <20220412220033.1273607-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Apr 2022 13:55:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFbOhs0ggxDbVwKM_8x=ELT85zFd-Wk6dJ_M+Awz+Pxw@mail.gmail.com>
Message-ID: <CAD=FV=UFbOhs0ggxDbVwKM_8x=ELT85zFd-Wk6dJ_M+Awz+Pxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] interconnect: qcom: sc7180: Drop IP0 interconnects
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Georgi Djakov <djakov@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 12, 2022 at 4:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> @@ -519,8 +500,6 @@ static const struct of_device_id qnoc_of_match[] = {
>           .data = &sc7180_dc_noc},
>         { .compatible = "qcom,sc7180-gem-noc",
>           .data = &sc7180_gem_noc},
> -       { .compatible = "qcom,sc7180-ipa-virt",
> -         .data = &sc7180_ipa_virt},
>         { .compatible = "qcom,sc7180-mc-virt",
>           .data = &sc7180_mc_virt},
>         { .compatible = "qcom,sc7180-mmss-noc",

I have no objection to ${SUBJECT} change landing and based on all your
research and Alex's review/testing I think it's good to go.

However, now that you're removed the driver that cared about
"qcom,sc7180-ipa-virt", should we also be removing it from the
`bindings/interconnect/qcom,rpmh.yaml` file and the `sc7180.dtsi`
file? I think that removing it from _either_ the driver (like your
patch here does) _or_ the sc7180.dtsi file would fix the bug, right?
...and then removing it from the yaml would just be cleanup...

-Doug
