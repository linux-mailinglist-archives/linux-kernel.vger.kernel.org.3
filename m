Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8AF5B1788
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiIHIrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiIHIqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:46:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF127149459
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:46:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b16so23283711edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ike64CUEUd9DsY2jLXloOMGX1zcdA8CVovnEVfdpkWw=;
        b=LKcaO49R7C8D7BiAe7tCsdVClR1PBI8B7udt+lfBQSS+x1yUq4VGovYQ1webE9nqw7
         lIQNKZXg+37DOjGos6CnFYKzKtsnkszwufk4cSmLu7jdwiMyGSYw6aRUDNMp2JNTPn9Q
         s0W5Y+tE3hEbzoF1CfjLlQOGKmHlcZeN/wT8wL24n6MQIgEEqgol87G35WOjwpcuI2lk
         qNFj7GRCe8xMlX3yyyXSqkgxlEUai6VUTz3ZY1QcAKRzdDCfDLicOza3s7aofcV2xmZm
         bl3Cf3g4utherIQaOE6u/cHbjoZ+HQ3QQBNu2v35D1poam90vFvonghu7DIe2RuqpQ/m
         WORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ike64CUEUd9DsY2jLXloOMGX1zcdA8CVovnEVfdpkWw=;
        b=FUEY7DDPHe/zbT4AAIvhwlJrmVV8JqMnR8TQXk1tOOZhe+kHktqs8rAQ2aygR4C5UN
         6gplOjKUb8da+rkHic2IUuQV1I77mf0WJNBrbPmAlckWmUhl/L0N1YEC/lo7LjglDFWm
         K9MWVKWVIhFVE4EIz+3kZkV4Bm2wmUnFDcXFcYRpYf0qTLNpJHo3FmgYerrsRYBU3jYB
         eJNjrm7I6tiHGW906kcm+pJIumJMMeRkHeFRsYBSK/yjmNHC1hRcyo5aia+bWkSOWXO6
         hSDpCd3lDpW6nQ6lolL9sHuL8GFzqI0UrAvUuTI0/jkniwTJNwlXn9BLXJXSIn4yyvbJ
         bXqQ==
X-Gm-Message-State: ACgBeo0QjKIVDMgXAhqvqhqpryArDyTgolXAo9yZGEX51pTF3atxXmNm
        5W3g+9YPiFfoXjqK2hHFf0R3+5sTSUQKm4LT+A/TInryyyYgsA==
X-Google-Smtp-Source: AA6agR4U76xtXaCBaEkcc16Efe+w9c+SR2weFMmxwjNiQ7qKd8luRRl6XC6xXOWShNwUnwGUtUi4ZhBzOgU6QexOVu0=
X-Received: by 2002:aa7:d6d9:0:b0:44d:e1b7:d905 with SMTP id
 x25-20020aa7d6d9000000b0044de1b7d905mr6280515edr.32.1662626790778; Thu, 08
 Sep 2022 01:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220907080251.3391659-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220907080251.3391659-1-horatiu.vultur@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 10:46:19 +0200
Message-ID: <CACRpkdYNvL9xf61BPJ1QDotXkJBG18+o=ZsFwoLw_LL-qGZ-Qw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: ocelot: Fix interrupt controller
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, UNGLinuxDriver@microchip.com
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

On Wed, Sep 7, 2022 at 9:59 AM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:

> When an external device generated a level based interrupt then the
> interrupt controller could miss the interrupt. The reason is that the
> interrupt controller can detect only link changes.

I see there are some further comments, I expect to just merge v3 into
fixes as this needs to go into the -rc:s right?

Yours,
Linus Walleij
