Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20874BC403
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbiBSAzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:55:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240697AbiBSAzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:55:15 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72812782A2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:54:57 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v186so22793256ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Vx+WPjk3Jqu/26mjZeRumiFftkfvBsbmk7u8x9gYoY=;
        b=R9puxGJ7+Pr8wR/uUccCrfAZoWcAAi1ZN6s1pGy9Gak7AQvMqOSH8LAhEjcn5CCCOZ
         noZmvNx/A+IjYcwWlom8/Ju1AK19wsZMF9LzmKV8bHUfeuyTMxNArJ0/s1CS30KgXoeU
         VCZHCHAzv7G5GSamfnD23A/TjvvNgrRHcMCMVR5forkuuUPcNXjX6VijmO9+5wbbVjJS
         kQSE1PXZ3paLguxz0QFxj+28GBv0+8jQeSJ4uy9l9CdexXEzbEd03znbqoQgU45/DKUi
         km+AMtEzkSYTV3N0hi7/Q7/ziITi1gP4hM142X+T6oKUw+/gZeUonk4LDW5RR+yFfAk1
         KpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Vx+WPjk3Jqu/26mjZeRumiFftkfvBsbmk7u8x9gYoY=;
        b=uzA+vyUQfjOC33Vopkd7xJxlqZzZB8UoNgsPjC4nikm+rNjRUi5BkmQnn8hqh9mH7k
         hyfH5yteE2jleQHbLXop7CwtvtWLcOtrBlfi8KIBRCGuOmte2xjnjFUTf+Ko5Zju4yE5
         ythQIP3Sd0zD99Aps/BM7/gzXP0Mac7TftUgjUahjVaC+92fmYNeZugnMTKIqWIw1XIp
         BBPhBUvOBRm2eg+H6PtjDHetOxfyoBaMO45K/f1gT5DFt59dkfeMG4U+pkOx2N+oBmPj
         +1rta7NyH81hHGb8JdP3NWTgJ4+kg0EMbwUDKox7f+q84EeXa5XwFuit/nWGsgxQJBS5
         4ecA==
X-Gm-Message-State: AOAM532jz6WRua4NmCZS4s8A5mQ6c+l+spTyowZI7YMXduC04bIl5ex0
        +F6n5Iglci3FtcAKXRnvEhkmKgRbSDawjwM+OW4q8A==
X-Google-Smtp-Source: ABdhPJwQCzUoixTMtsRur9qzlG1qSn+Sx4LgwajsEMFV5UPE5DKIly0PKpV1NusJBRnndSql78KQlyW9+v6HfFngB7A=
X-Received: by 2002:a25:a123:0:b0:623:f539:9b94 with SMTP id
 z32-20020a25a123000000b00623f5399b94mr10088403ybh.291.1645232097187; Fri, 18
 Feb 2022 16:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20220210131210.24605-1-jonathan@marek.ca>
In-Reply-To: <20220210131210.24605-1-jonathan@marek.ca>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 19 Feb 2022 01:54:46 +0100
Message-ID: <CACRpkdYPYJoteTR_zoSr4CZZiCEARu-wE4_ruN6gF8EdT_X6OQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: qcom: sm8450: Add egpio support
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 2:14 PM Jonathan Marek <jonathan@marek.ca> wrote:

> This mirrors egpio support added for sc7280. This change is necessary for
> gpios 165 to 209 to be driven by APSS.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Haven't heard anything for over a week so I just applied the
patches. I assume you know what you're doing.

Yours,
Linus Walleij
