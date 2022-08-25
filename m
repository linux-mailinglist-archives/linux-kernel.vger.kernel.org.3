Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB355A0FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbiHYMGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiHYMGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:06:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9394FA9C3E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:06:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z8so5183888edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Oc9XG7GPSCxnXnM95Iom9pMyD1+5Et6qnFByyd79xxQ=;
        b=clML/k7uO70cjZosomYnlrfu7Hk/7+IrQFqn3myTXjoUJFZSxafIE+zAKKGx7GCKv7
         nmZmkXh+KDxftT+cWcuBhYaXp5gM0qOuEXBPLUbEQ0bEApYPZ57YzVI3ou/hkquYdf02
         SOkj/AiI5Hr+P6P8KcRXNwyeWnwiBHXoX3/cEx8rtqCDzS0HBOcbuBuxdmCni0IwGcSM
         TRcF3d7kP/EAIR//kxokOuXtmNZrZ5LF0zz6ZUFUciVs7IEsJ23QQJdJow9JfZ4l5bhO
         3WudeBVKFA9derID2Irc+1YY0EfObX6XcO6t48WbS+V3VXVNhCrOQYmXAMUPQXKEuveF
         pWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Oc9XG7GPSCxnXnM95Iom9pMyD1+5Et6qnFByyd79xxQ=;
        b=kxlEPjZWJiw6qsn+JqqEoCWH2IDKDsA3NcZPaQWex008U6Ac2QsnS74fVrBAe0WcFH
         QnuddJd7Z2xynplQU/IVIDo8POpSCUsb85VnV9+5p/TefuEWXlyVAu0/+1QmyWHFCxTs
         WKs0uUeFv5+RgzkXqx+G7G9xtrktXKrNCS+MF4S+i//pD+fLle2QU6HTCHDVmnuyDc5a
         ojH0i16DK6IXNcMtAZCnr+t/K47cY6tKkgGAQCgI4L9OmxGfIP/HPBr+PwRdPNAm//D4
         CZHlQ9FcwRXvpke4EchmVXSVQQb11AErJL5k2KOtbPeShd/9vG3ZA/TsUgQGxiTVTUBH
         TAvA==
X-Gm-Message-State: ACgBeo3Ye2cmkceEbzNWT4WEjY9v+4Nzdguf+eDPkFJxJhVHx0QXsELB
        Bb4VR07fGNfxeOQrCeI8Bp+WyNWTTJtxq2nXUEtAI45zL/uQ/w==
X-Google-Smtp-Source: AA6agR6qKygK87NYbnGl66G8ErlJcVvZntTxHv2dOKGoYqAv+o1h3jteBWKRfNKH8hPkutu/oXU4XzTI2X8F0xu4iMk=
X-Received: by 2002:a05:6402:5384:b0:431:6d84:b451 with SMTP id
 ew4-20020a056402538400b004316d84b451mr2939099edb.46.1661429172173; Thu, 25
 Aug 2022 05:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220816090903.19558-1-Will.Shiu@mediatek.com>
In-Reply-To: <20220816090903.19558-1-Will.Shiu@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Aug 2022 14:06:01 +0200
Message-ID: <CACRpkdYX4xjG-UfuZ05KpOJJudVuuw+A_TB0U=zRP2+e7ZwndQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Pinctrl: Add in zero check
To:     Will Shiu <Will.Shiu@mediatek.com>
Cc:     stanley.chu@mediatek.com, matthias.bgg@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:09 AM Will Shiu <Will.Shiu@mediatek.com> wrote:

> add in check of buffer offset to avoid the exception when input 0 size.
>
> Signed-off-by: Will Shiu <Will.Shiu@mediatek.com>

Looks good to me, patch applied!

Yours,
Linus Walleij
