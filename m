Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9675D510FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 06:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357622AbiD0EIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 00:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbiD0EIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 00:08:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1271CB31
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651032326; x=1682568326;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FZHtsAFaRuQD3iQqtoOKS8GLIsWSCXJtA8Y7MOpLAxw=;
  b=md2DCqKoqRMEZ0l/QVU+17064wdV5eqmCDIwF5n2lqMhNlmkTLZZbpfE
   jHccZeG85YUCITfoyC3OxeRdrgv0+LRpERhG3/gdnAwQwi485YAFf0DG0
   DcnFEvvc5QKmZQho2GyE8SUNB9+87iG64Cg+x26kzDRKpe42BIi3M0G6M
   b6m4JZqzPziGmQkjVRJipGHN3npVUIZn2NE6mdCK/fABDsox2ido8/8nF
   rcwk6oGhhQkiModVznwXgHrYUN8QHC8WFTcpQox8MPdVtqxXE5Sly2RXx
   RzCpS7eZLuXZul3RuplBJN+lEsDIlB0n9euy5L288HCSuCkGhGD+mD5eX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="328748426"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="328748426"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 21:05:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="730594987"
Received: from jsaetton-mobl1.amr.corp.intel.com (HELO [10.209.41.167]) ([10.209.41.167])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 21:05:24 -0700
Message-ID: <405a4f3c-3d49-f3c2-441b-8d8b9d5eec23@linux.intel.com>
Date:   Tue, 26 Apr 2022 21:05:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <0457ce8e78ddd1d6c7832176368e095adae1bc18.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <0457ce8e78ddd1d6c7832176368e095adae1bc18.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

On 4/24/22 10:44 PM, Kai Huang wrote:
>> In TDX guest, attestation is used to verify the trustworthiness of a TD
>> to other entities before making any secure communication.
> Before provisioning secrets to the TD.
> 
>> One usage example is, when a TD guest uses encrypted drive and the
>> decryption keys required to access the drive are stored in a secure
>> 3rd party keyserver, TD guest can use the quote generated via the
>> attestation process to prove its trustworthiness with keyserver and
>> get access to the storage keys.
> "The key server can use attestation to verify TD's trustworthiness and release
> the decryption keys to the TD".
> 
> It is the key server who starts the attestation request, but not the TD.
> 
>> General steps involved in attestation process are,
>>
>>    1. TD guest generates the TDREPORT that contains version information
>>       about the Intel TDX module, measurement of the TD, along with a
>>       TD-specified nonce.
>>    2. TD guest shares the TDREPORT with TD host via GetQuote hypercall
>>       which is used by the host to generate a quote via quoting
>>       enclave (QE).
>>    3. Quote generation completion notification is sent to TD OS via
>>       callback interrupt vector configured by TD using
>>       SetupEventNotifyInterrupt hypercall.
>>    4. After receiving the generated TDQUOTE, a remote verifier can be
>>       used to verify the quote and confirm the trustworthiness of the
>>       TD.
> Let's separate TDREPORT generation and Quote generation, and get rid of details
> of how to get Quote part for now. Detail of GetQuote belongs to the patch which
> implements it.  Here I think we should focus on explaining why we need such a
> basic driver to allow userspace to get the TDREPORT.
> 
> Below is for your reference:
> 
> "
> The attestation process consists of two steps: TDREPORT generation and Quote
> generation.  TDREPORT (TDREPORT_STRUCT) is a fixed-size data structure generated
> by the TDX module to contain the TD-specific informatin (such as TD
> measurements), platform information such as the security version of the platform
> and the TDX module and the MAC to protect the integrity of the TDREPORT. TD
> kernel uses TDCALL[TDG.MR.REPORT] to get the TDREPORT from the TDX module.  A
> user-provided 64-Byte REPORTDATA is used as input and included in the TDREPORT.
> Typically it can be some nonce provided by attestation service so the TDREPORT
> can be verified uniquely.
> 
> TDREPORT can only be verified locally as the MAC key is bound to the platform.
> TDX attestation leverages Intel SGX Quote Enclave (QE) to verify the TDREPORT
> locally and convert it to a remote verifiable Quote to support remote
> attestation of the TDREPORT.  After getting the TDREPORT, the second step of
> attestation process is to send the TDREPORT to QE to generate the Quote.
> 
> How is the QE, or Quote Generation Service (QGS) in general, implemented and
> deployed is implementation specific.  As a result, how to send the TDREPORT to
> QE/QGS also depends on QE/QGS implementation and the deployment.  TDX doesn't
> support SGX inside a TD, so the QE/QGS can be deployed in the host, or inside a
> dedicated legacy VM.
> 
> A typical implementation is TD userspace attestation software gets the TDREPORT
> from TD kernel, sends it to QE/QGS, and QE/QGS returns the Quote.  The data and
> data format that TD userspace attestation software sends to the QE/QGS is also
> implementation specific, but not necessarily just the raw TDREPORT.  TD
> attestation software can use any available communication channel to talk to
> QE/QGS, such as using vsock and tcp/ip.
> 
> To support the case that those communication channels are not directly available
> to the TD, TDX also defines TDVMCALLs to allow TD to use TDVMCALL to ask VMM to
> help with sending the TDREPORT and receiving the Quote.  This support is
> documented in the GHCI spec "5.4 TD attestation".
> 
> Implement a basic attestation driver to allow TD userspace to get the TDREPORT
> so the attestation software can send it to the QE to generate a Quote for remote
> verification.
> "
> 
> 
>>       
>> More details on above mentioned steps can be found in TDX Guest-Host
>> Communication Interface (GHCI) for Intel TDX 1.0, section titled
>> "TD attestation".
>>
>> To allow the attestation agent (user application) to implement this
>> feature, add an IOCTL interface to get TDREPORT and TDQUOTE from the
>> user space. Since attestation agent can also use methods like vosck or
>> TCP/IP to get the TDQUOTE, adding an IOCTL interface for it is an
>> optional feature. So to simplify the driver, first add support for
>> TDX_CMD_GET_TDREPORT IOCTL. Support for TDQUOTE IOCTL will be added by
>> follow-on patches.
>>
>> TDREPORT can be generated by sending a TDCALL with leaf ID as 0x04.
>> More details about the TDREPORT TDCALL can be found in Intel Trust
>> Domain Extensions (Intel TDX) Module specification, section titled
>> "TDG.MR.REPORT Leaf". Add a wrapper function (tdx_mcall_tdreport())
>> to get the TDREPORT from the TDX Module. This API will be used by the
>> interface driver to request for TDREPORT.
>>
>> Also note that explicit access permissions are not enforced in this
>> driver because the quote and measurements are not a secret. However
>> the access permissions of the device node can be used to set any
>> desired access policy. The udev default is usually root access
>> only.

