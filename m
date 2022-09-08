Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE71A5B1731
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiIHIfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIHIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:35:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDA553D31
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:35:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 29so18130636edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=41aJIy4OTHB9iMGo4cS7m9t/pURKyc1pDT6bdLDLpCQ=;
        b=tMGRAYFGxk8jJRGYJD3oGNdPja4kvXMvJQaOyTlRTiWuOXFEouBb85EbP4zYzCiV7o
         pwl2SrWb0k6wnYP+27RENex/DDXgHIHL6lNXk9wCWnUuYfy4Da/8mnveh+OvRZEvijOi
         td26QXx5ZVeHQpeVFe43cPIodT7YYoP6caU5u8ldcm3tIdhKHo7aCAypB8zPGtrBlLrg
         lO0y0Q8bwnSb3ZTFpaQQtuwnexrZopWQCvb614YpxvUEKV+urxbZ9qOrlS0XfzaHdmJZ
         BxFVsZW4zt0D6mqfK4mk6XF0re32ZNDb9Jdeg3/sIoe2E3m96mBzJOaiVxXssJAjjmzN
         tGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=41aJIy4OTHB9iMGo4cS7m9t/pURKyc1pDT6bdLDLpCQ=;
        b=Bf/T2ND1Y6Tq4pbD3n+qvZXKWFHJH0VCb1fa/7Rwie0iAM789fBxkB48NreDe26wtt
         1tp5JASqKTY0LnDACC1Qo4IGnU3Yxlx9RNKJIniJRa/WMlSTyaWuGBKkeyXp9LLZHtwX
         TBKdLXX84jU3FPPWKR+TrtIlPVOjhkrXoqaVy/hkGHneJ2HGujh9T5gHrXUtEAObccMt
         3Dw7fE2VDgGI4H0w5yrOpbITnOmDfNGs9iXSzZaPvaPiLHFrLUXesytmVNtGwGL4/7c0
         YQRKT9sSl7eD2i/i9ftJYHxlQdYA74YLpAO6W0dYkstbuCAlnB+BF3so/WkqGX1Ndqo4
         x8Dg==
X-Gm-Message-State: ACgBeo3hnKdCPdn2ni/IQj8fiZy70mp8KJKI8uFBD1TaI5sWbd808U5J
        tp5b/gUBQRVIduEmhEvkXhFqIUstCbdzWQfXQAk+lg==
X-Google-Smtp-Source: AA6agR5pz4WZzndTBp4jUUROyInLbrcT00ub2FoRoGT9/n7hi4t+CSCkzYEr6u1rPJG+ddzNyd5BKhWnZVyeyUKEk8g=
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr6151272edb.133.1662626099071; Thu, 08
 Sep 2022 01:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220906115021.8661-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220906115021.8661-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 10:34:48 +0200
Message-ID: <CACRpkdYYjmW5shHedW95tbUvqcbWrYf87qGSQ10kJT+uDy_acA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pinctrl: microchip-sgpio: Correct the
 fwnode_irq_get() return value check
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com
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

On Tue, Sep 6, 2022 at 1:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> fwnode_irq_get() may return all possible signed values, such as Linux
> error code. Fix the code to handle this properly.
>
> Fixes: be2dc859abd4 ("pinctrl: pinctrl-microchip-sgpio: Add irq support (for sparx5)")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Michael Walle <michael@walle.cc>

Patch applied.

Yours,
Linus Walleij
