Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119CF55D284
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiF0JHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiF0JHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:07:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75916398
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:07:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q9so12044698wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cyeQ+V4km9/2EvgWm0zwWf2s2+sPYdq3cKYPDuqN8vo=;
        b=U3ZYJY6j0N1ghCOKh8XELTLBhAnp+6ZtxmUJ4YG1d4690N58olCy46j/PuCf31FoYN
         KejM1sEBFhiyWFf62itChGtFjFyVlKQJSeCNFFNiCknD5cqu1kgxp2/Mim6XTekWJS4V
         Re7jBHo0GNm99GYaQi9G4an2kxyPz1koKZmkIr2glBYTn0LTY/o6FoOLOHN7XXJtDEZ+
         2x/RxT1NRt9jUd9a1+FHBqA+x2z2px6lt4lRLmpSLMSUkG2jofccZLtJejXzfDPp5iWL
         cKm265BR7pPyUT2suMJZdO7PCqAbnIwSWiKL0cq6vza7gJPzA0qyKOoA8AYWR4PMWIgZ
         VOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cyeQ+V4km9/2EvgWm0zwWf2s2+sPYdq3cKYPDuqN8vo=;
        b=PymoCXC20g9zPI9TtR/fzIEixX9dBsBYjlBnEvRjNljeo9rYwJPBM5kRHer2nxGQnh
         k1BYamnzpbXBJNRK3IJagl9N/4yDrHAXBS4zrYviFN66OSGo0tZ4U2VUuA0H6MP6Q8ED
         LJQOb4XFBmDmcDlREW508dcCIb/P0yNNWFzu916/MeN/h41MeHNE5ei10dyFq2kfrXRA
         9KOrKqoa+yB0DL+Yrqx1RB3MGfrIZCmDQ0Gl6Xex313LVSnTjhDrjfg4CuzA8teBHl5+
         rX78GfRZ3f7umisM/deaYXOayQKR5loZxwhiS2xv/F8Q64RMJcjUPHCCGCb4zZYggKhY
         8Pqw==
X-Gm-Message-State: AJIora/VDmeYgPC0zMoh9A6wq9mVzWcFKTGfeV2d/Lq4L53IW+Jok0Kx
        5AYgVTsHd0F3xfGfR3ayQLqaeg==
X-Google-Smtp-Source: AGRyM1vEjNzJmNf0ZakZW+p9ZZMDGY2QxvgNATu+/8z9bq3w951/HqyXdHHVl0UQUprrm/4lq6JJ3w==
X-Received: by 2002:a5d:64e2:0:b0:21b:b1ab:254e with SMTP id g2-20020a5d64e2000000b0021bb1ab254emr11005082wri.451.1656320862406;
        Mon, 27 Jun 2022 02:07:42 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r68-20020a1c2b47000000b0039c4b518df4sm15312320wmr.5.2022.06.27.02.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:07:42 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:07:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 02/11] mfd: intel_soc_pmic_bxtwc: Create sysfs
 attributes using core driver's facility
Message-ID: <YrlzXIDp8JgFfYWH@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <20220616165823.4919-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616165823.4919-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022, Andy Shevchenko wrote:

> Driver core takes care of sysfs attributes. Use this facility instead of
> doing it explicitly in ->probe() and ->remove().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
