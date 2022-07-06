Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB325689AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiGFNhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiGFNhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:37:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0276A22B0D;
        Wed,  6 Jul 2022 06:37:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sb34so27110991ejc.11;
        Wed, 06 Jul 2022 06:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=dKKydK5tKzNauOSLwuMbV7i2MBJlb9QQ2YCYOCrDsp0=;
        b=RCOcZ/hoR/jOgEOOmG7sVY3Cwwm5J3af33LdQfjNdAmlIsJKjRu5c+DZyyN/x6vvKr
         6DkFdOIjKTjWW1hrfSJf91OFXO9fVs71YIg1NkAWTG6muLnHQeRL0vB2VGafhf/0b4eP
         jRgl6534p614z/2XJ+d08Aa6rJcqnIz0vCOca5xBVJALxjW+Su2osASE2YgSTd6aX9qX
         XhebzEWfi3DCB/ZVJ1k/aSBPZ0/If5kdmBDg2aVnqOLn9YQHBRdFBz1XG8EOFfY7lBge
         UnmnLhuVMSxzHhl9F4jHbo10yT2b2NH3tPIaMCHrCCsMkCDzx15cUU8dyEe0iPrwdKKn
         rbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=dKKydK5tKzNauOSLwuMbV7i2MBJlb9QQ2YCYOCrDsp0=;
        b=l+TO3TFqNZObD0ki9LRqGRYiykzUvybX1yLWouAucDDUh5DA+QmlY9VwveoWb3vfUa
         UH0p5+FuIHblCzqn4nobmec/a+eUlbi+fHYItTTJR3WQBd0oKw2iiW6DlVJWgM6REmyt
         4VVmWkBsgUITIakngAOhF9pVeY/cekLDfVgObuY+hUl5c/2TaaTU2lAfgje/FsQj821L
         TdhIbfoJtiLZNAtYBSZxzuYGBVpe56j5a7ExD/3JcdJ9kGo2hUQMvo5aCd2edxoaITJ0
         Who/4P83NXo14BsIsy9Wrc7CZlVRc6x7LbUeq1RBiJjgP4sROgbhTIvBqk//F0X7XhqG
         Zp8Q==
X-Gm-Message-State: AJIora9ykDm41wLtfqcMwmGIxBnpfDptonRr+BWYe6Iu9Ut0nSgbYCco
        1XmglC2LQnF6npSLSxvwQ94=
X-Google-Smtp-Source: AGRyM1sZY9e/JHjxCK1nAL99G44PCfL49v1xRwoanY5pRQH9Q23XUfZdE9rTVuYAMi7NFDmhqJB8Gw==
X-Received: by 2002:a17:907:a428:b0:726:c9f6:cb72 with SMTP id sg40-20020a170907a42800b00726c9f6cb72mr38200703ejc.663.1657114662366;
        Wed, 06 Jul 2022 06:37:42 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id fi9-20020a170906da0900b00722e5b234basm17492148ejb.179.2022.07.06.06.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:37:27 -0700 (PDT)
Message-ID: <62c59017.1c69fb81.a08b4.f18c@mx.google.com>
X-Google-Original-Message-ID: <YsWMMULRVCaNe9Fe@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 15:20:49 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 06/13] ARM: dts: qcom: enable usb phy by default for
 ipq8064
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-7-ansuelsmth@gmail.com>
 <eadf03c4-7e4c-e2a0-b20d-6e2dff3af1e3@somainline.org>
 <62c58b03.1c69fb81.527d5.ecc6@mx.google.com>
 <837c6cd8-72d9-e7c8-dfd9-e171d809f0bf@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <837c6cd8-72d9-e7c8-dfd9-e171d809f0bf@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:33:25PM +0200, Konrad Dybcio wrote:
> 
> 
> On 6.07.2022 14:59, Christian Marangi wrote:
> > On Wed, Jul 06, 2022 at 03:04:44PM +0200, Konrad Dybcio wrote:
> >>
> >>
> >> On 5.07.2022 15:39, Christian Marangi wrote:
> >>> Enable usb phy by default. When the usb phy were pushed, half of them
> >>> were flagged as disabled by mistake. Fix this to correctly init dwc3
> >>> node on any ipq8064 based SoC.
> >> Are you sure they are used on *all* devices? If not, you will
> >> lose power by enabling unused hw..
> >>
> >> Konrad
> > 
> > Well there could be device that have no usb at all... so honestly
> > enabling one of them is also wrong. Should I disable the other and
> > enable it for the upstream device?
> We generally disable everything that's not obviously being used by the
> SoC internally or is required for components like these for function
> (think clock controllers etc) and enable peripherals on a per-device
> basis.
> 

Will change this to disable the other usb and push another commit to
enable usb on the upstream device.

> Konrad
> > 
> > Also it's all handled by dummy vbus so i think we can ignore the losing
> > power thing. (this thing is old)
> > 
> >>>
> >>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>> Tested-by: Jonathan McDowell <noodles@earth.li>
> >>> ---
> >>>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ----
> >>>  1 file changed, 4 deletions(-)
> >>>
> >>> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> >>> index b2faa4a067e9..9c32c637ea46 100644
> >>> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> >>> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> >>> @@ -1177,8 +1177,6 @@ hs_phy_0: phy@100f8800 {
> >>>  			clocks = <&gcc USB30_0_UTMI_CLK>;
> >>>  			clock-names = "ref";
> >>>  			#phy-cells = <0>;
> >>> -
> >>> -			status = "disabled";
> >>>  		};
> >>>  
> >>>  		ss_phy_0: phy@100f8830 {
> >>> @@ -1187,8 +1185,6 @@ ss_phy_0: phy@100f8830 {
> >>>  			clocks = <&gcc USB30_0_MASTER_CLK>;
> >>>  			clock-names = "ref";
> >>>  			#phy-cells = <0>;
> >>> -
> >>> -			status = "disabled";
> >>>  		};
> >>>  
> >>>  		usb3_0: usb3@100f8800 {
> > 

-- 
	Ansuel
