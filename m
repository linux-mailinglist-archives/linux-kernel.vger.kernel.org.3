Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE494FBBE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345998AbiDKMT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345997AbiDKMT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:19:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DB340E6E;
        Mon, 11 Apr 2022 05:17:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c6so2986941edn.8;
        Mon, 11 Apr 2022 05:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+UzpRpDVSr1lDiVoAplTW0nNMatrStbGOT5sfh+3vF4=;
        b=qjaEI8sJKqCx6FqhjcgLMMWbTeG8y9NQUGiw4l5oizRI0AGwlg5Y/6wjt3qUVCMemK
         HJ723UHXzhcilmubQLVjvE8GMPB+M8DAFvu5208ryBWBBBxvphWi4DYhW2ZPx6zEqftN
         aDmTvNgfSG03v4rfwifL9Lg6o/GhB4fCTsv5A/pQDfHok9xeEPeTG0it3nm5sCqa5T5Z
         21V8hEhkUyg2P3YGzwvEFtQvECO+x5vzcOT6GY6azWBmL79Dm7nJ9kse2ILCW6j4M3dO
         rf7C8DNKmv6qZapoVTCBOVw03mSeq8vJw86C8C7l49pA6Lhg3q4KDsbijtjTRsDTgTH9
         UJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UzpRpDVSr1lDiVoAplTW0nNMatrStbGOT5sfh+3vF4=;
        b=VtItX5u9PKIrb9uL874m8DtZ3Uzw4KAvlhPnw3ATEj/VgMbYQCKjqxXWwRF3m6ykE5
         90H1L4pXi7QZOdJGLb5BaU0umqmzY7qOHgMov2P3ebcnZJHcpdVYYituWkfeylEEJqae
         N6FY0p4mrNNhRkDuNKLnhKI4gnec+TFafkbKPRbfbpXbYBXLn5K9ZUQ9iPZ0tlnSm834
         lBqfpk5m+Rc2sAldLConLHyVDwTBckwam1frK6lTzPiqsXH5xafjKBCPEbeiAnWrjb1s
         IA7H9wGEyom0cszJFYTsU9mXra3cuAGAXcpBSIMhZpF1ShbZSMiZATopUiGdfa/2/2aB
         bZZA==
X-Gm-Message-State: AOAM532mWpSGWA/UorrIyxbqt+0lwAastayL0B1SQvUcCCz6BtOtsh1K
        CObPWvF/nl0aRagAqvjRUUpiUlj3DsWFx3i/hcA=
X-Google-Smtp-Source: ABdhPJxfCv2MsAKHu3FYt2iZh2qWd14meSVbj2riyzMkKlv/CxExK5WPThXw92D+8woazoiQekGqTucridJwTRIUE0A=
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id
 i23-20020a05640200d700b004130673ba2fmr33225629edu.29.1649679430440; Mon, 11
 Apr 2022 05:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220411063324.98542-1-andrei.lalaev@emlid.com>
In-Reply-To: <20220411063324.98542-1-andrei.lalaev@emlid.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Apr 2022 15:12:57 +0300
Message-ID: <CAHp75VfyxspOScEt1qffshdrDYuQp50O5HFbr2cUV7MYsg=JdQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: of: fix bounds check for valid mask
To:     Andrei Lalaev <andrei.lalaev@emlid.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Apr 11, 2022 at 12:57 PM Andrei Lalaev <andrei.lalaev@emlid.com> wrote:
>
> Use "greater" instead of "greater or equal" when performs bounds check
> to make sure that GPIOS are in available range. Previous implementation

the available

> skipped ranges which include last GPIO in range.

the last

Should it have a Fixes tag?

OTOH, the current implementation suggests that we have start,end
rather than start,count. What does documentation tell about it? Does
it need to be fixed?

-- 
With Best Regards,
Andy Shevchenko
