Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A1B4BFF6F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiBVQ5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbiBVQ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:57:10 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C2C2DD54
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:56:43 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso21007pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=sXnwIqemEC4VmrxMuG0rukm8/Qgs5rtWRkI7dl2HHXQ=;
        b=ZErSsy2XtmemzMgltOpndEBcbJNGpdqZBal2hI3LVU0c7zhqOh08YrKILnGpQln1Yi
         mDewIy3LB3YfwcJmuhLGM5tuujgcjVA0rYKlAD5QxAlNCFz5Vvy6aIhspLvEhLQCH4S/
         4FOgRCJzZjq5gu2cIcaP1T3CCgMb9VRFzsQ91koKkcjss3QC3zoGXfeVIuVVtNrT6j5T
         qVzqv3//MpEGLtziUQ1XpfMuErG2bv/92c1CPiGN4f37+yelbOe/O9fDz+fDtErwInM3
         V90ZqhXw8oZlfv+zDq5ZzaAt4zmVoc0Vh7hdN25ypjoCzttupB5Si95j+AW83P/Q5ruV
         5raA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=sXnwIqemEC4VmrxMuG0rukm8/Qgs5rtWRkI7dl2HHXQ=;
        b=qzAZ60YmYAHdrPK1pYQ4Arv9ghj11766KlhvvFDa1TARCaqRrjM6XSyOfwBbMfyZlw
         x+3vpK3n3N8FPeIsxITJI3YneHoc25FAwI7Oc9EJEka8mTMf3CZXWrTPvdZRxHpUTtJr
         BhSmzCKeA3XtFK5TCTlip5PE92IKEi6lc/CRmPZUg50JHZrPjfRbRujj2HeNH6pZdc5W
         VCInR5bXGETfXgYMzlPJsmSTNea0qO2INrTpvQzOBgM8IziRsfjUt+c1gFxAZAq7LNVs
         J5ry2cK7SodWdVNSdk+2jiArf/qS2tUYseYI4pjiuWQg7ANv99P/Fcn+t8n/62UTlLJj
         PbGg==
X-Gm-Message-State: AOAM531cLUoWtIgy1MiY5QSzfKs5IhYmryHuqFobNxyyL43Bf48wn2C1
        xbZJU6wcrmEaJPDTaRYthrfmow==
X-Google-Smtp-Source: ABdhPJyZQOpQ+rB+jjtMOmnLRlG8KDNzfoPLbi3mZ7nXtXFc4nnYVev3L2+NfU2W0IUbq3CGl6yXzQ==
X-Received: by 2002:a17:903:31c8:b0:14e:db10:5b02 with SMTP id v8-20020a17090331c800b0014edb105b02mr23699396ple.81.1645549003167;
        Tue, 22 Feb 2022 08:56:43 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id f3sm17912532pfe.137.2022.02.22.08.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:56:42 -0800 (PST)
Date:   Tue, 22 Feb 2022 08:56:42 -0800 (PST)
X-Google-Original-Date: Tue, 22 Feb 2022 08:55:55 PST (-0800)
Subject:     Re: [PATCH 00/12] Initial support for Nuclei DemoSoC w/ UX600
In-Reply-To: <6ff70d9fbbfcde860823aa24f0ce58a0a96a1c91.camel@nucleisys.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     icenowy@nucleisys.com, robh+dt@kernel.org
Message-ID: <mhng-624abf1a-c1e9-40aa-97a5-07a5b9676942@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Feb 2022 06:45:43 PST (-0800), icenowy@nucleisys.com wrote:
> 在 2022-01-27星期四的 23:16 +0800，Icenowy Zheng写道：
>> This patchset adds support for Nuclei DemoSoC (which is an evaluation
>> platform made with Nuclei CPU cores and mainly peripherals in
>> original
>> Hummingbird E203 project, running on FPGA) with UX600 CPU cores.
>>
>> Most patches are for DT bindings, the remaining ones are adding a
>> Kconfig option and some DTS/DTSI files. The last one is a workaround
>> for
>> a severe bug in currently released versions of UX600, which is found
>> in 5.17 kernel, in which Sv48 support is added to Linux.
>>
>> Two non-technical patches are in this patchset too, for MAINTAINERS
>> and .mailmap items.
>
> Ping, could any RISC-V maintainers review these patches, especially the
> SATP workaround one?

