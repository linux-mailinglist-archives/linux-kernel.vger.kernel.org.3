Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4555E21F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbiF0Nji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiF0Njg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:39:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768DC263E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:39:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k22so13124477wrd.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dK6nvG1LKE7mez/Nz0K6+GD0vZ54i5HlaakVMCdDf98=;
        b=FuALRp15sWage/vPBykFawXQAmVvXHOTNUPRsOevatW0TKrYfXlSCmiIU3g5pmj5K6
         TlXHf3HmAtNG0pFookah5tZFhV9YC2CIYrIsiaNvifNqt/OiXQ1qHcdiUPPq/M++WHw8
         tcUEi0tTMxB30037EIuoKufmG8v7ozzHH85W9BPWsHKAY5oD8DHecph1aD5YyE12zn5U
         kppWEIyKJEmbOXQcomyAA0IqYEBvC5ZWXpNhg3d0/YfqVYWLe1Mpf/fb7KsKLQ+qk10k
         atoAUcTZeOpQWSkO4YXoX6GcYpo2ngN2xtBZ4sUzWs4Fa5rHwidbE9/E00Lk56cZ55s2
         YK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dK6nvG1LKE7mez/Nz0K6+GD0vZ54i5HlaakVMCdDf98=;
        b=65a9DiF8xRnZB/lyj/bZ3CLQG27HlGfzi/vjgdaR3uujI9paQhcZQqkSTdAeX385eB
         5m8QVOs1zdSHHy9gutFmTZ7ObYAaUiY9thiOsV0yq0MnW7g3axVUhCqpywauri7fUtZ5
         V07VqNjVDdo36u8vt7CTfM5Aptx17ryWyBsppvh/nA2NWMUVrHU44R7ciOA07Kmnggjy
         ASJUjVcvolwIxQVzMjituFIyDiXa1Vda9zTx3ddOLXaPhuHEI22HRLPAi6/iAGb84evY
         WYozWFe+fmshrxRt4BNuIQzDepRBwylSTdONU5O3C0oYHGeOK00x9oaTeyB7Jsc7+xj7
         Hgrw==
X-Gm-Message-State: AJIora+fOlUOmPIBi5u7FdyXbPuF0Dmv1Dq3LGTS4JL88Nv30oNJkwH9
        MNGfUd6bWwAf1ui1aZqN38BjIw==
X-Google-Smtp-Source: AGRyM1sgOSnjg396x+iG7XNw6zhcl91MfVcmZfnj8pOKIbffXbDnwMpjO1EwgHPqTHn6AL7Oz+vW1A==
X-Received: by 2002:adf:e4c9:0:b0:21b:9336:16b9 with SMTP id v9-20020adfe4c9000000b0021b933616b9mr12669479wrm.696.1656337174017;
        Mon, 27 Jun 2022 06:39:34 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g20-20020a1c4e14000000b003a02de5de80sm17344419wmh.4.2022.06.27.06.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:39:33 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:39:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 6/9] mfd: intel_soc_pmic_crc: Drop redundant
 ACPI_PTR() and ifdeffery
Message-ID: <YrmzE7OaMImfKZXB@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <20220616182524.7956-6-andriy.shevchenko@linux.intel.com>
 <YrmwKCoSP8XsEa5g@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrmwKCoSP8XsEa5g@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022, Lee Jones wrote:

> On Thu, 16 Jun 2022, Andy Shevchenko wrote:
> 
> > The driver depends on ACPI, ACPI_PTR() resolution is always the same.
> > Otherwise a compiler may produce a warning.
> > 
> > That said, the rule of thumb either ugly ifdeffery with ACPI_PTR or
> > none should be used in a driver.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/mfd/Kconfig              | 4 ++--
> >  drivers/mfd/intel_soc_pmic_crc.c | 6 ++----
> >  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> Applied, thanks.

Sorry, wrong key combo - long day:                             
                                                               
For my own reference (apply this as-is to your sign-off block):
                                                               
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>           

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
