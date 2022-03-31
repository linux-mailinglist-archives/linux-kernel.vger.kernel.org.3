Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFA64EDECA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbiCaQ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbiCaQ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:27:22 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782B45F8D5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648743934; x=1680279934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=H3QTCcN2mpYLHSKpmriKCfoZn5krghcdHbqPq6Aw8gE=;
  b=KjkTXxkPte+D9b3tCRB4nrhH1TcE1gPH9Q8zfhJzQVPpMAlO3UP9eq9T
   xN6mkVdBJESYVXXw9a99FPS7v0RlyssF0hs6m9Gs11AUeXIAXX9Ty6RFR
   GaYPRCzGmGBdLhn0i3iRdb/lpwVLBsiC5dR4xf5xvmfWVTb6UyAVhF5NU
   /X09kvDDZo0ZxS5Qu5kGmOkqVmwWO9rFzRfwTT1yrEc5FpwL3068D2C0Z
   gMijsYqMmZwU2vhXIv94l+cwV6eLHQisBP5GhsfVnVSc0y7ocNt6aKBrr
   ZZ+ma9CWvIw/ER+YAvWyFDWOr1DEoYWBUPY/zgptTFITiUfwrTj20Vpzs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="320578768"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="320578768"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 09:25:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="650354710"
Received: from mshakoox-mobl1.amr.corp.intel.com (HELO guptapa-desk) ([10.251.2.3])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 09:25:29 -0700
Date:   Thu, 31 Mar 2022 09:25:28 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Mark Gross <mgross@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>, kernel@collabora.com
Subject: Re: [PATCH v2] x86/speculation/srbds: do not try to turn mitigation
 off when not supported
Message-ID: <20220331162528.t5vkfvmkygkiqpcs@guptapa-desk>
References: <20220330082026.1549073-1-ricardo.canuelo@collabora.com>
 <YkS3OKLS1Cixs9up@zn.tnic>
 <87o81mzhoh.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <20220331084536.y4sl7qcfzltsnnew@guptapa-desk>
 <87lewqz2dp.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <YkXH5+Js+qRbqou9@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkXH5+Js+qRbqou9@zn.tnic>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 05:25:27PM +0200, Borislav Petkov wrote:
>On Thu, Mar 31, 2022 at 03:18:42PM +0200, Ricardo Cañuelo wrote:
>> Just to clarify, this changes the behavior wrt the hypervisor case:
>> currently it just bails out of update_srbds_msr(), with your patch it'd
>> clear RNGDS_MITG_DIS from MSR_IA32_MCU_OPT_CTRL. Is that what you
>> intended?

Yes, this should be fine as update_srbds_msr() would also check for
X86_FEATURE_SRBDS_CTRL. If a hypervisor doesn't want a guest to write to
the MSR it should not export X86_FEATURE_SRBDS_CTRL.

>Just do the simple thing I pasted earlier - no need to rewrite the whole
>function for no good reason.

I was trying to address earlier comment on split logic in two functions.
I am okay with keeping it as is (and just adding X86_FEATURE_SRBDS_CTRL
check in update_srbds_msr()).

Thanks,
Pawan
