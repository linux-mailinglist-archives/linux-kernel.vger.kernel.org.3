Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BBF567115
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiGEObW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiGEObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:31:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6DB25F8;
        Tue,  5 Jul 2022 07:31:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id li14so48397ejb.2;
        Tue, 05 Jul 2022 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=BFC2l1MyZV56kM1Rw63vkz5lyl4PxJ1PtAlfokNWogQ=;
        b=DwVvNKik7+V6gZkNv78Fz7JiLPvqMqIV+T7tm1+lj/PUmbYjRCPznlLOrsytpVHFW1
         dNcDbuqRb8BVycgA4lpGINftWZ9d1b2NqKpXU0Dak/ozAFn54wcGbjQusVM95hM8P2wf
         e8hW0g73DoNdzpU/rhHRKxZz3lSNkx8bFHoEvRKVzm07kbOSMTdIxAt8ssIh8v1YkRUy
         uQhs01e/fULt2fyzEh63tTRyzdygmH7OM2BMNagJrGgc4piuVMrBlF20Ddo9QZk+PXWi
         unbbZu2uEarfOP0HA853/SEh/MhL4YsGYCIPPcYsqovn7CDwwB0O1zISMAV8nnFdL8d4
         5Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=BFC2l1MyZV56kM1Rw63vkz5lyl4PxJ1PtAlfokNWogQ=;
        b=ZJgx2Y+JDDVDHwQI+u1wy9f09x07rAqdCdzOMncjRGJCkok8f1sp3wvjR7mGpetLri
         0scKv12jE6ER/N9bqgw/8DtU4EeVPvWNU+eMeGz3hNQYvJ7BezaEkzbbWHrG7YYSNeg4
         HLFxAMTzV7CJU9pcMhedOEapH12KHJZHdwODNLuHOx6S4lbN6wKuRPUFUck8eaX3FxiM
         W7PZBOA1EKxdEARSr7xyBhnvssGh1ASJNoqh6HAZYUzBBoCPjGBtltnef7evTxP32TW6
         oHiokyVcLbuFVhK9Mt+DX7w9yrWfWAOrBRdRn+2bwKWWAWy51g3EiGlByeAqrmhCT8Wq
         1wNQ==
X-Gm-Message-State: AJIora8GdtqCeaBuWvND1z82q6Jt4g7ok8pC2vvqwJVLS30YhcxAEPrt
        28/eAEhkNydCc8CRha59tck=
X-Google-Smtp-Source: AGRyM1vmeH2EndAVsLYo65XIMDW5zOXN3m9Ii8zBS0gTWyzfEpk6070F4Av+tTeTQ64rAZn8c1fd2g==
X-Received: by 2002:a17:907:3e18:b0:722:be7e:302c with SMTP id hp24-20020a1709073e1800b00722be7e302cmr33833103ejc.437.1657031475205;
        Tue, 05 Jul 2022 07:31:15 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id q25-20020a17090676d900b0072ab06bf296sm4370818ejn.23.2022.07.05.07.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:31:14 -0700 (PDT)
Message-ID: <62c44b32.1c69fb81.c87b7.72ac@mx.google.com>
X-Google-Original-Message-ID: <YsRE5eWVFCEgs9Iy@Ansuel-xps.>
Date:   Tue, 5 Jul 2022 16:04:21 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] Add ipq806x missing bindings
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <e84bb14b-a3a5-728d-e3a4-9d2e898a7aca@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e84bb14b-a3a5-728d-e3a4-9d2e898a7aca@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 04:28:47PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 15:39, Christian Marangi wrote:
> > This series try to add some of the missing bindings for ipq806x.
> > 
> > This still lacks of the cpu bindings and all the bindings required
> > to scale cpu clk or L2. These will come later as the driver and
> > documentation require some changes.
> > 
> > So for now we try to add bindings that can directly applied without
> > making changes to any drivers.
> 
> You mention here and in subject bindings, but your patchset does not
> have any bindings.
>

What would be correct word? Node? Compatible?
Sorry for the confusion.

> Best regards,
> Krzysztof

-- 
	Ansuel
