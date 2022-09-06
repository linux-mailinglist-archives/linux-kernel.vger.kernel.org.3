Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2605AF74E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiIFVub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIFVu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FC574CDC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662501024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zwvFhPvKtvilznQKajYnoXzh1pGf+L3B/vF7sjwMGQA=;
        b=ENSy8A2aHMU25YrQBXaahVPAJ5CENy6SEnNTvGoVx/fuIZDIDljMbTT+NGZ0S71nO3s9Be
        t0qAwoHvjTYopGfoyjpK3gVlhtl5wVThkaYdF9kkNAiL8KhkmqKTp2OKTaC/KeYQvSTSh7
        g3z8RT/DlW4kYtcK9MoZkDbFa9xoa6o=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-593-5xfNJyJeMbC4CxwtDqYrrA-1; Tue, 06 Sep 2022 17:50:23 -0400
X-MC-Unique: 5xfNJyJeMbC4CxwtDqYrrA-1
Received: by mail-qk1-f200.google.com with SMTP id f1-20020a05620a280100b006bc4966f463so10353128qkp.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 14:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zwvFhPvKtvilznQKajYnoXzh1pGf+L3B/vF7sjwMGQA=;
        b=ValdIZ6xg7rSt5bzxftYek+RdKjBlGrB1Kb4GdArgMYqrPOg94dHgp58rBIFvbi72W
         r2kIBMjWtsHZhQlgL2CWzOMwtncf75vApp49vbwarec415h16NBdVCwsXFPjxdlb5EWq
         xqlDevKulF6WYp1fVMDf7UlhzBwI/Q2UmMnhZeON8aB7vAfu2GjgcruxJDli8KVq+SQS
         qRRriAsokp6E4PbG05wH4oEg5LF4jW/YOqo/a1hqSHsTKQ0w1eyj8gVACg4+KX7xuimm
         Z6tl5w3tvX2+1ndiXbNkTdz5WSp2EuiLfvKO6YadWSkoB6UlqPlTA4qwth0rVJwhXJJq
         wKCg==
X-Gm-Message-State: ACgBeo0iliQsLdYT6reR2VcxsbB5p/LGC/dN6lzEPxJWde067EKgKxcB
        LnWsrbnjOrZXVz+YXxD6Gv04tjcMhQfm0dobKW2JQqzH+Dl6TZKtyq+F4UwfdcsR5EK+wpgJcYH
        F27KY4SmDGQ4zVCndNOTNDQQ1
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id v6-20020ac85786000000b003433051170dmr588594qta.429.1662501023158;
        Tue, 06 Sep 2022 14:50:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR79T3LmyqmdTcNPv4LymbPlxF6iExv08J532N/Q2bCHBhnmUIrEyOP/O8n8G9aGclC2TQxQTQ==
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id v6-20020ac85786000000b003433051170dmr588584qta.429.1662501022944;
        Tue, 06 Sep 2022 14:50:22 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::a])
        by smtp.gmail.com with ESMTPSA id l3-20020ac80783000000b00342fcdc2d46sm11175488qth.56.2022.09.06.14.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:50:22 -0700 (PDT)
Date:   Tue, 6 Sep 2022 16:50:20 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, johan@kernel.org,
        lgirdwood@gmail.com, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, broonie@kernel.org
Subject: Re: [PATCH v2] regulator: dt-bindings: qcom,rpmh: Indicate
 regulator-allow-set-load dependencies
Message-ID: <20220906215020.igxpywsdlmzpt7fp@halaneylaptop>
References: <20220906201959.69920-1-ahalaney@redhat.com>
 <1662500460.139898.1224962.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662500460.139898.1224962.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 04:41:00PM -0500, Rob Herring wrote:
> On Tue, 06 Sep 2022 15:19:59 -0500, Andrew Halaney wrote:
> > For RPMH regulators it doesn't make sense to indicate
> > regulator-allow-set-load without saying what modes you can switch to,
> > so be sure to indicate a dependency on regulator-allowed-modes.
> > 
> > With this in place devicetree validation can catch issues like this:
> > 
> >     /mnt/extrassd/git/linux-next/arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: pm8350-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
> >             From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> > 
> > Suggested-by: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> > 
> > v1: https://lore.kernel.org/linux-arm-msm/20220902185148.635292-1-ahalaney@redhat.com/
> > Changes since v1:
> >   - Dropped first two patches in the series as they were user error
> >     (thanks Krzysztof for highlighting this!)
> >   - No change in the remaining patch
> > 
> > Krzysztof also asked if this patch in particular should apply to other
> > regulators, which I think it should for those regulator's who implement
> > set_mode(). Unfortunately I don't know of a good way to get that
> > information in order to apply it at a broader scope for devicetree
> > regulator validation. At least with this in place RPMH users can get
> > better coverage... if someone has suggestions for how to broaden the
> > scope I'm all ears!
> > 
> > Thanks,
> > Andrew
> > 
> >  .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml    | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 

<snip>

> 
> pmm8540-g-regulators: ldo8: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
> 	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb
> 
> pmm8540-g-regulators: qcom,pmic-id:0: 'g' is not one of ['a', 'b', 'c', 'd', 'e', 'f', 'h', 'k']
> 	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb
> 
> pmm8540-g-regulators: Unevaluated properties are not allowed ('qcom,pmic-id' was unexpected)
> 	arch/arm64/boot/dts/qcom/sa8295p-adp.dtb
> 

Please note in case I didn't make it obvious in the commit message, the
regulator-allowed-modes dependency warning is the intent of this commit,
and those warnings go away once this patch series is applied:

    https://lore.kernel.org/all/20220829164952.2672848-1-dianders@chromium.org/

The last two are old warnings (that I have yet to look into).

Thanks,
Andrew

