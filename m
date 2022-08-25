Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67675A102B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241167AbiHYMSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHYMSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:18:03 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E32B08AD;
        Thu, 25 Aug 2022 05:18:02 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id l6so563226qvu.2;
        Thu, 25 Aug 2022 05:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WBcITNJBSrLnWAUXSign9aduSen7RhKmozXyR+8rTuI=;
        b=CLD3X2uN00bHSFMcKrgvXXYVx6qG1NnVFgY44zQ31UMpvVRKgVfi5LjI2cnTUNWPbG
         +lsVcEdavbIWxHjOPZV93IqxtKhpbYBf668aREfvWAUtMhlmMmOdI7ailjgmvJujpRg+
         8zIye1N99yJUDc+HWHFirPUwXTPZnW6k5viLvCFSrWI6Hc5K1mi8AmKY0a2Hpr6wd9Kg
         56OBb+F3WcQXp1VxQHhowpuD3C351pP+FThyUc6KKzHf3VrwD02FfoQFplxNJXg0yT/3
         KZHz+bQw5OKsw2SNp2KxF/Hs7GeM0fg2e7oISxEee2OucU+xtryTUp0CMtzR53vacPce
         hbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WBcITNJBSrLnWAUXSign9aduSen7RhKmozXyR+8rTuI=;
        b=5WiXzeV6K7VBgUWgi9Rr80FVNVj2CaJ95UsQf1Jp52AlEA98P3b3XLHPwMGDPE07Wn
         /Pi38uwFPx/gJEtvgeDrOpA8/E2w9DHjnubSjnHo9rW9br7w4RknmS9sE1Ny1LfuygJ3
         Kl7/7nT/Xw1el16/feFystX9bnX0iE1ecAtT3gZk0X18nkNMpqY9/Or+AK5wBU2A/462
         DKzUyqVYYo+iksrPYAIKOKrTO06QY7NB9/QgFg7jWqrGJt1IRx9aZmVJuOm23o2Ly5hB
         mRGIt+49H3BpChvGfQI28bf3IVkVBV5QcxtO5VxpKIRKPoP+IVLB25ShBj0W5lbXliu6
         1huQ==
X-Gm-Message-State: ACgBeo0DDuvcnHZ4+ggPuiGl09MJ4kG93bKelIDw0XY0x+cXejCVImFc
        NAd0nSi1GwFHMzuSIcZtS5k+bia3HdO0Pn2BRM0=
X-Google-Smtp-Source: AA6agR4wiLw8J+XrF8gziIjbkez3gEwsrEmBv+XNvnS8xETV9UlOuLBcNtMNwCHAxbPfJv2BM6tEFV5pwyTuNl7spBk=
X-Received: by 2002:a05:6214:c22:b0:497:10a8:3067 with SMTP id
 a2-20020a0562140c2200b0049710a83067mr3151644qvd.48.1661429881414; Thu, 25 Aug
 2022 05:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220816090903.19558-1-Will.Shiu@mediatek.com> <CACRpkdYX4xjG-UfuZ05KpOJJudVuuw+A_TB0U=zRP2+e7ZwndQ@mail.gmail.com>
In-Reply-To: <CACRpkdYX4xjG-UfuZ05KpOJJudVuuw+A_TB0U=zRP2+e7ZwndQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 15:17:25 +0300
Message-ID: <CAHp75Vf20piKwGTwCN2xbvvFZqzA60a7QWqWTEw=fgrS-5Nv_w@mail.gmail.com>
Subject: Re: [PATCH 1/1] Pinctrl: Add in zero check
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Will Shiu <Will.Shiu@mediatek.com>, stanley.chu@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 3:07 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Aug 16, 2022 at 11:09 AM Will Shiu <Will.Shiu@mediatek.com> wrote:
>
> > add in check of buffer offset to avoid the exception when input 0 size.
> >
> > Signed-off-by: Will Shiu <Will.Shiu@mediatek.com>
>
> Looks good to me, patch applied!

Sorry, but it seems the author didn't pay much attention and didn't
really work on it. What does the < 0 comparison mean here?

I would ask if there is _real_ issue with the code? What is the use
case and why is this check needed?

-- 
With Best Regards,
Andy Shevchenko
