Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3669E578DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbiGRWrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbiGRWrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:47:01 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933D924BE9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:46:59 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 7so5973625ybw.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQJVTZ5v7RU+QWK7eqra9kSzzqeCgRFsqsbR5Z4AZ7o=;
        b=Df+S+nm/ultWgajStkadNGGsbckIEro6h+yfnCP5TKbUAGV71rp0DzSh00h0DIQVoZ
         hAmEubPFgIKGGZ0negc8z/BwkzMgQeRZ+GmuTya9uN/+7JL/bWhG9imVMlbEwrYH8APH
         Y1l3ZNjiciOm3+yN/I2I5dk+7EoBrnGG9yNjEog4SIDc4cwOiowpPcTZh+FtdAjRp8y9
         7e5hForPc4VGiDEaSxcm9p6PkD2ifk0y9rYE8EfRP4gdlMYwL2h0M9aY2ewQrogVSdKP
         p46zFl2GWH7tCnaZm2PmXChvs2or8zlwr2WHxlDLrn5to1crZ9CjgAplGe1qA10+PMjE
         m+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQJVTZ5v7RU+QWK7eqra9kSzzqeCgRFsqsbR5Z4AZ7o=;
        b=ARE4pEEj8BP65PGoS/g1dxP4F6NgGpTp4JxXdhcXUmXLPFBelmpmd/OEJEoAzFcod4
         Yt4MmULbdBgHFCu/Zdwkt3UvT3AS9Al1PHRTqiJpM08BbbdP7LpNWaS0tAetR1yrApll
         i5MyLWAb1p806AAKjGF9TnDbiqNFTfQWV1E98t4lgwYrrwYFcJlIi88Oc6XVwXz1qR+q
         Gz2O64CyCwFfwjea95ubaKcrQQq61ekUZBkLinkOIMGJdokWIbD6/CoKKc2KlgZNoE54
         epUsXoknQM198P4A6IbPlXL06CFp/ICtlZ+b3fBsITWFyIAjbrEskRKYcz6eLcUWfdGD
         jqcw==
X-Gm-Message-State: AJIora+mvPKpy22k1MJWp3QMN+riaxGsoJJRZoHl9jE3vay01vZ9ojIB
        WayBGhSKwhM256N9BUtz32Hz/Du2Vl8dW57GDvgrdQ==
X-Google-Smtp-Source: AGRyM1upKT8DoHK9/hAXB2LaXysZKiUfoN4DANKDn581tq3jO8SbDNPhWd7P+SCZAnhOuFhNh+wn6oxO+TSGY2m7XVA=
X-Received: by 2002:a5b:9c5:0:b0:66e:cbbf:2904 with SMTP id
 y5-20020a5b09c5000000b0066ecbbf2904mr27768238ybq.220.1658184418848; Mon, 18
 Jul 2022 15:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220718220252.16923-1-andriy.shevchenko@linux.intel.com> <20220718220252.16923-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220718220252.16923-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Jul 2022 00:46:47 +0200
Message-ID: <CACRpkda8GwRMoUY60sTLRfbJrN70hxDjzxaG=4Hqh48kUrE9kw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpio: 74xx-mmio: Check MMIO_74XX_DIR_IN flag in mmio_74xx_dir_in()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 12:02 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> It's logically better to check the IN in ->direction_input() and
> _OUT in ->direction_output().
>
> While at it, replace ternary with plain if-conditional for the sake
> of consistency with mmio_74xx_dir_out().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Yep this is better.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
