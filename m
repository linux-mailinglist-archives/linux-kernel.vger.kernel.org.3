Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC20E4CC9DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiCCXN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiCCXN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:13:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F92AEF33;
        Thu,  3 Mar 2022 15:13:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25B3BB82702;
        Thu,  3 Mar 2022 23:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A6BC004E1;
        Thu,  3 Mar 2022 23:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646349188;
        bh=jnUbHJnKeuwckYEvpMWc3F3NDtb/FHG6OBOmn7PIsWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bdT3l8rJ6JeqEF5lrrsl1NKwVjbYqE7Dao4N+tDRG6YSTm37P8E+5lVo78RZky1WR
         RxSii+QDHfY79q5OPqd24VH5y+RcZhQYzKwI3+t6JYoGa3ePKwMWjAliykKQf/zgXg
         Oo6T3MrDQV42yAXCVz9ktJN8VJx+UqGrSvgBgcvSltgK8NfYypS3pSD6ydZt/dSMyT
         QihU+dAXuAqjp/2XIoNrsd8BiJEE33TxDof1hBMrUO5UhQlxIdakgDoVOTw/LjNxdt
         EXrtSTOfnePD9qGepPtMXsq3BM60+KKhsoq71ahdpKDfmd7C9WAepyNrLO1HhtDQ5i
         8OeykNSq3s64w==
Date:   Fri, 4 Mar 2022 01:12:28 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Message-ID: <YiFLXABTitx85sfj@iki.fi>
References: <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi>
 <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
 <Yh4fGORDaJyVrJQW@iki.fi>
 <Yh4i4hVcnfZ8QDAl@iki.fi>
 <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com>
 <Yh7Q5fbOtr+6YWaS@iki.fi>
 <6f65287a-f69c-971e-be2c-929e327e7ff9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f65287a-f69c-971e-be2c-929e327e7ff9@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 02:57:45PM -0800, Reinette Chatre wrote:
> > What do you mean by "user space policy" anyway exactly? I'm sorry but I
> > just don't fully understand this.
> 
> My apologies - I just assumed that you would need no reminder about this contentious
> part of SGX history. Essentially it means that, yes, the kernel could theoretically
> permit any kind of access to any file/page, but some accesses are known to generally
> be a bad idea - like making memory executable as well as writable - and thus there
> are additional checks based on what user space permits before the kernel allows
> such accesses.

The device files are limited by a GID (in systemd upstream), which is a
"user policy".

What you want to add and why augmentation cannot be made complete before
the unknown factor is added to the access control?

> >>> I think the best way to move forward would be to do EAUG's explicitly with
> >>> an ioctl that could also include secinfo for permissions. Then you can
> >>> easily do the rest with EACCEPTCOPY inside the enclave.
> >>
> >> SGX_IOC_ENCLAVE_ADD_PAGES already exists and could possibly be used for
> >> this purpose. It already includes SECINFO which may also be useful if
> >> needing to later support EAUG of PT_SS* pages.
> > 
> > You could also simply add SGX_IOC_ENCLAVE_AUGMENT_PAGES and call it a day.
> 
> I could, yes.

And this enables EACCEPTCOPY pattern nicely.

E.g. you can implement mmap() with EAUG and then EACCEPTCOPY feeded with
permissions and a zero page:

1. enclave calls back to host to do mmap()
2. host does eaug on given range and enter back to enclave.
3. enclave does eacceptcopy with given permissions and a zero page.

> > I don't like this type of re-use of the existing API.
> 
> I could proceed with SGX_IOC_ENCLAVE_AUGMENT_PAGES if there is consensus after
> considering the user policy question (above) and performance trade-off (more below).

Ok.

If adding this would be a bottleneck it would be already persistent int
"add pages", so whatever limitation there might be, it already exist.

Thus, logically, that could be safely added without worrying about user
policies all that much...

> 
> > 
> >> The big question is whether communicating user policy after enclave initialization
> >> via the SECINFO within SGX_IOC_ENCLAVE_ADD_PAGES is acceptable to all? I would
> >> appreciate a confirmation on this direction considering the significant history
> >> behind this topic.
> > 
> > I have no idea because I don't know what is user space policy.
> 
> This discussion is about some enclave usages needing RWX permissions
> on dynamically added enclave pages. RWX permissions on dynamically added pages is

I'm not sure if that is actually necessary, if you use EAUG-EACCEPTCOPY
type of pattern. Please correct if I'm wrong.

> not something that should blindly be allowed for all SGX enclaves but instead the user
> needs to explicitly allow specific enclaves to have such ability. This is equivalent
> to (but not the same as) what exists in Linux today with LSM. As seen in
> mm/mprotect.c:do_mprotect_pkey()->security_file_mprotect() Linux is able to make
> files and memory be both writable and executable, but it would only do so for those
> files and memory that the LSM (which is how user policy is communicated, like SELinux)
> indicates it is allowed, not blindly do so for all files and all memory.

We could also potentially make LSM hooks to ioctls, if that is ever needed.

And as I said earlier, EAUG ioctl does not make things any worse they might
be.

> >>> Putting EAUG to the #PF handler and implicitly call it just too flakky and
> >>> hard to make deterministic for e.g. JIT compiler in our use case (not to
> >>> mention that JIT is not possible at all because inability to do RX pages).
> 
> I understand how SGX_IOC_ENCLAVE_AUGMENT_PAGES can be more deterministic but from
> what I understand it would have a performance impact since it would require all memory
> that may be needed by the enclave be pre-allocated from outside the enclave and not
> just dynamically allocated from within the enclave at the time it is needed.
> 
> Would such a performance impact be acceptable?

IMHO yes because bad behaving enclave can cause the same issue anyway,
and more indeterministic manner.

BR, Jarkko
