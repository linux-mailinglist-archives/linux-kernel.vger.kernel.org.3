Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98125A7E27
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiHaNAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiHaNAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:00:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F122FFCC
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:00:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t5so18256376edc.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xp7tXXLPMDYdofl4qf4Gl9td/1mRU85TsGKFUiJpwew=;
        b=KoLazJ7+3BZEa1mKsT29gWm/v+ceptUVBuOOTw9AJeRCvNCEDYW8zShrE95+gtAv/X
         nF7Xzl/0ZmNXPFoaJIZK9vYdolOWfcCFYzOD22Wijkt7b15q30Ew3qLjUJwBOSpIl5ab
         HNu6VeE9StJTJu8lRF/mlDw4zJ7bvbTGb6r7ite6/1bP6S0yzAxJ6G6sOodH97XSNWPL
         lGi2vMfzqYw2L4XUGZFCZ96fQu6eIe+Ul7ZSoGuHQ1w0u8eZT2O4629AC/MOXPHdbVCX
         Ug9eKg3dpOhjTZPjV+gjfq1DAnb6dgaZF2L6wyJx9lK/0c3URbbq87U1oJiezbNoMHeN
         wb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xp7tXXLPMDYdofl4qf4Gl9td/1mRU85TsGKFUiJpwew=;
        b=z3A8DunjqAZuykByvBmFlONaRXq6lXBHletNlxZhMmLtKv2CX6Fw9H2ff8+fzWF4cW
         PefXKqweFYp72Gvfov27BuvRenQLwPTMnZmd58OzfIenfOtrlgFIMqm1P2GJgT6Cit2l
         qBdH5i2FnC+SSoP26aAZVhMwrhVQVJOaXilg7elGaunOztFbt5kp/td1p03sfJiZMMVB
         mkIIe9pQVLxX1Dyx+0JyaoHbdq5rxZzz3u02NI3vlkcihHkmd/kDiVgp39ZHkwOT6boA
         sBdQ4UfSWJXZjsOZe8Mi540JYR7LPEFsiMjEMNOC6CWwapmq7AL91vrrGpv4sym3Yt5m
         2XSw==
X-Gm-Message-State: ACgBeo2bcYWge2eq8V8W8fEI6NiklMblQGIys8oxbNDbimOgIieloWY0
        rmBctu9dyOLOUOPnspKaMQPdW8cp+mwUosi9O9Xljg==
X-Google-Smtp-Source: AA6agR4KevcTQSCsv36i9lAjGTdytvlVbA6t7qZIO+ilzGidRq7E1lo/YzkULzsx5+Kba/IWA5WdgW4qHoxmdE0MesA=
X-Received: by 2002:a05:6402:71a:b0:447:ebb2:18f2 with SMTP id
 w26-20020a056402071a00b00447ebb218f2mr19879155edx.408.1661950813923; Wed, 31
 Aug 2022 06:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220828154904.20477-1-farbere@amazon.com>
In-Reply-To: <20220828154904.20477-1-farbere@amazon.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 31 Aug 2022 15:00:03 +0200
Message-ID: <CAMRc=McK=QL7m5AGZJr0CtvcW0M+iLYHWB9ErC_M8=ix2W+HAw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] add power-supply control to enable eeprom usage
To:     Eliav Farber <farbere@amazon.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, dwmw@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 5:49 PM Eliav Farber <farbere@amazon.com> wrote:
>
> First patch describes the new binding property.
> Second patch adds the functionality to the driver.
>
> Change between v3 and v2:
> - Apply on top of v6.0-rc1.
>
> Change between v2 and v1:
> - Use a gpio regulator for power-supply control.
>
> Eliav Farber (2):
>   dt-bindings: at24: add new optional power-supply property
>   eeprom: at24: add support for power-supply control
>
>  .../devicetree/bindings/eeprom/at24.yaml      |  4 ++
>  drivers/misc/eeprom/at24.c                    | 40 +++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> --
> 2.37.1
>

What is the difference between this and the existing "vcc" regulator?
Why are you going through all the hoops in probe if a regular
regulator_get() will return a dummy regulator if the supply is not
found?

Bart
