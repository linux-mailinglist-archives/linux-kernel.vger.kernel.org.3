Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66819570DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiGKXIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiGKXI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:08:28 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCB788CC6;
        Mon, 11 Jul 2022 16:08:27 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id h200so6333726iof.9;
        Mon, 11 Jul 2022 16:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pvloJTubTBsx7sC/kjIEm6vN1ZbcVmo8m1zWHQoryq0=;
        b=oJpVBY37Hw9pTgUkVhRokDfqKXRQTDh8T9h/rW4Xhmuh0aGvwL5+FAYhPdrSxAtPgS
         AKFvKASMJtcIyDeHzPxGxg1NXpnsD/JVyKAl27Tudz+e2fFE0NMyJbL+T7/ugQiRmLDU
         cYb+jwIYi9seVfsGssNKLiYaftlo56KGvA7WNT97bcWWjeM+OY85UV7u6EHXd0A/VxAs
         IFXqVkbzSdhXwPO+sEh/xXiLL+ay6sGRllYMa5pexpK52XnBn9fU0w94w7DenbrU4gJe
         r3P11RoucQBtooLYAcio9jRANTNi/rjeBVWbSNIPYBKAaHG1Kb12/Pek0ZILD9mNYb12
         Ig6Q==
X-Gm-Message-State: AJIora/GWogIG8NFOHfnEzzYE3cUhyB+xhOc8pbJVH2wyxAlCkDg++aj
        M8J+mbABL5cFTZp/pyRyCA==
X-Google-Smtp-Source: AGRyM1sULjvtPhS5CNm5yDNWGLYSpg9oMeEplIoV+xcPzZO/durop56HimiZHaJEzaqk8s8+BcFvig==
X-Received: by 2002:a05:6638:1a1a:b0:33f:405d:b1ed with SMTP id cd26-20020a0566381a1a00b0033f405db1edmr7822607jab.164.1657580907256;
        Mon, 11 Jul 2022 16:08:27 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n25-20020a056638111900b0033f0589eb52sm3426348jal.2.2022.07.11.16.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 16:08:26 -0700 (PDT)
Received: (nullmailer pid 441464 invoked by uid 1000);
        Mon, 11 Jul 2022 23:08:25 -0000
Date:   Mon, 11 Jul 2022 17:08:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frank.rowand@sony.com>,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 2/2] of: unittest: make unittest_gpio_remove()
 consistent with unittest_gpio_probe()
Message-ID: <20220711230825.GA441389-robh@kernel.org>
References: <20220708214539.7254-1-andriy.shevchenko@linux.intel.com>
 <20220708214539.7254-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708214539.7254-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Jul 2022 00:45:39 +0300, Andy Shevchenko wrote:
> On the ->remove() stage the callback uses physical device node instead of one
> from GPIO chip and the variable name which is different to one used in
> unittest_gpio_probe(). Make these consistent with unittest_gpio_probe().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: no changes
>  drivers/of/unittest.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 

Applied, thanks!
