Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7290E58CBD7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243856AbiHHQJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiHHQJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:09:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F3395A2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:09:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h13so11440890wrf.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=1j1W+jwjlydXylfAN7wpF5bOMiQax+aF2MTXqW4pg5s=;
        b=qNejLJRiDTNpCdVsOFHfCf/GLSlCuHt9wSCUA7uysQ/2lXSuWeMMXfEkLYXtMaGV3q
         QUmyO8ST6N5MjszBXQGDQsnanTjsge5x23GsWPkLac1oEmQX3JYNAnhVtpFtdACbw0/r
         bqCWaVTEgmyakZBQ+425zTFB3tlTaEvrU0rwPD0XTqn+fc9uGpoQMgrugRhUUun4/GJt
         dh9oq8CzpHV6wEpz6VGTMYJZlHhGZNXCNUJfhiMNZg9eQxkfC8SZBrlq0ogds8WSbmiu
         qkGBhu4tpIZTFU93ubzWE3b+Sr4LBUsnzQ7uJ+thc9hTY5hUDXBoySyLL6GjbffMxIHD
         G2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1j1W+jwjlydXylfAN7wpF5bOMiQax+aF2MTXqW4pg5s=;
        b=QAD8gQwh+JhdllPnBzW5B0dEbGim0m244pvQAjk9nZ4RBPR/PbkEAwdwqlbRpgUapO
         SikedaYXuabU+WX/9wdT+ieHbeDC7+GyKNUFbu9pNHS0Po67/pa2YDExKLCoHDndIChm
         A/lK5s34ORMgRJtUCkQ+0PG9jBjPJpJDTKcta05GSB5UnTPipNTYW0YGIUynI3gU0JrG
         EOkgso9rhSS5A/N3Im8sN5SqWErNpIgfBH6x1KWvvyENYscEUTFqg/+PmEZ3QaRwQNpi
         84aZLoUoXqs7QqmBts2bHLfFOGSvvDb/2rGOAK2TZ9QFxTMfadVtpVYQY73vIJ9uQwhh
         C4mA==
X-Gm-Message-State: ACgBeo1MpmdJThrAGSCeL9IyMdfiW1wt0T7KI3/zFeQqgL4tFIT9AA9y
        TRAElMn6yIg3ZvZtLXlqlIEPww==
X-Google-Smtp-Source: AA6agR7+clLNvmARTUi1eYzg5BQ+RkCedYI9Cl3aVyX1SjWyU2NWzZ79gjS/vTOTHa1B0bWaLsGMXw==
X-Received: by 2002:a05:6000:1283:b0:21f:168f:4796 with SMTP id f3-20020a056000128300b0021f168f4796mr12633402wrx.615.1659974950110;
        Mon, 08 Aug 2022 09:09:10 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b003a3199c243bsm26058217wmq.0.2022.08.08.09.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:09:09 -0700 (PDT)
Date:   Mon, 8 Aug 2022 17:09:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 01/10] mfd: intel_soc_pmic: Fix an error handling path
 in intel_soc_pmic_i2c_probe()
Message-ID: <YvE1JPtSxGOT/21d@google.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Aug 2022, Andy Shevchenko wrote:

> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> The commit in Fixes: has added a pwm_add_table() call in the probe() and
> a pwm_remove_table() call in the remove(), but forget to update the error
> handling path of the probe.
> 
> Add the missing pwm_remove_table() call.
> 
> Fixes: a3aa9a93df9f ("mfd: intel_soc_pmic_core: ADD PWM lookup table for CRC PMIC based PWM")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> 
> v3: added tag (Hans)
> v2: new patch
> 
>  drivers/mfd/intel_soc_pmic_core.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
