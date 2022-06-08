Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269685432A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241237AbiFHOdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiFHOdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:33:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8DB2348D0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:33:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o8so789640wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WG0Tg8LMw+6v7cVOptDrWGidi6Emu/7DP7YsEfxFl6U=;
        b=w5ns9byp/YevaOrUVFMpt6yWKTxidJfob2R42ggpIXdfZryqVTt3BWo/JEXVWZr1j/
         8MQNNoSDO31sJw5ZxAGkWLRTguwolkAR3GkglPLBkfmQicHsLq0mpDWMII4t1rzJpDSJ
         1qHXNvuzp6rjxNOWug5lHVQ1Il0O3D1ScFGdxV1xsT2LMfxiK259cV7VikZuqUCgPH4Y
         abglkbFh7NIHE458XQ+pUluGsmU1Zvwx68tYsCfUfH4jlgyCZa/rIEjXR31fayXJJLKS
         imGwHjwGsoi0YKCMsil6mG/1USLI9QpcLwjnixUtFthbfRihxmZjOD7OcuAzV4fAmJI9
         /Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WG0Tg8LMw+6v7cVOptDrWGidi6Emu/7DP7YsEfxFl6U=;
        b=WA5NAAUOuQ0GbD96Re4nJwrJnjoJW+bzXfADZrZPyNNok/4dp9+sTyITKghuVEAd3X
         XoZDWSEFUmlvDBCCjBiXT0chbKdaEjAIKvYMoCj4SyoqPL9eRf0E9SE9cwJKaAYEZwLs
         zpAZdIXR0V/3HDNQ04Mj+WqVBr4gYPUWbz1Z/ihN/TGY565KvZTAr5JE4qma26V9eDEk
         8zX5j/kfiHNJum2rQLWkeHgTz2K3GqOyCpPLTOioiyBuABSo3C85Xk0EePewzD6f3Fve
         /PRW3IwpLvdjnxw5P0LID1m9L/gZO6as0hqfDXqt+yrH7sgDW2syOKjGOZg8QS4s/Zh7
         Nzcg==
X-Gm-Message-State: AOAM530MVw/06hSmzIHE/MVZKXjZSheE1+vboNk61vGNLzOW5g1G711b
        zJwOuNlj3x0hL4kK0Bo46uraBg==
X-Google-Smtp-Source: ABdhPJxvKQxEHFDay/r4QAKbU2kqfhMU+/AqDh0VaknrdyOg+5OV5Q/qtMdENt7I/tH2UsYyr2+h+A==
X-Received: by 2002:a5d:5410:0:b0:218:5b98:425 with SMTP id g16-20020a5d5410000000b002185b980425mr4976962wrv.243.1654698818607;
        Wed, 08 Jun 2022 07:33:38 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d62c7000000b0020fe86d340fsm21422134wrv.55.2022.06.08.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:33:38 -0700 (PDT)
Date:   Wed, 8 Jun 2022 15:33:36 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] backlight: arcxcnn: Use backlight helper
Message-ID: <20220608143336.duk2g75jjnwxxa2g@maple.lan>
References: <20220607190925.1134737-1-steve@sk2.org>
 <20220607190925.1134737-3-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607190925.1134737-3-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:09:23PM +0200, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
