Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7684F09FB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358881AbiDCNdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbiDCNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:33:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148A033E37;
        Sun,  3 Apr 2022 06:31:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x14so3125532pjf.2;
        Sun, 03 Apr 2022 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iYOSYhZyZIBQLp1UBX/AcUZuU6Qi+woR07oj0XKgFQw=;
        b=K1mjKxx51Aa/MI1Xhljs2Pkx6j5hZi/6WPP6vp50KwApqAZqv81zZzV9X1I183uUgY
         b9hvxSCPR4XqZl4yBVwNszIxyyucibQ0dUUWHWh3y8A0nZGBSsNww5MBkmfc3HWS60IK
         k8SFTXLJUZOGy9SRt+dD18CBHtAZCPMOZ1Yu60nbSshOBwJQkqOTCAZDjRBEfkfSbB6y
         LNCxY6RojeTu918Ju5KCnUjULXHLk+sTBZE0vnJbegIahl0szjONhc2oV49hADyifVAn
         X081llrh6vtR8xNBzqtSkiudHvuK9LQ5TzK0M0hHfsVWF8xJawxCa63Q0YXNO9PyALQS
         Rdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iYOSYhZyZIBQLp1UBX/AcUZuU6Qi+woR07oj0XKgFQw=;
        b=Jql18lnQSG9s87BmLRa9oUeG9mkcakxF/59F0dyKu8SVaPaR6+BTIVb5F6KbxqDIL4
         kvVVB0fBlAHHUsD29A0wuL/EPeiUVO1Ai2zCEgE+S4cvfMsiLU7hyjkGHI1EdJsFm8ZO
         aNRogcSlZGr1FdDUf8SF6fMi6WhsMfscrI40msSVX3q2nYEyTzP6H7eE7aHS+FTvTEx5
         VMDYoFQ2A5//IiwkN3BJ9ePUVbrfE288B86h/8K894bk7oJ47u9n2TIzgjHjHohKzjBt
         7PsMghKACu1XeEVTyQ3FqEI3PPuE5ZK4n0kINMaBDfVt31LAoELN/sj5RTIPkz8Qfnhq
         Ey0g==
X-Gm-Message-State: AOAM5302T5suTZUUc6yZDnw4SL7BwUlW0hYl6DzcFLV3XwSMknMYgYRy
        oBrg71tbdAYx4xj3sr3VYl/gk6dy75cYVw==
X-Google-Smtp-Source: ABdhPJzIQXZ9mVJBo6x8vbubXfMxe7SwZ1F27TTy+x2h5l84R7Nu3cCmwCfmNdl/uEFWKnRTWHgleQ==
X-Received: by 2002:a17:902:6b0a:b0:154:6527:8ddf with SMTP id o10-20020a1709026b0a00b0015465278ddfmr19120740plk.154.1648992689487;
        Sun, 03 Apr 2022 06:31:29 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id bv8-20020a056a00414800b004fafb37f293sm8351692pfb.209.2022.04.03.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 06:31:29 -0700 (PDT)
Date:   Sun, 3 Apr 2022 19:01:22 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 6/6] dt-bindings: power: supply: qcom,smb2: add bindings
 for smb2 driver
Message-ID: <20220403133122.GA49428@9a2d8922b8f1>
References: <20220401202643.877609-1-caleb.connolly@linaro.org>
 <20220401202643.877609-7-caleb.connolly@linaro.org>
 <20220403071426.GA49153@9a2d8922b8f1>
 <798f0244-95dd-cf2d-7bc5-02c72c7fa327@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <798f0244-95dd-cf2d-7bc5-02c72c7fa327@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 09:56:25AM +0200, Krzysztof Kozlowski wrote:
> On 03/04/2022 09:14, Kuldeep Singh wrote:
> > On Fri, Apr 01, 2022 at 09:26:43PM +0100, Caleb Connolly wrote:
> >> Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
> >> drivers.
> >>
> 
> (...)
> 
> > 
> >> +    pmic {
> >> +      #address-cells = <1>;
> >> +      #size-cells = <0>;
> >> +      #interrupt-cells = <4>;
> >> +
> >> +      smb2@1000 {
> >> +        compatible = "qcom,pmi8998-smb2";
> >> +        reg = <0x1000>;
> >> +
> >> +        interrupts = <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>;
> >> +        interrupt-names = "usb-plugin";
> >> +
> > 
> > In-between new lines may not be required.
> > And DTs use tabs instead of 2 spaces, we can follow that here also.
> 
> The DT examples in bindings use spaces. Either two (like YAML) or four
> (for easier reading).

ok, since example snippet is taken from DT that's why I said four
spaces(tab) as it will be closest to actual env.

> 
> > 
> >> +        io-channels = <&pmi8998_rradc 3>,
> >> +                      <&pmi8998_rradc 4>;
> >> +        io-channel-names = "usbin_i",
> >> +                           "usbin_v";
> > 
> > Channel-names can be written in one line.
> 
> They match the format of io-channels, so this is quite readable.

io-channels doesn't exceed max characters in line(i.e 75) even after
being clubbed. Won't be better if kept in one line?
This might be personal perspective but I thought it's worth mentioning.
