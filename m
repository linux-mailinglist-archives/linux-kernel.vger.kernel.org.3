Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F994DC8C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiCQOaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiCQOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:30:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488D213E16A;
        Thu, 17 Mar 2022 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647527330; x=1679063330;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=smlVo/6V8oeLQQwTEoeQtGNbNxQ+U934xez9VKbaknE=;
  b=mO2bvLBlQU5f4s4vHzmt5vcMLdbyiTLQNiR6bh+F9d0yT2rVhUFF8eiR
   qHm9tb0deJE4NoePPVSVxMVXUcwQlvij/PCpXfua0t/p4LFCdhSCkWLUP
   Vhs0FlrEkH9hissO4EVpW7p9T3M2wQ+AcsOEPFAvhBt0mO2wrtPmTPmbW
   rvs/VYsrbIaaxgBCJ2EySxBC9vM+xrAE/svxNQBGzHbj9TXHqN3WOM9TR
   z/IOqRTkMKMbWwRB0cfYOj1KYco9XmxtOLh+st6iBl7zGrzMWKYDIs0Ir
   zVUKO6Jg3Atw5CinZf+73cbxoruhYLXKVohJFQKBnBEtUHuDNULbW8w9t
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="236823092"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="236823092"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 07:28:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="557951293"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.255.39.199])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 17 Mar 2022 07:28:47 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     "Reinette Chatre" <reinette.chatre@intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nathaniel@profian.com
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
References: <YimWaAqEnXHbLdjh@iki.fi>
 <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net> <Yis8LV99mORcLYs6@iki.fi>
 <Yis9rA8uC/0bmWCF@iki.fi> <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com>
 <Yi6tPLLt9Q+ailQ3@iki.fi> <Yi6tinbF+Y7a66eQ@iki.fi> <Yi6va4dCaljiQ1WQ@iki.fi>
 <op.1i01q9s0wjvjmi@hhuan26-mobl1.mshome.net> <YjLcr9TwLNWUtwkS@iki.fi>
 <YjLfIMz4/Vx8Jm24@iki.fi>
