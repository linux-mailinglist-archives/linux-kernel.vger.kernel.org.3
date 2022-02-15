Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417E24B6F21
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbiBOOjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:39:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiBOOji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:39:38 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E7010241F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:39:28 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r27so20935243oiw.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lf/4yqUubIAsBX3zBqJUmMO3ziUy/Ck0QlY5xnv6TAw=;
        b=gCNi9H6h5bownQSUa/VlA7DaUpzKEcyHZY+rUbUzonZgquaJz2Rg9EN+8hFdSbUT5Y
         5Uj/XSNONMm2HRGEkBJEFXX3k10LrTPETlA2Bk8MUvsH5uUnDaH/YJoByOUVzXqKFVQz
         juPMxVhFJ2wUNzdliMpAqPOtvUKmzBiUC+4wsobuYOgWHMDWBz0/pi9Txbr3nD7xYFoP
         Xzo/H+26Pk5J83rLP2ymnZPGgE7ZaC4r5wIHXj5TF5TFbbVejqj3AmApIiAUB1fsCk4U
         8JXQh2BkHfKK1wXPfgPRZZL4uY8VZsL921qAAsocG0C6h2idZgYi9kuUuvns+VUyDj0k
         QaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lf/4yqUubIAsBX3zBqJUmMO3ziUy/Ck0QlY5xnv6TAw=;
        b=6U5INSvwErLpRKsnmANwyC8PEanLs6tigUJgTNHKS9TtEMR7crpOYJRLK0jBsPENQc
         Qo353/xNr6Usu9GCv83/VX6IX0zj/tjvG1H8acVex25p4TOO47aILfHTUM47mykoDTYi
         R6O7kp/wFvN5b/vCzKBem1vQqrBIi6QH3+hpSIQ1kglkLzpCPQvKunAXWQ0Yqi0R9eta
         QTIxFGJeZnMBNWztxcptAoAVcoFCoqfXsR0READqWAxSAZGcdHdlfQj5Xb6+vHW4mo6+
         RudhmImyxnDymt6fdw1px/vPubVAwrYHA+siHkQwfaVvPv89RGk9/wWiNzB3nDwzSEQG
         axLw==
X-Gm-Message-State: AOAM532vIIX90bNwl3bqtQU2zukjcKqiFQeLy412hrUHNgKlCkRjFeu+
        efmD+s71S491GTrZrftGeeJWxg==
X-Google-Smtp-Source: ABdhPJxKNfH/q+wfB2DRDx/TNV/ggNE+Wkg7gQclH/9vKbhBCkLSPxGUW40rpsmK/TP/T3bl6N4Qqg==
X-Received: by 2002:a05:6808:f05:: with SMTP id m5mr1561528oiw.337.1644935967969;
        Tue, 15 Feb 2022 06:39:27 -0800 (PST)
Received: from yoga ([2600:1700:a0:3dc8:5c39:baff:fe03:898d])
        by smtp.gmail.com with ESMTPSA id u5sm14029206ooo.46.2022.02.15.06.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 06:39:27 -0800 (PST)
Date:   Tue, 15 Feb 2022 08:39:25 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jarrett Schultz <jaschultz@microsoft.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jarrett Schultz <jaschultzms@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH RESEND v4 1/4] dt-bindings: platform:
 microsoft: Document surface xbl
Message-ID: <Ygu7HdrLnzFj3BrV@yoga>
References: <20211221182826.2141789-1-jaschultzMS@gmail.com>
 <20211221182826.2141789-2-jaschultzMS@gmail.com>
 <YcJiBk5f071eJ5+n@robh.at.kernel.org>
 <DM6PR21MB13238271EE4163A0F8A52B19A5289@DM6PR21MB1323.namprd21.prod.outlook.com>
 <BYAPR21MB1320B5FD66C8FA8C066A716AA5349@BYAPR21MB1320.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1320B5FD66C8FA8C066A716AA5349@BYAPR21MB1320.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Feb 19:04 CST 2022, Jarrett Schultz wrote:

