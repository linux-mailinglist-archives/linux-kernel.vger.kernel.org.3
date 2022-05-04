Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A2519EB4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiEDMCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiEDMCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:02:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5850918B0D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:58:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s14so1195427plk.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 04:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gkcv1QpvPBRPgCr2aRkAhYilhFBiQKVHreIJFm+mm9g=;
        b=kLckMQH6fBJiqE70PoR0Fycg0urB8qU1NOckAq8yQJUTCtPjHWmsxGMpSVrt9yaVDT
         9Tti/VPIJE+996dMKlk1UqsH9LRXg5qwycGgFLI0VzgZVaglcB9+wdupWuNawF95KfzV
         Z2NweVX7HZIJR10CLXF3aqDR8ZaJxC6b2X42C9kGPkQm2LDR40w6Vg2opEAEnEJQP9fJ
         cXyhZNIFKikc+vAkH3ea8Q5CFfxxcMgZMdVLVlx7E2aUn/6vkqf/Z9OsZ2WvCl54T27K
         1uFZ4X1uuJGOBv+St5/8rVXe/G2IuBeqarfh865HEugYC/TXU69Y5zkkSNDe/a1BlYpZ
         h61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gkcv1QpvPBRPgCr2aRkAhYilhFBiQKVHreIJFm+mm9g=;
        b=dbxNjYbtMe4y6T2Mhy8zM4KJDtlQZk+mAOoVLMuiQsQ9hu5Qf9bqmedHyR6HyKEdaH
         ORiIhHR65VpOu1pySyyHmy6AU9nWlekDUf/vxCW5gjg9J1DdCwbYwOCOtwBvQK47d5ib
         NIw4cWjo36DBruawvbR003mLGAY5z6wJK+LTTZ6Eaqe2fN/p+vhVNNTD6AOI8+rQkcOP
         SGNPaoq5qTZNfVjwvEJndYu0oaMnsnM9bFMWaqG2WSeEkV1c7VCPtHS+pE8z8Eb7GZ8Q
         prW8o1jEeOXesFp/99arBT2jSUEslwXoH8Pfa6fT1JEARV34YtdFkMHaKGWKHxMBZCRl
         C1cQ==
X-Gm-Message-State: AOAM531HdDNBfMVggT5Y3je79oRVQL9/Sq5e0TVh1cl35QSIgqdf1gCD
        niMBMVLuKk6ZtMQg4yj7zyq+Rw==
X-Google-Smtp-Source: ABdhPJx1Y8Ca1NZ/5dZjBxdSqSmXQCapxMhGjnPRQy4QecF4OQuOtBaKE7gjrz72aZcN6jTYFs5pDw==
X-Received: by 2002:a17:90a:530e:b0:1db:de96:dff5 with SMTP id x14-20020a17090a530e00b001dbde96dff5mr9924965pjh.22.1651665508834;
        Wed, 04 May 2022 04:58:28 -0700 (PDT)
Received: from localhost ([122.162.207.161])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709028a8b00b0015e8d4eb297sm8134943plo.225.2022.05.04.04.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 04:58:28 -0700 (PDT)
Date:   Wed, 4 May 2022 17:28:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V4 07/14] cpufreq: mediatek: Add .get function
Message-ID: <20220504115826.5qqj22x4c7jldfxz@vireshk-i7>
References: <20220425053548.72w2jh2g6lpzgz6g@vireshk-i7>
 <64c690e8edf493ec0a4a14e0fdaad2d8e88e6da7.camel@mediatek.com>
 <20220425100058.4kbvmpi63ygni6k5@vireshk-i7>
 <078b1f9b39690da98cbd3c4528ba28374a097083.camel@mediatek.com>
 <20220427031141.or2owu5wrh2cadfo@vireshk-i7>
 <346736a339bed576817179ded3795d61f71fa06a.camel@mediatek.com>
 <20220428114835.3ktimyz2tzzqdcbg@vireshk-i7>
 <27a5dddd91b3dcbd69f08c10108cdec808237ace.camel@mediatek.com>
 <20220504082249.anrvkf2ssbxyzz5m@vireshk-i7>
 <332f8adec6601f97ab2814d06330883a251e41ec.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <332f8adec6601f97ab2814d06330883a251e41ec.camel@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-22, 19:57, Rex-BC Chen wrote:
> Thanks a lot! It helps to fix this issue.
> And I will drop this patch in the next version.

Please provide your Tested-by in that thread then, it will help.

-- 
viresh