Date:   Thu, 17 Mar 2022 09:28:45 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1i6iegamwjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <YjLfIMz4/Vx8Jm24@iki.fi>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, 17 Mar 2022 02:11:28 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Thu, Mar 17, 2022 at 09:01:07AM +0200, Jarkko Sakkinen wrote:
>> On Mon, Mar 14, 2022 at 10:39:36AM -0500, Haitao Huang wrote:
>> > Hi Jarkko
>> >
>> > On Sun, 13 Mar 2022 21:58:51 -0500, Jarkko Sakkinen  
>> <jarkko@kernel.org>
>> > wrote:
>> >
>> > > On Mon, Mar 14, 2022 at 04:50:56AM +0200, Jarkko Sakkinen wrote:
>> > > > On Mon, Mar 14, 2022 at 04:49:37AM +0200, Jarkko Sakkinen wrote:
>> > > > > On Fri, Mar 11, 2022 at 09:53:29AM -0800, Reinette Chatre wrote:
>> > > > >
>> > > > > > I saw Haitao's note that EMODPE requires "Read access  
>> permitted
>> > > > by enclave".
>> > > > > > This motivates that EMODPR->PROT_NONE should not be allowed
>> > > > since it would
>> > > > > > not be possible to relax permissions (run EMODPE) after that.
>> > > > Even so, I
>> > > > > > also found in the SDM that EACCEPT has the note "Read access
>> > > > permitted
>> > > > > > by enclave". That seems to indicate that EMODPR->PROT_NONE is
>> > > > not practical
>> > > > > > from that perspective either since the enclave will not be  
>> able to
>> > > > > > EACCEPT the change. Does that match your understanding?
>> > > > >
>> > > > > Yes, PROT_NONE should not be allowed.
>> > > > >
>> > > > > This is however the real problem.
>> > > > >
>> > > > > The current kernel patch set has inconsistent API and EMODPR  
>> ioctl is
>> > > > > simply unacceptable. It  also requires more concurrency  
>> management
>> > > > from
>> > > > > user space run-time, which would be heck a lot easier to do in  
>> the
>> > > > kernel.
>> > > > >
>> > > > > If you really want EMODPR as ioctl, then for consistencys sake,
>> > > > then EAUG
>> > > > > should be too. Like this when things go opposite directions,  
>> this
>> > > > patch set
>> > > > > plain and simply will not work out.
>> > > > >
>> > > > > I would pick EAUG's strategy from these two as it requires half
>> > > > the back
>> > > > > calls to host from an enclave. I.e. please combine mprotect()  
>> and
>> > > > EMODPR,
>> > > > > either in the #PF handler or as part of mprotect(), which ever
>> > > > suits you
>> > > > > best.
>> > > > >
>> > > > > I'll try demonstrate this with two examples.
>> > > > >
>> > > > > mmap() could go something like this() (simplified):
>> > > > > 1. Execution #UD's to SYSCALL.
>> > > > > 2. Host calls enclave's mmap() handler with mmap() parameters.
>> > > > > 3. Enclave up-calls host's mmap().
>> > > > > 4. Loops the range with EACCEPTCOPY.
>> > > > >
>> > > > > mprotect() has to be done like this:
>> > > > > 1. Execution #UD's to SYSCALL.
>> > > > > 2. Host calls enclave's mprotect() handler.
>> > > > > 3. Enclave up-calls host's mprotect().
>> > > > > 4. Enclave up-calls host's ioctl() to  
>> SGX_IOC_ENCLAVE_PERMISSIONS.
>> >
>> > I assume up-calls here are ocalls as we call them in our  
>> implementation,
>> > which are the calls enclave make to untrusted side via EEXIT.
>> >ar
>> > If so, can your implementation combine this two up-calls into one,  
>> then host
>> > side just do ioctl() and mprotect to kernel? If so, would that  
>> address your
>> > concern about extra up-calls?
>> >
>> >
>> > > > > 3. Loops the range with EACCEPT.
>> > > >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> > > >   5. Loops the range with EACCEPT + EMODPE.
>> > > >
>> > > > > This is just terrible IMHO. I hope these examples bring some  
>> insight.
>> > >
>> > > E.g. in Enarx we have to add a special up-call (so called enarxcall  
>> in
>> > > intermediate that we call sallyport, which provides shared buffer to
>> > > communicate with the enclave) just for reseting the range with  
>> PROT_READ.
>> > > Feel very redundant, adds ugly cruft and is completely opposite  
>> strategy
>> > > to
>> > > what you've chosen to do with EAUG, which is I think correct choice  
>> as
>> > > far
>> > > as API is concerned.
>> >
>> > The problem with EMODPR on #PF is that kernel needs to know what  
>> permissions
>> > requested from enclave at the time of #PF. So enclave has to make at  
>> least
>> > one call to kernel (again via ocall in our case, I assume up-call in  
>> your
>> > case) to make the change.
>>
>> The #PF handler should do unconditionally EMODPR with PROT_READ.
>
> Or mprotect(), as long as secinfo contains PROT_READ. I don't care about
> this detail hugely anymore because it does not affect uapi.
>
> Using EMODPR as a permission control mechanism is a ridiculous idea, and
> I cannot commit to maintain a broken uapi.
>

Jarkko, how would automatically forcing PROT_READ on #PF work for this  
sequence?

1) EAUG a page (has to be RW)
2) EACCEPT(RW)
3) enclave copies some data to page
4) enclave wants to change permission to R

If you are proposing mprotect, then as I indicated earlier, please address  
concerns raised by Reinette:
https://lore.kernel.org/linux-sgx/e1c04077-0165-c5ec-53be-7fd732965e80@intel.com/



Thanks
Haitao
