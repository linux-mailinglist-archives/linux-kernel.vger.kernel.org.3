Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96855A28C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343861AbiHZNrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiHZNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:47:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F6BDC5F7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:47:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b16so2184205edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tdyqm7lW/9+BRKW1noV2HeTiiovjnxyU7lQpW/yER3A=;
        b=O9w7ecSB+WNfVwITP4QWmvW6OO25vFRs1Sdo2EdTAls2m3jrPtBALKsm1IOhTVKxoA
         cXJlYperIsC5N8IyAuHQSQzyPFLBTktnttvC8CE2fVhx7MlWn7VkKNkRTej4H0OJw9CM
         u5wvIKojceg8sTi6soDnTD7Mj2W11Wj5s+kObbrzqfzBYsisqYVFrii8VV7HToejDDXP
         tnHJCciBrqk8aOhappwRGWZ/YBgSOigHd/ge969BkVJr2fo0rA6g2iDYPFI0k7V/xuZM
         c72JEdZ3Br8wj3p6s51gEoILwgjx/ZR7EAVCS2jCr2k23c8qxKaPs068T4o8Uv0BR2tZ
         vxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tdyqm7lW/9+BRKW1noV2HeTiiovjnxyU7lQpW/yER3A=;
        b=RkGnXuS7on4NvZvToYF/3wiZWhYQWlELEGKq/LjNTGNYj22NDi1i3HZClZnCGnyEfh
         HvdgYRssPO4Ww0SX9+1okeHurYqymU1GY6rmUhM7qb2vqwEAhLpTs5fm3Ro9GbOuXjl6
         ayiL4tre3vNFP2iHc17PUulyM8klPUHoRe8ohm9NZmFvqKnBDwvCSRUOnTgsC9x//pBw
         bhhWQCfQnPOKJ3/t6Vn/nNK+VqkIVigGNRFVKla640ybd1c74+46p67SO25/Rd60IboW
         we33riUUbyR/aXDa3hQW4nShyQSf9AmV9ReO0JTgYhM9A2CmPke01ho8tYRky7OKFXf8
         yFOw==
X-Gm-Message-State: ACgBeo1PgPMePr39B7JwyWs+9OPZv8CJOwIwmLDnd/zsx4VK0oud30qW
        fG3ZE5iShJKwbFeV+AHF8O941DeXVVqq2Nm25yt5wQ==
X-Google-Smtp-Source: AA6agR67VcVIwydkOJbRJ+QEjF4GAyGy9EWxWvhhZOU/F/3QiJ1q7RjJsgnEJCNT7kkdxyg3X2i9roJGA4m0wxjQ1sg=
X-Received: by 2002:a05:6402:1f8c:b0:43e:8fab:76c with SMTP id
 c12-20020a0564021f8c00b0043e8fab076cmr6821062edc.126.1661521622829; Fri, 26
 Aug 2022 06:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220825124134.30242-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220825124134.30242-1-yuanjilin@cdjrlc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 15:46:51 +0200
Message-ID: <CACRpkday3c1BUDgheHVovBJ=v9Z-Gbq92Ex4J3VmKDr4sYdL9w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl/nuvoton: Use 'unsigned int' instead of just 'unsigned'.
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Aug 25, 2022 at 2:41 PM Jilin Yuan <yuanjilin@cdjrlc.com> wrote:

> 'unsigned int' should be clearer than 'unsigned'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Patch applied.

Yours,
Linus Walleij
