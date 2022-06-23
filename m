Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9EE557DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiFWOVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiFWOVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:21:05 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEFA443C3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:21:03 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3137316bb69so195291107b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rf5HiTVNrAIpJ0wokKeVeR89HA4WWdGGZS0VF8ik5kA=;
        b=pHtzpwCFlcK7eZL0a0b+EMhrPeNO8dYdsArNWv+GTsGJybwWOjkmyIynWIffqTInGp
         4oRZuEcpRnZjazyZBAL6cMH/wlnCUmqI2aNtmEZMBxNENwridYiD2Hw6VPWI3VWV389A
         CfLIXL8H8rdT9mufa2aObCB1WwEMkuV9Kmpx54Y52OZtSm2vcvS6oDhjGPSPtG6ipoEo
         SlCTrlNACRyIlkNgkkeAiPoM+QYujOcUGKnXKeZxWW7L9R9+CALv6fZFDbn7rF/KU/hF
         2loapSIR5f5OB/D2VZctVQVvtFTz5jqxJgM3VTR+nWYZfOBKln3+tyIEnOYK32exNV5S
         JOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rf5HiTVNrAIpJ0wokKeVeR89HA4WWdGGZS0VF8ik5kA=;
        b=fylQ8Gu2Te7m2yibaiMGBFo+4C/eY8fdoav3f+sQLiF5lL7oyp5xjC/PGIHk3ntHPS
         azV6T0qPDLVyhq8l50s3ewqptIc7/bH7zm8GElgcqxEyClJZvDE95WckBGivR05OFzwN
         IBApFJLsiGZwLyWefBgFkOAZ4+lnl72Xa0hPlbHdZJFaAnmmB0Aifav2vQeshPh5Y3hz
         6ZIC+cwdSqJpJ6md24iuZarN8H3XoyPps2f+doGFGf4B+Skvl2jUrLfGkGmPhxQ6CjSo
         9mgYEUWFqsZ3TQTrKxl1jQPINyMOvhzhooXFPMAwZ4RJpjBL9rD2qQFUd8TCr+LrYgrB
         wFlQ==
X-Gm-Message-State: AJIora9XWbOYTdx6ifyXJIJ+DbHd7cbv+pHyHQizegl0JYrV8J/kKtEl
        7d31cbheDfK/Tr+W/j7XKl+DHwsFy0YVe6ag7HIQ2UCPToU=
X-Google-Smtp-Source: AGRyM1uPE21ir/K+p82s2CyfHc4N4q09ryX43oPv1c8VFXsWoUkqO1Ru3sifHRUbZvOEM1QVtmSBp1ub/kdZShGRWg0=
X-Received: by 2002:a81:d05:0:b0:317:76a1:9507 with SMTP id
 5-20020a810d05000000b0031776a19507mr11305724ywn.151.1655994063125; Thu, 23
 Jun 2022 07:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220512093844.1109923-1-zhengbin13@huawei.com> <20220609222239.5fssqczkdqy4inoz@mercury.elektranox.org>
In-Reply-To: <20220609222239.5fssqczkdqy4inoz@mercury.elektranox.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jun 2022 16:20:52 +0200
Message-ID: <CACRpkdY=BY09fRb+SCTCbb=Nd6i-hD4LznjtOg10VivMbLb2ew@mail.gmail.com>
Subject: Re: [PATCH -next] power: supply: ab8500: add missing
 destroy_workqueue in ab8500_charger_bind
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Zheng Bin <zhengbin13@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaochao49@huawei.com
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

On Fri, Jun 10, 2022 at 12:22 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> On Thu, May 12, 2022 at 05:38:44PM +0800, Zheng Bin wrote:
> > ab8500_charger_bind misses destroy_workqueue in error path,
> > this patch fixes that.
> >
> > Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> > ---
>
> LGTM, but adding Linus to Cc and waiting a bit to give him time to
> react.

Don't have the original patch in my inbox so can't test it, but looks
reasonable so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
