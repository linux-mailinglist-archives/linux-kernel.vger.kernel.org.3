Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728024BA465
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbiBQPbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:31:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiBQPbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:31:17 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173032B1A98
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:31:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e3so9765764wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sqrY7cr1RKA78TNpBuiiBPVSVoBxKNilTCABh+xfoi4=;
        b=RWjrOwsj/w51HG/vxAaXh9kRWM7cfeMqFGi6yy7em512H3WE3w+qQwnkhYJRru5He0
         4+/cdiaNwLkCyeygmx0FygthSHkzVTxTmTCq8HGWUcWGyN/iUrrSELdJbvUgNoYTVIHE
         cNw7knyCE/Ll0z5mvCrwq0+df7niRY6Z4KM91SwxoH9y2r8HfCLtSlUn/X6G4VMcXKPH
         RXoavbgr6dTYPFEe+yfQeHwTPB9/3BSWcSbPeTWngXjifoDUJwoTf7Ub6DIv7Ub0wP8R
         pdqJqHovXHXaIAnH8HBtrATsbp/9Eog+TCkLRNb6x2qSDYvdkwOf8TpDLgyHdEP2wC1S
         sxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqrY7cr1RKA78TNpBuiiBPVSVoBxKNilTCABh+xfoi4=;
        b=Seo4aP7o9wSdNk0wbBLc6T513ZgzdM9pBNyEHcDNTvpcLCHPnKatfv6IGYvmg6Lhnc
         xSFF/UjI4bsOj1OP5HnBCaM6WC6SNIosAmJ6fc6QNyC36lv2KoPBiIFA3Ib49xQxeHc9
         RzSWvE7Ft2Bv3vvC1VucBlE1+gOTvWhHvvfixm+5ranzdnLAFqzz/67YiXGGBG0m5Frd
         HxaCf0XN5u9F5TEZUBcAct68a7uSXaUUtc7bHVlUDc+pAqOFMfhoaU1e0Hx9++cMj/CU
         cYR3485H1NVfpKit80uUMCRpy0uyHonLixpAt59Nhc/LJELcYvOQCWMpHrqgozniIC9S
         vpEA==
X-Gm-Message-State: AOAM532MBLwoQUu01THujy6h6R9vPD+IyuzqfkokVSMYPbQIIo9PMziJ
        wedzdQJU5W8WJkkhijoL+qu+qTki7Xkn0VeHrvbAlg==
X-Google-Smtp-Source: ABdhPJzaOOM9K/l0lss/puzUbxcEcPggkEXXEuDNTQPmwxXqOqgESnLLklMo6KboIgoXcbITVviR8XCovB0E+8oIqyA=
X-Received: by 2002:a5d:6da8:0:b0:1e3:c0b:153d with SMTP id
 u8-20020a5d6da8000000b001e30c0b153dmr2663917wrs.658.1645111860444; Thu, 17
 Feb 2022 07:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20220209105706.18852-1-quic_jinlmao@quicinc.com>
 <CAJ9a7VhZtNrj9S4T=dNDOWT9fEcnm1qqtp+4h3EqytidDwEd5Q@mail.gmail.com> <0c87c995-142c-9c8f-5a9a-02e3a1119cce@quicinc.com>
In-Reply-To: <0c87c995-142c-9c8f-5a9a-02e3a1119cce@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 17 Feb 2022 15:30:49 +0000
Message-ID: <CAJ9a7Vi=yYAEiHy-hAZNLKamRi-kQMGh02LSiVC6qGbeCOOUCg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Coresight: Add support for TPDM and TPDA
To:     Jinlong Mao <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
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

Hi,


