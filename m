Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334EE4C7075
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiB1PRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbiB1PRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:17:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAB683000;
        Mon, 28 Feb 2022 07:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646061390; x=1677597390;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=GFDKt/IDNLdqLTuvDR6yJcVQxe8prvsZyzafk0irqZQ=;
  b=dZt5eLPlw3/rVdLr0/J8lsOrDWfpq0pa3v7loKEUbA+zmQIBU9tSmasN
   cEPgzjUNMugxHN/ucZYKc9r9F2VHfmsEYHCzP/JmpeoUkZEukEJDuXGr6
   HztKmgEg6rAZoUePgH6Er969RH/lUr0q+v9AD1/L+mRwopSRyNQ4/SF3M
   KnOw+gpCfe+5T5gTbRcSDXnIfBb9oPeRKaFtfxbb1ikbSSkbX6asrAjLE
   PzR1yRYiqnPsUWTbonVrysuvzql5XdgO5urnMG/HwOy8GaHWflNw3vaCQ
   aogwzXcEFOdsGk72YKTlegqxI2LCeywn8BFOiDmxIy9jrl6iW2m6JcC7S
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="277563357"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="277563357"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 07:16:28 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="550276016"
Received: from eliasbro-mobl.amr.corp.intel.com (HELO [10.212.174.65]) ([10.212.174.65])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 07:16:27 -0800
Message-ID: <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
Date:   Mon, 28 Feb 2022 07:16:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
In-Reply-To: <Yhy/GvJegnTqYdq6@iki.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 04:24, Jarkko Sakkinen wrote:
>> Regarding the recent update of splitting the page permissions change
>> request into two IOCTLS (RELAX and RESTRICT), can we combine them into
>> one? That is, revert to how it was done in the v1 version?
> They are logically separate complex functionalities:
> 
> 1. "restrict" calls EMODPR and requires EACCEPT
> 2. "relax" increases permissions up to vetted ("EADD") and could be
>     combined with EMODPE called inside enclave.

It would be great to have a _slightly_ better justification than that.
Existing permission interfaces like chmod or mprotect() don't have this
asymmetry.

I think you're saying that the underlying hardware implementation is
asymmetric, so the interface should be too.  I don't find that argument
very convincing.  If the hardware interface is arcane and we can make it
look more sane in the ioctl() layer, we should that, asymmetry or not.

If we can't make it any more sane, let's say why the ioctl() must or
should be asymmetric.

The SGX2 page permission mechanism is horribly counter intuitive.
*Everybody* that looks at it thinks that it's wrong.  That means that we
have a lot of work ahead of us to explain the interfaces that get
layered on top.
