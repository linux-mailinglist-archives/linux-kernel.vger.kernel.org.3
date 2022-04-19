Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CDA507211
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353997AbiDSPsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243401AbiDSPsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:48:32 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F091BF6E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:45:49 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e2fa360f6dso17941305fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=k80igm9bNYeo0/PuGUmVJIFnE85OFqPLleVrR/GfhOI=;
        b=A+7wUP963dS6aGhmek9wwRA/GDmHbWws04i5dh9LdMjVk5cV3jP9YeQwl+QFX2HzL2
         x6DqMrRlcX2wd5vLhkSRv+w1u9zmBNW/ZOb9wP38+SjnUbP2IktJq4yKXYSB2VaP+8MO
         xcVitCJ4zLm9g/CHNyNdmeakGh3rr9tuojwwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=k80igm9bNYeo0/PuGUmVJIFnE85OFqPLleVrR/GfhOI=;
        b=Rxvrfdyylr58WwqfwQw1tN4rY4oxI+dLUYkzHXePB73moqumMTEVSPKxorn7B3j7Fg
         WvFsbYvs4eBmQZkc0RlBNTAAox63kXG7qkQyx2f57SaLwqFlawDWuVWaRRHbwguC2geM
         hhnEujp8ejnkSDAt5NrPsi1we5MkNM1Aev6lpJLV25Q8HCGHKEHBdqo3rq90xYldMyFF
         otsoJOfrAQxL1NFbUyasrD4Zrb58YLe7mIQy075FeUdjZfIb5ZDI6Pmbyr+4+UHiClNG
         H2xY+g5P0T4bvOK/Hf0/B/fk/fKOBEaTl8Uoq/jpj7ndSfGIx7zm3vSCfwDc4Cz12Zz9
         7atg==
X-Gm-Message-State: AOAM532hriQrjdKsvIJkm8dX4D6p79aLtslQDCOjt1btUpcOCPXrOhQj
        bcGO1qcfoC6z8t+Mp+kz4D00dzdAFPdid21vlEmqBg==
X-Google-Smtp-Source: ABdhPJzk6+Q51TifhGU0xY14VkV/+mpM+40heyVecZrtV+q3RQACke7WNgpOzd0DTutcDoqHSMARdxnCqmfsiltD298=
X-Received: by 2002:a05:6870:3907:b0:e5:a6fd:4047 with SMTP id
 b7-20020a056870390700b000e5a6fd4047mr6541720oap.193.1650383148187; Tue, 19
 Apr 2022 08:45:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Apr 2022 08:45:47 -0700
MIME-Version: 1.0
In-Reply-To: <Yl7Nb0mNjt7kV3uV@sirena.org.uk>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649939418-19861-8-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n533obTi995x_rJG_ihUUquF3MQLJt6VMf7=oxyzMUL5DQ@mail.gmail.com> <Yl7Nb0mNjt7kV3uV@sirena.org.uk>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 19 Apr 2022 08:45:47 -0700
Message-ID: <CAE-0n53zWdrT7S6MKM_aktnj=AwjUKH0XKySwSkfkX8vTv2w9w@mail.gmail.com>
Subject: Re: [PATCH V10 7/9] regulator: Add a regulator driver for the PM8008 PMIC
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2022-04-19 07:55:43)
> On Thu, Apr 14, 2022 at 05:25:49PM -0700, Stephen Boyd wrote:
> > Quoting Satya Priya (2022-04-14 05:30:16)
>
> > > +static struct platform_driver pm8008_regulator_driver = {
> > > +       .driver = {
> > > +               .name           = "qcom-pm8008-regulator",
>
> > I'd prefer to use an of_device_id table here. That would let us populate
> > a "qcom,pm8008-regulators" node that had the ldo nodes as children and
> > avoid mfd cells.
>
> That's encoding the current Linux way of splitting up drivers into the
> DT rather than describing the hardware.

The DT binding has a subnode of the pm8008@8 node for 'regulators'.
There's also a subnode for gpios (see qcom,pm8008-gpio). The gpio node
has a reg property, so I'm confused how we can even have the regulators
container node at the same level as the gpio node with a reg property.
Every node that's a child of pm8008@8 either needs to have a reg
property or not.

What benefit does it have to not describe secondary i2c addresses as
nodes in DT? I think it's necessary because the reset gpio needs to be
deasserted before i2c read/write to either address, 8 or 9, will work.
Otherwise I don't understand. Having the reset puts us into a small bind
though because child nodes sometimes have a reg property and other times
don't.

This is the current example

	i2c {
	  pm8008@8 {
	    compatible = "qcom,pm8008";
	    #address-cells = <1>;
	    #size-cells = <0>;
	    reset-gpios = <&tlmm 23 GPIO_ACTIVE_HIGH>;
	    gpios {
	      compatible = "qcom,pm8008-gpio", "qcom,spmi-gpio";
	      reg = <0xc000>;
	      ...

	    };

	    regulators {
	      vdd_l1_l2-supply = <&vreg_s8b_1p2>;
	
	      ldo1 {
	        regulator-name = "pm8008_l1";
	      };
	      ldo2 {
	        regulator-name = "pm8008_l2";
	      };
	    };
	  };
	};

What should the final result be? Dropping the regulators node would end
up with the same problem where ldo1 has no reg property. Adding a reg
property to ldo1 might work, but it would be a register offset inside
i2c address 9 while the binding makes it look like a register offset
within 9. The binding for the container node could get two address
cells, so that the first cell describes the i2c address offset?

	i2c {
	  pm8008@8 {
	    compatible = "qcom,pm8008";
	    #address-cells = <2>;
	    #size-cells = <0>;
	    reset-gpios = <&tlmm 23 GPIO_ACTIVE_HIGH>;

	    vdd_l1_l2-supply = <&vreg_s8b_1p2>;

	    gpios@0,c000 {
	      compatible = "qcom,pm8008-gpio", "qcom,spmi-gpio";
	      reg = <0x0 0xc000>;
	      ...

	    };

	    ldo1@1,30 {
	      compatible = "qcom,pm8008-regulator";
	      reg = <0x1 0x30>;
	      regulator-name = "pm8008_l1";
	    };
	    ldo2@1,40 {
	      compatible = "qcom,pm8008-regulator";
	      reg = <0x1 0x40>;
	      regulator-name = "pm8008_l2";
	    };
	  };
	};

We don't make a node for each gpio so I don't know why we would make a
node for each regulator. The above could be changed to have the
regulators node and a reg property like this

	i2c {
	  pm8008@8 {
	    compatible = "qcom,pm8008";
	    #address-cells = <2>;
	    #size-cells = <0>;
	    reset-gpios = <&tlmm 23 GPIO_ACTIVE_HIGH>;

	    gpios@0,c000 {
	      compatible = "qcom,pm8008-gpio", "qcom,spmi-gpio";
	      reg = <0x0 0xc000>;
	      ...

	    };

	    regulators@1,0 {
	      compatible = "qcom,pm8008-regulators";
	      vdd_l1_l2-supply = <&vreg_s8b_1p2>;

	      reg = <0x1 0x0>;
	      ldo1 {
	      regulator-name = "pm8008_l1";
	      };
	      ldo2 {
	        regulator-name = "pm8008_l2";
	      };
	    };
	  };
	};

I wonder if there's a mapping table property like i2c-ranges or
something like that which could be used to map the i2c dummy to the
first reg property. That would be super awesome so that when the
platform bus is populated we could match up the regmap for the i2c
device to the platform device automatically.

By the way, Is there any document on "best practices" for i2c devicetree
bindings?  We should add details to the document to describe this
situation so this can be conveyed faster next time.
