Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A81573E77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiGMVC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiGMVC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:02:56 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E212732B97
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:02:55 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10bd4812c29so58152fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IK7HzOOjB/YRFSR7VtNB/n1Tcb53AZBNpdOAwR1E0eE=;
        b=n/06Hkl30Gvy7TKjCGQan1GIKtORgd1KXX1HcjZ6llewGOvbkjS1MGOvilFTZh3kMO
         RAQ2vRNRynCmaKT5+s9DdytQf0ZbI6uJ+Za7Vev1VqOoemL9A/RlV1TsvqX4b42ncu+0
         pGUaxcb2ALQS3cy4RfL3kI77J0P+DErzEe9sSs1BMEPeakBV+UCg8crfcrpLqKd7X+tl
         0AUmmaimfftnv2UxndJVwT3WFCcE1rufdCYHYPwaWZdM8C9C85kHW6WigKZNx4wuc/Zx
         7yld8N25N9FQ5fC+o8NmItuSxHjNR8/b9bdK05x8Chmwdz77yOc1VnIzhoaN0Z2+p558
         ngSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IK7HzOOjB/YRFSR7VtNB/n1Tcb53AZBNpdOAwR1E0eE=;
        b=A3PVq/Ol00TCWGGsYdhUcPBp2KkpDDQnKoJ0hq+2Q8+LXdHRg3DqbptyvF0oL9bYo+
         45aYaFLLt3XokzGDxvk6mz8q5fIGi0UkVDkSN0waHD6rhkr+jNi0Ojed//RwV3bh84z4
         EQCLlC3yHWVJ1RG4efMDkIM+PMjvbrId+GcnI9bylEZX6Th17rn6MAudCZj8SoHK51Zl
         GPD5D2+PQRTkIR92eB1PMm0Q1zujmjfL7PcQRDJpk5Hxm78nox+gcOzH+K0BTPqteezx
         u3/ttbIIa0/qM0dEtAMYY7HG+4WsRqdklXyudBYGxsTniYIllT86knyoYIiGI+QOWnqN
         wMiQ==
X-Gm-Message-State: AJIora8699vXlWsRn/X3OECoft/jynDafUADrwbmXdXvTKYHa197NYLV
        pfexeQfdbecUHXJbyYVVsaStQw==
X-Google-Smtp-Source: AGRyM1uAB82b7HJZhMHsI15ICK/mZgZgMu+xab6E2swRNoGW92ufBzJOT+w8X4NyhfNKiAdV3gkmfw==
X-Received: by 2002:a05:6870:558b:b0:101:d77c:3369 with SMTP id n11-20020a056870558b00b00101d77c3369mr2932757oao.213.1657746175273;
        Wed, 13 Jul 2022 14:02:55 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r13-20020a056870438d00b0010c33621645sm6413069oah.55.2022.07.13.14.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:02:54 -0700 (PDT)
Date:   Wed, 13 Jul 2022 16:02:52 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] drivers: thermal: tsens: allow configuring min
 and max trips
Message-ID: <Ys8y/HRtdgD1f3uH@builder.lan>
References: <20220708132930.595897-1-robimarko@gmail.com>
 <20220708132930.595897-3-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708132930.595897-3-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 Jul 08:29 CDT 2022, Robert Marko wrote:

> IPQ8074 and IPQ6018 dont support negative trip temperatures and support
> up to 204 degrees C as the max trip temperature.
> 
> So, instead of always setting the -40 as min and 120 degrees C as max
> allow it to be configured as part of the features.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
