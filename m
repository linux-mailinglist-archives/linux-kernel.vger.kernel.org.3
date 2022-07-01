Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3332562971
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 05:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiGADPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 23:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiGADPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 23:15:11 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDD841600
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 20:15:10 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u199so1973403oie.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 20:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BxMVRlozs5gaL5y+tksQaCZPN44sJr80WYAWh7e65c8=;
        b=VuZxcn7NzbAx1RYFKd3d6ugSfHcjpGYDGgiOadaY/oAjEp9D6yvBn8qGzGNmpltxOf
         cROV/qrCwTB7SOajxmHjEv1vC49BiQIWKxvsOBNv25QrvctiLdUugGHZ08AxSG0jGe9H
         Jj4sK30uQv+M3XRx1dBx3pvwCR4AlRb6mAJcOVI0hpd4Y5pQ3B/qTWhIGXT0ifxs9MCi
         yU6idl++JaO9N3sGA7dmTrCvj2kVe3ey0Fcl/ktEzr6R4Bupnm9tN608XyGFCW7EX6BL
         fcUFDmpxXu6bFW58xnqnLgA+Jh4RLE9tN+8PhsFm+TO9hkMSd1pHkMLWq93ieYELBRM5
         3HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BxMVRlozs5gaL5y+tksQaCZPN44sJr80WYAWh7e65c8=;
        b=GJrX5nAzx5OIFHIPhXWjCSFGibQVIdp46rUqSrnm9l3nQ1NCSojwOyZMqes9s6MnUJ
         J4mmpLnJAzcRFKwqZ9MwuYX+t7Zy2exkmiLy7+q9vBfE00JFpJYAMBNg0xVBMtkgx52v
         6qmuYuS9ZZGEoFd/WxCO8rLBab/3Y66OGHelqpLfikoeo25K7qinY/oAOa134s/I+p7s
         o6E2RkvCJj5kRTzZzdkEpuU01U+u7/IaDo/aVEVbtQS6BXX0Z0SF6qVH0X1tvxGArOrR
         uxUKqQbSkW5KoL2WrzJeVO3gVJEIyrf6ZCYU6jcXZOkoHStYDeGJAI8M2GfDUCqtes75
         0H6g==
X-Gm-Message-State: AJIora+WXf8MX3jUCgWieiw2frUH1VhvlYAntNk9JhSM2lX4ZlfPZ49c
        cTC+jhu3WuOsGm//DQLEMXJjaA==
X-Google-Smtp-Source: AGRyM1ssBoPtQRcmEAjnjYBiorhZ2EAIrmmwQ9Fy88H4Rw50wh6VlhhnIza68G+u/M6FNXgpBHeW8g==
X-Received: by 2002:aca:2204:0:b0:335:5bd4:f6db with SMTP id b4-20020aca2204000000b003355bd4f6dbmr8457410oic.201.1656645308146;
        Thu, 30 Jun 2022 20:15:08 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o4-20020a9d4104000000b0060bfb4e4033sm12205091ote.9.2022.06.30.20.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 20:15:07 -0700 (PDT)
Date:   Thu, 30 Jun 2022 22:15:05 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: qcom: msm8974-*: re-add remoteproc supplies
Message-ID: <Yr5mua6i6WxoAlzB@builder.lan>
References: <20220606160421.1641778-1-luca@z3ntu.xyz>
 <20220606160421.1641778-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606160421.1641778-2-luca@z3ntu.xyz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 Jun 11:04 CDT 2022, Luca Weiss wrote:

> As part of a recent cleanup commit, the remoteproc supplies for adsp and
> modem were removed from msm8974.dtsi and now need to be set in the
> device dts. Do so.
> 
> Fixes: f300826d27be ("ARM: dts: qcom-msm8974: Sort and clean up nodes")
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Bjorn, could you please pick this up for -fixes so it lands in an
> upcoming 5.19-rc?
> 

As reported by lkp, this doesn't build. Am I missing something?

Regards,
Bjorn
