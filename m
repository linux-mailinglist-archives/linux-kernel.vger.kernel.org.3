Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351235047F0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 15:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiDQNyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 09:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQNyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 09:54:35 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24BE1EC76
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:51:58 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id j2so21902903ybu.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1YC+4qj0ofm4fZxd2lXKtVJb4PrA/5HBQxOtfDvFQA=;
        b=Pp2oHE+bhzP6O3Nv9ESmCrnqps2DiHpABagwyPuFmmbjq6zboHplyf9uiBC2eBXj7e
         DWiBx9atRc52M1nWs5TMi8TeP0X7EBMeHog31TxViiJME0JB10iGMtKOYP61Aq1eVI3s
         hJJweHM8tvt6t2KI8Sq3ITxRROWX8DM0ZzAtaTDse+ksFe1dYCT7rUWB02AtUHY2ItMB
         laBNFrcQYa55P2p8kFLHT/1As8FXVz/Ob69vATD2Gm+KllA+uPKQ6WhSLNg2qibSeEzf
         eaqpUYlG3rHKb4r9zy+jZLeDn1+ZiJTHRD+1yQKZ5+zdYg0ajCY6HkN/RaOXK2ks6jYm
         5kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1YC+4qj0ofm4fZxd2lXKtVJb4PrA/5HBQxOtfDvFQA=;
        b=m6HGrNSm7SrX2oXy5rJsclB2Yzstj0gWRjEpcjUO9bz2zTrYaj7hl8M/A9ohm+EOvI
         MpGOrV91BPpHK/t+fvJ2Xt0+dx3k4uFxpo0P34LQP3pPXF6yjTSmcN4pjCRLJ0XTk+gY
         UmsXIm0Sdpcw7Asl+CBgUd3TCKScaqAsm/d6TrNTi7OWY+2BIK3cd6NNl2/7KnIMuWUn
         NnwSUY/ZN9+ogGcsOXgDeFqN8sHDn3wMstubXtQOjT07YH70NHrHN5iJQXqw9vYNlamR
         7gQK8ntcqrHj5eIKy4zd/LCYTuLT03e3T+WHyoGKAFK9HxNjQdze28ierbI+0Ngu8Dbl
         qH/w==
X-Gm-Message-State: AOAM531nFT4GIxxjkjEnGmOHmW6gOIAjBzBz325IfN0QLKdAB5LTYUfg
        BewIMIVhG/NX/6nRwj15gDJeiUX52eD9ekvEgw8/zhSigqQ=
X-Google-Smtp-Source: ABdhPJzbb8iFPWriy129wK1T8jTk7tlK1sM0GemG9BO8OC56F+CZqre4jbAYLbbCjnwyLaH826YjGdVi0Rz4CNSfcO8=
X-Received: by 2002:a5b:dc5:0:b0:624:f16d:7069 with SMTP id
 t5-20020a5b0dc5000000b00624f16d7069mr6401060ybr.295.1650203518028; Sun, 17
 Apr 2022 06:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220413163004.84789-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220413163004.84789-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 17 Apr 2022 15:51:46 +0200
Message-ID: <CACRpkdaiwa4uC2qW38gwauBXmXhCwHxcHn-9nNbP=NSyd0OrTA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: gyro: mpu3050: Make use of device properties
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
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

On Wed, Apr 13, 2022 at 6:30 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>
> While at it, reuse temporary device pointer in the same function.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Too late because Jonathan is trigger happy (which is good!) but FWIW:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
