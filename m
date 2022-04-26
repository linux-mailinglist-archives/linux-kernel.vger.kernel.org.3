Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E27510ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355142AbiDZUuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355103AbiDZUuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:50:20 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742AE4CD7E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:47:11 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id a10so22024826oif.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QzB3Bdi4TZ2Nws2HCQQhwkIjzXxft3C3e6a003vLbvE=;
        b=vvdly9VcW+FAd/BRUYEN8pLSa18CiNt5rOAYy02F79PncC/cyELUr+kTRLEVjoCkGa
         k9KSZCcXnphk9wvuD4zWOPN4X9m9maHjKdcZ9ip7EL4paaEKbK2y+b+ELiNGUcJT8Fge
         7u6HxblMgLQ2RHnGNu7+9GQcJsO06eb9PaEeGnFlug6AXrG9Kw1g2fFN65GQFMIVfPuX
         sK2XxmONL1F5NzcNC1epk4czsWVBA4KNxAPTKwHdrc5WlBBJnz1wb3dwNtJZSVSN1s65
         FKNrAfb0hgm428AFl6BDNWA0EXOwTIj2GkGKx6gEcztMfaCrr+2CG3fFcDS0C9w/b9xB
         YtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QzB3Bdi4TZ2Nws2HCQQhwkIjzXxft3C3e6a003vLbvE=;
        b=bZPWp+M09qVT3eTHkKiEbE+zmt14Cu2uBGfMD96Q2I1H3dJhi9ZFOtE0J6An/GWDkT
         Mjrpl4Ul92/D1klEZ+sQwo/GkjAGypfAE+1O1jkCA7XBhKLREHZKDorsLoG5cN203VzK
         W1dzs9JWl2itPUjS+dz0Qd6VzFoDNWRqL+14nXHX89RD/D69tJRllm052y9dsUxL+8/C
         vSIl5+mHyw2v/3eYhPZY9uk3PSB5mRqZwMrgw1olwVLLBHS/hJb/q2Lwck6BBXIuL8xv
         AVgWbDQjtKyDREa18Fc8Nol/Jq8jmFPaOEdExlDEkT/SRdq5ptJzXAWGatDfsnlrh6Ho
         ufBg==
X-Gm-Message-State: AOAM532BNES8dLhhyUW+gh8PVfcfg9IDh4dCna5nNAzG2yd4JuI+fD9h
        ILFxpDA0Lczf+PbfSHhebS9urA==
X-Google-Smtp-Source: ABdhPJytkLIz0yPUD72X91npy9NSOKrvOFG9hQCViddsQAVjI6xY6tpbOieUx0/M7QRqK/nF1xwQ1w==
X-Received: by 2002:aca:1004:0:b0:322:8ac2:a1ef with SMTP id 4-20020aca1004000000b003228ac2a1efmr14892914oiq.239.1651006030834;
        Tue, 26 Apr 2022 13:47:10 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id e26-20020a056820061a00b0035e46250f56sm5331987oow.13.2022.04.26.13.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:47:09 -0700 (PDT)
Date:   Tue, 26 Apr 2022 13:49:05 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] ARM: dts: qcom: apq8064: Use generic node name
 for DMA
Message-ID: <YmhawW3wAn7HAUVC@ripper>
References: <20220421171809.32722-1-singh.kuldeep87k@gmail.com>
 <20220421171809.32722-2-singh.kuldeep87k@gmail.com>
 <YmQjW4OYe5rTBP/Q@ripper>
 <20220423180934.GA35431@9a2d8922b8f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423180934.GA35431@9a2d8922b8f1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 23 Apr 11:09 PDT 2022, Kuldeep Singh wrote:

> On Sat, Apr 23, 2022 at 09:03:39AM -0700, Bjorn Andersson wrote:
> > On Thu 21 Apr 10:18 PDT 2022, Kuldeep Singh wrote:
> > 
> > > Qcom BAM DT spec expects generic DMA controller node name as
> > > "dma-controller" to enable validations.
> > > 
> > > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > It seems that I picked up v3, but patchwork-bot didn't send out any
> > notifications.
> 
> Yes, somehow there was no notification for this series as well as geni
> uart/i2c patches also.
> 
> >
> > Please double check linux-next to confirm that we got them all sorted
> > out.
> 
> I checked dma dts patches[1] and they are in next/linux-next.
> I hope I checked the right tree, please correct me if it's wrong.
> 
> Please note, there was one small typo fix from v3->v4 in commit
> header(s/User/Use). Not sure if it's worth updating as it's already in
> next tree, upto you. Thanks!
> 

I generally never rebase my trees, as that's causing issues for anyone
references commits in my tree. So we'll have to live with this typo.

Thanks,
Bjorn
