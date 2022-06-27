Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB0155D11B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiF0N0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiF0N0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:26:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B0A6409
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:26:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso2090216wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JcLz/KoCaogHgljtgcV2WlJJZTbbPdLK9jrKXjCLh74=;
        b=RE9St2/0S9RTdvvkoFDmb46XCHkUsywXCrsFArUfStd3SXFLot/9HYbQUbqWnk0uq5
         piwe39yaC6dTwdqJeY4hR29Ri/UPdLjSBV5rI2S6k1bFu17uLSXpnrz5stlkRQO3loof
         H+5Aqpkx2lx0qV6cY88AxmcbcJqgVlIOLCe+gc1Pw5jzT/4hkw2LkhZqYyj3UiYPirFW
         PwbpfW3jAF5rksmqm9tPd+QmrQ/rcna3rim3L/VGPvukEuGUaeUl3RXFUdKPKpm+FMos
         QtfE37lp5Pv2zYGD4AJE7JHE01h+idGRHOhLh0G32jjzGq29SHm4qlHzDCL4S3kgMuLg
         7OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JcLz/KoCaogHgljtgcV2WlJJZTbbPdLK9jrKXjCLh74=;
        b=kXYL+YsD2RCiYsJHhSfBpzIL5Y+e1OuE0D56Jrq2BCu39jYv7661JguA/p67jVNHfq
         as8cWSJ/QH1O5v6K7uFDeETiESCI6912zaqq0JbXn2VGpEWIb32nReArCOFm0Zo3lCu5
         13dsSN99AWG8mBfqt8EEV5Uns96H2SQiOP9egFjKlMdOQpsAuP8a7fjfHWdapOeUZJsF
         XExEtJCLjUxzDrRqAE0xIzD6KPLhifX8h4gl/0VMVFDmsFm8A4fzNgZzyz0oBNJBeP6g
         HpPku0Rn0zpMxAm9tiHh58LOdWwlZzX1eFcdbWcQxeKODj8TlqdmCifApCNzd520h4dW
         yDqg==
X-Gm-Message-State: AJIora+scUQTauQA2/HteCyX8RZZMMlMtem870KXr+WwOTyLOaHOOB6f
        5kdB1CC6v2avcrRAxsvrfjF3+LUdqUstwg==
X-Google-Smtp-Source: AGRyM1tAN9sZxItKUQdKGNLzw9zOj2/X6QC6qCn8GzppbuWC6L2JwqCUol1heOg0vyPwmdC51bfb8A==
X-Received: by 2002:a05:600c:3847:b0:39c:6a85:d20c with SMTP id s7-20020a05600c384700b0039c6a85d20cmr20488269wmr.129.1656336393717;
        Mon, 27 Jun 2022 06:26:33 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id s2-20020adfea82000000b0021b90d7b2c9sm10482567wrm.24.2022.06.27.06.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:26:33 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:26:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 5/9] mfd: intel_soc_pmic_crc: Switch from
 CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Message-ID: <YrmwBxjN9lCgS01X@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <20220616182524.7956-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616182524.7956-5-andriy.shevchenko@linux.intel.com>
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

> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_soc_pmic_crc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
