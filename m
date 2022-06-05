Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B586853DE7B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 23:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348582AbiFEVy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 17:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiFEVyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 17:54:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1552D25D9;
        Sun,  5 Jun 2022 14:54:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y19so25624005ejq.6;
        Sun, 05 Jun 2022 14:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABebLwqo263XImxv15WLBOgTgljqLTOZQ9qLhJbfj4M=;
        b=gE3MrqpbpVRDsTV5MMCGyHCk5v+WbI4w44tUaDP68sCLA4ijYy+H4hxOLT4zHW6vO+
         9NXxieOl498QxZ15MCs5QFWZS9fQ2MUwGCz1Q3st36F0+Xti+r/syURpUBb/1bmTwkys
         w4Ic4cl5AR+/X6uzpPyzhBsBlSQ9plqzZ9YXJISTn3UEtyaDKpgVtzKTp+LdSDwgpSGw
         XUaxudt3OQFq6PgeCpIZb8niuIMSovpMDw9eblBnTOE3L5tWzGAjir5ewMc5fWSgl/DK
         v8528A+sqE1VIYQV+ICdzkQfrAEkSz+5Q6xkBDH/Wq6VyJeFaLr+9DQFaHIJIXh0vCND
         56YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABebLwqo263XImxv15WLBOgTgljqLTOZQ9qLhJbfj4M=;
        b=ksha7XKGelbLqE6yTo6BUNLKsO8zKjdC63pxBYS8iCGchZpBzdKtKSLn/w9ecD/Vh2
         thFCkg857p7xwPwuKxY37sHkgWte73lS4AZSmclACIIgPlthg4EZaTikYN+6C3iL74HJ
         z9/uyNvLww1NkaNmBShNs14NSB2CE+PJiwkYayzD5g35ITjtxphqmsVgEFa+RRGUy8fV
         YyOtRwwvpL9O05ZyEqLPV/LDWVkjtdk74L/CFeEy6TcroCLi6QEkEkETdxqPj7GWnROI
         EpIGTfqAnpFgZ5wbg/bvx/aJHrv9/L/nZUA3hqtCkt1o+tcFvlP7bjED/dsk9B926gDK
         9YyQ==
X-Gm-Message-State: AOAM533KBEOjCcrmG0jo2gU+PGyKj2rbSH/8myQ4SEge0aZ9VuCPzX5/
        4wrwOj91lS/XtSliJQ+HFVT6aEHoZH/gzlo2akk=
X-Google-Smtp-Source: ABdhPJzSDwXWfpMZTQJxufLLyVm7/xbOttKxhZwowPd123orPtSasKAoePIaRSV3YyoLklNCG+aJWvY/jht4PcwEIlc=
X-Received: by 2002:a17:906:acb:b0:709:d274:611b with SMTP id
 z11-20020a1709060acb00b00709d274611bmr18721865ejf.147.1654466062611; Sun, 05
 Jun 2022 14:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com> <20220603100004.70336-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220603100004.70336-5-andriy.shevchenko@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 5 Jun 2022 23:54:11 +0200
Message-ID: <CAFBinCCAVZzhtX2WicBPkLe93jhCM1Pci-kGZztLiFG5zoUjxQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] iio: adc: meson_saradc: Use temporary variable for
 struct device
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
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

On Fri, Jun 3, 2022 at 12:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use temporary variable for struct device to make code neater.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
