Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DF6580631
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiGYVJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbiGYVJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:09:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765A723BF4;
        Mon, 25 Jul 2022 14:09:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id oy13so22809934ejb.1;
        Mon, 25 Jul 2022 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IBClN82YoVpNAVGE2752fEAjd0c+qRoH9wzCzhZ21WY=;
        b=lUrT14h59TO1EL5+VgArEaGykGv5hsEVAAtVn8kcHL6KG+a3UUbH6tZWhwaAYUE3nC
         XWRXRqko6aVF6ynQmU52AfKMxQMPyqBUkl5i/Zco04o+T3o/jnBRoo4WAyuFhjUVKFkD
         AG80TnKOKPpmIj+3Eq9F+pxF/TsrW9HmLcfuFs9aUAL/uT/d8cayFFSRdPx+fGkta50c
         ZdZYAFpS4ASq9FLDQipPnkjpaX8Fy/xB51ZSeB8jmpwsQg9mOACHtxiOOyhzR9rSzFd9
         dXYyJBfh8vHhRNJho5hgjb7cxK3LRler0gZLgffrHaOmLu03VeaQm/6RxqRSNajmpsM7
         57uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IBClN82YoVpNAVGE2752fEAjd0c+qRoH9wzCzhZ21WY=;
        b=tIjX7kYkOUt2hUYX4qRyxzUTafyv//iJCcX/JtyYuaAIfxqOb3UF8x20dc23+PATUI
         jCOh5fwHvhTwXm0Des165xVPVttkTISolHPCYU+MqB5uFY1iVtGTZ/z3fTBblkfeOuXW
         WrPwv716RlGYEUlC7KGhGn5wKNfZXeGaEajJhS4+AgguwUanMuZtJhvgSLhVoLlH/IV7
         3ncvN1MhFFGreUFtakwdvHt6l49cGjbID1uPEwWEfaOE3eeh5G4tLMc9BmNyb7aTlvV+
         viLEZ9peV/xxZy1h22HUOP3b1W2wxdz8KXumMuhqcOCZfbXD0N8iiYiii//VVdXPxDmX
         J+/g==
X-Gm-Message-State: AJIora+0LX/yNS9DcYMjR5MrQK6pPLdqnYWwG7y+HHA2pBveg5jpVrYk
        e3yH0CR8mICnTFtejp9ATfPE5/QD92ZTVXk1PU/yy9+ALIE=
X-Google-Smtp-Source: AGRyM1v7KnuBD2lgD3d5rDW+rXuC/MNigLNBLDKwRSU2uWg+fuW4/htLdhSnr4ssA1zg9XJub7UbZfF0OvPBK7BmxyM=
X-Received: by 2002:a17:906:8a4a:b0:72b:5b23:3065 with SMTP id
 gx10-20020a1709068a4a00b0072b5b233065mr11815839ejc.557.1658783368009; Mon, 25
 Jul 2022 14:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658597501.git.ang.iglesiasg@gmail.com> <e6f4055d1c2a535e645ce6c25091dd5b40cd5a2f.1658597501.git.ang.iglesiasg@gmail.com>
In-Reply-To: <e6f4055d1c2a535e645ce6c25091dd5b40cd5a2f.1658597501.git.ang.iglesiasg@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 23:08:47 +0200
Message-ID: <CAHp75VfwhUEdpkRKNme_rVn=bxEgV+p+RK4G961oVnikB35vCA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] iio: pressure: bmp280: Fix alignment for DMA safety
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Jul 23, 2022 at 7:40 PM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>
> Adds a DMA-safe buffer to driver data struct to store raw data from sensor
>
> Updated calibration read functions to use DMA-safe buffers as well.
> In this case, as calibration data is only read at sensor initialization,
> the buffers are allocated with kmalloc and freed after being processed.

> Suggested-by: Jonathan Cameron <jic23@kernel.org>

Jonathan, maybe it's easier to fix in regmap once for all (something
like a new flag there dma_safe)? Also a side note: i2c doesn't need
that, since it has its own implementation.

P.S. Use sizeof() in regmap calls where it's appropriate.

-- 
With Best Regards,
Andy Shevchenko
