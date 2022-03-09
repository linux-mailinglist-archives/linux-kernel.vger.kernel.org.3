Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9519A4D3D33
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbiCIWlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiCIWlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:41:37 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A23212150A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646865638; x=1678401638;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=LkjL9mkuDj2d+Jb//irbsmLlpXBL+4xQZFL4zvXiTbI=;
  b=It83cGPe6QlAbUvZhifIvEaHnPOvwBdcHfkXYcC1Abzdl2Rj4n49U0i1
   u0Ez0/lgpo7udCzydNTTgMGQiWI25pfdmMwCXmBbT4PJMp5Mzyr/s+Cwc
   ZPtDsdkniQGthU7Pc4QAmViu0SJWWaUBA+jOggNoa7tzjxVxa9ax3kADY
   ZS2na3EnuVUOcsoYPNAPwiNZOV0ZhsPdgNEWVyG6Zbn1RYVx9Etno5ipO
   kknSZzflXGPfHYMMdfewHls8nshkuUJwFSVLnCo65Zg9541wAqyYrPOdx
   zKtHSaclFpV8wmqBcLf7M3YBDx+zwnxQwdjJA/4lPWYjtEMbj6jValrlC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="315825441"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="315825441"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 14:40:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="642322549"
Received: from sli6-mobl.amr.corp.intel.com (HELO [10.209.104.236]) ([10.209.104.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 14:40:36 -0800
Message-ID: <8498cff4-3c31-f596-04fe-62013b94d7a4@intel.com>
Date:   Wed, 9 Mar 2022 14:40:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     thomas.lendacky@amd.com, brijesh.singh@amd.com,
        kirill.shutemov@linux.intel.com, hpa@zytor.com,
        pbonzini@redhat.com, seanjc@google.com, srutherford@google.com,
        ashish.kalra@amd.com, darren.kenny@oracle.com,
        venu.busireddy@oracle.com, boris.ostrovsky@oracle.com
References: <20220309220608.16844-1-alejandro.j.jimenez@oracle.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC 0/3] Expose Confidential Computing capabilities on sysfs
In-Reply-To: <20220309220608.16844-1-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 14:06, Alejandro Jimenez wrote:>
> On EPYC Milan host:
> 
> $ grep -r . /sys/kernel/mm/mem_encrypt/*
> /sys/kernel/mm/mem_encrypt/c_bit_position:51

Why on earth would we want to expose this to userspace?

> /sys/kernel/mm/mem_encrypt/sev/nr_sev_asid:509
> /sys/kernel/mm/mem_encrypt/sev/status:enabled
> /sys/kernel/mm/mem_encrypt/sev/nr_asid_available:509
> /sys/kernel/mm/mem_encrypt/sev_es/nr_sev_es_asid:0
> /sys/kernel/mm/mem_encrypt/sev_es/status:enabled
> /sys/kernel/mm/mem_encrypt/sev_es/nr_asid_available:509
> /sys/kernel/mm/mem_encrypt/sme/status:active

For all of this...  What will userspace *do* with it?

For nr_asid_available, I get it.  It tells you how many guests you can
still run.  But, TDX will need the same logical thing.  Should TDX hosts
go looking for this in:

	/sys/kernel/mm/mem_encrypt/tdx/available_guest_key_ids

?

If it's something that's common, it needs to be somewhere common.
