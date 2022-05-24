Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B0E532CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiEXPDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbiEXPDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:03:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A761E8A339
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:03:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id rs12so24188915ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlQEZ/gCc3QpUXehaN1GEEfOCVI81XCJ2rd4OltFdLY=;
        b=CbNc1wxia4KBEnPojOwiwyFFW4lhBKRf4AQt/+oQ3TR8JoKODULUGG36Ybz8lklHLj
         L6zd81OhoNFtQdzWk3JnSpvvQeD9/k+wmO7sOhIrSK0u/1YI/HJngN7SSxXuQ9A23p0/
         PBjADz9nDQP9Py1zA+vYmC/eIvp1CfMTlYZN0zZ1Wxx+rIxWfIc6Umoo1SMLcZVFwvHL
         +8Rg9i8OTAnChsU+N3sBsft+ZwPVVRVipal3rAR2RxAv0D+b1O9anbkY6UfjcMkyHzi0
         zbrTbd7o8+x9SZDqISgByUttWLIFYko/kvdNsMpBgxE9GAw28KiuSo/i2w15EPbM1r4t
         io9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlQEZ/gCc3QpUXehaN1GEEfOCVI81XCJ2rd4OltFdLY=;
        b=Uzsk5bqpubcWs9O0C1JUdhgUfVMPaVn1p11ba1pZHNOCdILjVyw8xsOESXkCVHByEr
         x1KFmIObrZ2zv3qUVwb2ltNrX1T95D6cQqtZJq5Y/CYc11z9ME6TerQnwWFRAeSSiPG8
         eOu0UdXvhcQFpSxiHrTH7lcCRpndeqX4lTUYgycNwBVXN48UQUfgGyapqJiOalDXlgGh
         Dx2oXjUeXCvy7Le3IJxw+PVIsZuoGwvyqsZbHo8tEVR4eFAUaBub6oMISLxpWL/eKZu9
         551/lPgZkuIa6gqLYiXpM1PcMVDvp/vGIYbYIf5kuZFgU4Yq7ouwuWuWpdb2ozJwhwLo
         Ivxg==
X-Gm-Message-State: AOAM531yJrzcaxGa5JA9j3gYfZ8906Va373MpHJ1sdNeIK1NQkaZ6W+f
        8F/vqUc+0Cpd8Jya9RwMY+K5IyAo4DTsR/TBlwcdLsyXYgQEYg==
X-Google-Smtp-Source: ABdhPJzT/FI/PkyFzW9TIbfxwAFTxWm8y8bCfFXrNT9T+t7BemqsE+qUfpfq2j+/xSzZ88zaoNI8smzlJkq8rYwpRc0=
X-Received: by 2002:a17:906:974c:b0:6fa:8c68:62a8 with SMTP id
 o12-20020a170906974c00b006fa8c6862a8mr25615119ejy.293.1653404582161; Tue, 24
 May 2022 08:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20170323055435.29197-1-bjorn.andersson@linaro.org> <20220523163038.GA9124@duo.ucw.cz>
In-Reply-To: <20220523163038.GA9124@duo.ucw.cz>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Tue, 24 May 2022 10:02:51 -0500
Message-ID: <CAOCOHw7N9EHcxSSe6n8828oy2fh6xNxRYf9OUXkY4SQh6gtVLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] leds: Add driver for Qualcomm LPG
To:     Pavel Machek <pavel@ucw.cz>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:30 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> > PMICs from Qualcomm. It can operate on fixed parameters or based on a
> > lookup-table, altering the duty cycle over time - which provides the
> > means for e.g. hardware assisted transitions of LED brightness.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> I'd really like to see the patch fixing the pattern interface (or
> disabling it). I don't want to push the tree to Linus with that bug.
>

Please find a proposed update to lpg_pattern_set() and the documentation at:
https://lore.kernel.org/linux-arm-msm/20220523233719.1496297-1-bjorn.andersson@linaro.org/T/#u

@Marijn, would love to get your input on this proposal.

Regards,
Bjorn
