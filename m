Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B56565862
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiGDOMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiGDOMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:12:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EF66587
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:12:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n10so8717818plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XvMKNURBZmqHrxF8QJGS8F3eP/YEjEThVZ5YkAtR3LA=;
        b=sHzLNS/B2So35b27QkvNaBk4Jn+rjZp+E9MQO9sYclG8QsVUCjcZggvFhjxs4l9+Uv
         +dgwwcTeqveqTbqd/w0YIJDEAsIgl9IT/nkHo/LyDydGZ5mGUFOuOTCqZCL02qmOikis
         +GghU0LJ2Z2kIILUoGxDWTRaD7r2uTxciVOj7jqmZkFA56W7GSl+dyHNHB5/I28UU0jt
         BDeDsiRO8hXmiib8hguNzM/mqdBni/r/HxG2Qu+3F+MoLik/r7wIUNPmfi3bRmeFCIWu
         gNTihADRcaaJsTmPagoDdrA+OtUVzOi6BpXzr2NfZ5pSaQweQtrnG/rWb634njxiCmVq
         heuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XvMKNURBZmqHrxF8QJGS8F3eP/YEjEThVZ5YkAtR3LA=;
        b=wAFxIo8KDq1Jwwqisqgfzhzc1TF5e2RRgUS6C7RIOgLKPMKX7kKuKw3x6D1JrSBc9y
         ctN37col55Uw1XgfBYCjSSFyw/zesQ63+E3OUm8zPjhB5PmzNHfTUZUC3TvFsjzq0NHJ
         oNniKwbTjjlAHIiWOuA+I7WVRWKotfoyeFsUL+9Q0L33p7Q/1MsDEj5h0VrCUk7lefJt
         37k5RI1r6mJwfPd85VHY989uXOBDV+ppyGowz9quoN6lqdVtfwNTCmVK4Co67Plxkk/c
         Q0ulSIW6sIVvrVDia+KBVG3N/faDlbca8p5tt/rujnAUMm+BFIw5mCoE1nco7eQObVQa
         Yj5w==
X-Gm-Message-State: AJIora9eRHh2b6aa38uinBajqPvhgNOZiEUDnBxgqOp+laoKZB1y2YXM
        mQzcio/1q6xKSnA1vHUaolUquw==
X-Google-Smtp-Source: AGRyM1sX+EQSZ3AJZh6255vGBLnZ8wef2aRbNcQk1qdilVus1vftYuMtYm1EkWpVflBclbuaDmSknA==
X-Received: by 2002:a17:90b:1e42:b0:1ec:f362:8488 with SMTP id pi2-20020a17090b1e4200b001ecf3628488mr36066518pjb.32.1656943942253;
        Mon, 04 Jul 2022 07:12:22 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([154.3.32.171])
        by smtp.gmail.com with ESMTPSA id n24-20020a170902969800b0016a034ae481sm21235779plp.176.2022.07.04.07.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:12:21 -0700 (PDT)
Date:   Mon, 4 Jul 2022 22:12:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: interconnect: Update property for
 icc-rpm path tag
Message-ID: <20220704141217.GA961806@leoy-ThinkPad-X240s>
References: <20220704093029.1126609-1-leo.yan@linaro.org>
 <20220704093029.1126609-2-leo.yan@linaro.org>
 <18f1ee4a-5787-40d7-2eb5-50a43298845d@linaro.org>
 <20220704130712.GD659023@leoy-ThinkPad-X240s>
 <5fa79e89-144c-7261-335a-8f509b182bba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa79e89-144c-7261-335a-8f509b182bba@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 03:50:41PM +0200, Krzysztof Kozlowski wrote:

[...]

> >>>    '#interconnect-cells':
> >>> -    const: 1
> >>> +    description: |
> >>> +      Number of interconnect specifier. Value: <1> is one cell in a
> >>> +      interconnect specifier for the interconnect node id, <2> requires
> >>> +      the interconnect node id and an extra path tag.
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>
> >> Ah, too fast.  No ack. This ref is also pointless and not explained in
> >> commit msg.
> > 
> > I referred other DT binding file for adding $ref to specify property
> > type [1], so it's confused why it's pointless, anyway, I can drop $ref
> > in next spin.
> > 
> > Thanks a lot for the review!
> 
> The "arm,prefetch-offset" is not a cells property.

Understand.  Will drop $ref for in new patch.

Thanks,
Leo
