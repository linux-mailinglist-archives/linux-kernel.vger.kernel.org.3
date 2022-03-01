Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D994C8D47
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiCAOGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiCAOGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:06:33 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C475C673CC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:05:50 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id p4so7044312edi.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 06:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N005AwlH1PzA71NUEIY/vHtIRr35X9iAtVZVAl8AQhE=;
        b=yWDpHn3ZxeTncAqWxOgXJB4+cv/Jq+56OLnG14Cng/rsrxC21XQcAZPqDGYJHfxzWG
         kozfYM1TX7hdwZ/lThUShd8cCntctDLtIC8lUbCPvPBjeLZJmMjgYAnG7VTbsY0Ixcpl
         BiRcxg+LaTMUbp/xP9RGkKnsE71iRYQOqVmZnvJtlQDmHs8P4wLRmUbaRYCtmqa0mtsI
         PdNFc9Buor5nM7ZooyT9uVpudHpGXxTbphjliesyFIQg4NPS5iyJfZ4DNxy57OsCITBj
         01nGMTW3g+/2OQPxuAyTHG5qEGdbdSQlPK7YEs0IqjXzQpQ+0c9kprfKIROOGiyTgny8
         c1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N005AwlH1PzA71NUEIY/vHtIRr35X9iAtVZVAl8AQhE=;
        b=7ZVPSJRS6PwHKF5cx5paq4gUVDD7qdv6Kxu24Eh2gJYKexNRLVjp7NL1fzC77G27Z9
         xktj3S5jIDlfiBNJPajEdjX4ocE4us0ygZsyEppxPAhcSFCDdVuvc9D0579ifSLwp0n8
         46E+CvnCVU8xgwidcB5OBRqPXPVuDI9F4c4MUdxp5yzrlxjFW8l6ItV0u9IMIFsqzNDi
         9lOYGHmWgz8sysgG3vqYlzCz6pTurYSeciEcPKXgwEkATdjRBPQkfJR8Vc1pBVYdgs0x
         nsKK6oe4p+Y0CxsWjuDucofamPnQMNXKD+YqsWWBpKlKIO3nwtxxuUYTiEj1OBKWjz+k
         IDHA==
X-Gm-Message-State: AOAM5302Ki622taNQeDQx172veBrLTmlIzWfrw2A50UyqT0nhurWahuJ
        zzZ8t2/Z/CZKsiTKxc3j0ncpCTCkVlQ0uoHou6DhKA==
X-Google-Smtp-Source: ABdhPJx1S3eoIMz9zMH8opo26eotWUnGYPGCBix2/gr/tVzQp2i/MNdlRpn+y3CfRL8j9owXXlFDcYoS+raUA2nsDD8=
X-Received: by 2002:aa7:d7da:0:b0:40f:f16f:dc25 with SMTP id
 e26-20020aa7d7da000000b0040ff16fdc25mr24119297eds.17.1646143549264; Tue, 01
 Mar 2022 06:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20211028140009.23331-1-etienne.carriere@linaro.org> <58a0e791-9573-99c2-0cc5-3920a1048113@pengutronix.de>
In-Reply-To: <58a0e791-9573-99c2-0cc5-3920a1048113@pengutronix.de>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Tue, 1 Mar 2022 15:05:37 +0100
Message-ID: <CAN5uoS_DQNkG8J0C-oT8aC-Xfozy9hgwAge_x2e4S-HOhSn5=w@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ahmad,

On Mon, 28 Feb 2022 at 17:01, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Etienne,
>
> On 28.10.21 16:00, Etienne Carriere wrote:
> > Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> > based on an OP-TEE service invocation. The compatible mandates a
> > channel ID defined with property "linaro,optee-channel-id".
>
> I just found this thread via the compatible in the STM32MP131 patch set:
> https://lore.kernel.org/all/20220225133137.813919-1-gabriel.fernandez@foss.st.com/
>
> Linux doesn't care whether PSCI is provided by TF-A, OP-TEE or something
> else, so there is just the arm,psci* compatible.
>
> What's different about SCMI that this is not possible? Why couldn't the
> existing binding and driver be used to communicate with OP-TEE as secure
> monitor as well?

