Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7C4D9237
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbiCOBUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241657AbiCOBUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:20:51 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBE8473A4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:19:40 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e186so34349757ybc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CAQV7OW5DIVoy49mXItJtHDnpMN5TYYxiJrbhxC4jyk=;
        b=jDH/0OzYmEqK2xNtLP4C5LVw0ybx+9cFmcuBzO8v8nvbMZVcfdWLyuQ5azyCWwpKYX
         y6pyeV2rZU2akXuq+5RZ15ARo9wjY0ros0PMYNUCwaqfqw9zKW98Pan/9ENpwzGTi5nM
         GZgxWPDl3zEJPoqaweUa23Wn7sGRAhqfPJ/D7uowDIpC666MmZig5BOKGgnTMiKMQfWP
         rf0EgURF93cr4+pNa59EWV2ahfcUG1MIm/hRLJiny0vi5ygLsY9t12R1Vs/r1I0H00dk
         sJx+zX3m2ROXSyHcW1ViasJbMWkh9WSh8Y9HpED/hV3tV02CyHUyoY6PxeVUQg9kSCBk
         lIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAQV7OW5DIVoy49mXItJtHDnpMN5TYYxiJrbhxC4jyk=;
        b=DdUcouHHrp/KLoFNQSOI201Dc1TWxhTI8pCC54e7lWT6fdYd5ML1Mv6Q/kMF8irsD9
         2Cc0qoFFVWY0ro6Ywg1WgIrNs/FTscyeA05mRAXF0M1e1HkCBovYLALpn3PBfzZwzeUI
         KpEUhMuafmHv0n+hajptSxfka1zt4QetAtReuQoO712w5WWvCYEM3YTayQO7yvF63IZy
         nWiA2tQyvVilc3hKJFyKR0JqQt89Vokxi8bUKPDQ9sI8Z216RO4N+mtZ6aTYISN6zBd9
         wrzO/p/XArIXl7dnV3z6/yMiWbDbbTH00doJ2A9mOrATA+ucYD6EoFcBxC5sv5+iKNOn
         SdBg==
X-Gm-Message-State: AOAM531AUQN2648NMeI2SmbnIJbUbwBFqXI2rGvdT2mUzhCESepR+5D/
        IMoHeRLOQT9onKaLHXoVftLJAhk95eo+dPplhrdOeGjXaTk=
X-Google-Smtp-Source: ABdhPJwkeenfT24JdlbNiz6up7mPHv+kyB95NY4vskHaB3Ozp8o/ij49btgsTtJwb2QNcIsiElAwbcY8SDY22QhewC8=
X-Received: by 2002:a25:ab64:0:b0:633:6d02:ebc8 with SMTP id
 u91-20020a25ab64000000b006336d02ebc8mr2610032ybi.492.1647307179860; Mon, 14
 Mar 2022 18:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220303080206.16463-1-tangmeng@uniontech.com>
In-Reply-To: <20220303080206.16463-1-tangmeng@uniontech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 02:19:28 +0100
Message-ID: <CACRpkdYaWFuuE2_p5My_PSLAPw3tumGaxJqMCiCvGFAPWrk2KA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: berlin: fix error return code of berlin_pinctrl_build_state()
To:     Meng Tang <tangmeng@uniontech.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Mar 3, 2022 at 9:02 AM Meng Tang <tangmeng@uniontech.com> wrote:

> When krealloc() fails and pctrl->functions is NULL, no error
> return code of berlin_pinctrl_build_state() is assigned.
> To fix this bug, ret is assigned with -ENOMEM when pctrl->functions
> is NULL.
>
> Signed-off-by: Meng Tang <tangmeng@uniontech.com>

Patch applied!

Yours,
Linus Walleij
