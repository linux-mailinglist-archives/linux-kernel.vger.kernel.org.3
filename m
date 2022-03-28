Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E324E8EC5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbiC1HO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiC1HO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:14:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911DD52B31;
        Mon, 28 Mar 2022 00:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE8B61196;
        Mon, 28 Mar 2022 07:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1793AC340F0;
        Mon, 28 Mar 2022 07:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648451566;
        bh=aTuuu2axi5cYif53H68iRcvN42KyVTPoMDC9fe2anyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MoVfhhlA/29cW3VhAR23lZnCDNRqrdeLAKITFPTfJoJucgIr+sp5oWCLg0MrN0Xzd
         d93PUkblrsotySSq6DYolTiQ0Xkalh8eX4ZjlaN/N32iclyMhJdkrtwDs/LuMiM1tJ
         umm1o3HvqhtZZygnh5RE/CESeBs7M7tFJOqunMZa5GBrICkEfFJ8ZjWIkpgSOQvGOJ
         w0KeQW5lP5t/UG1arWS3AQ1iZTjWy5igQdclB+GXCZnZR+dUWOPOvEs3+MjNVeE210
         QK2Ap9HTukWjRscbTIgqXk8AFmKv0DW9AB7VtEu2D/x5vDdv/VClqwMxN6snomXz4L
         otLBXcxkxUG2g==
Date:   Mon, 28 Mar 2022 12:42:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: Don't report disabled nodes with duplicate
 addresses
Message-ID: <YkFf6kuOZYJcYGrD@matsya>
References: <20220210065132.234341-1-vkoul@kernel.org>
 <CAL_JsqKPO0TGDjD1+_Tbg39YRpxRCcH_LTy83SHcMBzFA_tw2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKPO0TGDjD1+_Tbg39YRpxRCcH_LTy83SHcMBzFA_tw2g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 10-02-22, 08:39, Rob Herring wrote:
> On Thu, Feb 10, 2022 at 12:51 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > Duplicated unit address is okay if we have only one such node enabled.
> > So, remove '-Wno-unique_unit_address' from DTC_FLAGS.
> >
> > This helps in reducing warnings in qcom dts from
> >
> >    6483 unique_unit_address
> >    1108 simple_bus_reg
> >     764 avoid_unnecessary_addr_size
> >     712 unit_address_vs_reg
> >     120 graph_child_address
> >      32 unique_unit_address_if_enabled
> >
> > after this patch:
> >     277 simple_bus_reg
> >     191 avoid_unnecessary_addr_size
> >     178 unit_address_vs_reg
> >      32 unique_unit_address_if_enabled
> >      30 graph_child_address
> 
> I'm confused how unique_unit_address changes the count for others?

It does, I reran this and comparing before and after logs and looking
at the diff, few other warnings seems to disappear as well:

For example these are not shown now after applying the patch and they
seem legit to me

arch/arm64/boot/dts/qcom/ipq6018.dtsi:181.11-764.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
arch/arm64/boot/dts/qcom/ipq6018.dtsi:188.20-193.5: Warning (simple_bus_reg): /soc/qrng@e1000: simple-bus unit address format error, expected "e3000"
arch/arm64/boot/dts/qcom/ipq6018.dtsi:519.9-525.5: Warning (simple_bus_reg): /soc/timer: missing or empty reg/ranges property
arch/arm64/boot/dts/qcom/ipq6018.dtsi:646.22-679.5: Warning (simple_bus_reg): /soc/usb2@7000000: simple-bus unit address format error, expected "70f8800"
  also defined at arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts:86.7-88.3