Sorry, I remember having written this but I guess it got lost.  IIRC my 
main worry here was that, at least as far as I can tell, DemoSOC is an 
FPGA development board.  If this is actually in production somewhere 
then it's a different story, but IIUC the general rule is not to accept 
code for development hardware that can be updated.

Assuming DemoSOC can be updated, I'd also argue that we should have some 
sort of version attached to it in DT entries.  Without some versioning 
we'll end up lost when trying to later determine what we're actually 
running on.

As far as the errata goes: it looks fine to me, but I'd like to see some 
sort of description of what the errata actually is (ie, some 
documentation from the manufacturer).  I know that's not always 
possible, but without some desciption of what the bug is it gets tricky 
to mainain this sort of stuff.  For example: we've got sv57 patches 
now, so how do I know what to do with them on this target?

>
>>
>> Icenowy Zheng (12):
>>   dt-bindings: vendor-prefixes: add Nuclei
>>   RISC-V: add Nuclei SoC Kconfig option
>>   dt-bindings: riscv: add compatible strings for Nuclei UX600 series
>>   dt-bindings: timer: add compatible for Nuclei UX600 CLINT-compat
>> timer
>>   dt-bindings: interrupt-controller: add compatible string for UX600
>>     PLIC
>>   dt-bindings: serial: add compatible string for Nuclei DemoSoC UART
>>   dt-bindings: spi: add compatible string for Nuclei DemoSoC SPI
>>   dt-bindings: riscv: add binding for Nuclei platform boards
>>   riscv: dts: add device tree for Nuclei DemoSoC w/ UX600 on DDR200T
>>   RISC-V: workaround Nuclei UX600 cores with broken SATP CSR
>>   MAINTAINERS: add myself as Nuclei SoCs/CPUs supporter
>>   mailmap: add Icenowy Zheng's Nuclei mail addresses
>>
>>  .mailmap                                      |  1 +
>>  .../sifive,plic-1.0.0.yaml                    |  1 +
>>  .../devicetree/bindings/riscv/cpus.yaml       |  7 ++
>>  .../devicetree/bindings/riscv/nuclei.yaml     | 27 ++++++++
>>  .../bindings/serial/sifive-serial.yaml        |  1 +
>>  .../devicetree/bindings/spi/spi-sifive.yaml   |  1 +
>>  .../bindings/timer/sifive,clint.yaml          |  1 +
>>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>>  MAINTAINERS                                   |  7 ++
>>  arch/riscv/Kconfig.socs                       |  6 ++
>>  arch/riscv/boot/dts/Makefile                  |  1 +
>>  arch/riscv/boot/dts/nuclei/Makefile           |  2 +
>>  .../dts/nuclei/nuclei-demosoc-ddr200t.dtsi    | 41 ++++++++++++
>>  .../nuclei/nuclei-demosoc-ux600-ddr200t.dts   | 13 ++++
>>  .../boot/dts/nuclei/nuclei-demosoc-ux600.dtsi | 49 ++++++++++++++
>>  .../riscv/boot/dts/nuclei/nuclei-demosoc.dtsi | 67
>> +++++++++++++++++++
>>  arch/riscv/include/asm/vendorid_list.h        |  1 +
>>  arch/riscv/mm/init.c                          | 17 +++++
>>  18 files changed, 245 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/riscv/nuclei.yaml
>>  create mode 100644 arch/riscv/boot/dts/nuclei/Makefile
>>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-
>> ddr200t.dtsi
>>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600-
>> ddr200t.dts
>>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-
>> ux600.dtsi
>>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc.dtsi
>>
