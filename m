Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FF24BF2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiBVHxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiBVHxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:53:35 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658F01390D5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 23:53:10 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso1070369wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 23:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pLXS14J792x7SSfraV/cdDPu+eF1SNjvqW3hFrRqjTg=;
        b=C9L1rX5HbVQQ7ADB9YBVHHhVZFQpdoe+c0h0CJWyM9/B6guQ+tCrFRLEM+tdg/Z4z7
         HsWmKxswEL2SBD6+rXOby4g5gmsUmd+DFknGngdS+3eOIGDeP321MPdxBRTMRnW0lAlf
         +gBaeUhIo2Ht4P0BZyzpyefXZ/jZW7zPf4OQHEL6Gr0riVZQmPvxmaqgJJLsj+uqvE6f
         FivXvY4ChqwbtgQL8CqiG5UUD2xXyWPNExXIeFrIseSAfkjgmkFDWIQ3RG284j/S8Jo1
         foSaSEerfyuPkBbItqtsL5AsPzkU3j8pMlCxgHlSGMrzUrsvQpbqG9G2Um9CQck/dwp1
         ffAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pLXS14J792x7SSfraV/cdDPu+eF1SNjvqW3hFrRqjTg=;
        b=Q6eiZCsfqDPPYMkYksasO9//EXssmqC8KzcTikGlFE2JEpWJaPw0dlvSzgHzWnQRRR
         8pS6bDbv9moKB+jDA7lOfnb4juGxtTQAOhKFEeh/eCNbWRQmMDbZbpk2poStWTaM3hLd
         W9d8lLh+zl8lwvNe+e6YpeY0hFvNszlBLQikm0ogPUf2fFaLbaqozcYLwjesCsXBsOrx
         Vrxyr15CD13a3soV1k7Unwi98VGGko/aCh3usBp0DX74dRx3XOtQ4i8pDVM/tsLHWVQr
         u6DBxYHf0waJ5rERDrYuz14TcXTYghTXp+k167MTZGDylJv3MEBx1RhIWCbODZkY8h3Y
         lHjQ==
X-Gm-Message-State: AOAM530QiufwBia53Hmf4qe3C9Q0KGTdbHIrVL3eThyDoSLq6n5LH6yG
        Ew2JVocdkuBtlGA7AP6+lKWxDg==
X-Google-Smtp-Source: ABdhPJzmofo1dS+qrwJ7d7MgVxj2byhauxZ/nxS0fFNklXwFe4ODFc31jbPf3owrSJtuQSF2bTZC8Q==
X-Received: by 2002:a05:600c:3b87:b0:37c:af2b:4f36 with SMTP id n7-20020a05600c3b8700b0037caf2b4f36mr2175046wms.132.1645516388910;
        Mon, 21 Feb 2022 23:53:08 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id t16sm2406233wrg.99.2022.02.21.23.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 23:53:08 -0800 (PST)
Date:   Tue, 22 Feb 2022 07:53:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] dt-bindings: mfd: qcom,tcsr: Document msm8953
 compatible
Message-ID: <YhSWYl2zVOKmw2Qg@google.com>
References: <20220220201909.445468-1-luca@z3ntu.xyz>
 <20220220201909.445468-2-luca@z3ntu.xyz>
 <YhNRweYMmkaSKJX7@google.com>
 <11925600.O9o76ZdvQC@g550jk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11925600.O9o76ZdvQC@g550jk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022, Luca Weiss wrote:

> Hi Lee,
> 
> On Montag, 21. Februar 2022 09:48:01 CET Lee Jones wrote:
> > On Sun, 20 Feb 2022, Luca Weiss wrote:
> > > Document the compatible for tcsr found in msm8953.
> > > 
> > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > ---
> > > Changes in v2:
> > > - no changes
> > > 
> > >  Documentation/devicetree/bindings/mfd/qcom,tcsr.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > This is already applied.
> 
> Sorry, last week you wrote[0]
> 
> [0] https://lore.kernel.org/linux-arm-msm/YgujkzAezfFBNRDP@google.com/

Yes, that's strange.

I don't remember fixing that merge conflict.

Perhaps I did.  Must have been in a good mood. :)

> > Doesn't seem to apply.
> >
> > Could you please rebase.
> 
> and it wasn't part of linux-next as of yesterday.

Tree has been updated this morning.  Should be in -next tomorrow.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
