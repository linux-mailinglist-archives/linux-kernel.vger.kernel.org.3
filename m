Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964844D3FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbiCJDa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbiCJDaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:30:23 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB48129B9B;
        Wed,  9 Mar 2022 19:29:23 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2dc348dab52so44527277b3.6;
        Wed, 09 Mar 2022 19:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llQryIxK1gbbO/x6DesV6WYWYDXoSpETouQ9e1mfBRA=;
        b=w7VLaOU+iT8aANDizTEz05ps/SS3pkDuM2ymOtJhBr4EavVc2we8aSjsFUlt1HJbOm
         0XcZlSIgFEhCysJl9bpwQPgLrsv6oK5lh1yLfJ2SRSMdX3XH+P2Y7S4bRFEwe4cCPz+A
         EotaHsq/rpHCHDEUW4bTO4X2FdywDThv7HOk18vSGZ8OFwHqNZoi1RuXuimP1hMtSZJj
         N0QvELb1oIdRA8nQhvsQL2q1Pdh3Oezl+bVmYmIh7BUdttgnu2pvVDqOEHPNFAwYYOrX
         7KenmJCUj/A32NrvCPL7BZIYrSs7rdtpl5W4W605qUMWcwymW9Ky5XKwKxiZmcGrRBSW
         4lLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llQryIxK1gbbO/x6DesV6WYWYDXoSpETouQ9e1mfBRA=;
        b=Q8M5LbZqGuVm2NfU/oLuU+dR2xi4N+xexO4vi9ZZMNwRU+NOXpo61oj0MsYKOO2tYH
         rfC9BY6pUdfSL5Z+RqpXW15tBwkvO2SbyreEEADMcVPBvvDudMJjFQLorJgBe3qh6MUK
         bqAXpHSyjCOndUlhsyKOgyRcuRuNGX0dUuSZFzNR7uoDSSHOyZYK79Qo+zNOIZZNLq1B
         o1bjj1yFbfbi1hLEX0FC9jxn7bVqg8TPpAzCqsZh/ABdaFxJ2CVto0L3ux2iEDHeHjgS
         8c4WuSFeUl56W3nBp6IncTyBZz46TmZQ+TsVOMOkg6jVRtFnzlwY8Rn3U8STP/0XiXty
         7y4A==
X-Gm-Message-State: AOAM5330MXiRdf7tqt+X4KlyNoVcwvc7vyGa/Z77Wshg2TDBXGfi9dw6
        Uo4h3KZEj6jf4vXcS+3KeMVRhPpDqgh6QWfR470=
X-Google-Smtp-Source: ABdhPJxY9Ku+de+MYC5VrdKufztup7vVy/UHiJWm3eg3wHp8kQ2A+vdxP9X1PTbsCKxvsRMJlBC0lS1L7ojyDf5Be90=
X-Received: by 2002:a0d:ea97:0:b0:2d7:9394:17ce with SMTP id
 t145-20020a0dea97000000b002d7939417cemr2363757ywe.297.1646882962813; Wed, 09
 Mar 2022 19:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com> <20220309162301.61679-18-alexandre.belloni@bootlin.com>
In-Reply-To: <20220309162301.61679-18-alexandre.belloni@bootlin.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 10 Mar 2022 08:59:12 +0530
Message-ID: <CAOh2x==UmGhcDp_SKnRa68RSreqzQw=N_Gq5Z-rXiQVhZHZVNg@mail.gmail.com>
Subject: Re: [PATCH 18/29] rtc: spear: switch to devm_rtc_allocate_device
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 10:26 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Switch to devm_rtc_allocate_device/devm_rtc_register_device, this allows
> for further improvement of the driver.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-spear.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
