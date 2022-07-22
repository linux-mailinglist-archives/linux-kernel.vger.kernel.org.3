Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD48C57E3A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiGVPVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbiGVPVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:21:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4D3951EC;
        Fri, 22 Jul 2022 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658503310; x=1690039310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aDJUMyeqWgGKDiSGRd02hg78VKlOMsWC6o9pMReTRlc=;
  b=kfZUyhMC3FM65hDiDrmDux2jkWwMx6JUoQodZnFzPtk5FnX+avWA3h3i
   OkquEr0gdCpMwu2GdqLcgc20r/FNxt+cVMUIf25PtO8VcdBZhzhqXJaWt
   39iXHm6iSNsixjBOT9q2uV4Ba8spp6lEJm8Zo2v0yaXotus03esGPD3Gr
   qEk3d2/P61xPPXfIHTKi86qZS+ZANHTYo5X8neTk9//R689BwJ4ELgPKz
   NnF0iNiG0SvMA/23Jp9R7jhCR1m6M0oiIjqtNOzW0CwshZ2AiontdFi0g
   7vTNgdpkHe6niBlOlT9acgyMBqirxXSBNBqf4sgnQvm0EhMUb6YolsnpN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="288504864"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="288504864"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 08:21:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="926078552"
Received: from jnoah-mobl.amr.corp.intel.com (HELO [10.209.71.211]) ([10.209.71.211])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 08:21:47 -0700
Message-ID: <a82e840f-2030-7ab3-7160-f1b900ecdb7d@intel.com>
Date:   Fri, 22 Jul 2022 08:21:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Haitao Huang <haitao.huang@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
 <ab467244dd03b5f94bafe9068b1c02790033c18c.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ab467244dd03b5f94bafe9068b1c02790033c18c.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/22 06:26, Kai Huang wrote:
> Did a quick look at the spec.  It appears ENCLU[EDECCSSA] should be used
> together with AEX-notify.  So besides advertising the new
> SGX_ATTR_ASYNC_EXIT_NOTIFY bit to the KVM guest, I think we should also
> advertise the ENCLU[EDECCSSA] support in guest's CPUID, like below (untested)?

Sounds like a great follow-on patch!  It doesn't seem truly functionally
required from the spec:

> EDECCSSA is a new Intel SGX user leaf function
> (ENCLU[EDECCSSA]) that can facilitate AEX notification handling...

If that's wrong or imprecise, I'd love to hear more about it and also
about how the spec will be updated.

Oh, and the one-liner patch that I was promised for enabling this is
getting a _wee_ bit longer than one line.
