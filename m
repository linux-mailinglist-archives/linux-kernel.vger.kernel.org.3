Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166F9487103
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbiAGDH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiAGDHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:07:25 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54853C061245;
        Thu,  6 Jan 2022 19:07:25 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p14so3873613plf.3;
        Thu, 06 Jan 2022 19:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gnH114STT8YnsWgJhc87udMHHLSSILWXx2aVT6ZKp78=;
        b=IPtQgxNXXye3vrO61LkJ9uDE1W3w/2a5prtcwAumWGMDH716B3ATudCOceRiQIGvVu
         ClTCAue88GqvjnTOTM/N3WbwI+exZvo3zdgowAkAsPL2PRctIqjiFE2MI2wxVdqXE/lu
         jz+W6cpabAklUajeNsI2tBV1T9DdwN8MY5rEAACdCkgWlAUwJ06g20jKHfCbcpS31sMu
         4xls6eLfYI9MF32eqGFhLxSPzKYIV4rTpe92Sy2gMvVxvgMHmAN3t+A9xbAGix973k7P
         bqQwirW4Ec86gWbMPgV/ZEZRJFtJTV1G5h2NMNRvveodp6hGSGpHA7ohlhHMNgADWvYM
         GF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gnH114STT8YnsWgJhc87udMHHLSSILWXx2aVT6ZKp78=;
        b=JaFCEtDMon1FtjNw54cKoNXIbdHp3uNb0BS0AXGrWUTWPCVcfWgU9TJJm6Gm5iihwt
         Nvb45+KLZpDNd01DFZfVWAOQCYwnE8VuAR5W14uwY6gegrP/tupLTac/ECPtxm7pgbUm
         hUI2pS5we9weifRnwgwCxLXaz1Q7rO6ahE838rMOujwo8+LHjCqrv4v92yN0awsPeFxo
         GvEAp7JJxeWQeYa9tnaUU9GO2ZCtckyFeQlvlD1hstjFkd3nXyJ11Kesu8ILZRcsrpWF
         cyVkqT3PxHDCdlX1L7SUoMa3q0zQMy2iG3ZvA4zPHuzGIhHdAw64A6yFvTSAQdGLSWze
         hCYA==
X-Gm-Message-State: AOAM531Zn0Rywm2bmpAvGCsK2LMRszYm6C+7t2iXQkjOXY1DKYmPDyZA
        yu3td7HvCZc9oFbXLTIxW8rio2jehs/FH6B1TBo=
X-Google-Smtp-Source: ABdhPJx/0/4bNwc0VXDEcBX+xyEgn9woQacd0N8S7Y3rirlAECRGPTJF6s8/62NjceRipUETMVA0gg==
X-Received: by 2002:a17:90b:3a85:: with SMTP id om5mr13434408pjb.145.1641524844899;
        Thu, 06 Jan 2022 19:07:24 -0800 (PST)
Received: from VICKYMQLIN-NB1.localdomain ([103.172.116.195])
        by smtp.gmail.com with ESMTPSA id nk13sm3568005pjb.36.2022.01.06.19.07.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jan 2022 19:07:24 -0800 (PST)
Date:   Fri, 7 Jan 2022 11:07:19 +0800
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     vladimir.zapolskiy@linaro.org, agross@kernel.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: dwc3-qcom: Add missing
 platform_device_put() in dwc3_qcom_acpi_register_core
Message-ID: <20220107030719.GA1972@VICKYMQLIN-NB1.localdomain>
References: <83d55401-d8b3-f709-c77a-fa0e09fda27f@linaro.org>
 <20220105065517.6967-1-linmq006@gmail.com>
 <Ydb8LIgZ/xGZ/lYX@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydb8LIgZ/xGZ/lYX@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi greg k-h:
> > Fixes: 2bc02355f8ba ("usb: dwc3: qcom: Add support for booting with ACPI")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> > Changes in v2:
> > - add fixes tag.
> > - do error handling in a unified way.
> > - add necessary blank line.
> > ---
> >  drivers/usb/dwc3/dwc3-qcom.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> 
> Does not apply to my tree at all :(
> 
> Please rebase and resend.

I see the v1 of this patch has been applied to usb-next branch.
v2 has some format fixes. I am unsure should I rebase v2 on the top of usb-next?
I am afraid to introduce more inconvenience.

Regards,
Miaoqian.
