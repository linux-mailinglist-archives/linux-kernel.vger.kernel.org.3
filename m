Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB594F6CEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbiDFVjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238667AbiDFVjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:39:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C236813F00
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:16:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u14so3761986pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 14:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tJyA8Psl3YHMPqRVK9xE2ZJSKTmC/2/5ZzNk4f8mImo=;
        b=Bl0mLNt+vWjiKOe66L4+QBLhF2XVQ6jtKWOoPUdu1zRU48S2QnOdJF7cVgpslyEtoS
         0NBNzuSwCaREZJ9nt0h9xV0pRTIKhb3B5qQiOVvluwtnIv5yLUx8T3jRxFTX63SdEqKF
         LMpGbdoO5VSu0NDV3yun66sPc2uQ9scmBchZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tJyA8Psl3YHMPqRVK9xE2ZJSKTmC/2/5ZzNk4f8mImo=;
        b=0/L91plymPgivcbfxCHuClf3YNWnGblifVr+Z3wnjVF+CMoEbfiAQ4r7HwYijyaqZs
         cbqUl7KA8QOp14lC4RSruPLtXD4LvqFWsrh6+4TVsAQUM4V2FZGpj7kf9VmWu6FQk1YA
         FgL3RnvQAjJ35qEnAKd3IFtMhuDLCJQeGVHcA3AtI+twxcs8UrircoJoiyMoKnQiDY46
         /i4c15zrA83IqEZlh03sWOgDzIRbalA2Bl5w41pKpNDPhPb/nG6ozejB+FWbiPthkZZN
         1utaZnqUlJU8+VMBqflKIZ/ELeNpML+zX9EnyuDfKQwCi7HBaJ5YUklGOcki/24bNEVB
         oHzQ==
X-Gm-Message-State: AOAM533P1HzT3ZUSV5C+3hom0ZhMyewU3dyraX2/pxrxZ9tQVfvR+juR
        MJl9Ic+dLGS8zm/caFH8RrHT+w==
X-Google-Smtp-Source: ABdhPJwdAJPWKqrvBsZQfH7MXUEMK0KiWte+EpNNHaFtUte3M51uejqFxyfwibKpFuzB6N4Gi4dT1w==
X-Received: by 2002:a17:902:b941:b0:14d:af72:3f23 with SMTP id h1-20020a170902b94100b0014daf723f23mr10677730pls.6.1649279771300;
        Wed, 06 Apr 2022 14:16:11 -0700 (PDT)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 207-20020a6217d8000000b004fdd5af8885sm19926585pfx.22.2022.04.06.14.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:16:10 -0700 (PDT)
Date:   Wed, 6 Apr 2022 21:16:09 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Check for EC driver
Message-ID: <Yk4DGZfpYbK8dofL@chromium.org>
References: <20220404041101.6276-1-akihiko.odaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404041101.6276-1-akihiko.odaki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akihiko,

Thanks for the patch.

On Apr 04 13:11, Akihiko Odaki wrote:
> The EC driver may not be initialized when cros_typec_probe is called,
> particulary when CONFIG_CROS_EC_CHARDEV=m.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 4bd2752c0823..7cb2e35c4ded 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -1084,6 +1084,9 @@ static int cros_typec_probe(struct platform_device *pdev)
>  	}
>  
>  	ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
> +	if (!ec_dev)
> +		return -EPROBE_DEFER;
> +

Just a quick check: are you still seeing this issue with 5.18-rc1, which
contains a null check for the parent EC device [1] ?

Thanks,

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/platform/chrome?id=ffebd90532728086007038986900426544e3df4e
