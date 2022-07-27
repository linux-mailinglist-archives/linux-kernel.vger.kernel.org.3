Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6E0582931
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbiG0PBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiG0PBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:01:09 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBE01400F;
        Wed, 27 Jul 2022 08:01:07 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id l24so13735995ion.13;
        Wed, 27 Jul 2022 08:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y157E2oBzytod4TkQTrmvICZzHXXfTxGVqyEjL5k05w=;
        b=EnB3deOLK4+AxS41IK/jQxEbb12nPIAhGAwnPFaqaYQlmR3EX5kA8UrpQ5Ita+Ff6o
         xhwei85q1aa5XQ6M/XD6E2dakrZz2VWyFp0JS71mbev2WrcmM7j52UggRnxeFfRpZ7qz
         bmExkxvhVqTeq4fvLkf6zVXQjmFC3w+lLh0y0bNYHvoXr+2SXrrapWVY+R7LnXMb63VS
         ivIvorMQ8s/alNvp6jgxlwRvb5xt+z0KDUSe1161n38YtIlfNWYnO8vaZUg9y8nk7JN7
         aBV9fLeT+Mu8JEcH9aiQ4TQg5C9yXWY6O0ulz32Z0DMxvzFaOEWqzdreQKX2gD26tUZS
         g6Tw==
X-Gm-Message-State: AJIora8ozm5ouhjpfFNAtI2bmao699cRG7q0paI1HZet7/sjYg4Bv12V
        1hCuDMUD6UwHX9qUDxo5fQ==
X-Google-Smtp-Source: AGRyM1sQbLoIwnO35T/as0MFAgGLvk4AneC4Ef/FuzpONzzM/so0vzFvPyMhtYGk2wAaHixa1ATWYA==
X-Received: by 2002:a05:6602:2acc:b0:67c:4fd3:f659 with SMTP id m12-20020a0566022acc00b0067c4fd3f659mr7756908iov.186.1658934066202;
        Wed, 27 Jul 2022 08:01:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f10-20020a92cb4a000000b002dd028f5ef5sm6945764ilq.38.2022.07.27.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 08:01:05 -0700 (PDT)
Received: (nullmailer pid 2658834 invoked by uid 1000);
        Wed, 27 Jul 2022 15:01:04 -0000
Date:   Wed, 27 Jul 2022 09:01:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     ulf.hansson@linaro.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        bhupesh.linux@gmail.com, agross@kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: Fix 'operating-points-v2
 was unexpected' issue
Message-ID: <20220727150104.GA2658777-robh@kernel.org>
References: <20220725202709.2861789-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725202709.2861789-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 01:57:09 +0530, Bhupesh Sharma wrote:
> As Rob reported in [1], there is one more issue present
> in the 'sdhci-msm' dt-binding which shows up when a fix for
> 'unevaluatedProperties' handling is applied:
> 
>  Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb:
>   mmc@8804000: Unevaluated properties are not allowed
>    ('operating-points-v2' was unexpected)
> 
> Fix the same.
> 
> [1]. https://lore.kernel.org/lkml/20220514220116.1008254-1-bhupesh.sharma@linaro.org/
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  - Rebased on linux-next/master.
> 
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
