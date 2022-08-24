Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8175A03ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiHXW0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHXW0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:26:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4DC6D566
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:26:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w19so36205142ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+ajTV7s62W1buFOBU//XnEVu0hO13KdLtqXDbl3tmPE=;
        b=io0+e8FIXTSQk1g3wDnwByFBPdYF9s3ZfdaG/RVPfDS0+g1Cf8HeP05gu2l4YJx0s6
         YZCxo5E0NzrIspU7PnlluB/jxieN42x24fvDfo/A6K/5tjdw627ED+XY74QfvAA/U+MX
         VyjsfAxKdG7W8BC5sB6IgnC83poZeX1OhO2zzNpOISyodk4R5s2UkPdC4EoYtOfcfX4R
         Lxzya/OdzuFbnZnbLNDRSMDHdjxAVP70Iqq5dr4HmbWJAXZo9n9bSs+0SGP5xpsQS98y
         ScEdM5Mqyounm3LQ9JSMcQkTQT7X2W8+DewaPkmp2hPvf6J3rit/x2nSIKrdIGCWT9OY
         dVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+ajTV7s62W1buFOBU//XnEVu0hO13KdLtqXDbl3tmPE=;
        b=elSC79S55cqfgFAca24rzIPV6rIcnNOxHluIF3w7RqVv5yRiZmPMlHBmacQ6zAHKTm
         gWSvgcy7fgeAhbPdbZyhETdvb79ldbvEQPOWFEgveIO0wkqOJA0BNNTFphidk7CHrvUx
         y8BX+BAeKzcGSgOcHxVj821WKzVhAQxzwbYH8FSgIoXHsoKfTyuTGCDHsfa76tlC6qzN
         AT7EYtW3d2cV0cvxSVwekVbmv8Z/YHMyzGCaB3SUbTFl6fM08pIyUnSYssWKPW+Ok2PF
         4/rIUzGff+ObewhirgjAZksyO1nVUfu7DvdYZRsSkPFSC2iw5qNsGQ7TVr8nqapGZqgH
         k1hw==
X-Gm-Message-State: ACgBeo3/Baw/PZLbPFeL/WIprqYqK3gTOAKqlr+/ytSks+6D9CJPoDt/
        wYwLVmJX2c++iUHzQoBsC76YGhB2skNpjrG4ZQC7Ng==
X-Google-Smtp-Source: AA6agR5p/xUIeIsNjIdgP8K8L1dDugg9o6K1q4VmFAeXWY2JRKLaX9si4wdK9/4rP+CDDJDtHdAgKonzsr/NdUZqeqU=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr661185ejc.440.1661379966637; Wed, 24
 Aug 2022 15:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220816054917.7893-1-patrick.rudolph@9elements.com> <20220816054917.7893-3-patrick.rudolph@9elements.com>
In-Reply-To: <20220816054917.7893-3-patrick.rudolph@9elements.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Aug 2022 00:25:55 +0200
Message-ID: <CACRpkdYc=KQo2dt_6NmQnbf-6VhYc4og0xm0mD-AVEE=K=BgpA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: Add Cypress cy8c95x0 support
To:     Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 7:50 AM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:

> Add support for cypress I2C GPIO expanders cy8c9520, cy8c9540 and
> cy8c9560. The GPIO expanders feature a PWM mode, thus add it as
> pinctrl driver.
>
> The chip features multiple drive modes for each pin when configured
> as output and multiple bias settings when configured as input.
>
> Tested all three components and verified that all functionality
> is fully working.
>
> Datasheet: https://www.cypress.com/file/37971/download
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Patch applied!

Yours,
Linus Walleij
