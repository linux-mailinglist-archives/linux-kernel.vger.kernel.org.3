Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395BA57D689
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiGUWIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUWIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:08:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB5B93C2B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658441329; x=1689977329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A15/vVZpnpZfHrd9m7ClSkmBk0SMp9sEl8Bf2e15Ymw=;
  b=VKat/S161BbfhWvjsH2xtVU1gl8EVaRb621tba/HzJg2+HU3GMt5SrcF
   ekkHpnrSd6JYyPA4Wk2cSPPePSCK1gzfK1UFjloLULnOCoJUULu85O72j
   tB/gTbWKuNm52Cm5vDZ6YVjB9H31Kt/G9X5KrYP7cWZusHyk8aEb3VovP
   mM+0yZqLVkltH9QqxKVf9Zc6imtNa9WEghZB6OevUTC252LgC0qu4Ke9R
   uM5ZxyBwgiSS6aFyZtSv4AGf6KRlN5D+VwoE5V9+oNzYPX7snnkVVnbT+
   PTNgHAQMYY/Zro76SYIwFP5/ttvwl5+TPPcsACUQWJtFkipfQcswdz7QT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="270217629"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="270217629"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:08:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="598633154"
Received: from sattaran-mobl1.amr.corp.intel.com (HELO [10.212.246.186]) ([10.212.246.186])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:08:48 -0700
Message-ID: <0b4af60c-73fc-054e-8a2c-7bf4544e77f6@linux.intel.com>
Date:   Thu, 21 Jul 2022 15:08:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
 <f043d9f5-8f89-4ef3-2ce1-75665122bb3a@linux.intel.com>
 <214e24f0-5236-be8d-024a-da48737d854a@intel.com>
 <e280aaf4-57da-6453-c31c-6996dc85219c@linux.intel.com>
 <a65473db-b307-c076-6d2f-8f2084d81eb5@intel.com>
 <b8af932e-13da-ddcd-4ecb-bd8369853242@linux.intel.com>
 <fb9cbec5-6f64-4647-3bc2-30f07a0b6b59@intel.com>
 <20220721184221.GA3288872@ls.amr.corp.intel.com>
 <1fdecc17-8f4f-fceb-8da0-4a21ca0d58be@intel.com>
 <d0a3d1cc-dfea-0731-c801-97c8eb2cd535@linux.intel.com>
 <71f3326d-319b-c78a-345b-499001e766ff@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <71f3326d-319b-c78a-345b-499001e766ff@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 7/21/22 12:23 PM, Dave Hansen wrote:
> On 7/21/22 11:57, Sathyanarayanan Kuppuswamy wrote:
>>> How does the VMM know how much to read/write?  I have a theory: the spec
>>> says that R12 is:
>>>
>>> 	"Shared 4KB GPA as input – the memory contains a
>>> 	TDREPORT_STRUCT."
>>>
>>> That's *A* 4KB GPA.  The maximum is one 4KB page.  That's the only thing
>>> that makes sense because there's no length in the ABI anywhere.
>>>
>>> What am I missing?
>> I think you are looking into the old spec. Please check the version
>> "FEBRUARY 2022"
>>
>> Following are the ABI details:
>>
>> R11 - TDG.VP.VMCALL< GetQuote > sub-function per Table 2-3
>> R12 - Shared GPA as input – the memory contains a TDREPORT_STRUCT. The
>>        same buffer is used as output – the memory contains a TD Quote.
>> R13 -  Size of shared GPA. The size must be 4KB-aligned.
> 
> Yeah, silly me.  I assumed the ABI was stable and wouldn't be, you know,
> adding and removing parameters.
> 
> I still don't know how this all works.  You just said:

At a high level, the quote generation communication flow is as below:

Entities involved are,

Guest TD user app (send TDREPORT)  <-> Quoting Enclave (QE) (Sign TDREPORT and send Quote)

Steps involved are,

1. Attestation agent (in TD userspace)  will get the TDREPORT data from
   the TDX module.
2. To generate a remotely verifiable Quote, send the TDREPORT data to the
   Quoting enclave (QE). QE will verify the integrity of TDREPORT and sign
   it with the attestation key.
   * QE can be hosted as simple app in the host, or it can be hosted in a special
     TD guest.
3. Method of sending TDREPORT to QE depends on the QE requirements. In most
   cases, it will support TCP/IP or vsock communication models. So the attestation
   agent can easily send the TDREPORT via TCP/IP and get the Quote data.

But for platforms that do not want to support TCP/IP or socket communication,
TDX ABI defines a method of getting Quote using TDVMCALL. It is a less common
case. Our current discussion is related to this approach.

Entities involved in this approach are,

TD Guest user app <-> TD Guest kernel <-> VMM  <-> QE

Communication flow looks like below:

1. Attestation agent (in TD userspace)  will get the TDREPORT data from
   the TDX module.
2. Check with QE about the required quote size (it can be some form of
   agreement between QE and attestation agent).
3. Allocate space for Quote buffer and update the header details like
   mentioned below and send the quote buffer and length details via
   IOCTL

+/*
+ * Format of Quote data header. More details can be found in TDX
+ * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
+ * section titled "TDG.VP.VMCALL<GetQuote>"
+ */
+struct tdx_quote_hdr {
+       /* Quote version, filled by TD */
+       __u64 version;
+       /* Status code of Quote request, filled by VMM */
+       __u64 status;
+       /* Length of TDREPORT, filled by TD */
+       __u32 in_len;
+       /* Length of Quote, filled by VMM */
+       __u32 out_len;
+       /* Actual Quote data or TDREPORT on input */
+       __u64 data[0];
+};
+
+/* struct tdx_quote_req: Request to generate TD Quote using TDREPORT
+ *
+ * @buf         : Pass user data that includes TDREPORT as input. Upon
+ *                successful completion of IOCTL, output is copied
+ *                back to the same buffer.
+ * @len         : Length of the Quote buffer.
+ */
+struct tdx_quote_req {
+       __u64 buf;
+       __u64 len;
+}

4. Once an IOCTL request is received, the kernel will allocate a Quote buffer
   of the requested size, and use GetQuote hypercall to send this request to VMM. 

   GetQuote (TDVMCALL type, kernel buffer physical addr, length of the buffer).
   
5. Upon hypercall request, VMM will further send the details to the QE. Once
   QE processes this request and generates the Quote, it will update the status
   details in the Quote header and copy the Quote back to the guest GPA. After
   completing the request, it will also send the IRQ notification to the TD
   Guest kernel. Event notification IRQ requirement is due to this step.
   
6. Once TD Guest kernel receives event notification, it will copy the 
   contents of the Quote back to the user buffer and complete the IOCTL
   request.

> 
>> Current ABI allows attestation service and agent to decide the quote size. So
>> we can't make assumptions on what that size will be.
> 
> But, the guest *HAS* to make assumptions, right?  It's allocating the
> buffer and handing a pointer and size over to the host.  It's also guest
> *userspace*.  In fact, this implementation *ABSOLUTELY* makes
> assumptions about the buffer size.
> 
> If host userspace some day decides it needs 5MB of space, then all the
> guests will just stop working.  This implementation is limited by the
> max page allocator size.

Agree. We are assuming that the user agent will not request buffer that
exceeds the limit of the page allocator. But as Isaku mentioned, it is
expected that the Quote size will only be in KBs. I think the main
reason for ABI not limiting the size is, for flexibility and to
support future requirements.

Also, as mentioned above, this approach is not a common case. TCP/IP or
vsock models are generally supported and can be used for Quote generation.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
