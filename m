Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B734F9E3D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiDHUe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbiDHUez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:34:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27BF3A1B2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:32:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id c2so8709383pga.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=/KqnrdwGzlf8oEa0IfTyQSFrKPtPSsWbAmTKt3bSBaw=;
        b=bSYtEQV1SVOIaMYMd8qMkOclqEVBABfaNJlBzEMuOT07Jj6QOZBwk67GOGexYFR84m
         ndUhCgL1deArCVZGdwjeqJzf8sQTr8MRRwF2SOxL+hALaDyFAyDuBiF4MWTp4nPycDbo
         Ry1rpQkerNLg2JQQ3a9isIbV9drUt3IkbdStl9geLCm6aU84Z4GPBY/8gft5IL6+09EF
         KSvsrzYOc6JobpCyz/IEPAq3VVxQ6gpejTEgxSLKTbj7j5BGbXdirX9IhS3ShGW9sfG3
         SQrRtEXLmcbciHcoBkGvrJiR9/QGJpe6ByS0EoBU0s4fUG1bP5qw5+/GS/pw4oqE2k3/
         fvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/KqnrdwGzlf8oEa0IfTyQSFrKPtPSsWbAmTKt3bSBaw=;
        b=DWk+tLi6DZklxD81ztVCZkNAR8ozAnT6aG4h022jsJDfhZAdIIYQkWxrIzXDWPK7Tc
         gtAu82mNiST5QWw/6mHhyBiSoYu0czhalPJ9GijduEnFJJcmz54jeLjSM/dCILLOC6QX
         DQvtIHCxi2YLNm4A2dlEO/v+pO3bOdItYN7tKgBnwrtSkldvRtcmFLzOoY0LC+OYmDTl
         iAlqeGTtlYokvu3GvQ1XXvec9He6PEgEEGo8TanKqZXOTlTmrL+yk+83XK1MDqFJKSn7
         5Uy8DXOnI7y6LDryUGGZh7x9v9qGIaoVaWKRtf5Q+zExifc/kvuEmDWG+n4MFB24qlqC
         nYsg==
X-Gm-Message-State: AOAM533Ckckcx9Ff4vd32HDDp0WKfzQ82pEGNjmQZj9gOuLpthTf4NdT
        HIKJTofwhsfL6VNX2d4+J+AnYw==
X-Google-Smtp-Source: ABdhPJw94bMJVltpaabJ4ZxqAt+yzYzf77Fd6sm1altDdMxSl7h9RT/pzr2JplWj0K9ai+ylxhumng==
X-Received: by 2002:a63:214c:0:b0:381:1a27:fe1 with SMTP id s12-20020a63214c000000b003811a270fe1mr16619582pgm.328.1649449965655;
        Fri, 08 Apr 2022 13:32:45 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id k92-20020a17090a4ce500b001ca69b5c034sm12627141pjh.46.2022.04.08.13.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 13:32:45 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V2 10/15] cpufreq: mediatek: Make sram regulator optional
In-Reply-To: <20220408045908.21671-11-rex-bc.chen@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-11-rex-bc.chen@mediatek.com>
Date:   Fri, 08 Apr 2022 13:32:44 -0700
Message-ID: <7ho81b5n9v.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rex-BC Chen <rex-bc.chen@mediatek.com> writes:

> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
>
> For some MediaTek SoCs, like MT8186, it's possible that the sram regulator
> is shared between CPU and CCI.
>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>

nit: missing your sign-off.

> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 9e9bce0ff235..8f688d47e64b 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -435,7 +435,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  	}
>  
>  	/* Both presence and absence of sram regulator are valid cases. */
> -	info->sram_reg = regulator_get_exclusive(cpu_dev, "sram");
> +	info->sram_reg = regulator_get_optional(cpu_dev, "sram");

The changelog says that this regulator may be shared with CCI, so I
understand it's no longer exclusive.  But here you make it optional,
which should be explained in the changelog.  If it's not actually
optional, then it should just be normal "get".

Kevin
