Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBFB50DBA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbiDYIx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiDYIxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:53:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB8FB1888;
        Mon, 25 Apr 2022 01:50:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d15so11033538plh.2;
        Mon, 25 Apr 2022 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XEF1fqkTA7SoInR5IA+7IfzdVc+rCVTbChZYDVnBlt8=;
        b=hel2ha51wMOKVcyqusD+syK7aku+UAKzVvGkzQ4aALypEAEjUrQ0KjvBph2Jq/VxwV
         ooseU1mCy4yxtWoM3a0iEQnNuUfxhqhAQnnaqZDml/Edl/ltXstBGkb9nN7hFumPLBJq
         enySQUiIvrEnVnlRYw54qecoSTfR0JRodWJ9eD0lFgU4pWz64mZ2DQFHocAVk0Vt65qJ
         wqJ3knndJQP45mwMk/M3ZU7ArOZ01KLrFsT6huxCo4FYgSZk6HeHZUIjYW0FUvyzIGqa
         5JUTr0BWllla9FQl7+/niGfIcsSVefx2MMoMuwfNZqqy7yHOnukl9HommDjqxbIp2+ds
         dHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XEF1fqkTA7SoInR5IA+7IfzdVc+rCVTbChZYDVnBlt8=;
        b=YDhscnAyRrTbvDT0sfuDb33oqNjy1mSyX7JAwE/7I1kgQexuUVf6qpnBsheZwwI/rv
         vhMdSKG2NqdhjmfK89OdARkgfELfEH6V33B6AOk3FuPaRKI2UoYePR03hm6UpJg7l/d/
         Vm97nPki7locCzfrbRGbiZqDQDSC5AvUqlq7O7FQcrPQBevrruO6KOfEYzra9V7oU8uP
         ge3c9pNpLXkkdq/ON//RotrYS4IVl9B4Lvm6hhM6kPfBXQtvECxU3BZ5lxJpEJCHJ96p
         ZdGKoBQucBLWIH/WWWxC2BUC8V445qcxYh5QOQKwE4AhjrCyrixyKI8Bq8xV9eKulfiE
         RfOw==
X-Gm-Message-State: AOAM532zvDR2M6HX/94qKBNhzGVxzEZg3UmimRjiMsJdQZfRtL+7wlYc
        AhMQgRaVBrAz/P0gcm2sn9M=
X-Google-Smtp-Source: ABdhPJwE9laMmZWBOsrohhJNiglGYilf3hEeOd8xI1jwk7vLAc5hg2EEKiny9Sb2rP3dc1DsLKSejQ==
X-Received: by 2002:a17:90b:38c9:b0:1d8:efe1:6846 with SMTP id nn9-20020a17090b38c900b001d8efe16846mr14581300pjb.86.1650876618334;
        Mon, 25 Apr 2022 01:50:18 -0700 (PDT)
Received: from cyhuang-hp-elitebook-840-g3.rt ([2402:7500:569:b7a9:d402:1333:c60b:f1a1])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090ad0c200b001cd4989fedfsm14057309pjw.43.2022.04.25.01.50.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:50:17 -0700 (PDT)
Date:   Mon, 25 Apr 2022 16:50:10 +0800
From:   ChiYuan Huang <u0084500@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] regulator: richtek,rt4801: parse GPIOs per
 regulator
Message-ID: <20220425085005.GA21178@cyhuang-hp-elitebook-840-g3.rt>
References: <20220425072455.27356-1-krzysztof.kozlowski@linaro.org>
 <20220425072455.27356-3-krzysztof.kozlowski@linaro.org>
 <20220425075812.GA29439@cyhuang-hp-elitebook-840-g3.rt>
 <fe4b42c9-f747-145a-5fce-9be6fc3e19af@linaro.org>
 <20220425080819.GA20397@cyhuang-hp-elitebook-840-g3.rt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425080819.GA20397@cyhuang-hp-elitebook-840-g3.rt>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 04:08:31PM +0800, ChiYuan Huang wrote:
> On Mon, Apr 25, 2022 at 10:01:24AM +0200, Krzysztof Kozlowski wrote:
> > On 25/04/2022 09:58, ChiYuan Huang wrote:
> > >>  
> > >> -	priv->enable_gpios = devm_gpiod_get_array_optional(&i2c->dev, "enable", GPIOD_OUT_HIGH);
> > >> -	if (IS_ERR(priv->enable_gpios)) {
> > >> -		dev_err(&i2c->dev, "Failed to get gpios\n");
> > >> -		return PTR_ERR(priv->enable_gpios);
> > >> +	for (i = 0; i < DSV_OUT_MAX; i++) {
> > >> +		priv->enable_gpios[i] = devm_gpiod_get_index_optional(&i2c->dev,
> > >> +								      "enable",
> > >> +								      i,
> > >> +								      GPIOD_OUT_HIGH);
> > >> +		if (IS_ERR(priv->enable_gpios[i])) {
> > >> +			dev_err(&i2c->dev, "Failed to get gpios\n");
> > >> +			return PTR_ERR(priv->enable_gpios[i]);
> > >> +		}
> > >>  	}
> > > You can directly removed all about 'enable-gpios' in probe phase.
> > > Just keep of_parse_cb to get per regulator 'enable' gpio. 
> > 
> > We cannot, it would break the ABI and make the change backwards
> > incompatible.
> > 
> 
> Almost forget the backward compatibility.
> 
> I'm testing it right now. After that I'll add 'Tested-by' tag.
> 
> Thanks.

Tested-by: ChiYuan Huang <cy_huang@richtek.com>

Best regards,
ChiYuan Huang.
> > 
> > Best regards,
> > Krzysztof
