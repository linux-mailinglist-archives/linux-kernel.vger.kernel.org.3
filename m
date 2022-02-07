Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29954AC5AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386997AbiBGQae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345722AbiBGQVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:21:13 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77887C0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:21:11 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u23so1987409wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 08:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Np4LH/PHz6uNkDpTZmQ/zoxgwDp96GbmnvDa2V7nWjk=;
        b=QgufGM+1w3bsYZSJ9xlKRmy3+TsigV3ZsM/lqCkrk+2PFrRq2qAxjaRIcbaZ6XTMpd
         dHN3csVfUdJlhnr4ISuVdfwWYthqcjlVkwEKaIzb9ohnAgPPPEnUh8ZXbwWBB4FE5VTD
         v4qiUp1+V61ZK9GFt06cQBjo9kwCIXouNxnx1dWjOOpSi6rvXPFsU0oBn2JtQQ8qDYSE
         JTzdjg3Q550FQW+DQ/yUhMrzvS9yoNZmt/a2M2/z7siYRPqcfv6jjVIuNkLoSpWuQ8d/
         sOwBN4knqfQHkxWpOzloC+DeoSvsFYb63wY9gAxv2vVkHqYOCumGB9afLCGKIFbX2MJ5
         xl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Np4LH/PHz6uNkDpTZmQ/zoxgwDp96GbmnvDa2V7nWjk=;
        b=xTCqIa5jsKhPp+GyJUWfhlV/HjGWNTXqz7zGGuXbEW+2TzrAj6GsGTgJNevbCqH/EN
         m+vgcdmtSCYj3aNTMAx/LKCpdnwMcq0qBrl+ANYZ4ZyFpBXPR/t2S8wI+MkfxNLzG57s
         NiKdvxdNPpgeueoISpxu955HQ7d/tP15Z1qcr2qAFmHIo7vS3cGKUkepTIwPgsewq9YT
         A5WStzHd65xJyCHDWQV0DA6xsOpHmOUmxAyjggoT013tGRTaApZsWEs/4Lm/BRdLVcvg
         6ONCUWHZ8ZZTB3wBPF4v0P5PqoRwIsIsvTIIDuH6GWnng7q8a2gToAktwZsCbdBtHUDz
         52CA==
X-Gm-Message-State: AOAM533hl3/r6XaVpgVJijNyLxacHsZg50hBYJa/M39/EZmfVg50MYxR
        NtfCQtJxkIPhcAm2dFOyI/kY5w==
X-Google-Smtp-Source: ABdhPJx9cikXNjt/6MFPqIqkMx5U5Ng8Uv5wYgVhdvs4xghr+YQWYDB7vr7F/zL+84q9GXPE6QDA6w==
X-Received: by 2002:a5d:50c2:: with SMTP id f2mr173218wrt.694.1644250870003;
        Mon, 07 Feb 2022 08:21:10 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id k9sm9789271wrv.81.2022.02.07.08.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 08:21:09 -0800 (PST)
Date:   Mon, 7 Feb 2022 16:21:07 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Avoid open coded arithmetic in memory
 allocation
Message-ID: <20220207162107.eblu6rxyhkuyyqnf@maple.lan>
References: <bd3d74acfa58d59f6f5f81fc5a9fb409edb8d747.1644046817.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd3d74acfa58d59f6f5f81fc5a9fb409edb8d747.1644046817.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 08:40:48AM +0100, Christophe JAILLET wrote:
> kmalloc_array()/kcalloc() should be used to avoid potential overflow when
> a multiplication is needed to compute the size of the requested memory.
> 
> So turn a kzalloc()+explicit size computation into an equivalent kcalloc().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