On Fri, 11 Feb 2022 at 04:17, Jinlong Mao <quic_jinlmao@quicinc.com> wrote:
>
>
> On 2/10/2022 6:30 PM, Mike Leach wrote:
> > Hello  Mao,
> >
> > I have looked through this set and have a few general questions.
> >
> > My understanding based on the information in the code is that the TPDM
> > devices will always send data to the TPDA device, the TPDM is not
> > capable of directly driving the ATB itself?
> > The TPDA device  will then packetize the inputs and output these to
> > the ATB over the normal CoreSight architecture to a standard ETR / ETF
> > for collection.
> >
> > Looking at the TPDM driver - it is assigned a trace ID but never
> > actually uses it in the hardware. My assumption here is that this is
> > used purely to satisfy the requirement that the CoreSight core has
> > that all sources have a unique trace id?
> >
> > For the TPDA driver you assign an ATID as an attribute in device tree,
> > and then program this into the devices control register.
> >
> > The trace IDs in ETM / ETE / STM, are programmed into the hardware and
> > these values drive the ATID value on the trace bus. So assigning an
> > ATID value to the TPDA driver through device tree will lead to clashes
> > with the assignment of trace IDs in the other driver software.
> >
> > The topology here appears to me that you have multiple  "data source"
> > devices TPDM, supplying a TPDA - which is the real CoreSight "trace
> > source" from the viewpoint of the trace bus and CoreSight
> > infrastructure.
> > To get this to work in the current CoreSight driver stack, you have
> > assigned the TPDM as a source type, and the TPDA as a link to ensure
> > that when a TPDM is started, all the components on the path to the
> > sink are activated.
> > This is fine.
> >
> > If my assumptions above are all accurate I suggest the following improvements
> >
> > For TPDA drop the device tree assignment of ATID and instead use the
> > coresight_get_system_trace_id() function you introduce in the 2nd
> > patch in this set.
> >
> > For TPDM you have assigned a unique source sub-type
> > CORESIGHT_DEV_SUBTYPE_SOURCE_SYS.- this could become
> > CORESIGHT_DEV_SUBTYPE_SOURCE_DATA_ONLY. If the trace ID assigned to
> > this device is only to satisfy the unique ID requirement and is not
> > used elsewhere, then the sub type could become
> > CORESIGHT_DEV_SUBTYPE_SOURCE_DATA_ONLY. We can agree that this sub
> > type does not need a unique ID and acts as none ATB a source for
> > another component, The core code can be altered to drop the
> > requirement for this sub-type and trace ID can be dropped for this
> > component.
> >
> > You should be aware that we are in the process of re-designed how
> > trace IDs are allocated. The current mechanism does not scale for
> > large multi-core systems (currently broken for any system > 46 cores),
> > and as you have discovered there is a need for additional allocation
> > of IDs. Also the ETE / TRBE combination does not need a trace ID.  A
> > dynamic allocation system is being proposed.
> >
> > Regards
> >
> > Mike
>
>
> Hi  Mike,
>
> Your assumptions above are all correct.
> TPDMs connect to the same TPDA will share the atid of the TPDA.
> We have a PC tool to parse the TPDM trace data. It needs the fixed atid
> for each TPDA to identify the data.
> So we configure the atid for TPDA in device tree with fixed ids.
> I will discuss with internal tool team to see if TPDA's id can become
> dynamic when parse the data.
>
I understand that it is essential to know the ID when extracting the
trace from a sink with a coresight frame fomatter.
However, tools such as perf, achieve this by saving the metadata for
the session. If you are programming the trace ID, then it should be
possible to read back the same register to get the required
information for your trace session.

If this is genuinely not possible for your system, then treat as a
fixed ID as I describe below.

> Apart from the TPDA's atid, we also have some other sources with fixed
> id in HW on our internal device.
> Do you have any suggestion to how to allocate the IDs for the source
> with fixed id in HW ?
>
>
Fixed IDs in hardware - assuming that these devices do write directly
onto the trace bus using the ATID, should be accommodated by reserving
the fixed ID in any scheme used to allocate IDs,
In your case this would be to set a bit at the correct area in the bitfield.

As mentioned we are working on an updated system to dynamically
allocate IDs for CoreSight sources - a reservation scheme for fixed ID
devices will be provided
.

Regards

Mike

 >< Thanks
