Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7175A994E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiIANne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbiIANnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:43:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B121141D1B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:42:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lx1so34733659ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1EaqqddIR1XCNfaCz7qVyQXA7LW4dhv9ZwS++IlbD+Y=;
        b=IjWM/RUWFXuOL5S+TUF3nNqpQDn2bNf/5uODcH0ZQzBCdudapBoXEDqZMwRWwG6rPW
         8IEqjPLFyWm6LYS5w+e4e037UVAHiF9d7iugfbNbYokdTXXNl5twn8nld8/YfPZXjqzc
         Qn+Ltw8m9zsG8CGkDvbUJuypB4L5ilPXs5RVbk9ZC+p0Ej0+D0YSXxZa4lCEog+mmRq1
         oJFrcRt8zEwB0TD3g3C8FxyEjl77o+1uRifEDIlzfTNjBfgdls5dKDEvUOVzbxD6rFXj
         STQf7teoEu2Huu0BadNvl21W1StyPNFjFBF1rvj6yPLpziol+rLpMMaWm1SgloOLd45x
         9aEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1EaqqddIR1XCNfaCz7qVyQXA7LW4dhv9ZwS++IlbD+Y=;
        b=QKQWJovp3w7L+w3+AKrHPpf8st5hsCqYrrE4LyfQ7A/JIPHmzt+AMi+DZ1CUBUSfKf
         L+PBNiPiC5QVj/St/roZ6CKJodrmZ8QF6AB1fLKu+nUBVphJDU6nnMc0uh5nFYKDrveC
         Rkda3wzmM0QJIivAsKVTaimm5kg2Kf8kJkWTBRIyVcMM4x5djb0h5bpNaSI7wVMv/Dun
         SqsiZ9huitazEGmhRUPX+X0OCcZljP4ppW9DxjAuS48tK1l8uK9Sed48CVrfKp4NvKJA
         MPKwKIBLErWllziGT0vbTvIY3hRC75XkREiGy58h+c959lObxRSTdrak3B7PvieUxywZ
         rcew==
X-Gm-Message-State: ACgBeo2F6LTgNLDBtSYHuQCPaJKpXGZ+29/vZNuA5zpwHa09ENUGdWdF
        LSs8ZSugGMTXD7YJ8Fs1NWVMXsp0aSZqVhL/3gnJtAGpMNLYxQ==
X-Google-Smtp-Source: AA6agR5nUGmRNV8JzA6VNl3F8DGDdlt5GTRYXhMvOPuc2ikogYt06OX5mVzQUHxNzzgEP85R9EGNuhish/DH8MBHS1c=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr24192010ejs.190.1662039731459; Thu, 01
 Sep 2022 06:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220830193938.56826-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220830193938.56826-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Sep 2022 15:41:59 +0200
Message-ID: <CACRpkdZa5bP_aJQ61B_SUBc-kAOfWTvp6h-Ek5_=9=3mhXPHLw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: pistachio: Switch to use fwnode instead
 of of_node
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 30, 2022 at 9:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch looks all right but I don't understand the compile error from
the kernelbot... device_get_named_child_node() isn't available
on arc? No idea what's wrong here :(

Yours,
Linus Walleij
