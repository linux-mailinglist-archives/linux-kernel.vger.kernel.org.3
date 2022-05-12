Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085CA525072
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355505AbiELOmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355511AbiELOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:42:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343F263397;
        Thu, 12 May 2022 07:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F5B3B8286C;
        Thu, 12 May 2022 14:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7CDC385B8;
        Thu, 12 May 2022 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652366518;
        bh=lO/Qu5Nf2ml3fZ177q4ahOGbvoGlU6Rf0HczodM1aWU=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=jiRwg7s0maDYdE7dhVB9Xl/S30cPI855qHNrqNH66GzO65xBOy3wV3jl5NWw/87XK
         ySpz4YIBnAtGKY/0WqrUXbq63+7vq54St+rWdGxe5nmiRKNCY2dXy2kwWz4RsIkjmJ
         /GnxKGyi6uSi0GhWzTagDrTDno3otI3NzYTP/ltNy0cx8ERTDaKAsC0ybXtDx4zChj
         m1tjIhC5nrvmDJI7IF0lTJkkowGlGF3Wy80+Zv/OBbe7V+bICw+HEsIy03vj2ASwO6
         imSHytriwbUwSYILs80ceL3wbeeYpPu9Mm/WUeG4cI/3+VHWvIyLipaF6LCCXM57en
         ekUxHdZzZ1Hfw==
Message-ID: <98d7e84c-086a-794f-019d-849bcc2570c9@kernel.org>
Date:   Thu, 12 May 2022 09:41:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/3] Add device tree for Intel n6000
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220508142624.491045-1-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/22 09:26, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> This patch set adds a device tree for the Hard Processor System (HPS)
> on an Agilex based Intel n6000 board.
> 
> Patch 1 defines the device tree binding for the HPS Copy Engine IP
> used to copy a bootable image from host memory to HPS DDR.
> 
> Patch 2 defines the binding for the Intel n6000 board itself.
> 
> Patch 3 adds the device tree for the n6000 board.
> 
> Changelog v3 -> v4:
>    - move binding yaml from soc to soc/intel
> 
> Changelog v2 -> v3:
>    - remove unused label
>    - move from misc to soc
>    - remove 0x from #address-cells/#size-cells values
>    - change hps_cp_eng@0 to dma-controller@0
>    - remote inaccurate 'items:' tag
>    - added Acked-by
>    - add unit number to memory node
>    - remove spi node with unaccepted compatible value
> 
> Changelog v1 -> v2:
>    - add dt binding for copy enging
>    - add dt binding for n6000 board
>    - fix copy engine node name
>    - fix compatible field for copy engine
>    - remove redundant status field
>    - add compatibility field for the board
>    - fix SPDX
>    - fix how osc1 clock frequency is set
> 
> Matthew Gerlach (3):
>    dt-bindings: soc: add bindings for Intel HPS Copy Engine
>    dt-bindings: intel: add binding for Intel n6000
>    arm64: dts: intel: add device tree for n6000
> 
>   .../bindings/arm/intel,socfpga.yaml           |  1 +
>   .../soc/intel/intel,hps-copy-engine.yaml      | 51 ++++++++++++++
>   arch/arm64/boot/dts/intel/Makefile            |  3 +-
>   .../boot/dts/intel/socfpga_agilex_n6000.dts   | 66 +++++++++++++++++++
>   4 files changed, 120 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
>   create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
> 

Applied!

Thanks,

Dinh
