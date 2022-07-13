Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11675573E82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiGMVFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbiGMVFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:05:13 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03BA2B252
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:05:12 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u9so59152oiv.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8UQgy4Q8FGdA/Aqfe2MOpvAi3K11kCF5PxsjUjKpa3k=;
        b=QNwqtUTst2ieKisRxsycHIPorcglviR+QQHNAbZWN57M3wDvzSQCtlaQarVAVY6sJE
         0pJOAEJDibWaJYWCR0O1acrbZnRJY82DT8tQImWP9nK0QngUv1LwInkDoxu6QchlkTPH
         Li9abQzJw/5r7RAbc06x4ZBp3VJ76PlMmSHvfjtCqlxyQas9y9k7Su6SteBTA9BFo4wn
         YlogJZzpmb1cGSI5JztShADD2E2JLfJUjo09/Q4clky58JK6htdp/f8WAf+dtD+6KC/K
         TccH+cJJXROu5AMHBO0iBIYpiE9BiHuDmkMer7+vqHEUKTarCNsn0lM/W8ExpqourOxU
         RSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8UQgy4Q8FGdA/Aqfe2MOpvAi3K11kCF5PxsjUjKpa3k=;
        b=28x5weWmg/geDz/JCvQPdt1ZT8ijioHzox5a0/6yDYZvcYkMgBy3iINHvbybaGQEK5
         8iafO/r8MtlvnL2A+FV+kno7tmJ2na4RMc5jm0emn8xclaIguAFbuWgpvjAKtxt6b58V
         uwURSR5kIPm/YV4WeqHWXVNTf9lx0RE6FT2hMurUiTa9RC+x8AQ4UeBqsTSxp7GCJ7Kg
         qIXfLmcHWqkZrypt9qB3q6krCRmKDDi+TVrJ9WHrvg1c+GDItPJRi5AS5CpTQaThV+1o
         ZL9yj3QbKSHz/B+F7uaxuClUGBea9xGglVxDin8L3x9pXwMQpQvdfNLpxEbWKuGnHL4c
         HLpw==
X-Gm-Message-State: AJIora9YGDmAWWj7af09QhzZ9NHVsKkh+fvb7BwODn2n1huqiWwotLog
        gCj3DOJ+kla0hZrSo6bJHRSk2w==
X-Google-Smtp-Source: AGRyM1tESh5p5JLl5SU0h1S49SXHXt7hpXZIB4yl/kKklZ8Tofs49GNKgqxZBaFmxw/s/jewgCXh8Q==
X-Received: by 2002:a05:6808:1595:b0:33a:16b7:21b8 with SMTP id t21-20020a056808159500b0033a16b721b8mr5845066oiw.30.1657746312187;
        Wed, 13 Jul 2022 14:05:12 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 68-20020a9d0bca000000b00616d25dc933sm5156134oth.69.2022.07.13.14.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:05:11 -0700 (PDT)
Date:   Wed, 13 Jul 2022 16:05:09 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] drivers: thermal: tsens: add IPQ8074 support
Message-ID: <Ys8zhW2YmJKNvqC3@builder.lan>
References: <20220708132930.595897-1-robimarko@gmail.com>
 <20220708132930.595897-4-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708132930.595897-4-robimarko@gmail.com>
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

> Qualcomm IPQ8074 uses tsens v2.3 IP, however unlike other tsens v2 IP
> it only has one IRQ, that is used for up/low as well as critical.
> It also does not support negative trip temperatures.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
