Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ACD471AC6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 15:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhLLObl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 09:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhLLObj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 09:31:39 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79111C061714;
        Sun, 12 Dec 2021 06:31:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id e24so734269lfc.0;
        Sun, 12 Dec 2021 06:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VBxOttOanXQi8+gUOe1aPRf28WeiRgO0+KmnpkQpZ9s=;
        b=goi0nVevc1lmZp2gJ4gpKszQiyxv8QQKnbF23lOAZQNVSUJg6E7Y1Yy/odw1kkO7GA
         6o6voSIx5T7S+vdJl1i+dNJVXFRXigMwons9NIewnx+uRkC0sZyAFygobaOLqaELcMMq
         wicFr+vr4OZ+N5r7bHkkbcH6TMhPdoc4MmRWjWCCc03QHNyFHQd3Doyf1O5EoA5bjQb9
         7VvcfzFCYaplcE6m7+WsF8NVIPSSgr5TYkNAddOjMuv2jTTWPk9eGXVubv80jnukflZl
         i2pH/RLuno1+oG9nrzn5Ar4pW3T6L4JVu9TnNfcPDjYBIA6vNqzbAVwFVhgQH/VFiQUt
         qmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VBxOttOanXQi8+gUOe1aPRf28WeiRgO0+KmnpkQpZ9s=;
        b=GqSfBen4ZnJv3GLxFHZHcyNMDVN7bOD5npnUycdVMz6kwFaeivgJOy67R60/H4tcxQ
         f3llPRbw7zujwKpU5gPZiYm15FjnVjBoRwNqe1LK+V3wE2LcoRhpOZBO8N5mIqgcjePR
         NYWlFQGrNVNMgVAvSthJwYUidqdnWa0dsHUS39ugPkBNpcjt5n9uew1VXoyH/ueX3zbr
         wkTftDA40nUrmiz8chuXxJNiTx2Q0zyD1F9Bi6Nt+sz2jeYPFsUMefDB2eLuH8gFv3nI
         Uu6nS0jBjmm8kZNKysp84i7sRKv/mAe6ptp1b3z4pJLXqVFnQH6UxDJ5wPhEa93k7kXt
         LIDA==
X-Gm-Message-State: AOAM533qriq3isDrdTarzeyIH4b+pWnPX+UES+g2um8AL3L1sZYWo2w6
        S2Rsxu9mhLB0a97VwLWVK194DcLHq5M=
X-Google-Smtp-Source: ABdhPJx975a/nLjNoGRL+73F5WkY/HOAQXv1b/iHWAdCDWGX4R3ePRLX6RiBQax3wzLUJJYbxReR6w==
X-Received: by 2002:a05:6512:110c:: with SMTP id l12mr23746178lfg.224.1639319496636;
        Sun, 12 Dec 2021 06:31:36 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id v10sm1054752ljp.125.2021.12.12.06.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 06:31:36 -0800 (PST)
Subject: Re: [PATCH] phy: tegra: xusb: Fix NULL vs IS_ERR_OR_NULL checking
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     JC Kuo <jckuo@nvidia.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211212065014.31660-1-linmq006@gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <942f943c-9ec8-9887-aa6d-4d133821beca@gmail.com>
Date:   Sun, 12 Dec 2021 17:31:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211212065014.31660-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.12.2021 09:50, Miaoqian Lin пишет:
> The tegra_xusb_find_port_node() function may return error pointer when
> kasprintf() return NULL. Using IS_ERR_OR_NULL to check the return value
> of tegra_xusb_find_port_node() to catch this.
> 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/phy/tegra/xusb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Instead of changing the 6 lines and making code less readable, you could
change a single line.

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 963de5913e50..aa5237eacd29 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -455,7 +455,7 @@ tegra_xusb_find_port_node(struct tegra_xusb_padctl
*padctl, const char *type,
        name = kasprintf(GFP_KERNEL, "%s-%u", type, index);
        if (!name) {
                of_node_put(ports);
-               return ERR_PTR(-ENOMEM);
+               return NULL;
        }
        np = of_get_child_by_name(ports, name);
        kfree(name);
