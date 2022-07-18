Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573C0578099
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiGRLUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiGRLUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:20:52 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE1AB4A5;
        Mon, 18 Jul 2022 04:20:52 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id l11so8461412qvu.13;
        Mon, 18 Jul 2022 04:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FTeMoAHtnCPt9zaBpC4a6d1gebz+vzJPv9Y27GinJbg=;
        b=OYHy9I4Jf4Z/O9dNLuqv9E8TbczfHBclUfgxhCrXrmtkcbV3F9m4JX/AQROxDT/VWj
         LQqOfdRgkmwqULlvunXTK96UGs3D6FfTCD+yDoWTxMpzCYSMjYhYWK06u1BcG+zvPl6w
         ZS0WUjukvrHiU15GB1xBhwL+HMZOdZGYimKnUiwlDnIAOxRSPfH69jgb98iQS7dMsiHR
         rVjJKTOp20O+KTz9onmRHUO5oMbMokQq3i77684N88AL41mpVGaaIfnDzL0sAbuO+JHD
         CYOi6J16Q0NGOZM3gmhqQo9DQMqIbCFD5Lew4D3TLWnAjLYZBzA2Qa0fgtPdKoNR2NMW
         VcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTeMoAHtnCPt9zaBpC4a6d1gebz+vzJPv9Y27GinJbg=;
        b=jOlbIPkzMO0tdcWTbOMj39UnPj1MZAwkcTQfXadV7lVPSg8cH0iabkUCT94yAhrnSa
         xSe0+5M7MZi2UhkpMmQXl/SPhXtNtJqyYUh+MzeDr9zA4JEPqQ4sOzk44EM7gyNvOHJM
         oKFztWaAiEl48N5QP99XxkhMgBdRHQKkfBAIqdmx5k1Z4WaiOAI5em2hwqRzAYaOKj4i
         o5djUnbp3GmT7EH02h+x3+zGy7jsXlUOgXJTkBpjX7svcMJG55tDivui7pv3qAsYYItA
         kvJ1TxAAXnjtnnJLPGBInRPy6SiWeAYXkqJABs036bWwDMGLqr9yqsaTGKhvY0xhSst7
         U1Gw==
X-Gm-Message-State: AJIora/Nu5MGlYFWnUK5MHnhVFrK2zaeBl18GkEb1/KaaCmPd3M3QD54
        6in66TncLEIoxQvi7lAxFvntofNjOXEiqIqthJ2FssrF
X-Google-Smtp-Source: AGRyM1t670FYwMUy+rWS1sJ649OLE9CeHki8pcOKdf5K9r1zXsVH7iZO4iRZJMvBejkuhjDtI+nNH5YT2fFcicR38gc=
X-Received: by 2002:a0c:eb4a:0:b0:472:f936:3ea0 with SMTP id
 c10-20020a0ceb4a000000b00472f9363ea0mr21197314qvq.43.1658143251297; Mon, 18
 Jul 2022 04:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220624195112.894916-1-robimarko@gmail.com> <CACRpkdZdccrfA4yHoVjzpsJesYshuP6PjtT=KTeEQgOdXR6_5w@mail.gmail.com>
 <CACRpkdZ5P-U19wTnzsOr9o_XWn1rKqVSxc+YrYnKNJLTmJyYTg@mail.gmail.com>
In-Reply-To: <CACRpkdZ5P-U19wTnzsOr9o_XWn1rKqVSxc+YrYnKNJLTmJyYTg@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 18 Jul 2022 13:20:40 +0200
Message-ID: <CAOX2RU5QuApQxo3f12iM8FEr59UuT=BBE1PqAWnKwK1e=sqO8Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: make the irqchip immutable
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 at 11:59, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sun, Jul 10, 2022 at 1:05 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Fri, Jun 24, 2022 at 9:51 PM Robert Marko <robimarko@gmail.com> wrote:
> >
> > > Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
> > > immutable") added a warning to indicate if the gpiolib is altering the
> > > internals of irqchips.
> > >
> > > Following this change the following warning is now observed for the SPMI
> > > PMIC pinctrl driver:
> > > gpio gpiochip1: (200f000.spmi:pmic@0:gpio@c000): not an immutable chip, please consider fixing it!
> > >
> > > Fix this by making the irqchip in the SPMI PMIC pinctrl driver immutable.
> > >
> > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> >
> > Patch applied!
>
> Jumping the gun too quick.
>
> Reverted the patch following Marc's feedback.

Thanks for doing this, I was planning to send a revert patch.

Regards,
Robert
>
> Yours,
> Linus Walleij
