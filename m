Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E78F5A0135
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbiHXSQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbiHXSQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:16:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957A776750
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661364968; x=1692900968;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c/S0eX7GP40YmWzS5fu0WgIGqmES/7R/7RCOdpbrjD8=;
  b=S6DhharXDd68Xz3M+Gbhw+jy86MNY5Mtc/OoAAze2+ExM0Ln5t+Wz5Gp
   zT9foWDoIaxHHaU3ma0p5wp886T9ilC3u7KmMUVlWBKF3WxGZdn2VoU3+
   QlIYYkVqKwZQ/fELwC+CNMNpS30VE8Hfu9QzPEADAs7qkilWbL2a43try
   cLRBKZpIbB4WFfSmNlDb+GSlDQcd8C9Ds5/xMC3yMxOpg0uD3CqGDGj8Q
   kQ1jp6MWyhm7H8G8HURVCwSekoL0w7xBkxzY8Jv87eYvYXOSrJoNHXAOI
   X9U0miqWiDnwKwKzNDc6gp3Yf1b169zFlV4ashjvlcSVDLuVtDPNnNl/c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="320107235"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="320107235"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 11:16:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="639233957"
Received: from cceisenm-mobl1.amr.corp.intel.com (HELO [10.212.174.196]) ([10.212.174.196])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 11:16:07 -0700
Message-ID: <1481d6c6-7d59-cd06-2c44-2ed534d3070a@linux.intel.com>
Date:   Wed, 24 Aug 2022 11:16:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v9 0/6] Add TDX Guest Attestation support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <bb006b7a-525a-3f1b-0fc4-1620bb5bd3ba@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <bb006b7a-525a-3f1b-0fc4-1620bb5bd3ba@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/24/22 10:12 AM, Dave Hansen wrote:
> On 7/27/22 20:44, Kuppuswamy Sathyanarayanan wrote:
>> An Intel SGX Quoting Enclave (QE), written specifically to support
>> quoting Intel TDX TDs, uses EVERIFYREPORT2, to help check the integrity
>> of the TDG.MR.REPORT. If it passes, the QE can use a certified quote
>> signing key to sign a quote containing the guest TD’s measurements and
>> the additional data being quoted.
> 
> (maintainer hat firmly in place, not speaking as an Intel person here...)
> 
> Let's say Intel tires of SGX and zaps it from server CPUs just like it
> did clients.  Or, that Intel decides that TDX is really cool and wants
> it on SGX-free clients in addition to servers.
> 
> Can the guest ABI which is introduced here work for a future attestation
> architecture that does not involve SGX?

Yes. ABI introduced here is agnostic to QE implementation. For getting a
signed Quote, the guest will pass TDREPORT with length as input and expect
signed Quote with length as output. This requirement is valid irrespective
of QE implementation(SGX/no-SGX).

As you can see below, in our ABI we pass TDREPORT with "tdx_quote_hdr" in a
buffer. Upon successful completion of the request, we expect Quote in the
same buffer with proper header details. Such header format is generic and
should work well in non-SGX environment you have mentioned as well.

Input buffer -> [tdx_quote_hdr][TDREPORT]
Output buffer -> [tdx_quote_hdr][Quote]

struct tdx_quote_hdr {
        /* Quote version, filled by TD */
        __u64 version;
        /* Status code of Quote request, filled by VMM */
        __u64 status;
        /* Length of TDREPORT, filled by TD */
        __u32 in_len;
        /* Length of Quote, filled by VMM */
        __u32 out_len;
        /* Actual Quote data or TDREPORT on input */
        __u64 data[0];
};

/* struct tdx_quote_req: Request to generate TD Quote using TDREPORT
 *
 * @buf         : Pass user data that includes TDREPORT as input. Upon
 *                successful completion of IOCTL, output is copied
 *                back to the same buffer.
 * @len         : Length of the Quote buffer.
 */
struct tdx_quote_req {
        __u64 buf; // buf with header and data
        __u64 len;
};

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
