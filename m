Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4975B520180
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbiEIPua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbiEIPuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:50:18 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC62BD0EE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:46:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 7so12361528pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 08:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S/TC9bWz9I6ZMMjC6GwTNUgx4rkkWTPZ4te3Dp2zLMc=;
        b=SZJ1be/sAnEjYMdo/53l2wYcs/kxnrL/J9hVaHBWGSvaVLXUFLigG9vRzL5+WqR15s
         saWMBpWQa+MLm7Wh1s78/dIabbYBYCqmf6BLjPGqUDwKYS8nvA9zg+d1fnAxL/WfgMDe
         kzc7EzNBZt8kcxEuIh/7CVVWR5iIs2MARl0VsyaFw3IOQBdfFwvuP17Afg9JVM/st1aS
         c/kyQOHwwQ27LoF+CJucbSvIeT74hx6E3XojdSm49FZIV3Kpht5Ke679Vrz6EU2/HM/3
         JmoYjnjqQa83mYku5d4BVIOrReMw1Ov3SvMMls2H6rEvOWVD951G8fmO+dve4uSdOE6W
         YVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S/TC9bWz9I6ZMMjC6GwTNUgx4rkkWTPZ4te3Dp2zLMc=;
        b=aJk0LjDFmaONFSO2/gsEriD40/OiaVaLG/dXLpAzPssmyZIyH550AFPcyILVEKlNnf
         SDE+FzQfGLmYt5R/pFWzU5yvmkSrVwHaiFJjKeFoIVbifjgIW61TuPs67luUgHPnpRTF
         LGhX+zthZJQ8P8QmOGZmPh6dfSzjO6G6J6GvDGdsO+PZP1G0Ht8zKh4fAfunsBnK6HFT
         YPRNX7/7tA17daStODKcwpkVPuOADsn3q3gjX0DhvRJxBTCt+5aOFJxBWjyfyr0t5pgP
         0Y5xQaVoho/2yJgiaKKa1GmYtjDmrgil3Q4CsH3D4L/61F+70waC8W5TwRAWaegY3f3d
         jKcQ==
X-Gm-Message-State: AOAM533ckWGLyLfMgSufyDJT9kffVzEkcTIT0KoBER/c6W5r6WXza2kj
        /77VM/NYGCZszKxYH+OTQvV1l1r2WqwbyQ==
X-Google-Smtp-Source: ABdhPJw1QwyuH5Ll4AKBrmxCLijMpkXJ7MDKaJBO2Q5Up8ff50HdJqvQa7EWqUNVSRznv+NClcR0Jg==
X-Received: by 2002:a65:56cb:0:b0:378:82ed:d74 with SMTP id w11-20020a6556cb000000b0037882ed0d74mr13747963pgs.491.1652111180515;
        Mon, 09 May 2022 08:46:20 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709027d9200b0015edb22aba1sm7300818plm.270.2022.05.09.08.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:46:19 -0700 (PDT)
Date:   Mon, 9 May 2022 09:46:17 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 0/2] remoteproc: add i.MX93 support
Message-ID: <20220509154617.GA2969947@p14s>
References: <20220429005346.2108279-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429005346.2108279-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 08:53:44AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>  CC dt maintainers
>  Reorder compatible strings in alphabetical order in patch 1
> 
> i.MX93 features a general purpose M33 core, support in with this patchset.
> 
> Peng Fan (2):
>   dt-bindings: remoteproc: imx_rproc: support i.MX93
>   remoteproc: imx_rproc: support i.MX93
> 
>  .../bindings/remoteproc/fsl,imx-rproc.yaml    |  9 ++---
>  drivers/remoteproc/imx_rproc.c                | 33 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 4 deletions(-)

I have applied this set.

Thanks,
Mathieu

> 
> -- 
> 2.25.1
> 
