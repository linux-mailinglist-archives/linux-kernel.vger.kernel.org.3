Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89E34FA152
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbiDIBf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiDIBfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:35:25 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC0332B31D;
        Fri,  8 Apr 2022 18:33:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s137so6497117pgs.5;
        Fri, 08 Apr 2022 18:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hpGiOlwZfN1jegaUT8eMVHpr3PeOblVesX+ImSdkAQ8=;
        b=ZO8uMWA2fG1KLvzigIS7gvwyOWW4qmJrY01xCkqvpyycNLuBl4+flyvB8LR4X0G1kJ
         Kc4ANlBrhNkTeNFxW/IPC64X86MgSNdKLqy5Elk5gJi038DHHCrG1qksTneJBbbcRKFl
         lZkg1m513Ur2s8JKqh9D3rbw4FQe3uAXSdUogPuv0t3Sdra1xYIFQfYEW8p2gSEKYIIr
         +jXhpnJb6ksdP7ZKRolqP8a+HfFLX6/kyo909LF53GK+RYFfAD6bMkcCxlqmh2GH37AE
         2jKsAiayVBvoegnyrbIIxtihSUATgK/Px5prhbQOr4iNd1Yy6A0idTOuGectlNihxade
         VQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hpGiOlwZfN1jegaUT8eMVHpr3PeOblVesX+ImSdkAQ8=;
        b=qUF7ZQNizT0oLPXpg24nk7vIkvvzJ1hVmRVpNzqPTtVKWti15PthSidzz5sq6VCoks
         /Mng7VjtTyDCzF5/ULT7p9BPItiMEpN/ZBC8xoODHpxCwzSlD8iSGRitSJOzh6TG4wd5
         IGbqFFIVIFxHrQxeJHxc0CEpuNlDy3QbzWEwwliFWVo/R1uc1yk0IFCsAHDkfQRZPCdW
         aTW2mS0Wwpqd71DcqdkUdV0eb+KiziU0m3UPx3yYsuNNfWcjpGs16Xg31V/s5j6BmW5T
         oz4XFn++gmjbN7GQG8u3KChU8LOkCcpGCkmpPctY3mkiAcVvGMhKBNnXqFu+Gh6MjEpm
         5wXw==
X-Gm-Message-State: AOAM532C9pBlKOTE7y97ocSJDa7Ef41jmUa+seTgC4HaAQwrNuDejg9q
        R5IRq3kbpqN0JXzzqkIwjSej7gQNryk=
X-Google-Smtp-Source: ABdhPJzSYwdL/glC3XYkPSqPq+OhrFtXYnZ1z3wcjbOxxdf+2CT+t7Z/5B90wApXI59Ehu7T7Ti/Rw==
X-Received: by 2002:a05:6a00:23c1:b0:4fa:efcb:9c81 with SMTP id g1-20020a056a0023c100b004faefcb9c81mr22113232pfc.75.1649467999513;
        Fri, 08 Apr 2022 18:33:19 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:9186:332c:bcb2:4506])
        by smtp.gmail.com with ESMTPSA id d9-20020a056a00198900b004fafdb88076sm27375953pfl.117.2022.04.08.18.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 18:33:18 -0700 (PDT)
Date:   Fri, 8 Apr 2022 18:33:15 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        lv.ruyi@zte.com.cn, m.felsch@pengutronix.de,
        fengping.yu@mediatek.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: mt6779-keypad: Move iomem pointer to probe
 function
Message-ID: <YlDiW0dpZ7A41j/Z@google.com>
References: <20220406115654.115093-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406115654.115093-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 01:56:54PM +0200, AngeloGioacchino Del Regno wrote:
> The mmio base address is used for the only purpose of initializing
> regmap for this driver, hence it's not necessary to have it in the
> main driver structure, as it is used only in the probe() callback.
> Move it local to function mt6779_keypad_pdrv_probe().
> 
> This commit brings no functional changes.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thank you.

-- 
Dmitry
