Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E854F0FF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377653AbiDDH0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiDDHZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:25:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BF81D30E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649057042; x=1680593042;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6S6H9m506Zflqt/ahZ8IYpB9GrSU0XZnufsomsoR+nc=;
  b=RJPP5K8iwlQDSXHHvsbhTB9wnlEaUgxVh7Ntk5o6Tsx3W1K0fl8/XTGo
   +SLvWYqwOFG7SNiAZQIwujm3Os77jfDzWxiU7zW6YG4zuM20eUHOAfyuW
   l6R50V3LH7SuEztUK6Rinh8od70UtvEqqW7YyPCkqR17qQeBpPPn7aEC4
   1GUqJAvfLMLd6MIqbFoXd6LYPi7CSoUafQxzxy/wrjnO2qDnA9n80P7qI
   0fpOVcSMYlIv1SFXCHx5bPwTj515vhcE83nCptytC1L1Rkz8GSjE8PMop
   zzpmuhH3qTx3Tv/zIii7MUpXUfdYSXgdsAPLr+xcktYmO/bMeWkIVx0+2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="260154570"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="260154570"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 00:23:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="587484445"
Received: from vlee3-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.28.97])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 00:23:47 -0700
Message-ID: <4605b7ba6ed1197b3f58fffc56be1c7250b5e79c.camel@intel.com>
Subject: Re: [PATCHv7 30/30] Documentation/x86: Document TDX kernel
 architecture
From:   Kai Huang <kai.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 04 Apr 2022 19:23:45 +1200
In-Reply-To: <faee19b5-5ee2-d6e1-63fe-c8a7fb1f9d32@intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
         <20220318153048.51177-31-kirill.shutemov@linux.intel.com>
         <7c507b609a6e742ebdcd61ea204d5f05ee0b3b35.camel@intel.com>
         <faee19b5-5ee2-d6e1-63fe-c8a7fb1f9d32@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-04-03 at 23:25 -0700, Dave Hansen wrote:
> On 4/3/22 21:32, Kai Huang wrote:
> > This is not the best way I believe.  I think we have two options here:
> > 1) Having dedicated tdx_guest.rst and tdx_host.rst
> > 2) Having a single tdx.rst to cover both TDX guest and host materials.
> > 
> > I don't know which way is better, perhaps 2).  
> > 
> > Kirill,
> > 
> > If 2) is better, could we add an additional level of menu to represent "TDX
> > guest support" and make all materials as sub-menu of it, if you need to send out
> > v8?
> 
> If the host support means that this needs to be reorganized, then the
> host support patches can do that.  Let's not make this more complicated
> than it has to be.

Sure. I'll do the change.

Still it would be appreciated if you guys can provide comments on which is
better.  Thanks.
 
-- 
Thanks,
-Kai