How about the following summary? It includes important notes mentioned
by you and some more driver info.

x86/tdx: Add TDX Guest attestation interface driver

In TDX guest, attestation is used to verify the trustworthiness of a TD
to other entities before provisioning secrets to the TD.

One usage example is, when a TD guest uses encrypted drive and if the
decryption keys required to access the drive are stored in a secure 3rd
party key server, the key server can use attestation to verify TD's
trustworthiness and release the decryption keys to the TD.

The attestation process consists of two steps: TDREPORT generation and
Quote generation.

TDREPORT (TDREPORT_STRUCT) is a fixed-size data structure generated by
the TDX module which contains TD-specific information (such as TD
measurements), platform security version, and the MAC to protect the
integrity of the TDREPORT. The TD kernel uses TDCALL[TDG.MR.REPORT] to
get the TDREPORT from the TDX module. A user-provided 64-Byte
REPORTDATA is used as input and included in the TDREPORT. Typically it
can be some nonce provided by attestation service so the TDREPORT can
be verified uniquely. More details about TDREPORT can be found in
Intel TDX Module specification, section titled "TDG.MR.REPORT Leaf".

After getting the TDREPORT, the second step of the attestation process
is to send the TDREPORT to Quoting Enclave (QE) or Quote Generation
Service (QGS) to generate the Quote. However, the method of sending the
TDREPORT to QE/QGS, communication channel used and data format used is
specific to the implementation of QE/QGS.

A typical implementation is, TD userspace attestation software gets the
TDREPORT from TD kernel, sends it to QE/QGS, and QE/QGS returns the
Quote. TD attestation software can use any available communication
channel to talk to QE/QGS, such as using vsock and tcp/ip.

To support the case that those communication channels are not directly
available to the TD, TDX also defines TDVMCALL
(TDG.VP.VMCALL<GetQuote>) to allow TD to ask VMM to help with sending
the TDREPORT and receiving the Quote. This support is documented in the
GHCI spec section titled "5.4 TD attestation".

Implement a basic attestation driver to allow TD userspace to get the
TDREPORT, which is sent to QE by the attestation software to generate
a Quote for remote verification. Add a wrapper function
(tdx_mcall_tdreport()) to get the TDREPORT from the TDX Module. This
API will be used by the interface driver to request for TDREPORT.

Also note that explicit access permissions are not enforced in this
driver because the quote and measurements are not a secret. However
the access permissions of the device node can be used to set any
desired access policy. The udev default is usually root access
only.




-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
