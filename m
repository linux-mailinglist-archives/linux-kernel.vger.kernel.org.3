Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66D15676EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiGESyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiGESyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:54:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B42E1ADB4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657047248; x=1688583248;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bM0ABJX0qGEyGQRZ6VO/v3KuV7TXXVDZ98ArQud1930=;
  b=Pf8XHU9e3KMVnEkKitLEpcONpREWJutbFdVtRmQm//lTj7hNRe7grZ07
   kFCo4xPcglnFAOdIbCIO8mCMq0+NM4IVayClHrC/qZq4Enk1sfuxl5geB
   B0bF6Akf7N5bd75vPkkYrgnn/BeeWDOdmCPFd6hHxr6JMCUr3MC9Gm0k9
   XXTUWQdv8JoGDkncLv6zPXsUqugMx8eJ18g1wfVvghnZPp8I9rYxx9m8x
   XTi/1bGkvBMvUho5W1CyKx+p/jp/tXharrP2FOpD3JITT+ekvzkEJtD8l
   S+olUjd5I3Ep9w7zrV3xN2YHYahVSGF42qLZUQ6lRpvrocjPmSnMJKEoW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284180221"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="284180221"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 11:54:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="839237437"
Received: from tdisanx-mobl.amr.corp.intel.com (HELO [10.209.16.32]) ([10.209.16.32])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 11:54:08 -0700
Message-ID: <8b6f3f9f-71c8-2b6f-20a3-5e9c259a1b9a@intel.com>
Date:   Tue, 5 Jul 2022 11:52:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <0f6bedbb-14cc-bf93-5d9f-bfd2c49dc7b2@intel.com>
 <48b9d807-2d9e-016f-bada-906911d6ecb0@linux.intel.com>
 <f26f88ee-1226-3e32-77cc-fc86bc65e0b7@intel.com>
 <ca73d2bd-5d40-d385-aeb0-8c04811690ff@linux.intel.com>
 <331abea18e728061979301772a9d0d61543f59fb.camel@intel.com>
 <0b5884b8-9240-63b2-ca4c-20c86fd2e8c1@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <0b5884b8-9240-63b2-ca4c-20c86fd2e8c1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 11:45, Sathyanarayanan Kuppuswamy wrote:
> Yes, there are many ways to design this. But I still think IOCTL is a better fit
> for the request/response kind of use case.

Are there any other similar ABIs in the kernel?  What kind of mechanism
do they use?
