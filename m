Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752FD59EACC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiHWSR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiHWSRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:17:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D027196FF0;
        Tue, 23 Aug 2022 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661272366; x=1692808366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=51743oZRSoGzyO43jSMuIsCr9qTV5fXTfblP0N5OYg8=;
  b=eHt0GaGgsTXfLe6qqpUUIl7R+WxC4IOPTX3KLhkYTNyTOEbnNr1OPhBq
   PHA3vQytbK9c9cEX0WI5wV6sd+k0HzXqokdqMJ8j686NuWkRUDbjLTgAo
   VR4PUV5zA2QcWf/WXIF0BzMjOKmvbTyPDeoLSkHeqBd7PscRQhvLWK3ht
   VRaBkDD+SGWFyPxRWDtbR7AX9ZcJcH5j7VAWf4tvsDuMVUyZnkp0Z2v18
   M8nnZ9pV0VqfFxq/EJMh7O55nbDRImw9nbFfuzw64wRHimfkn8dmuyFes
   ijtrbv/9biSwQMg3OX2Isy25FLjWfCVsPrzn71b30q/eRmoQ/EuX7ncFc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="295019611"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="295019611"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 09:32:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="677686766"
Received: from tmnguye8-mobl1.amr.corp.intel.com (HELO [10.212.174.243]) ([10.212.174.243])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 09:32:45 -0700
Message-ID: <beabe16c-b28b-cd65-f6b6-4242bc74926d@intel.com>
Date:   Tue, 23 Aug 2022 09:32:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446
 ksgxd+0x1b7/0x1d0
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de>
 <4253695b-85aa-a2fb-fbf6-718db8b6c20c@molgen.mpg.de>
 <46e3483b-a5ab-2a05-8a28-f9ea87e881c3@intel.com>
 <04c9d5fa-5861-bbc3-3e2f-e18a73866645@molgen.mpg.de>
 <63a60042-4a4a-3bc3-5fa1-4495d80cc06c@molgen.mpg.de>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <63a60042-4a4a-3bc3-5fa1-4495d80cc06c@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 06:48, Paul Menzel wrote:
>>> I'm suspecting either a BIOS problem.  Reinette (cc'd) also thought this
>>> might be a case of the SGX initialization getting a bit too far along
>>> when it should have been disabled.
>>>
>>> We had some bugs where we didn't stop fast enough after spitting out the
>>> "SGX Launch Control is locked..." errors.
> 
> Let’s hope it’s something known to you.

Thanks for the extra debug info.  Unfortunately, nothing is really
sticking out as an obvious problem.

The EREMOVE return codes would be interesting to know, as well as an
idea what the physical addresses are that fail and the _counts_ of how
many pages get sanitized versus fail.

But, I don't really have a theory about what could be going on yet.
