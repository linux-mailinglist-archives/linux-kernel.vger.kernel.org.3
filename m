Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5DE4B7387
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbiBOQfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:35:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbiBOQfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:35:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413D7985A2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644942897; x=1676478897;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=XE1KBCsW/dykWU7rY14M9Ew3D8FRC9d7vegLXfRW8d8=;
  b=moT63t4t5yixtCJv8u8XCP7fn29X8BRuLGorugQmJt+QOBH+rJvCOiko
   p+bn3h/vGCtGPQ/h9euU6Q6pz5odpN8fElJDMhJUAcFNSVi/VhArfzdB7
   UYxuhFVK8hfpuziXAjHBLtE3TxJ+5xs10ZYyTUbJdE6pL5qNdU6t0b3dk
   9JI4t5tktJaoxkPYM/gghW3wo1dkM+1L0cxjqU20tYkg+RmLYhFA573li
   mzJdcQSJ+zy7+1gt8HMFqDGwCDtKq90kZ+zO0RPnCvm2BaXIIYsHSIKL/
   52umgaDOW9PczJ3uy0QyF9IWmsuk3I8JUkEXX4sQvBz+MxLtxSZNkSwAf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249224017"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="249224017"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 08:34:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="775923937"
Received: from tngodup-mobl.amr.corp.intel.com (HELO [10.209.32.98]) ([10.209.32.98])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 08:34:55 -0800
Message-ID: <52e34ee2-e6a8-5b5c-41f9-5fcf21902a25@intel.com>
Date:   Tue, 15 Feb 2022 08:34:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
 <YgFIaJ8ijgQQ04Nv@zn.tnic> <1d77e91c-e151-7846-6cd4-6264236ca5ae@intel.com>
 <YgFWpGQfA84Y0mW/@zn.tnic>
 <20220214220926.fjwlyieatwjhcpij@black.fi.intel.com>
 <f1dfc268-7b2f-9980-27ce-0b5bb1aea962@amd.com>
 <20220215154118.ldpvvk5seljntl44@black.fi.intel.com>
 <dd21e54a-a431-4d6f-47b7-ab1a3e8e0cc8@amd.com>
 <20220215162722.cvzik5r57spr2krz@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
In-Reply-To: <20220215162722.cvzik5r57spr2krz@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 08:27, Kirill A. Shutemov wrote:
>>> But with u64 as type, I'm not sure 'pgprot' in the name is jutified.
>> Maybe cc_mask_{enc,dec}()? It just sounds like cc_{enc,dec}() is actually
>> performing encryption or decryption and can be confusing.
> cc_{enc,dec}_mask() sounds better to me.

The pte_mk*() functions might be a good naming model here.  Some of them
clear bits and some set them, but they all "make" a PTE.