> Jinlong Mao
>
>
> >
> >
> > On Wed, 9 Feb 2022 at 10:57, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
> >> This series adds support for the trace performance monitoring and
> >> diagnostics hardware (TPDM and TPDA). It is composed of two major
> >> elements.
> >> a) Changes for original coresight framework to support for TPDM and TPDA.
> >> b) Add driver code for TPDM and TPDA.
> >>
> >> Introduction of changes for original coresight framework
> >> Support TPDM as new coresight source.
> >> Since only STM and ETM are supported as coresight source originally.
> >> TPDM is a newly added coresight source. We need to change
> >> the original way of saving coresight path to support more types source
> >> for coresight driver.
> >> The following patch is to add support more coresight sources.
> >>      Use IDR to maintain all the enabled sources' paths.
> >>      coresight: Use bitmap to assign trace id to the sources
> >>
> >> Introduction of TPDM and TPDA
> >> TPDM - The trace performance monitoring and diagnostics monitor or TPDM in
> >> short serves as data collection component for various dataset types
> >> specified in the QPMDA(Qualcomm performance monitoring and diagnostics
> >> architecture) spec. The primary use case of the TPDM is to collect data
> >> from different data sources and send it to a TPDA for packetization,
> >> timestamping and funneling.
> >>      Coresight: Add coresight TPDM source driver
> >>      dt-bindings: arm: Adds CoreSight TPDM hardware definitions
> >>      coresight-tpdm: Add DSB dataset support
> >>      coresight-tpdm: Add integration test support
> >>      docs: sysfs: coresight: Add sysfs ABI documentation for TPDM
> >>
> >> TPDA - The trace performance monitoring and diagnostics aggregator or
> >> TPDA in short serves as an arbitration and packetization engine for the
> >> performance monitoring and diagnostics network as specified in the QPMDA
> >> (Qualcomm performance monitoring and diagnostics architecture)
> >> specification. The primary use case of the TPDA is to provide
> >> packetization, funneling and timestamping of Monitor data as specified
> >> in the QPMDA specification.
> >> The following patch is to add driver for TPDA.
> >>      Coresight: Add TPDA link driver
> >>      dt-bindings: arm: Adds CoreSight TPDA hardware definitions
> >>
> >> The last patch of this series is a device tree modification, which add
> >> the TPDM and TPDA configuration to device tree for validating.
> >>      ARM: dts: msm: Add coresight components for SM8250
> >>
> >> Once this series patches are applied properly, the tpdm and tpda nodes
> >> should be observed at the coresight path /sys/bus/coresight/devices
> >> e.g.
> >> /sys/bus/coresight/devices # ls -l | grep tpd
> >> tpda0 -> ../../../devices/platform/soc@0/6004000.tpda/tpda0
> >> tpdm0 -> ../../../devices/platform/soc@0/6c08000.mm.tpdm/tpdm0
> >>
> >> We can use the commands are similar to the below to validate TPDMs.
> >> Enable coresight sink first.
> >>
> >> echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
> >> echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
> >> echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
> >> echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
> >> The test data will be collected in the coresight sink which is enabled.
> >> If rwp register of the sink is keeping updating when do
> >> integration_test (by cat tmc_etf0/mgmt/rwp), it means there is data
> >> generated from TPDM to sink.
> >>
> >> Changes from V2:
> >> 1. Use bitmap to assign the trace id. (Mathieu Poirier)
> >>
> >> Mao Jinlong (10):
> >>    Use IDR to maintain all the enabled sources' paths.
> >>    coresight: Use bitmap to assign trace id to the sources
> >>    Coresight: Add coresight TPDM source driver
> >>    dt-bindings: arm: Adds CoreSight TPDM hardware definitions
> >>    coresight-tpdm: Add DSB dataset support
> >>    coresight-tpdm: Add integration test support
> >>    docs: sysfs: coresight: Add sysfs ABI documentation for TPDM
> >>    Coresight: Add TPDA link driver
> >>    dt-bindings: arm: Adds CoreSight TPDA hardware definitions
> >>    ARM: dts: msm: Add coresight components for SM8250
> >>
> >>   .../testing/sysfs-bus-coresight-devices-tpdm  |   6 +
> >>   .../bindings/arm/coresight-tpda.yaml          | 129 ++++
> >>   .../bindings/arm/coresight-tpdm.yaml          |  81 ++
> >>   .../devicetree/bindings/arm/coresight.txt     |   7 +
> >>   MAINTAINERS                                   |   1 +
> >>   .../arm64/boot/dts/qcom/sm8250-coresight.dtsi | 690 ++++++++++++++++++
> >>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |   2 +
> >>   drivers/hwtracing/coresight/Kconfig           |  33 +
> >>   drivers/hwtracing/coresight/Makefile          |   2 +
> >>   drivers/hwtracing/coresight/coresight-core.c  | 127 ++--
> >>   drivers/hwtracing/coresight/coresight-tpda.c  | 193 +++++
> >>   drivers/hwtracing/coresight/coresight-tpda.h  |  32 +
> >>   drivers/hwtracing/coresight/coresight-tpdm.c  | 270 +++++++
> >>   drivers/hwtracing/coresight/coresight-tpdm.h  |  57 ++
> >>   include/linux/coresight-pmu.h                 |  11 +
> >>   include/linux/coresight.h                     |   1 +
> >>   16 files changed, 1592 insertions(+), 50 deletions(-)
> >>   create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> >>   create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpda.yaml
> >>   create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> >>   create mode 100644 arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
> >>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
> >>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
> >>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
> >>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h
> >>
> >> --
> >> 2.17.1
> >>
> >
> > --
> > Mike Leach
> > Principal Engineer, ARM Ltd.
> > Manchester Design Centre. UK



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
