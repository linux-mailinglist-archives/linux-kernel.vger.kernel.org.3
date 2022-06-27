Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECF355DE79
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbiF0QYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiF0QYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:24:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6571EAE7E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:24:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n1so13786018wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9ZJokoMXakMIFvLaDTnIr0oqMcFY7ZRf51dGtS2NzKw=;
        b=feeC4sKGHE7611Q+VF/dI1qLSv1TW8TB6IEUb172FaXQGILpjVUaEUzdifEOwGFOCR
         2bQ5TCjXlEy5/hx5mWbltaaG2B8wr5ugFpllP8i6iOPzDtEZABXfGIP3DMXZ9FvR/5Uk
         IzwOCB1CQCzzb5tGlJyMpgotO/sW/7G0KxDhK89RhjlWPVmH/gvJrNqlX8HgN2JRh9xl
         /z3e2vhQkyYi+ROJJGuQ7bdtAh1WpsBmB05yEbqxAX17bkAAr/WfNX4gg0Lo7abcziJe
         nSu3CLjJi5jsIKf3yB1Ud2thAqk1+UXl1TBX3rZLAIOX93jlxXgehnNP/Fl4PPt9wike
         HiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9ZJokoMXakMIFvLaDTnIr0oqMcFY7ZRf51dGtS2NzKw=;
        b=EZO2x7TW7Usvrki0pxBFrL+jvxR4k/pJ4lmQowJSKMKMbKf5Zg46ytxtC6qyd5tg9R
         bG7lcJAS3BFSwNP3JmX9+LS0YAM80fQeRIDQYpfeqTZE2a/mog72mFi5cX24GowdQrK2
         6FyrNahH4wrOrpUJM6ELKwzebDykeW+OxUhRgfP9M64GT/9ZtZhnJwtP/vGkWZcAlaaL
         7cspOS686uB3spwMzaqKDi8gfL9Z7NWxryxOH48xggG4zqQjjT6GR5Pc+HhkunFpS4B7
         DH85eBl0TDIFXnn22mxCPZInKyhEGMA/ldwKHJwrr9z1SMys+p0u6+K1HkCHYdKbloCo
         ckSA==
X-Gm-Message-State: AJIora/2m7SWL4NB4RBFWSCD+lqW9vN2fpx2Xl3YJ6+mXE7kzEMImvYf
        FnPJIPVCkILfsOUd3zr/udgiWg==
X-Google-Smtp-Source: AGRyM1uZ9qNp8zEkPoKpJGNx/hE5miAeiNLVcPpeva+u+qwk34ucCb4LUGHAkEV7oJ9n/6hP9pxjxQ==
X-Received: by 2002:a5d:5966:0:b0:21b:80b5:ecc3 with SMTP id e38-20020a5d5966000000b0021b80b5ecc3mr12913127wri.130.1656347044005;
        Mon, 27 Jun 2022 09:24:04 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l16-20020adffe90000000b0021b9a4a75e2sm10887612wrr.30.2022.06.27.09.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:24:03 -0700 (PDT)
Date:   Mon, 27 Jun 2022 17:24:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mfd: axp20x: Add AXP221/AXP223/AXP809 GPIO cells
Message-ID: <YrnZof9lwsIQCqu7@google.com>
References: <20220616060915.48325-1-samuel@sholland.org>
 <20220616060915.48325-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616060915.48325-3-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022, Samuel Holland wrote:

> These PMICs all contain a compatible GPIO controller.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/mfd/axp20x.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
