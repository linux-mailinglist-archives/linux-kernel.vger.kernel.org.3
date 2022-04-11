Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0958A4FB245
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244503AbiDKDX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbiDKDXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:23:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E40F1A040
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:21:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bx5so13937292pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ze0ESBmwKUOHj/pycolgwWuWoCj7yCyL4oV7/1CC0gk=;
        b=r8gy3J8rMVFjQIjHPbwRym9TBFENrWtto7E2A6+AkR6eBn0JxshuknH+A3eOEMMMzL
         lxnnV/b+N11DnQiMuvrN9X4pZBBvsnzmYAB5psULHPnQBH4b1EvVRsHCjKLY0gxp7pnC
         A9rO5l939eTP1M1JBeLV8HXVS0l2026NMTfJhek+KzX14gv3hAfLot//r8hnNPMymRtw
         7L79JbnOf7w0ipcQnYVZ34fIizcZoCfiBThxkA57xn3ckdowJyWFWQOTB/x1dK4W7yv9
         VzskU/mzN7kAFrQ67Qh8QED8lZBcBQNxhHitWI1c6WWGuyaXCY2sB+wLTMaIb0Vy/3Su
         0gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ze0ESBmwKUOHj/pycolgwWuWoCj7yCyL4oV7/1CC0gk=;
        b=sSOjHuGATk1fZRYDVNl8Qz5RDhWKx48Nw7X6bxZ76G0vi+bTua2Ejze+jxu3GKLJ0U
         WYjfzaZUzt6Bi0hG0qappYqgCcePEIVs0YWhw8nH2DdjlDS1yEo0JvOMv76uxsK9H7DL
         FkbEUs3iKOON6D9Sz6IrfVWESRskQk89h0QaH4tnkj5pNDyFFhAz23iAqRo3BbK2wtYm
         B19NvCC0PFc8wP1sqNySHUTB5nt8IHw0uOwnnAr8+QeX6xDlwZnswyZIlP9PZmXVynvc
         TOiiM2gNCw+CXS1Ab47G3oh4FdOUcsY1OllZp7f6act+hRk8BJhIV5A9gCvQdlqpquiA
         pjmg==
X-Gm-Message-State: AOAM533112qDrZTz3l26+baaXGXbOO8eRORul5kTh4er3dOgLZ+1UMDd
        3LxD0OKKqxBBmNPbg1hHCknv2Q==
X-Google-Smtp-Source: ABdhPJzWfdSEYf47igK96LjdYnx9LWMRrxKFmfQEzCgnRi1hvZjIBDq7xUULOljhycVBX/LD3Gzhpw==
X-Received: by 2002:a17:90b:4f43:b0:1c7:552b:7553 with SMTP id pj3-20020a17090b4f4300b001c7552b7553mr34412395pjb.117.1649647272653;
        Sun, 10 Apr 2022 20:21:12 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id w187-20020a6230c4000000b00505cde77826sm337396pfw.159.2022.04.10.20.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:21:11 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:51:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
        jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V2 04/15] cpufreq: mediatek: Remove unused headers
Message-ID: <20220411032110.tgk74h6vciix4eof@vireshk-i7>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-5-rex-bc.chen@mediatek.com>
 <13c1bee4-f9c0-2ca3-1f6c-ee60f090bef2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13c1bee4-f9c0-2ca3-1f6c-ee60f090bef2@collabora.com>
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

On 08-04-22, 15:36, AngeloGioacchino Del Regno wrote:
> Il 08/04/22 06:58, Rex-BC Chen ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > Remove unused headers.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied. Thanks.

-- 
viresh
