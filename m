Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DED484643
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiADQxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiADQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:53:38 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234F6C061792
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 08:53:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c3so14268044pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 08:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TR6Cu/+uQ4xcHjIjGjwETyTTXPP8JtD9qNRslKv4f/0=;
        b=vdNlWBcvqr9GUl+R/98nLAfw+u2Ra7et3aeVbTuhljHhbWNXb/s8lAH+uTP42OEn/H
         yQqDdCP0YOdOP5+E2C+CcEn1H/ZTblFPmHWi5s9OBOVRuovSqWSr5uJoXCj5QKOOaP+8
         i7qj+yUKwyIE6VCEkdX4bd9x+umWGTC2L9MFOnW2+zFTmhyB3sJo9pvepSFVu+rj2AM6
         c/O6OmReomp0ml51dLGKbjP+o+T7HgKM82v6Gt0IFiCh0ibmhPFnwybrDDRwylRwfrBQ
         gdJa+IhfhI779z8IWuu9x+6tJqXXTEdLJUvfFrcWEzvkpdsYCZPNINHR1RG5zfnSqCzn
         b2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TR6Cu/+uQ4xcHjIjGjwETyTTXPP8JtD9qNRslKv4f/0=;
        b=iplUIshX8a3MkQ+fKBBJDOWHc05tK8cYTqsKZ5hXYfXSNWIfJqDzAdCJrjPE3E1NPh
         P4kEANB8aj/Fng6MDiBjJE6DEO1067ew7orIb65DV3QA2TATJ3HwDSqvl5HmhT+KzUB4
         K7taOBZsHy51aE7aUd+uWl2r1PPdd4l2fNAwMnY9TAYjl88ca7Jr3at5mtoV5yxSHlEr
         9mkK31gLIYYEzwb9y3Fui2JQacjznyjQg0obTlWbk6dRl4eniD5H4N0WuIB5RtIAD3iL
         WImIZy4Pzfu76pLFizqovYrNo0S03C+2HJixj0WmQW6xGVVS6DEx657y15xMzGBV4Ltj
         /RGg==
X-Gm-Message-State: AOAM532XzkqnxWHM3jyRQyBHnVyW0ndlAg4FgzDag+/lA2gBorxx79E8
        EpRzuAMksEUzyf7/KrDDi+u2jw==
X-Google-Smtp-Source: ABdhPJxxmHvZgGCzzsPyI8u0TckTilqGSoSSh4At+XAfLQ5zRVilq2nw4Y0oNP+piBnf63zHvwW7gw==
X-Received: by 2002:a17:902:ed52:b0:148:da08:9a6 with SMTP id y18-20020a170902ed5200b00148da0809a6mr50131155plb.89.1641315217634;
        Tue, 04 Jan 2022 08:53:37 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e3sm2062480pgm.51.2022.01.04.08.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 08:53:36 -0800 (PST)
Date:   Tue, 4 Jan 2022 09:53:33 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 0/2] Add SCP support for mt8186
Message-ID: <20220104165333.GA539868@p14s>
References: <20220104114706.27461-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104114706.27461-1-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

On Tue, Jan 04, 2022 at 07:47:04PM +0800, allen-kh.cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> changes since v1:
> - use mt8192_power_on_sram() helper
> - add MT8186_SCP_L1_SRAM_PD_P1 in mtk_common.h
> - add MT8186_SCP_L1_SRAM_PD_P2 in mtk_common.h

It is quite hard to follow the evolution of this patchset.  The second revision
had a "v2" tag but this one doesn't, which can be confused with the patchset
sent on January 3rd.  Please send another one (v4) with:

1) A cover letter.
2) The right SoB.
3) The right version tag.

> 
> Based on v5.16-rc8

This should be based on rproc-next[1].

Thanks,
Mathieu

https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/log/?h=rproc-next

> 
> allen-kh.cheng (2):
>   dt-bindings: remoteproc: mediatek: Add binding for mt8186 scp
>   remoteproc: mediatek: Support mt8186 scp
> 
>  .../bindings/remoteproc/mtk,scp.yaml          |  1 +
>  drivers/remoteproc/mtk_common.h               |  3 ++
>  drivers/remoteproc/mtk_scp.c                  | 35 +++++++++++++++++++
>  3 files changed, 39 insertions(+)
> 
> -- 
> 2.18.0
> 
