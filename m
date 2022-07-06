Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52D056899F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiGFNgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiGFNgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:36:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBABE094;
        Wed,  6 Jul 2022 06:36:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id d2so27210075ejy.1;
        Wed, 06 Jul 2022 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=o+i6UfE6tLbb5A8Bxft/xHMAROfGJh6TRqfobcDmJM4=;
        b=LSwP/sekDgSqBlvtdFx4fvClrAxxHlYsykzg189tHsYtBAjv9zkpviVg2BTiFMMPhj
         H/jueqX+epgF+fdRdzWU1IfQxgPohuCmRpp2r/KIxIsG761JoDqVIlb6ZUOV5bZX+G0K
         4eN4QalNSG8r0H57lOA6rdfoaGU6bF7mFPg7vnG68ftoyH1/m0KSo7p3iX+0knXyRx9a
         qiHfLyVlbHuY3tKiJIYYyss0u/LnFCPkfrLwFvirUO0pTblggpclamnwnm8ouXzve1D1
         MdfXhUVqS2EqtB0U7d6CMQ3bQlySbAyn4XKS5wjm90WHNBtb2YCoX6OAxG8lY0ItTmTf
         N2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=o+i6UfE6tLbb5A8Bxft/xHMAROfGJh6TRqfobcDmJM4=;
        b=iA4Qdq2uk8eEBMtIUSSz9+7+MLo8K+5hW3wPdLkEGuICpn0bTgyqNAa/NMfolK9eDm
         m7dM/3NigpahKmJWXC1iVNIMgpOnNF5BGutWeibexJ3b6MU3XSJRYbHviSb44G+1a9te
         T8Cw0t79YkQX5Hjo3rfi/blvZNXK/ja8MOHbq3NF7ALtRWG1J4u8/68nZSAx/3totxhg
         yRavc5kEk3w64QEhFcKbz5aiajrlewgxUq69I5iwWbjY0QhxdRWNYpLgFleU0f5ckFMD
         qQknjzx28LyLwHpmxlMIP71szR/QQzoEa8t7eAHu3cbbaAJCDwkwDSvXitKoVo7P4WE7
         lUxw==
X-Gm-Message-State: AJIora/QzTqsBsX5vYYjc9nYIf3vn6sfu7t+8li/4+liAvFrBNtQfwuE
        yK5fIBvQxylDsEhjcNhSB9xC7ZwLRts=
X-Google-Smtp-Source: AGRyM1uH7h2oOWqie2/AB0J+ZQKdaALUsl5hYNdPSTI72nrmLmEqD0UE913cSUIsfJ9ll00zrxufPQ==
X-Received: by 2002:a17:907:3e11:b0:726:372b:6c32 with SMTP id hp17-20020a1709073e1100b00726372b6c32mr40255707ejc.157.1657114570858;
        Wed, 06 Jul 2022 06:36:10 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709061ba200b0072afb1467desm816949ejg.127.2022.07.06.06.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:36:10 -0700 (PDT)
Message-ID: <62c58fca.1c69fb81.76f6a.15f4@mx.google.com>
X-Google-Original-Message-ID: <YsWL5Qxb5fxLpYGL@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 15:19:33 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 04/13] ARM: dts: qcom: disable smb208 regulators for
 ipq8064-rb3011
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-5-ansuelsmth@gmail.com>
 <8a394fa3-92fb-d162-b4ee-df010a09aed0@somainline.org>
 <62c58a60.1c69fb81.25b26.e72a@mx.google.com>
 <36a68a0b-0c18-deb5-609c-2128aa3fc21f@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a68a0b-0c18-deb5-609c-2128aa3fc21f@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:31:55PM +0200, Konrad Dybcio wrote:
> 
> 
> On 6.07.2022 14:56, Christian Marangi wrote:
> > On Wed, Jul 06, 2022 at 03:03:32PM +0200, Konrad Dybcio wrote:
> >>
> >>
> >> On 5.07.2022 15:39, Christian Marangi wrote:
> >>> Mikrotik RB3011 have a special configuration where the regulators are
> >>> not the common smb208 controlled by RPM but they use a TPS563900
> >>> controlled via i2c. Disable the smb208 for this specific device.
> >> Ok, so that answers my question from the previous email.
> >> Please define the SMB208 regulators only in the DTs of
> >> boards that actually use it, as it is not a SoC component as
> >> far as I can tell.
> >>
> >> Konrad
> > 
> > This was already discuessed,
> Yeah sorry, I didn't notice earlier and started reviewing patches
> that were already reviewed by others.
>

Np, thanks for the review.

> 
> rb3011 is the exception, qcom for ipq8064
> > recommends to use smb208 but gives the option to implement it in their
> > own way. So again we have 28 device with smb208 and 1 device that use
> > its own special way...
> > 
> > Wonder if a separate dtsi can be used for this if we really can't put
> > smb208 in ipq8064 dtsi?
> There's msm8916-pm8916.dtsi. You can follow.

Ok, will put the smb208 definition to a separate dtsi, something like
ipq8064-smb208.dtsi? or ipq8064-rpm-smb208.dtsi? Looks also cleaner that
way.

> 
> Konrad
> 
> [...]

-- 
	Ansuel
