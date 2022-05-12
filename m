Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6995C52511C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355859AbiELPTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355535AbiELPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:19:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDCB1B7921;
        Thu, 12 May 2022 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652368741; x=1683904741;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2FxysYr9kxWMHnyew6A3AGuoWPoDUWpnlJdlKIYnGFQ=;
  b=adQoGU63iP6HZbajoNXR0FKG49gEsAeFv23ZuYYkpDd9aHQG18Xq37gH
   coaXhEiemavEE86tMXvoBdvHnafM6RvdP5Uf5eNLtCmBjq++Xvg5WH+2z
   ccjaA3YGCy4g5yFBve0LadYwA5sFYY68fQDjYQkZGeyFg4tXtfGiLPOSb
   xwvZngA9Yr7ttHT+uQXIikHdxV/XPEvHdhbwGCUAy6HTyBNig9GWXOmlJ
   J3Y+C8vWhDaLEy5feuvIrtzl/1w6H0AekMEYbC3ResNvP8GhFUVQfEEaH
   ty303dXjrb03CI4hu3vilKfqroJlPPOZPmHVVqNwCVuYpZPLIXSaFIyFg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250553789"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="250553789"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 08:19:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="542813080"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 08:19:01 -0700
Date:   Thu, 12 May 2022 08:18:56 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Dinh Nguyen <dinguyen@kernel.org>
cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 0/3] Add device tree for Intel n6000
In-Reply-To: <98d7e84c-086a-794f-019d-849bcc2570c9@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2205120812410.4082310@rhweight-WRK1>
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com> <98d7e84c-086a-794f-019d-849bcc2570c9@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 May 2022, Dinh Nguyen wrote:

>
>
> On 5/8/22 09:26, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> 
>> This patch set adds a device tree for the Hard Processor System (HPS)
>> on an Agilex based Intel n6000 board.
>> 
>> Patch 1 defines the device tree binding for the HPS Copy Engine IP
>> used to copy a bootable image from host memory to HPS DDR.
>> 
>> Patch 2 defines the binding for the Intel n6000 board itself.
>> 
>> Patch 3 adds the device tree for the n6000 board.
>> 
>> Changelog v3 -> v4:
>>    - move binding yaml from soc to soc/intel
>> 
>> Changelog v2 -> v3:
>>    - remove unused label
>>    - move from misc to soc
>>    - remove 0x from #address-cells/#size-cells values
>>    - change hps_cp_eng@0 to dma-controller@0
>>    - remote inaccurate 'items:' tag
>>    - added Acked-by
>>    - add unit number to memory node
>>    - remove spi node with unaccepted compatible value
>> 
>> Changelog v1 -> v2:
>>    - add dt binding for copy enging
>>    - add dt binding for n6000 board
>>    - fix copy engine node name
>>    - fix compatible field for copy engine
>>    - remove redundant status field
>>    - add compatibility field for the board
>>    - fix SPDX
>>    - fix how osc1 clock frequency is set
>> 
>> Matthew Gerlach (3):
>>    dt-bindings: soc: add bindings for Intel HPS Copy Engine
>>    dt-bindings: intel: add binding for Intel n6000
>>    arm64: dts: intel: add device tree for n6000
>>
>>   .../bindings/arm/intel,socfpga.yaml           |  1 +
>>   .../soc/intel/intel,hps-copy-engine.yaml      | 51 ++++++++++++++
>>   arch/arm64/boot/dts/intel/Makefile            |  3 +-
>>   .../boot/dts/intel/socfpga_agilex_n6000.dts   | 66 +++++++++++++++++++
>>   4 files changed, 120 insertions(+), 1 deletion(-)
>>   create mode 100644 
>> Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
>>   create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
>> 
>
> Applied!

Hi Dinh,

Rob Herring suggested I move 
Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml to 
Documentation/devicetree/bindings/dma/intel,hps-copy-engine.yaml as well 
as some cleanup to the yaml.  Rob also had some concerns about the h2f(lw) 
bus that I was considering some changes.  Should I send a v6 patch set or 
a new patchset on top of the v4 to address Rob's concerns, or do you have 
some other suggestion?

Thanks,
Matthew


> Thanks,
>
> Dinh
>
