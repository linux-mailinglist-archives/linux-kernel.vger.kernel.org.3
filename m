Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE84747B86E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhLUClP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhLUClP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:41:15 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F42C061574;
        Mon, 20 Dec 2021 18:41:14 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t123so8983092pfc.13;
        Mon, 20 Dec 2021 18:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=afti1NXvSIwBw8US5gzMRH6ZikCTI5DK3ck1t2Ge/2s=;
        b=J3uv/O/S+HSTaa2LdazRFnAe5WNXJLOy6PA+B7U4tshjAacxGvSQclIlAynOcZT/CN
         CQpGZtGaQEFewu+j5wDytaXzaLG9kx4rd8rMmJMEne3uNxQzL4AP/lwekxPj3v3TFOCV
         6X+UD3Xro49FkcqML18U5jslu4oDep6EA9f400IDpalDyZLMYH7hZjfANOWHloE1fL7D
         L+7ZK6wgEnRgwbaO7KWOCgJYjoy5RkpM8K86Ci5fYIRMSDM5eWBlw7XCvqZjjr+C6BQc
         kVwROulXy2ch1EGfKBDzZeSfT+pVB4vKUjzH5G6z/uOyTgMGgePWRuspyQB9b13MujKb
         9F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=afti1NXvSIwBw8US5gzMRH6ZikCTI5DK3ck1t2Ge/2s=;
        b=6QPGFKCLtiK+nDcs1ZOhhFqvzPthBIkMwYtzKwNK+G4F8H0kn19vD2SoKWwqSpGsLA
         nK4EvdpPX7AZCjkyhFqoksxe+krceNjwchFZGA4JkW6fmY3dzceVEpCXI+Q6hOS6QqY/
         xeKbbDsuR/XDONCH8zXayeAOeuGlPUk81FbVsYWgTDFaRQ7FF+tf8/+4qh0MeutS4b5h
         E1ifuyTwyIZjbk7wAPXvZLib17ydjmxDcgVWvrPmyorMlaSU94SLLaFnu2/VwtDddDzf
         pEWaPHC7q3vqYFculKQ04b4vLnzK2C3am9PAbuI4sXakCNNp1oJrobIZ60l8GBpMMWBu
         psbQ==
X-Gm-Message-State: AOAM532r44nbFGD1oa/mub/J3WPmFX8EpjlIKw/fMUZCIvJdsBfWXGvu
        BcBT1ebCdK/UdriE09VRoI8=
X-Google-Smtp-Source: ABdhPJxbRUfeiNisUkz//f/ap0uiQ4vbYAccA0RhpZjFSVQEJMcTMzFEpu+yc6yWie1WSmLvwjtHrw==
X-Received: by 2002:a63:2b05:: with SMTP id r5mr1023137pgr.0.1640054474022;
        Mon, 20 Dec 2021 18:41:14 -0800 (PST)
Received: from google.com ([2620:15c:202:201:9632:a1c4:968a:6f66])
        by smtp.gmail.com with ESMTPSA id pc1sm718411pjb.5.2021.12.20.18.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 18:41:12 -0800 (PST)
Date:   Mon, 20 Dec 2021 18:41:10 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        linux-input@vger.kernel.org, dianders@chromium.org,
        "jingle.wu" <jingle.wu@emc.com.tw>
Subject: Re: [PATCH 2/3] Input: elan_i2c - Use PM subsystem to manage wake irq
Message-ID: <YcE+xrSnS7qw0G1/@google.com>
References: <20211220234346.2798027-1-rrangel@chromium.org>
 <20211220163823.2.Id022caf53d01112188308520915798f08a33cd3e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220163823.2.Id022caf53d01112188308520915798f08a33cd3e@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raul,

On Mon, Dec 20, 2021 at 04:43:45PM -0700, Raul E Rangel wrote:
> @@ -1368,11 +1367,13 @@ static int elan_probe(struct i2c_client *client,
>  	}
>  
>  	/*
> -	 * Systems using device tree should set up wakeup via DTS,
> +	 * Systems using device tree or ACPI should set up wakeup via DTS/ACPI,
>  	 * the rest will configure device as wakeup source by default.
>  	 */
> -	if (!dev->of_node)
> +	if (!dev->of_node && !ACPI_COMPANION(dev)) {

I think this will break our Rambis that use ACPI for enumeration but
actually lack _PRW. As far as I remember their trackpads were capable
of waking up the system.

I think we should remove this chunk completely and instead add necessary
code to drivers/platform/chrome/chrome-laptop.c (I suppose we need to
have additional member in struct acpi_peripheral to indicate whether
device needs to be configured for wakeup and then act upon it in
chromeos_laptop_adjust_client().

>  		device_init_wakeup(dev, true);
> +		dev_pm_set_wake_irq(dev, client->irq);
> +	}
>  
>  	return 0;
>  }

Thanks.

-- 
Dmitry
