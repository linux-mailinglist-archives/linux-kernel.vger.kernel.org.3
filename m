Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C18251C5F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382636AbiEERWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiEERWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:22:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2A65D19E;
        Thu,  5 May 2022 10:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651771148; x=1683307148;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VxpqTJ3ACX+lKVS2otK9bmlY+2HMmudezngmybG5wNQ=;
  b=OKQpW44DGbhWjhipefwQhftg65vIsfEQM3RNmBKbyh1cetb5cT9jO7TD
   GQwZ08N+q5LkDB1VpgpAksJf374I1ObbK/rZB9ic0hKbu+xkokG6XHrmA
   JuJlBd5S0p4SAZz3cdYENCz16FkUucRYYcd70YvUpFplNeiIWu3AU9OBY
   oebL2KlpcfWhDmLRXEhycrlqD0Bh11f8f2FNACdI60icbyoYsFRQyjVAC
   ub78QnGXU/sZKwge1fU75ajAwqT5L5wPPl7G6Z0u8YPiRqe4LaPv3FjOZ
   5uP+ckAm5d9Up4qWP3FhDD34Jj/f6PQ+UfXuqhIERDP7oKDmY9Te68TpU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268079798"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="268079798"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:18:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="709047754"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 10:18:57 -0700
Date:   Thu, 5 May 2022 10:18:57 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 1/3] dt-bindings: misc: add bindings for Intel HPS
 Copy Engine
In-Reply-To: <9581ba8b-1d28-3292-872b-026c60e20424@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2205051017220.3669830@rhweight-WRK1>
References: <20220503194546.1287679-1-matthew.gerlach@linux.intel.com> <20220503194546.1287679-2-matthew.gerlach@linux.intel.com> <17407fe7-b11d-2ba8-acca-3e71cf1a3b2f@linaro.org> <alpine.DEB.2.22.394.2205041425230.2669897@rhweight-WRK1>
 <9581ba8b-1d28-3292-872b-026c60e20424@linaro.org>
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



On Thu, 5 May 2022, Krzysztof Kozlowski wrote:

> On 05/05/2022 00:41, matthew.gerlach@linux.intel.com wrote:
>>> Please find appropriate directory matching this hardware, not "misc". As
>>> a fallback SoC related bindings end up in "soc".
>>
>> I thought misc seemed appropriate because it is a very specific IP block
>> in the FPGA connected to the HPS.  It does perform a simple DMA function;
>> so I considered putting it in the dma directory, but it also has some
>> hand-shaking registers between the HPS and a host processor connected to the
>> FPGA via PCIe; so I thought misc.  Since the HPS "soc" accesses the
>> component, I can put it in the "soc" directory, unless there is a better
>> suggestion.
>
> So let it be "soc".

I will move it to the soc directory.

>
>>>
>>> $ git grep address-cell
>>> Do not use inconsistent coding. The same applies to your DTS.
>>
>> Is the inconsistency the use of '0x' in the values of #address-cells and
>> #size-cells, or is the consistency having different values for
>> #address-cells and #size-cells or both?
>
> It's about "0x".

Got it.  I will remove the 0x.

>
>>
>>>
>>>> +        #size-cells = <0x1>;
>>>> +        ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
>>>
>>> Why do you even need the simple-bus above and cannot put the device
>>> directly on the bus?
>>
>> On an Agilex chip, the HPS is connected to the FPGA via two bridges,
>> referred as the "HPS to FPGA bridge" and the "Lightweight HPS to FPGA
>> bridge".  An IP block in the FPGA could be connected to one or both of
>> these bridges.  I am anticipating device tree overlays being applied for
>> other IP blocks instantiated in the FPGA.
>
> OK
>
>>
>>>
>>>> +
>>>> +        hps_cp_eng@0 {
>>>
>>> No underscores in node names. Generic node name.
>>
>> I understand.  I am considering dma@0 for the generic node name.
>
> Let's keep the same as in DTS.

Yes, we want the example and the DTS to be the same.  It will be called 
dma-controller@0.

Thank you for the feedback,
Matthew

>
>
> Best regards,
> Krzysztof
>