> Jarrett Schultz wrote:
> > From: Jarrett Schultz
> > 
> > Rob Herring wrote:
> > > From: Rob Herring <robh@kernel.org>
> > >
> > > On Tue, Dec 21, 2021 at 10:28:23AM -0800, Jarrett Schultz wrote:
> > > > From: Jarrett Schultz <jaschultz@microsoft.com>
> > > >
> > > > +title: Surface Extensible Bootloader for Microsoft Surface Duo
> > > > +
> > > > +maintainers:
> > > > +  - Jarrett Schultz <jaschultz@microsoft.com>
> > > > +
> > > > +description: |
> > > > +  Defined to expose information that is used during production when
> > > > +  device is in manufacturing mode. Some of the information included
> > > > +  in this imem section is -
> > >
> > > If this is onchip sram, we have a binding for that. That's not an MFD.
> > 
> > I now have this driver working with nvmem, but I could not find the binding
> > that you are talking about here. Could you point me to the binding?
> > 
> > Thanks,
> > Jarrett
> > 
> 
> Rob,
> 
> I followed up with my team members who have let me know that this lies
> in DDR rather than SRAM. Could you please point me to the correct
> binding to use?
> 

It might be DDR, but it's on-chip and the memory region that you
describe is a region within "imem" - something used for various purposes
by Qualcomm, presumably also in your device. Unfortunately we haven't
specified a binding for "imem", only some of its regions.

Perhaps it would be appropriate to express the entire imem as nvmem, in
addition to the region-specific logic, if that suits you.

Regards,
Bjorn

> Thanks,
> Jarrett
> 
> > >
> > > > +    * board_id
> > > > +    * battery_present
> > > > +    * hw_init_retries
> > > > +    * is_customer_mode
> > > > +    * is_act_mode
> > > > +    * pmic_reset_reason
> > > > +    * touch_fw_version
> > > > +    * ocp_error_location
> > >
> > > nvmem binding doesn't work for describing these fields?
> > >
> > > > +  See sysfs documentation for more information.
> > >
> > > sysfs? Not relevant to the binding.
> > >
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: simple-mfd
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - ranges
> > > > +  - address-cells
> > > > +  - size-cells
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    / {
> > > > +        compatible = "foo";
> > > > +        model = "foo";
> > >
> > > No need to make this the root node with a fake compatible.
> > >
> > > > +        #address-cells = <2>;
> > > > +        #size-cells = <2>;
> > > > +
> > > > +        imem@146bf000 {
> > > > +          compatible = "simple-mfd";
> > > > +          reg = <0x0 0x146bf000 0x0 0x1000>;
> > > > +          ranges = <0x0 0x0 0x146bf000 0x1000>;
> > > > +          #address-cells = <1>;
> > > > +          #size-cells = <1>;
> > > > +          status = "okay";
> > >
> > > Don't show status in examples.
> > >
> > > > +
> > > > +          xbl@a94 {
> > > > +            compatible = "microsoft,sm8150-surface-duo-xbl";
> > > > +            reg = <0xa94 0x100>;
> > > > +            status = "okay";
> > > > +          };
> > > > +        };
> > > > +      };
> > > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > > > 13f9a84a617e..5d0ca2a98b57 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -12649,6 +12649,13 @@ F:	Documentation/driver-
> > > api/surface_aggregator/clients/dtx.rst
> > > >  F:	drivers/platform/surface/surface_dtx.c
> > > >  F:	include/uapi/linux/surface_aggregator/dtx.h
> > > >
> > > > +MICROSOFT SURFACE DUO XBL DRIVER
> > > > +M:	Jarrett Schultz <jaschultz@microsoft.com>
> > > > +L:	linux-arm-msm@vger.kernel.org
> > > > +L:	platform-driver-x86@vger.kernel.org
> > > > +S:	Supported
> > > > +F:	Documentation/devicetree/bindings/platform/microsoft/surface-
> > > xbl.yaml
> > > > +
> > > >  MICROSOFT SURFACE GPE LID SUPPORT DRIVER
> > > >  M:	Maximilian Luz <luzmaximilian@gmail.com>
> > > >  L:	platform-driver-x86@vger.kernel.org
> > > > --
> > > > 2.25.1
> > > >
> > > >
