Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F412F55FD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiF2Kkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiF2Kkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:40:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F73DDC8;
        Wed, 29 Jun 2022 03:40:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r18so13706036edb.9;
        Wed, 29 Jun 2022 03:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=OZGHhwFxChxDscfWMdp/0hPM41tz4KYeItHFPAfWjXg=;
        b=n6Dj+ubBXgTqBcQ9GNePKalUQR+A4y9r7wELKNOq+i+y3ys8mIlCGuKMsyIj2RKOsS
         UJQ1d+xB/qbS3xIAqK0empxdbC8+z0TOCeRE9mR2MYXNLxFerD7GB8CTvoyPOeqHXuaD
         xr6q3vSt2oE6Kn3svS1jLygTCnRloyqsvL+42iQ3N44L95f2NDeSmiMOFzU2h8RS7AA3
         eVrqhVYzGJIqy4bHlepIiDMwhurmwoVGWTW6Gq2Ru1RLF7mAzPv4UAmuTaMSabmohgtN
         Kwl/IluHg50DS7wuN9KVMapGq8XasqfGHoDUgr4JtR/8AguKPnIvZxDzUraAZOBtW5zR
         /nXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=OZGHhwFxChxDscfWMdp/0hPM41tz4KYeItHFPAfWjXg=;
        b=pj2W/Ka+P8vXJZxtGitlKkAMoAyx0ZY+Md73rNCzyg1Mmxz6Pq4FOr++60ZQPkJR5E
         UZzkqg/TvbsRWZf7kNgwiJ2SsSqRu2iwAqF5jk47y9WCxYtKrX0UYemeLezg0gtabJc1
         PoxblufHKAzP4grBciF7Sa0sva1xNfiauiZeABF+UkDWFUJzadbELKC5r6qq4u5R/y2e
         wja13U62pJvcTcSHLTvTS/yCGlX2VjnmtBs5dX3i5scY+/zUb9BhRch/JZTVSJyyTTnS
         xa1Ok7Zis/LKTuAujOmb2tbEqHr456SO6Y3Fj066J7iGWf4PCzQLYbyxXt0THH3kDBEZ
         9WQw==
X-Gm-Message-State: AJIora/d9tlCIbcYHTtemaDAlEGnPq7+RuhuOrgTbYYC2oTgfrFGLlLh
        Oes0Gp3LD5PHQ8lGN8DDiM+UgKW5LSM=
X-Google-Smtp-Source: AGRyM1uWD4Bgc7cQ374NBKdJUhsnzAdBJRMDBDRHEPbI7ogeu6aX2BELORIGdQo2w+wfdKG7xYyWfw==
X-Received: by 2002:a05:6402:5214:b0:437:5b1d:9966 with SMTP id s20-20020a056402521400b004375b1d9966mr3378608edd.16.1656499229681;
        Wed, 29 Jun 2022 03:40:29 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709060f5200b006fe9e717143sm7579266ejj.94.2022.06.29.03.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 03:40:29 -0700 (PDT)
Message-ID: <62bc2c1d.1c69fb81.09d2.e244@mx.google.com>
X-Google-Original-Message-ID: <YrwsG4w3piWq+7QX@Ansuel-xps.>
Date:   Wed, 29 Jun 2022 12:40:27 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: msm: Convert kpss-acc driver
 Documentation to yaml
References: <20220628184137.21678-1-ansuelsmth@gmail.com>
 <20220628184137.21678-3-ansuelsmth@gmail.com>
 <e625e2c9-7321-51fa-b9bb-40ed9742ffcc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e625e2c9-7321-51fa-b9bb-40ed9742ffcc@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 08:14:12AM +0200, Krzysztof Kozlowski wrote:
> On 28/06/2022 20:41, Christian Marangi wrote:
> > Convert kpss-acc driver Documentation to yaml.
> > The original Documentation was wrong all along. Fix it while we are
> > converting it.
> > The example was wrong as kpss-acc-v2 should only expose the regs but we
> > don't have any driver that expose additional clocks. The kpss-acc driver
> > is only specific to v1. For this exact reason, limit all the additional
> > bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> > v1 and also flag that these bindings should NOT be used for v2.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> This is still not fixed and not tested. Since 4 versions of this
> patchset (previously was part of other set).
> 
> I retract my review. Please test the bindings.
> 
> Best regards,
> Krzysztof

Thing is that I tested them and on my side I don't have such errors.

I'm using the linux-next branch. Should I use something else that have
newer schema files?

Also on other patch there are some error reported that are unrelated to
my change and that looks strange.

-- 
	Ansuel
