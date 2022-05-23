Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC3E531057
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiEWNJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiEWNJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:09:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260A6403C8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:09:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r9-20020a1c4409000000b00397345f2c6fso6571798wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AYt2OCenl70qBTG1bp5+SWn59EV0w49jKoa75goSWWY=;
        b=lwJAnJGfeFSUEJqjO2kTRe9MmYngeLPsGnrRB1YJ6FKTBDoyTxgsSMeeMH6nhjiTYd
         5JEmHzqnEieO3FaHgDIhLuP6MEE3Byw4zxS+4LdfLaIuXr6jmKKsHhgOcXyUkY9vQMJ9
         FpQVZ64e8Tt84kbM+SMf3Knx0AupgGyjsQD2v9/7cz5hJ/hzTjTNx+iFxrYef8cC9zYM
         0DfRIvkLLAuuMoU+EQgWiBNpOgUZPMWieKos6YXT0wzePXj+BGSYQHuF87FccwBknI/t
         zdBaTBaqTGkfvY2KFvwz0/ka6QRgQySBKm5yu+M0zLZB8mYACpWs60icZEyqcoZVqAaB
         K/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AYt2OCenl70qBTG1bp5+SWn59EV0w49jKoa75goSWWY=;
        b=gJg7ACnpQS/57l5XHI/19qVrX2Rmu6heKWSY9QPzahW6L6nmyvslBt3E3i2mju9Piz
         SfQikJn1EN2CZmt98DkgKfC2dLK4eKeI9pGPLq9LJYuoh4JWiLTOnngofmbkEb7y/BRO
         9ZRVSWT0U2nmGzWjw2kYRU9gXK5ty6zrXO5m9QxYl0wsbBilCKkNy5PBEzGKFgYGq06k
         9Cd3rf6/AHCPrvCIvNMWnLFf8/zFcFnmgmYQWrAXy/NyZq/Pv0o/D3EwG4ot7iBnKsK8
         IsvD16xVoPZKUwFWX8grnLUXtlNqb8JwBe68DnojV5i4AnXb3+wXaxR97c1T/2UOduln
         yNaA==
X-Gm-Message-State: AOAM530VPxAjEkp0ltMgXjcEBNVXVOWyZaYDYxe1M0xcb9rG7kP5CdR5
        gD2nNjLdrZPMx3HzPfH2eQBguw==
X-Google-Smtp-Source: ABdhPJzabgOnSw9gEuS4K9M1UrtrpdHTjmbZcJTNPiDTnL8aBn5thyA1LChhkh3e0ygAQP2O8aQyeA==
X-Received: by 2002:a05:600c:384c:b0:397:404a:3ccd with SMTP id s12-20020a05600c384c00b00397404a3ccdmr10289502wmr.114.1653311342737;
        Mon, 23 May 2022 06:09:02 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id v15-20020adf8b4f000000b0020c5253d8d3sm10068750wra.31.2022.05.23.06.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:09:02 -0700 (PDT)
Date:   Mon, 23 May 2022 14:09:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     gaggery.tsai@intel.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Add support for ADL-P i2c6 and
 i2c7
Message-ID: <YouHbLLFZhgLO+N/@google.com>
References: <20220520193537.26090-1-gaggery.tsai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220520193537.26090-1-gaggery.tsai@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022, gaggery.tsai@intel.com wrote:

> From: Gaggery Tsai <gaggery.tsai@intel.com>
> 
> Added 8086:51d8 and 8086:51d9 to the intel_lpss_pci driver. They are
> Intel Alder Lake-P i2c controllers.
> 
> Signed-off-by: Gaggery Tsai <gaggery.tsai@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
