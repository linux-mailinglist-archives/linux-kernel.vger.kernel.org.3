Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D958D4FE682
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357973AbiDLRGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357962AbiDLRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:06:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BB813E8E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:04:14 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q3so6097221plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=svCJiNYCVSTSADFJuSISCpOI75wKzQz4JEvN3pdJrsM=;
        b=I0pM3O+HVyaN+WR40sxZKPBujfPiS3TYbtroP2cR9D3EyonmrVjWLo+lFmCjjMF/C9
         cKC95ZxJ5Wrj7D8YYDHGFUDvGV5CqSfJIeyJZp4xia9AH0fNss/9hGUjx3Dc5k/kk+NI
         SK55KI1P+NrSthu6nAnBYzB/AAGQORsGEG9JNxBoBlmcVXq8WOOypF/3nfo1RTjKbfAK
         3wkiCRIRYK/PBpuqmNWFGd3fnVzQpOgfZYmS3EiJjdqvm+ZOuX4X+FXha0FXLcH2RAYv
         wEPfq51y/pCgvHdYlIvMzU1RG15mFEFWbDIbpcC1v792nKvKq9up0JlbsebYKLsxNu3N
         N77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=svCJiNYCVSTSADFJuSISCpOI75wKzQz4JEvN3pdJrsM=;
        b=xbKPpwRiH9TAI4ueDod1xqu+lTqa/kV+2wzK9ByNET6hxEi2aZDij1qZABEdrC/gyv
         Q80eZMgp+yvDIJePYvCdMDOToh3Vi3EeXx2gqTmbGJQc2O2FZUKaBUKgOTjcK9biZiXW
         9MRw3duMB2Jyso1o3B16RVSIQawjw5mAIJWDpp/E4qm0ax0lPRM1nBzurXBmDhYEUeqL
         0wYgPriVp4pnf22M9CtXZ00L8cIo2IMThkKzAl+bAB9SA9L3oDfzdIJWT8d1q0RoNnJ3
         SMP/VWzVnTDdcgHKNTvtXouX2pL01icXJp6xuvTfwh++m5i9Ziwn59er2GkugUwoGsNe
         efng==
X-Gm-Message-State: AOAM530tw5Bk4zDiIeawj4iOdsiN79iiag9q5xl5hQK6+80Gju0RrPFQ
        3zQTKF59E7E5FlqB6LBchLjUEavbwihrlw==
X-Google-Smtp-Source: ABdhPJxED4y9fHEAFYCWz2UyU0Yj+9pcsOz0knbV4/SXxH9hKezQCW0Zl7/FRRX8+OwqcltokcmuJw==
X-Received: by 2002:a17:90b:19d0:b0:1cb:7ef1:d915 with SMTP id nm16-20020a17090b19d000b001cb7ef1d915mr6130873pjb.16.1649783053717;
        Tue, 12 Apr 2022 10:04:13 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k92-20020a17090a4ce500b001ca69b5c034sm49060pjh.46.2022.04.12.10.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 10:04:12 -0700 (PDT)
Date:   Tue, 12 Apr 2022 11:04:10 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] remoteproc: mtk_scp: Fix a potential double free
Message-ID: <20220412170410.GA465495@p14s>
References: <1d15023b4afb94591435c48482fe1276411b9a07.1648981531.git.christophe.jaillet@wanadoo.fr>
 <34c30f7c-70e2-dc95-a664-9379f91f5aed@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34c30f7c-70e2-dc95-a664-9379f91f5aed@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 10:55:52AM +0200, AngeloGioacchino Del Regno wrote:
> Il 09/04/22 08:27, Christophe JAILLET ha scritto:
> > 'scp->rproc' is allocated using devm_rproc_alloc(), so there is no need
> > to free it explicitly in the remove function.
> > 
> > Fixes: c1407ac1099a ("remoteproc: mtk_scp: Use devm variant of rproc_alloc()")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied.

Thanks,
Mathieu

> 
> 
