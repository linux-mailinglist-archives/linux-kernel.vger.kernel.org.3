Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4594F6833
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbiDFRmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbiDFRmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:42:17 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874B71F0466
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:51:49 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so1972796otj.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=XATxJhiSi08CMkmNXLKTq3CLPnWTER4zvKF23kznV6Y=;
        b=ZqBPfnyy1bsh3DHodys1XwdGezt/fQP9m2viphLAvw40Oo/ipEe6LXlVCfjlJS+Cj8
         46/rfZ1NNqT8FkRphuJDTUQsyfYP1PgN7YH2dgp3yJu4EK84LOqmhBs5F0xHQapt8dZN
         iHr3pfnI4Fe3mbUtz1pGI01XRGk0XPvOMYU6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=XATxJhiSi08CMkmNXLKTq3CLPnWTER4zvKF23kznV6Y=;
        b=GyqfiPNvGHeB7wBXfbfRQ9A8uIfvYjSXabFdvh+3jpNlPUEvW6p4EqqkNHqm96FRnx
         wIjKruCqguyzyQSxixxJZIxtlZQrd9VN5F3rzkGSkD4ST3hZR1VvZpdsJgDcZk4GTlzG
         y1Gt8hIU1FyxgYAEeavJ8tRpJGsO0rv/JM19/S4ARR6QwSHuUtIIDYS6TXL8s8BRy2mL
         n8FQ8cOchSE5PYjUJElpPaTTRz/CfBVGRm0zzZbgpp2ZH3V0Bp8EYVFJdbmL47HV2qA+
         vekPPi0CccPNrODN0142Y4ryAr/5KsP8f+wBe9Jqr/dn7SUMLkCobl7Hz0VE6qWjk+0p
         I64w==
X-Gm-Message-State: AOAM530ktHOu0bx+m/p1Nt8C/rv5oYDCy4SanJTiNdxTbGjitM5UkK+T
        ecBBj/W61GLMvhL3KJQFM6BHaBBaklm8vNgkkZ6fLg==
X-Google-Smtp-Source: ABdhPJwICXr6Eifd3Vhc5Kk0YeHuGA75H9hr/0XmurR09WxvpQACKLxL85HABV6EfCWUP8j+18vcc7LTD0k097lFZTQ=
X-Received: by 2002:a9d:b85:0:b0:5cb:3eeb:d188 with SMTP id
 5-20020a9d0b85000000b005cb3eebd188mr3226346oth.77.1649260308834; Wed, 06 Apr
 2022 08:51:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Apr 2022 08:51:48 -0700
MIME-Version: 1.0
In-Reply-To: <Yk21pdu16lyR8jXm@sirena.org.uk>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com>
 <Yk1B4f51WMGIV9WB@sirena.org.uk> <CAE-0n53Cv_bR92M64dhdnDge_=_jeOs4VZzDhUkksN90Y7rgog@mail.gmail.com>
 <Yk21pdu16lyR8jXm@sirena.org.uk>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 6 Apr 2022 08:51:48 -0700
Message-ID: <CAE-0n50C8khP2x4sgNP5xnfLVMRQj2=LChyWWx1BWL+Xgecgyw@mail.gmail.com>
Subject: Re: [PATCH V9 4/6] regulator: Add a regulator driver for the PM8008 PMIC
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
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

Quoting Mark Brown (2022-04-06 08:45:41)
> On Wed, Apr 06, 2022 at 08:23:11AM -0700, Stephen Boyd wrote:
> > Quoting Mark Brown (2022-04-06 00:31:45)
>
> > > It's a MFD function driver isn't it?
>
> > The DT binding shows a single i2c node at i2c address 0x9. The
> > compatible for it is "qcom,pm8008-regulators". It looks like an i2c
> > device that is dedicated to providing regulators. I'd only expect to see
> > an MFD if the device responding at i2c address 0x9 supported more than
> > just regulators.
>
> There's a MFD parent for it, and if it's for an I2C device for a pm8008
> why would it have a -regulators in the name?

There are two i2c devices. One is pm8008 at i2c address 0x8 and one is
pm8008-regulators at i2c address 0x9. Earlier revisions of this patch
series were making it very confusing by redoing the pm8008 binding and
adding the pm8008-regulator i2c address device to the same binding and
driver.

My guess is that this is one IC that responds to multiple i2c addresses.
The "main" qcom,pm8008 address is 0x8 and that supports things like
interrupts. Then there's an address for regulators at 0x9 which controls
the handful of LDOs on the PMIC.