Compatible "linaro,scmi-optee" denote a alternate SCMI transport to
those already in v5.16.
"arm,psci" defines a mailbox + shmem interface.
"arm,psci
 it uses an optee service as in service


>
> Cheers,
> Ahmad
>
> >
> > Cc: devicetree@vger.kernel.org
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> > Changes since v6:
> >  - Remove maxItems from linaro,optee-channel-id description
> >
> > No change since v5
> >
> > Changes since v4:
> >  - Fix sram node name in DTS example: s/-shm-/-sram-/
> >
> > Changes since v3:
> >  - Add description for linaro,optee-channel-id in patternProperties
> >    specifying protocol can optionaly define a dedicated channel id.
> >  - Fix DTS example (duplicated phandles issue, subnodes ordering)
> >  - Fix typo in DTS example and description comments.
> >
> > Changes since v2:
> >  - Define mandatory property linaro,optee-channel-id
> >  - Rebased on yaml description file
> >
> > Changes since v1:
> >  - Removed modification regarding mboxes property description.
> > ---
> >  .../bindings/firmware/arm,scmi.yaml           | 65 +++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > index 5c4c6782e052..eae15df36eef 100644
> > --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > @@ -38,6 +38,9 @@ properties:
> >                       The virtio transport only supports a single device.
> >          items:
> >            - const: arm,scmi-virtio
> > +      - description: SCMI compliant firmware with OP-TEE transport
> > +        items:
> > +          - const: linaro,scmi-optee
> >
> >    interrupts:
> >      description:
> > @@ -83,6 +86,11 @@ properties:
> >      description:
> >        SMC id required when using smc or hvc transports
> >
> > +  linaro,optee-channel-id:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Channel specifier required when using OP-TEE transport.
> > +
> >    protocol@11:
> >      type: object
> >      properties:
> > @@ -195,6 +203,12 @@ patternProperties:
> >          minItems: 1
> >          maxItems: 2
> >
> > +      linaro,optee-channel-id:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Channel specifier required when using OP-TEE transport and
> > +          protocol has a dedicated communication channel.
> > +
> >      required:
> >        - reg
> >
> > @@ -226,6 +240,16 @@ else:
> >        - arm,smc-id
> >        - shmem
> >
> > +  else:
> > +    if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: linaro,scmi-optee
> > +    then:
> > +      required:
> > +        - linaro,optee-channel-id
> > +
> >  examples:
> >    - |
> >      firmware {
> > @@ -340,7 +364,48 @@ examples:
> >                  reg = <0x11>;
> >                  #power-domain-cells = <1>;
> >              };
> > +        };
> > +    };
> > +
> > +  - |
> > +    firmware {
> > +        scmi {
> > +            compatible = "linaro,scmi-optee";
> > +            linaro,optee-channel-id = <0>;
> > +
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            scmi_dvfs1: protocol@13 {
> > +                reg = <0x13>;
> > +                linaro,optee-channel-id = <1>;
> > +                shmem = <&cpu_optee_lpri0>;
> > +                #clock-cells = <1>;
> > +            };
> > +
> > +            scmi_clk0: protocol@14 {
> > +                reg = <0x14>;
> > +                #clock-cells = <1>;
> > +            };
> > +        };
> > +    };
> >
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        sram@51000000 {
> > +            compatible = "mmio-sram";
> > +            reg = <0x0 0x51000000 0x0 0x10000>;
> > +
> > +            #address-cells = <1>;
> > +            #size-cells = <1>;
> > +            ranges = <0 0x0 0x51000000 0x10000>;
> > +
> > +            cpu_optee_lpri0: optee-sram-section@0 {
> > +                compatible = "arm,scmi-shmem";
> > +                reg = <0x0 0x80>;
> > +            };
> >          };
> >      };
> >
>
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
