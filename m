Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5202F534D50
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbiEZK15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiEZK1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:27:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC531C9666
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:27:51 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 202so1392369pfu.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oUe5qjHE746YsZEG88fvj0C8TBLZdImHAFuEEdYBkXw=;
        b=Stw9e/v85gPO2N1vgvwURGj/CxdNR6Azaiv97JK6NQnC940NOP+Clev15pCSWT4xyT
         3JzT+Y/NldWIOhGkH1iJqwkzCdGZULf3Jy1FLhuYQz6ZmBZhplHx+175DIwVM9mU1baw
         LnVRP0b4ZQkGQjpGggN05t64QoKodEh7UMgifBA1ciK8hvfP/aYqxHkeHiUpIF64qYNs
         uDrdr7Wu9tKkzkP8TShGWX+QWTLRZKGKq3tKCENZMoL9b6QfXXvSfDwk+EexkJFASX+V
         laexhG2eygNOfgCYl+xvNJRcnpj7IqUSrx5mam9sPOeapbpMZQAi3yJELV9xFAjLOyG3
         kEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oUe5qjHE746YsZEG88fvj0C8TBLZdImHAFuEEdYBkXw=;
        b=wswEQv5f/RAgMhq22fu1gC+cMyOmRGhs5cJkLRhIwqxO7efJnkXzdTUnq1TlrCr/wX
         kHXV5R2pgRp77s2OKxskCqKc2qIT6WAJo7DreB3aa6tC0HvwA2rGI+bdqqEnJgFPZXAf
         QnDAW7QxraSpbeSSR6hP+d8vPuEEdMkxLdOrUGc2iL6OVrQcuXH5cjluetDRpdvG4XQ/
         wU8QTNjM2iOVpJ84hyiWFeNCR3fmD9/hGiVrQCbmPYLUTPsazSR9+8PAqkco9zT1HaZX
         3pcvTm90vMqQVzyeAPLXcdJ7vc2iMVExsQAvTiRuFVRIcg/lpvd1KFgckCAn7pOKw1xu
         g4/g==
X-Gm-Message-State: AOAM532M2YDxPq5zaL9cLbEuKi1+3JFXgnMPq8I6NpI9cR+mVPkS2eiz
        WdVcfrQx1yu78ynNBZbDVFzXCg==
X-Google-Smtp-Source: ABdhPJzk/4qznsz2eXu4MQ8+yKPx64W3doEbD81UmTDqITtBAoa74V+NV5H6kgRfZ3+aohJyYyt5sw==
X-Received: by 2002:a63:488:0:b0:3f5:e6da:4619 with SMTP id 130-20020a630488000000b003f5e6da4619mr32218957pge.6.1653560871342;
        Thu, 26 May 2022 03:27:51 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id k2-20020a170902f28200b0015e8d4eb1dcsm1134696plc.38.2022.05.26.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:27:50 -0700 (PDT)
Date:   Thu, 26 May 2022 15:57:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/6] PM: opp: allow control of multiple clocks
Message-ID: <20220526102749.5tj5ttr5wxwfdrhh@vireshk-i7>
References: <20220425072710.v6gwo4gu3aouezg4@vireshk-i7>
 <dea39b1f-0091-2690-7f07-108d07ef9f3c@linaro.org>
 <20220510044053.ykn6ygnbeokhzrsa@vireshk-i7>
 <1e533194-7047-8342-b426-f607fddbfaa3@linaro.org>
 <20220511050643.hd5tcrojb3wkbg7t@vireshk-i7>
 <20220518235708.1A04CC385A9@smtp.kernel.org>
 <65a4c28d-6702-3a9f-f837-1ea69a428777@linaro.org>
 <20220520005934.8AB1DC385AA@smtp.kernel.org>
 <20220525070551.guv3csxi5kkqfr4f@vireshk-i7>
 <20220525160455.67E2BC385B8@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525160455.67E2BC385B8@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-22, 09:04, Stephen Boyd wrote:
> I'm saying that each OPP table would be for a single clk, but they would
> be connected through required-opps for the device's OPP table.

Ahh, okay.

> It would
> mean that dev_pm_opp_set_clkname() would need extension to let a driver
> indicate which clk is associated with an OPP table.

Hmm, just that it complicates simple cases. Lets see.

> From your other
> reply on v3 it seems that you're leaning towards having an array of
> frequency values in the OPP table instead of doing table linking?

I am not against that to be honest, we have done that for voltages and
current already. I am just not fine with having any one of them as the
primary clock. I liked your idea of reusing "level" for that.

I have started some rewriting of the core, to simplify things and
reduce the number of ever increasing APIs (which you suggested earlier
once). Lets see where we land eventually.

-- 
viresh
