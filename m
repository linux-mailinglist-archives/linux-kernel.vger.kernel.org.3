Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F784D3B3D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 21:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbiCIUkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 15:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiCIUkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:40:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22DD9EBA8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646858374; x=1678394374;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=0uWpjRp/Vo5q8YVz1wzLlP1EMBE9VkkchbITpxeIAdE=;
  b=nxiUViPbw1/ecT/n9TH6A0LbjRqgYamyU7Au10SmIqG3hsfDTGpBa9WD
   V/kMP7Orkg+z9MZ3haTqRoB5yHcwGew/2YEIa/bwtsXq8SpUWIt9G6XKA
   Cb4oONspSGq3zYMbHjaPFoggAtqsblONwNGHU/W1awIYjSm2cG18RClK1
   eOGr0FSa8dOdgarh3Z2p8OCqCN9dtiuq8giZTvJIQbjDu+cQCNM2SN3+L
   W0LPlOdheKRJKiF3NVybwCPWI2U+ZB18s5PQKbN4YHHDTXXdiWk1a2K7B
   SvgYldcsWdbxABP5g9gHzbMIbXCtrL8ufS0e04WCf0YY7yEcfDfS6aJGR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="279820379"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="279820379"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 12:39:33 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="642294953"
Received: from sli6-mobl.amr.corp.intel.com (HELO [10.209.104.236]) ([10.209.104.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 12:39:32 -0800
Message-ID: <d6db956d-38b5-c3bc-611d-c947e246a36e@intel.com>
Date:   Wed, 9 Mar 2022 12:39:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-29-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 28/30] x86/tdx: ioapic: Add shared bit for IOAPIC base
 address
In-Reply-To: <20220302142806.51844-29-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 06:28, Kirill A. Shutemov wrote:
> +static void io_apic_set_fixmap_nocache(enum fixed_addresses idx,
> +				       phys_addr_t phys)
> +{
> +	pgprot_t flags = FIXMAP_PAGE_NOCACHE;
> +
> +	flags = pgprot_decrypted(flags);
> +	__set_fixmap(idx, phys, flags);
> +}

This is only used by the "io_apic".  No need to add the "_nocache".  Maybe:

static void io_apic_set_fixmap(enum fixed_addresses idx, ...
{
	pgprot_t flags = FIXMAP_PAGE_NOCACHE;

	/*
	 * Ensure fixmaps for IOAPIC MMIO respect memory
	 * encryption pgprot bits, just like normal ioremap():
	 */
	flags = pgprot_decrypted(flags);

	__set_fixmap(idx, phys, flags);
}
