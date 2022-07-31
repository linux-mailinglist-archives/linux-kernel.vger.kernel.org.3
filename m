Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA4586113
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 21:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237617AbiGaTiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiGaTiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 15:38:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5691055A;
        Sun, 31 Jul 2022 12:38:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z2so958715edc.1;
        Sun, 31 Jul 2022 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tAlWO/lfTLeUDFwT+LCah5fdEb9i+2JJs+LfXYTWE5k=;
        b=D+Ynpx6UO0C6qCacH4JAMUif9xBpMI4CK96S2U9aQddjpAe6KtjcEuy3JKPBB5XRjq
         xBKeavE9B7NwrRTu4sbyggxV0YXcd4pT6yO6hMmyHWjTuDn0r/ovy9heL0+F+sg0zyqc
         8Lx6cy4MICQgvpdfOKRw+V6SMVSIVXNHc1B/C/qme9wEvrb5CU2CMtyaUYYDrHqnpYaA
         XIv04xm0EAPuNEguxUbQ4CfoMLJ7XYZmKatztrKRP1ogIw2dGvc0BB975Ily2tLc0bVQ
         mppx4tQoQ7oO/6AaTdl1gMBjMYC3G8KJ2bGhFkN5NSYbF5nInQT1Rdmn5NHDXpZvAkbq
         upaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tAlWO/lfTLeUDFwT+LCah5fdEb9i+2JJs+LfXYTWE5k=;
        b=oUHSKHCmNhEBJDwHnMwx1licBs1SxU44epyZVACaIdWzhNnQi6lsx4i0kEKzJ7CwKo
         XTlHf3bNYqJEw7Wa55BSvSnNAf2dEb0OvxG9hkYqe9uZODJ8PkYwin92cQmUaqRkecQK
         BvDFaywKhPhrjQZhrhiz9G2uZO1LwBQ9iKSsQ6uNPst/QZE/hkXumHX7+G+9cYg3r68e
         6DOf6YkkGQFp9/A7zrGFzyrEU0Ubn9K7/aUBctFFk5qDQfLxg4wKij/iFPwXG2wizJy9
         fSGf673vdB8NZQfNKXaMwLPzZSe4ENrGlUBQyWmIKZrAkD4w0iUGf/z20UxjwX/SQKHs
         ni0w==
X-Gm-Message-State: AJIora+TugNVHz8UQeYQqvi0qdTXV9/DOTb7TBJewjCHdxa8wKpCTPdB
        zz5AtGsSwCaUIBYWQ44qGWd58vfs3UnmyzqXvfg=
X-Google-Smtp-Source: AGRyM1tV3xZEg2s+6wazTnQy9KDB4hpaoK0WmHFw+cqOQppd1gluJKOpGMWTGnb+lLP8A/GwfunIYraWTqM7t//LfOs=
X-Received: by 2002:a05:6402:280b:b0:43b:5d75:fcfa with SMTP id
 h11-20020a056402280b00b0043b5d75fcfamr12394440ede.114.1659296287503; Sun, 31
 Jul 2022 12:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <7c3918d7cce9643414697cef02ef636f05efb003.1659266359.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <7c3918d7cce9643414697cef02ef636f05efb003.1659266359.git.christophe.jaillet@wanadoo.fr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Jul 2022 21:37:30 +0200
Message-ID: <CAHp75VfHBvpy-u766n7A8HYEcWBZGrqsyi2mOnh96oPTSOuVdw@mail.gmail.com>
Subject: Re: [PATCH] mfd: intel_soc_pmic: Fix an error handling path in intel_soc_pmic_i2c_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Shobhit Kumar <shobhit.kumar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 1:19 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The commit in Fixes: has added a pwm_add_table() call in the probe() and
> a pwm_remove_table() call in the remove(), but forget to update the error
> handling path of the probe.
>
> Add the missing pwm_remove_table() call.

...

I guess it should be rebased on top of [1] which I assume will go into v5.20...

[1]: https://lore.kernel.org/lkml/20220718122328.8287-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko
