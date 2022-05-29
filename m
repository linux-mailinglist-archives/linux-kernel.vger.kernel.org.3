Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4985370B8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 13:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiE2LPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 07:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiE2LPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 07:15:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01BE986C3;
        Sun, 29 May 2022 04:14:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p22so12840254lfo.10;
        Sun, 29 May 2022 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5FtteHWZGo9XZ7scso44Da3d3+hVMECLmg5cp5RvsAY=;
        b=Jv3DqjnltHSi5wiXkkj3jSTxfoxCmb9HpnfqeHUGAAnEuQPf+ixHyeNtS/qdjzdD0x
         eYlb6mAMZe1PShKaa7/QxrVXbNhrrupjAulXsNqyUZs6B+5RIE/X8eripqVTbgp20+1w
         YRg6odmSu/oZPGwzI8igNILfLyxIkMQtbFYAEgZ6aC23eeycYNCxGDCsMmj6lzllS+Ip
         5CZvvI+uGBCksVkAnNyzLzcM5URli1DDmrZPsQbcnTrJSkYTXjlAV8mDkaCrbWgmu8Mf
         z/MMBIveREAaC0lSGskaj6Alx4RMCQF59ZPbg1YQ9URT1wJ8g2tJqZS1+OryPUjAW/7B
         4RJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5FtteHWZGo9XZ7scso44Da3d3+hVMECLmg5cp5RvsAY=;
        b=N+csYAMTdsg27HkB0iXa6VbYhQN7OnsnyWF1krJXzBI7aPAdpfcU0MrjhMJQ9zUB5F
         lzCzQ9aMlvcxjBiVbqfVWypOhwmoCfIPq6rJ7+NYOPP3io0MgTaNgddHsp4Z/m1WucWY
         o6/xhIWm8wtgbuUUlaIiG9MtH+YbzjnjBVoFa1qWEM9Vb6P8c4bX3dvwni+sLB7XOrJF
         OjDRrEsZJ7ZfMlVkbLIF/egIv1wcqLLIiOy/mx0QeoAUMz2F4Lu+SYePXG4QdHS3hc9O
         LvWzoFhlfKT7XWRpwKal9jK6oX6m1BqIvp4XIIhaPXb3qe0wT/ipZGcPtqHsTZW/ZHI6
         mbWg==
X-Gm-Message-State: AOAM532Ub7JLXT7QH7nYGxfWbsqdBq3RXkxSEvl1lUOhCJ0WEmMdo+f5
        NzrpMrSj7eVRY1kkRts/KBs=
X-Google-Smtp-Source: ABdhPJzEhP78Xi4TzBQreFDbg7R8/FB1cQkOqRpNRPZgf0mrOTSHXW/wpv/2YqHXr304f1c2jGHVFA==
X-Received: by 2002:ac2:44db:0:b0:478:ae7c:ca3d with SMTP id d27-20020ac244db000000b00478ae7cca3dmr13831031lfm.571.1653822897793;
        Sun, 29 May 2022 04:14:57 -0700 (PDT)
Received: from dell.intranet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id n17-20020ac24911000000b0047255d211eesm1729897lfi.285.2022.05.29.04.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 04:14:57 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Imre Deak <imre.deak@solidboot.com>,
        Trilok Soni <soni.trilok@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] video: fbdev: omap: Add prototype for hwa742_update_window_async() to avoid build warning
Date:   Sun, 29 May 2022 13:14:56 +0200
Message-ID: <4460689.LvFx2qVVIh@dell>
In-Reply-To: <YpMXF9luBc4Sjr9h@ls3530>
References: <YpMXF9luBc4Sjr9h@ls3530>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

On Sunday, 29 May 2022 08:47:51 CEST Helge Deller wrote:
> The symbol hwa742_update_window_async() is exported, but there is no
> prototype defined for it. That's why gcc complains:
> 
> drivers-video-fbdev-omap-hwa742.c:warning:no-previous-prototype-for-hwa742_update_window_async
> 
> Add the prototype, but I wonder if we couldn't drop exporting the symbol
> instead. Since omapfb_update_window_async() is exported the same way,
> are there any users outside of the tree?

It looks like there are no non-local users of any of those two functions 
either, so we could make them static, and I'm not aware of any out of tree 
users, but let's ask more deeply involved people.  Tony, Aaro, Tomi, can 
you please confirm?

Thanks,
Janusz

> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/drivers/video/fbdev/omap/omapfb.h b/drivers/video/fbdev/omap/omapfb.h
> index d930152c289c..0c753ccbc1c0 100644
> --- a/drivers/video/fbdev/omap/omapfb.h
> +++ b/drivers/video/fbdev/omap/omapfb.h
> @@ -229,5 +229,9 @@ extern int  omapfb_update_window_async(struct fb_info *fbi,
>  				       struct omapfb_update_window *win,
>  				       void (*callback)(void *),
>  				       void *callback_data);
> +extern int  hwa742_update_window_async(struct fb_info *fbi,
> +				       struct omapfb_update_window *win,
> +				       void (*callback)(void *),
> +				       void *callback_data);
> 
>  #endif /* __OMAPFB_H */
> 




