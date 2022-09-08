Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5F75B1E8C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiIHNTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiIHNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:19:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3323413E37
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:19:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 29so19226718edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hD5OXMtLiYSOIRBjRrAVL/u0p1vcpt9OcFktqvDydiU=;
        b=bx/YRchjyb2nOvHtoc75bCkN+oQIDERZe+EWlS4MzTd/8AuxA+O7Eo1NA2SEwCTzSL
         h8DkRnlHGEaUUFNJVJATXqpBeaaUbO3ARMeRfqkuPjaaizT5yWx0Yf2loL90POmHI44A
         /jhooV0tZJ3bTKhdB3VgkqL32zGkfRJGpqXm+6WYnsAgmHYuaY7Y5U+e8mSfJ/eLAj/X
         Y9EWJoz3h4H9v4203B5s5EDpH4wHAs6UKSB88A/fwRIbyDHCgeDMzG74LGWBW2faPz1r
         bMH5iYbnJlQb2P3yxa81E/VjGHr02uZTbvDXsXhpClnk7wcKZ1nC4eJ8vBfVbOEYzNsv
         N/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hD5OXMtLiYSOIRBjRrAVL/u0p1vcpt9OcFktqvDydiU=;
        b=oH4RYus+PB6OgPxkwcFdP/4ZZ5pzw4dPjxI0cyX21oZZjz7agfiz+4w0iIcZiqY1JD
         yOrtOmUBbbNPM/SSk4Jbt+KOCTWyYbDwVv0LGA8+iMLdEu9F8hQRerhSHljO6OHX6zKl
         tlgn8o0maTMFc9H+f6+ZfTpfwdlpLZI56tjJY5aSxwMUS4xJSEr9ROQ2cO73FUEsqPHC
         /Ch4uLEe1SnNAy8hH8SvIIelNmhDIBt5wKP7XLtlDRj04ncwK3kE4GieAmIUxzSbRvei
         l7qkrk0Ty7/Qp4S0tBA0WKtXh/IdPEVRmjiY3Ic6nP876IwBll+VjsLj1824MmrOmxuw
         WViQ==
X-Gm-Message-State: ACgBeo2tLbBsuD7KfSwtYO8aJtF7kGWFfiy0YWmk3ZYkFTFYwMPi8GPa
        SuQcsLLiLYelxtMBIn6vGRu1oQCbdcWea4q/NxV0qg==
X-Google-Smtp-Source: AA6agR7n/EBgjUAQ2j0IRBf7HDTjCCp6RUdm9MKV1Rxspw/JVsknP74Cazms8OeJnnN3GyZCJCFI4exGXDkDcMFAeww=
X-Received: by 2002:a05:6402:1f8c:b0:43e:8fab:76c with SMTP id
 c12-20020a0564021f8c00b0043e8fab076cmr7085760edc.126.1662643171530; Thu, 08
 Sep 2022 06:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220908094323.31965-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220908094323.31965-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 15:19:20 +0200
Message-ID: <CACRpkdZRtXxAUaXkpWemsAZp_F36k2skz0wmnv8jX1Hv_xgh+g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: pistachio: Correct the fwnode_irq_get()
 return value check
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

On Thu, Sep 8, 2022 at 11:43 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> fwnode_irq_get() may return all possible signed values, such as Linux
> error code or 0. Fix the code to handle this properly.
>
> Fixes: 1074e1d23a5c ("pinctrl: pistachio: Switch to use fwnode instead of")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied.

Yours,
Linus Walleij
