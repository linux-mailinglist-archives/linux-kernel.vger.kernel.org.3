Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7EF55A326
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiFXU7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiFXU7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:59:07 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BDB3057A;
        Fri, 24 Jun 2022 13:59:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b21so3408979ljf.1;
        Fri, 24 Jun 2022 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eZSZCpbsimxpe8y0nI2vhGyb3S9o4fusHBXGkJK5Cfc=;
        b=QtMwHvmYMWJKh0ZLqnKgANF/OLV82B74Mco6zvnuZeUejNoYhy3/XMUTG/IZxeWN1g
         kJdFX7Hjjll5/gBbGDFfE6NZ8Z29REr8unbv/+Rw3EywhBgZrzUKHOFbsy+9hm74n6W9
         FgxFz9+BxFFugBZ7wGl/0JzWCFktsdwHV3yRMFgHnNXL54N/hJPqiRFrtpAHgfAV26va
         xmrjOfYjXA5cjt979wG15bgUAfQ9zTnFdadgyXYvvGP+unwebPCQDrxzW6mC4gLjZm8L
         VBd3ejedJJ834pxFVJIh0zkDdBaoMunu6IPVDte8eqiNoRGsva/W17BJryh5PbVTYkVi
         zfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eZSZCpbsimxpe8y0nI2vhGyb3S9o4fusHBXGkJK5Cfc=;
        b=srRWHy+1Q5eq91BIM22aSW3pP28nz3PL/RyrY0cFyN+RbqWFoIjjxxb0Jn+FS5u/eQ
         xDVNsR07FBNvGw7aLAev+67NSq6GXiKK0LMzy7eL3CHN3T9C9ZcTXqJqKdIo9FF9Mjmw
         dnnvXFhhx6KvmmfEPVH+JC6iPYCcqtMhYrzEWAA0wWc6aA2tjqpg0uO7SMRWh8LngAIU
         Z65BnY/PmbbFNJ+4TZsaPzmWyibIah85QxUcR0VacEfFi/gfisLw/8O8UHZRks7D5niL
         4xaCfQiNS4JNUTaFYjXVODj70YnGBAg9kmnKT5RKa3cVdXS033LHv1UrsFqGLgVi7WU4
         v3Kw==
X-Gm-Message-State: AJIora/jLz8l1kUXmMWsAgZSsbNFuxlau7KZADqzYMOeF8T44yBNIfxS
        Ix8ClrQwHGuGddcLH1CeArM=
X-Google-Smtp-Source: AGRyM1v6fuennno+VmySkb2y5X/FFQLPUJh7sXw3iLNDmiKty2pRq4AJTIzsRg4onyEuYZ8fkJyBPA==
X-Received: by 2002:a05:651c:1617:b0:25a:9e88:af82 with SMTP id f23-20020a05651c161700b0025a9e88af82mr401410ljq.106.1656104345088;
        Fri, 24 Jun 2022 13:59:05 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id 13-20020ac2568d000000b0047fa40b5052sm523338lfr.62.2022.06.24.13.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 13:59:04 -0700 (PDT)
Date:   Fri, 24 Jun 2022 23:59:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-snps-arc@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v9 5/5] arm64: dts: apm: Harmonize DWC USB3 DT
 nodes name
Message-ID: <20220624205902.y2un4lr7d3zkc6jx@mobilestation>
References: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141622.7149-6-Sergey.Semin@baikalelectronics.ru>
 <eb00b6c3-ae5e-9858-ab5f-fd78229ff436@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb00b6c3-ae5e-9858-ab5f-fd78229ff436@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 07:17:53PM +0200, Krzysztof Kozlowski wrote:
> On 24/06/2022 16:16, Serge Semin wrote:
> > In accordance with the DWC USB3 bindings the corresponding node
> > name is suppose to comply with the Generic USB HCD DT schema, which
> > requires the USB nodes to have the name acceptable by the regexp:
> > "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> > named despite of the warning comment about possible backward
> > compatibility issues.
> 

> Sometimes node name is exposed to user-space which depends on it. How
> did you check there is no issue here?

I well remember the Qcom problem caused by one of my patch:
https://lore.kernel.org/lkml/CALAqxLX_FNvFndEDWtGbFPjSzuAbfqxQE07diBJFZtftwEJX5A@mail.gmail.com/

The next patch caused the same problem, but hasn't been reverted.
https://lore.kernel.org/lkml/CALAqxLWGujgR7p8Vb5S_RimRVYxwm5XF-c4NkKgMH-43wEBaWg@mail.gmail.com/

As before I am more inclined to thinking that the problem was mainly caused
by the improper node-name utilization. Anyway John later noted that the
problem was fixed in the user-space. That why afterwards you were able
to provide the commit b77a1c4d6b05 ("arm64: dts: qcom: correct DWC3
node names and unit addresses").

Anyway I am not able to track the way the node-name is used on the
affected platform and can't make sure that the dts would be still
working well on that devices. But seeing nobody responded/commented on
this patch for more than a year we can at least try to merge this in
and see whether it causes any problem should the denoted platform is
still in use. If it does we can revert the update back and forget
about it.

-Sergey

> 
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 4 ++--
> >  arch/arm64/boot/dts/apm/apm-storm.dtsi     | 6 +++---
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
> > index a83c82c50e29..832dd85b00bd 100644
> > --- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
> > +++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
> > @@ -597,8 +597,8 @@ serial0: serial@10600000 {
> >  			interrupts = <0x0 0x4c 0x4>;
> >  		};
> >  
> > -		/* Do not change dwusb name, coded for backward compatibility */
> > -		usb0: dwusb@19000000 {
> > +		/* Node-name might need to be coded as dwusb for backward compatibility */
> > +		usb0: usb@19000000 {
> >  			status = "disabled";
> >  			compatible = "snps,dwc3";
> >  			reg =  <0x0 0x19000000 0x0 0x100000>;
> > diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> > index 0f37e77f5459..1520a945b7f9 100644
> > --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> > +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> > @@ -923,8 +923,8 @@ sata3: sata@1a800000 {
> >  			phy-names = "sata-phy";
> >  		};
> >  
> > -		/* Do not change dwusb name, coded for backward compatibility */
> > -		usb0: dwusb@19000000 {
> > +		/* Node-name might need to be coded as dwusb for backward compatibility */
> > +		usb0: usb@19000000 {
> >  			status = "disabled";
> >  			compatible = "snps,dwc3";
> >  			reg =  <0x0 0x19000000 0x0 0x100000>;
> > @@ -933,7 +933,7 @@ usb0: dwusb@19000000 {
> >  			dr_mode = "host";
> >  		};
> >  
> > -		usb1: dwusb@19800000 {
> > +		usb1: usb@19800000 {
> >  			status = "disabled";
> >  			compatible = "snps,dwc3";
> >  			reg =  <0x0 0x19800000 0x0 0x100000>;
> 
> 
> Best regards,
> Krzysztof
