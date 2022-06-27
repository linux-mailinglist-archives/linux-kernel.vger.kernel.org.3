Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337B055DE18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbiF0N0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiF0N0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:26:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF79263D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:26:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso2089450wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hnl3RtifgFt0AfUQxWxZ3pj4jK/IHli6xgw21jvHAjs=;
        b=TSZdRNRqLKxI9iDG+ce7yqP/1qEhab82rGSxNl8y+6UpKYiWUfFNmDqqT/JemDK6fb
         QxIX2+Vgr0zLoQj6Q15Ik7L3S4D8yT85P4SN+GHPwbcemutGjWOZinuHB253uc1UaHPQ
         7u1AvhkLc+E5UyYRICWFOAU3kAOZO0lTWXMq1gpGD112mxP07kHDddMc2Q+LKLVof1Z+
         Q/+IxSa7xo4xD875/zvXP60usHeQM9upb50yqDoSNp6jXr7MRmJDj+OhCCZgbxV6qeea
         d8n/K63dluw6Q7SWqWRwrwuXlw+XyJYDDHXKYZ/UcyoFnrWnouhAaVcebRJQRo4znFuV
         ed9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hnl3RtifgFt0AfUQxWxZ3pj4jK/IHli6xgw21jvHAjs=;
        b=UW0ifRKE2NgqfJU7oOklJtVzZg6vgYn1c3txpkfj4494zailbuYjZkfwSKhxrZwxDj
         Na4dP0phx7+cVEaksSZxWwI2MUbvNSOp18K9vgzOcsTGq4qxpghpf+Kh9UtuULCfArBl
         DYC54jY1C7g1oOAmk0PVsUNT38AvYwC6zqB9WGGnoe5/3tCIDUkIRGLw/M9XJKDwZdyf
         HsZOx0dRU/a7if7hGe8MKN2x+MR/mwMiGxL3EpH8vdmv49XieL0EDJ2VMmGMFC8FehKB
         lRzIXBQhVtpLvrOtn1ELOZkM8ZIdzqpWCVGE7TsXvTA/VEMe78tKSSs2jFFm2IvroatC
         Y8WQ==
X-Gm-Message-State: AJIora/aOC6oop/kEvd/JNZG+t5UQXtBQx28oanNOebYfbSH4GnqGi1g
        9MQOMfgQdwa+IIP5uYiN/6oMDA==
X-Google-Smtp-Source: AGRyM1smyXisJsjStEHPSXWnStZCupB1MA3J7LqiVG3rmsnM3QhnJa93R0dIqvbq0cd6hI4frBdGpw==
X-Received: by 2002:a05:600c:a18a:b0:3a0:2978:30d2 with SMTP id id10-20020a05600ca18a00b003a0297830d2mr15255804wmb.173.1656336370358;
        Mon, 27 Jun 2022 06:26:10 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c130-20020a1c3588000000b0039c454067ddsm13299601wma.15.2022.06.27.06.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:26:09 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:26:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 4/9] mfd: intel_soc_pmic_crc: Convert to use
 i2c_get/set_clientdata()
Message-ID: <Yrmv8FFX62QZAUh+@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <20220616182524.7956-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616182524.7956-4-andriy.shevchenko@linux.intel.com>
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

> We have the specific helpers for I2C device to set and get its driver data.
> Convert driver to use them instead of open coded variants.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
