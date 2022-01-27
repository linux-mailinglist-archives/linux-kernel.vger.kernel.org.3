Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DB849DC64
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbiA0ISM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:18:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:29322 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237689AbiA0ISL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643271491; x=1674807491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eXBkGgw60bdFoIyLSIRLyrUbjMrn4EVCKvo0GitUMPk=;
  b=XvTcTlImmatMQjUVWThCT8EiCIh2yCd+GVoo2dSQ7nl4p/1S9DX0WQME
   HR/+CogbqXMT7BNAOWB1qsqEuekSpIR67v3N9bp1SfcCQoxSL4geWj69y
   TNf8NshK3OM5uFBOQkVrwpetd+B9QnctKGZn11z/YZf5lrjwuevMicrb5
   Y6AxJapL910xc1/Ff/F5gVRfd1Wo/4huA7t2PhihQ4jG8jcYpk+IIC/i/
   e4ceC3FeBMX9+Ef4EHXr31hbbL6Amsujwzq+qyOdbG72EO76O9SF9xCZV
   cZapaJfyrnbM00uKvjL+WTQZ19oUK84AhL1NTrake/RCqsM0NmhSOVgAL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246730620"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="246730620"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 00:18:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="521125802"
Received: from anithaha-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.224.126])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 00:18:10 -0800
Date:   Thu, 27 Jan 2022 00:18:10 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     linaro-mm-sig@lists.linaro.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH 02/19] dma-buf-map: Add helper to initialize
 second map
Message-ID: <20220127081810.6zt6cyib4s7kpa6f@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220126203702.1784589-1-lucas.demarchi@intel.com>
 <20220126203702.1784589-3-lucas.demarchi@intel.com>
 <f0dbdcc0-13b5-c484-0bf3-a1f8c3e48954@amd.com>
 <20220127075728.ygwgorhnrwaocdqv@ldmartin-desk2>
 <3066c6a7-fc73-d34d-d209-a3ff6818dfb6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3066c6a7-fc73-d34d-d209-a3ff6818dfb6@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:02:54AM +0100, Christian König wrote:
>Am 27.01.22 um 08:57 schrieb Lucas De Marchi:
>>On Thu, Jan 27, 2022 at 08:27:11AM +0100, Christian König wrote:
>>>Am 26.01.22 um 21:36 schrieb Lucas De Marchi:
>>>>When dma_buf_map struct is passed around, it's useful to be able to
>>>>initialize a second map that takes care of reading/writing to an offset
>>>>of the original map.
>>>>
>>>>Add a helper that copies the struct and add the offset to the proper
>>>>address.
>>>
>>>Well what you propose here can lead to all kind of problems and is 
>>>rather bad design as far as I can see.
>>>
>>>The struct dma_buf_map is only to be filled in by the exporter and 
>>>should not be modified in this way by the importer.
>>
>>humn... not sure if I was  clear. There is no importer and exporter here.
>
>Yeah, and exactly that's what I'm pointing out as problem here.
>
>You are using the inter driver framework for something internal to the 
>driver. That is an absolutely clear NAK!
>
>We could discuss that, but you guys are just sending around patches to 
>do this without any consensus that this is a good idea.

s/you guys/you/ if you have to blame anyone - I'm the only s-o-b in
these patches. I'm sending these to _build consensus_ on what may be a good
use for it showing a real problem it's helping to fix.

 From its documentation:

  * The type :c:type:`struct dma_buf_map <dma_buf_map>` and its helpers are
  * actually independent from the dma-buf infrastructure. When sharing buffers
  * among devices, drivers have to know the location of the memory to access
  * the buffers in a safe way. :c:type:`struct dma_buf_map <dma_buf_map>`
  * solves this problem for dma-buf and its users. If other drivers or
  * sub-systems require similar functionality, the type could be generalized
  * and moved to a more prominent header file.

if there is no consensus and a better alternative, I'm perfectly fine in
throwing it out and using the better approach.

Lucas De Marchi
