Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416555A0176
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbiHXSjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiHXSja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:39:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9BD7A753;
        Wed, 24 Aug 2022 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661366369; x=1692902369;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6kllcoGLd/oieDxknGPqnzJ+0To7+vbTJBdPwvBOljE=;
  b=M7ENKBMQDD1FW5ddXRfe+edPxyamqJe2x3qv+8nhmjxk+jzs0XWcz4p3
   qjkfSNL7lfbkgsy3zAajy+0Wjz19EsZ14axL58zTZziZXcccnr/z+GpLz
   hKB3jBWP79Pt6U/gaxTmOaDp+o3HWiO4rE2SmpVMHBgZwcuKbhW9+orLZ
   gmkJFECOfKAVUSGPRtBvaOAgkZlbBYkh9tFCHvLWKXHDMg+Dn7tVvICzT
   Rz235V0wkbINRFxDh3aDgqJIkM1Ls1DOwoyxilfHFHKIcCjqH+NzSAZDM
   kuWWSGHLzmuJ3+0G93lLByHBbxqhyp7zXR9rTmrxBzoyXZeD5wbM6Xo+H
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="292791530"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="292791530"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 11:39:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="938021111"
Received: from skeshri-mobl.ger.corp.intel.com (HELO [10.212.154.182]) ([10.212.154.182])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 11:39:20 -0700
Message-ID: <4414b911-80a1-beec-a402-2966f93d9670@intel.com>
Date:   Wed, 24 Aug 2022 11:39:20 -0700
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
 <beabe16c-b28b-cd65-f6b6-4242bc74926d@intel.com>
 <33c2a495-13ad-97ac-f2c2-4096cf8f5b58@molgen.mpg.de>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <33c2a495-13ad-97ac-f2c2-4096cf8f5b58@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 15:33, Paul Menzel wrote:
>> Thanks for the extra debug info.  Unfortunately, nothing is really
>> sticking out as an obvious problem.
>>
>> The EREMOVE return codes would be interesting to know, as well as an
>> idea what the physical addresses are that fail and the _counts_ of how
>> many pages get sanitized versus fail.
> 
> Is there a knob to print out this information? Or way to get this
> information using ftrace? I’d like to avoid rebuilding the Linux kernel.

You can probably do it with a kprobe and ftrace, but it's a little bit
of a pain since the ENCL* instructions are all inlined and don't get
wrapped in actual function calls.

I'd just rebuild the kernel if it were me.

Maybe we just just uninline all of the ENCL* instruction so that we
*can* more easily trace them.  It's not like they are performance sensitive.