arch/arm64/boot/dts/qcom/ipq6018.dtsi:723.22-763.5: Warning (simple_bus_reg): /soc/usb3@8A00000: simple-bus unit address format error, expected "8af8800"
arch/arm64/boot/dts/qcom/ipq6018.dtsi:300.22-313.5: Warning (unique_unit_address): /soc/spi@78b6000: duplicate unit-address (also used in node /soc/i2c@78b6000)
arch/arm64/boot/dts/qcom/msm8996.dtsi:427.18-436.5: Warning (unit_address_vs_reg): /reserved-memory/rmtfs@86700000: node has a unit name, but no reg or ranges property
arch/arm64/boot/dts/qcom/msm8996.dtsi:576.11-3188.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
arch/arm64/boot/dts/qcom/msm8996.dtsi:1569.11-1730.5: Warning (unit_address_vs_reg): /soc/agnoc@0: node has a unit name, but no reg or ranges property
arch/arm64/boot/dts/qcom/msm8996.dtsi:2994.24-2997.7: Warning (unit_address_vs_reg): /soc/slim@91c0000/ngd@1/tas-ifd: node has a reg or ranges property, but no unit name
arch/arm64/boot/dts/qcom/msm8996.dtsi:3063.13-3066.8: Warning (unit_address_vs_reg): /soc/remoteproc@9300000/smd-edge/apr/q6core: node has a reg or ranges property, but no unit name
arch/arm64/boot/dts/qcom/msm8996.dtsi:3068.19-3080.8: Warning (unit_address_vs_reg): /soc/remoteproc@9300000/smd-edge/apr/q6afe: node has a reg or ranges property, but no unit name
arch/arm64/boot/dts/qcom/msm8996.dtsi:3082.19-3092.8: Warning (unit_address_vs_reg): /soc/remoteproc@9300000/smd-edge/apr/q6asm: node has a reg or ranges property, but no unit name
arch/arm64/boot/dts/qcom/msm8996.dtsi:3094.19-3101.8: Warning (unit_address_vs_reg): /soc/remoteproc@9300000/smd-edge/apr/q6adm: node has a reg or ranges property, but no unit name
arch/arm64/boot/dts/qcom/msm8996.dtsi:1569.11-1730.5: Warning (simple_bus_reg): /soc/agnoc@0: missing or empty reg/ranges property
arch/arm64/boot/dts/qcom/msm8996.dtsi:1810.23-1943.5: Warning (simple_bus_reg): /soc/camss@a00000: simple-bus unit address format error, expected "a34000"
arch/arm64/boot/dts/qcom/msm8996.dtsi:831.21-878.6: Warning (avoid_unnecessary_addr_size): /soc/mdss@900000/dsi@994000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
arch/arm64/boot/dts/qcom/pm8994.dtsi:132.9-141.4: Warning (avoid_unnecessary_addr_size): /soc/spmi@400f000/pmic@1: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
arch/arm64/boot/dts/qcom/msm8996.dtsi:3046.13-3104.6: Warning (avoid_unnecessary_addr_size): /soc/remoteproc@9300000/smd-edge: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
arch/arm64/boot/dts/qcom/msm8996.dtsi:2901.27-2916.5: Warning (unique_unit_address): /soc/i2c@75ba000: duplicate unit-address (also used in node /soc/spi@75ba000)
arch/arm64/boot/dts/qcom/msm8996.dtsi:927.11-937.7: Warning (graph_child_address): /soc/mdss@900000/hdmi-tx@9a0000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
arch/arm64/boot/dts/qcom/ipq8074.dtsi:104.11-849.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
arch/arm64/boot/dts/qcom/ipq8074.dtsi:651.9-657.5: Warning (simple_bus_reg): /soc/timer: missing or empty reg/ranges property

Thanks
> 
> >
> > which would help people focus on the actual warnings and fix them.
> 
> Hopefully you do a 'sort -u' on the warnings to dedup them...
> 
> >
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  scripts/Makefile.lib | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 79be57fdd32a..7e4f6671d950 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -299,7 +299,8 @@ quiet_cmd_gzip = GZIP    $@
> >  # DTC
> >  # ---------------------------------------------------------------------------
> >  DTC ?= $(objtree)/scripts/dtc/dtc
> > -DTC_FLAGS += -Wno-interrupt_provider
> > +DTC_FLAGS += -Wno-interrupt_provider \
> > +       -Wno-unique_unit_address
> >
> >  # Disable noisy checks by default
> >  ifeq ($(findstring 1,$(KBUILD_EXTRA_WARN)),)
> > @@ -307,8 +308,9 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
> >         -Wno-avoid_unnecessary_addr_size \
> >         -Wno-alias_paths \
> >         -Wno-graph_child_address \
> > -       -Wno-simple_bus_reg \
> > -       -Wno-unique_unit_address
> > +       -Wno-simple_bus_reg
> > +else
> > +DTC_FLAGS += -Wunique_unit_address_if_enabled
> >  endif
> >
> >  ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
> > --
> > 2.31.1
> >

-- 
~Vinod
