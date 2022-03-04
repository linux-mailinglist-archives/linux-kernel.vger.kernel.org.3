Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B204CCB0C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 01:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbiCDA7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 19:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbiCDA7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 19:59:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054DE13775D;
        Thu,  3 Mar 2022 16:58:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72F00617CA;
        Fri,  4 Mar 2022 00:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F22C004E1;
        Fri,  4 Mar 2022 00:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646355509;
        bh=AV3bWsGVlhUYUJ6Ym7sGdEWFTXgwZ92WPj9KuDOn8OQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qe3iwZRA0J5zZEuebWuDSmEHUR7wUrSRj8Wh3eQ0Hd4H6ahLbmrbq0k59cxxc+1ZU
         +5dml5iWG/qwXOOzKWax3q+bz5XIz+/FK1U2W2XnxEzVArYCNA/MB5ci6YWe5mw9Rw
         A0D9HyG/A8hf2Z/BOcIEa7QVOTqBGER0V6+wYp/Ms7NaCdrX/Ca8Z9xTFv3AJ2yCB7
         DjhTIO7wf0ZjTkwD5djzJ8S6MAj9ZhWr0p8TzAl0SzqQvNHUtdObOfy3sa/V3Wvt16
         7PMCfHirhtUi86fQz+pevW7ANdXRAOYREo3sa42NGPc0qJ1TBMj1uoVrim3EdkF9vl
         sU/dS6OmMaT1A==
Date:   Fri, 4 Mar 2022 02:57:49 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nathaniel McCallum <nathaniel@profian.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 00/32] x86/sgx and selftests/sgx: Support SGX2
Message-ID: <YiFkDVhBBYj9zo1N@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <CAHAy0tR-64vxtFo4KXiJP_va2=WF++Q6gDaPksNxiaSB5wWvhA@mail.gmail.com>
 <86495779-a9c5-45d5-0017-c491bf6354ab@intel.com>
 <CAHAy0tQYBD2b0jdim=6Zv+hwskyd1FhpycyGF+1FBHDih9TP3g@mail.gmail.com>
 <e746026c-33f3-fd15-5303-563b3eb761d3@intel.com>
 <CAHAy0tRXxDQSuBVoEW9jzpFaWns4DzWqmFASFNGgGb5vjnYuPw@mail.gmail.com>
 <b2733dba-278a-4574-f7ab-f035e97f762e@intel.com>
 <CAHAy0tRoy=qpn-OqKmEHaWSngO+_Ko+YYd3Aq7WGk+1=n8=2mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHAy0tRoy=qpn-OqKmEHaWSngO+_Ko+YYd3Aq7WGk+1=n8=2mA@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 08:13:55PM -0500, Nathaniel McCallum wrote:
> On Wed, Mar 2, 2022 at 4:20 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
> >
> > Hi Nathaniel,
> >
> > On 3/2/2022 8:57 AM, Nathaniel McCallum wrote:
> > > Perhaps it would be better for us to have a shared understanding on
> > > how the patches as posted are supposed to work in the most common
> > > cases? I'm thinking here of projects such as Enarx, Gramine and
> > > Occulum, which all have a similar process. Namely they execute an
> > > executable (called exec in the below chart) which has things like
> > > syscalls handled by a shim. These two components (shim and exec) are
> > > supported by a non-enclave userspace runtime. Given this common
> > > architectural pattern, this is how I understand adding pages via an
> > > exec call to mmap() to work.
> > >
> > > https://mermaid.live/edit#pako:eNp1k81qwzAQhF9F6NRCAu1Vh0BIRemhoeSHBuIettYmFpElVZZLQ8i7144sJ8aOT2bmY3d2vT7R1AikjBb4U6JO8UXC3kGeaFI9FpyXqbSgPTmg06j6uiu1lzn2jSKTA2XwD9NEB31uPBLzi-6iMpLnYB8Wn4-kOBYpKBW52iXj8WQSmzEy5Zvt01ewG5HUQN2UEc7nK77YPjdALd64GWih8NpkALGwR_JtzOGAaKXexyTKGEt2pgoMaXahgj5Qgk9nM_6xGvDDJpsmOyiVv0LB62B8un4dBDrLiLPeWciCL9fvvKVQizhSG6stFz9Df7sxUpcYitR-SodFO2A_Vw-7l4nzzduqjX9bKJxOHDDeBB3RHF0OUlS3faq1hPoMqzulrHoVGPZOE32u0NIK8MiF9MZRtgNV4IhC6c3yqFPKvCsxQs3_0VDnfzf-CPg
> > >
> > > This only covers adding RW pages. I haven't even tackled permission
> > > changes yet. Is that understanding correct? If not, please provide an
> > > alternative sequence diagram to explain how you expect this to be
> > > used.
> >
> > Please find my attempt linked below:
> >
> > https://mermaid.live/edit#pako:eNqFUsFqAjEQ_ZWQUwsK7XUPgthQeqiUVang9jAkoxu6m2yzWVsR_72J2WTbKnSOb97MvPeSI-VaIM1oix8dKo4PEnYG6kIRVw0YK7lsQFlSghGfYPCy845GYXWJm05ZWV8ZaEt55QB-IS9UwOfaItF7NGc0I3UNzU3-ekvaQ8uhqiLPd8l4PJnEYxmZsvXm7i20e5B4QlA5rAqMgJJfG9Ixg21X2ctVXn9GGJsvWb65729FSZXWDdlqpxx46Qzu-gB8-cHzhhim2zKdzdjLcuAAt3IPzv6Qkq84EdxGM3492UJS-cdSpLHp6nEgCPz3RjI5NPvAlRisJjspOsbWT8sUyc_MwjuynC1Wzyw9EB3RGk0NUrgvePRYQW2J7tNQd5sKDN5ooU6O2jXCiWZCWm1otoWqxRGFzurFQXGaWdNhJPXfuGedvgFejOuH
> >
> > The changes include:
> > * Move mmap() to occur before attempting EACCEPT on the addresses. This is
> >   required for EACCEPT (as well as any subsequent access from within the enclave)
> >   to be able to access the pages.
> > * Remove AEX[1] to the runtime within the loop. After EAUG returns execution
> >   will return to the instruction pointer that triggered the #PF, EACCEPT,
> >   this will cause the EACCEPT to be run again, this time succeeding.
> >
> > This is based on the implementation within this series. When supporting
> > the new ioctl() requested by Jarkko there will be an additional ioctl()
> > required before the loop.
> 
> https://mermaid.live/edit/#pako:eNp1U9FqgzAU_ZWQpw1a2F6FFaQLYw8ro7asUPeQmWsNNYlL4rZS-u-LRmut1ie953jvOecmR5woBjjABr5LkAk8c7rTVMQSuYeWVslSfIH23wXVlie8oNKijGr2SzUMkT1oCfmwrktpuRj5wWRcDKvwB0ksfX2hLCD1A7quBkgIWtwtP-6ROZiE5nnLq1A0nc5m7bAAhWSzffj0cFNEFaEaGiBCFiuy3D42hKp4gWZUshy6ISOUL6X2e4CCy10rQhUW8dR52QESivGUJ9RyJQ2SAAyYZ_V6ndUSsnldneVca_bJdvY7lkf6vc4haTBlbsdbDmLoaLlSBUqVy5wmWW2nw3rq26Pg-oTzOXlf9Xkt7BfTeqjjSWlP2JWTlkrC9cutlmcLlUlxoRBkE3T9Mrq7KArd0UBPqFDGTpstI2OphSv-jf1cBukPJlmSaP1GXFs8wQK0oJy523Ws-DG2GTiJOHCvDLx3HMuTo5YFc1MJ41ZpHKQ0NzDB1fWLDjLBgdUltKTmhjas0z-kWy8L
> 
> My comments below correspond to the arrow numbers in the diagram.
> 
> 2. When the runtime receives the AEX, it doesn't have enough knowledge
> to know whether or not to ask the kernel for an mmap(). So it has to
> reenter the shim.
> 
> 3. The shim has to handle the syscall instruction routing it to the
> enclave's memory management subsystem.
> 
> 4. The shim has to do bookkeeping and decide if additional pages are
> even needed. If pages are already allocated, for example, it can skip
> directly to step 13. However, if modifications are needed, it will go
> to steps 5-12.
> 
> 5-12. This is the part that represents new code from the kernel's
> perspective for SGX2. It is also in a performance critical path and
> should be evaluated with greater scrutiny. The number of context
> switches is O(2N + 4) for each new allocated block, where N is the
> number of pages: a context switch occurs at step 5, 6, 7,  8, 9/10 and
> 12. However, this can be reduced to O(4) for each new allocated block
> with a simple modification:
> 
> https://mermaid.live/edit/#pako:eNqNk11rwyAUhv-KeLVBC9ttYIXQydjFymhaVmh24fSkkUbN1Gwrpf99pvlsk8G80nMez3l91SNmmgMOsIXPAhSDR0F3hspYIT9o4bQq5AeYap1T4wQTOVUOpdTwb2pgmNmDUZAN46ZQTsiRDTYVchiFH2CxquIL7QDpLzDnaICkpPnN8u0W2YNlNMsarsyi6XQ2a5oFKCSb7d17la6DqATKpgEiZLEiy-19DZTBXjalimfQNRlBPrTe7wFyoXaNCJ07JBJ_lh0gqblIBKNOaGWRAuDAK-qiVquWkM3zqpVzrblytjt-R2Va5yjR3h_K0nPrLleOaudFERKunzoIVE9Xj26VtZYbsEXmxgUOTP2_witfSTifk9fViMDzZPQuoij0V40eUK6tm9a3hqyjDq74P_zuH6V6aGRJovUL8WXxBEswkgruf8ux5GPsUvDvGQd-yiGhpS04ViePFjn3XQkXThscJDSzMMHld4oOiuHAmQIaqP5xNXX6BeBJIEk
> 
> The interesting thing about this pattern is that this can be done for
> all page modification types except EMODT. For example, here's the same
> process for changing a mapping from RW to RX:
> 
> https://mermaid.live/edit/#pako:eNqNk11rwyAUhv-KeLVBC9ttYIVCvdhFu5F0UGh24fSkkUbN1Gwrpf995jttMphXes7jOa-vesZMc8ABtvBZgGKwEvRgqIwV8oMWTqtCfoCp1zk1TjCRU-VQSg3_pgbGmSMYBdk4bgrlhJzYYFMhx1H4ARarOr7RDpD-AlNFAyQlze_C3T2yJ8tolrVcmUXz-WLRNgvQkuz2D-91ugmiEiibBoiQzZaE-8cGKIODbEoVz6BvMoF8aH08AuRCHVoROndIJP4sB0BSc5EIRp3QyiIFwIHX1FWtTi0hu-dtJ-dWc-1sf_yeyrTOUaK9P5SlVes-V45651URsn5ZvYY9BmqgbMB32jrTDdgic9MSR7b-X-ONs5U-MqGvmkxeRhQt_V2jJ5Rr6-bNtSHrqIMb_g_DhyepXxoJSfS2Jr4snmEJRlLB_Xc5l3yMXQr-QePATzkktHQFx-ri0SLnvivhwmmDg4RmFma4_E_RSTEcOFNACzVfrqEuvytQILY
> 
> My point in this thread has always been that it is an anti-feature to
> presume that there is a need to treat EPC and VLA permissions
> separately. This is a performance sink and it optimizes for a use case
> which doesn't exist. Nobody actually wants there to be a mismatch
> between EPC and VLA permissions.

I would not touch pre-initialization, EADD'd pages. The reason is
backwards compatibility.

For post-initialization, options are still open.

> So, besides EMODT, the only userspace interface we need is
> mmap()/mprotect()/munmap(). The kernel should either succeed the
> mmap()/mprotect()/munmap() syscall if the EPC permissions can be made
> compatible or should fail otherwise.

For mmap() it is the enclave who sets the permissions, not kernel, i.e. you
get a half-broken mmap() implementation. Kernel does EAUG, enclave does
EACCEPTCOPY.

I think what you're asking is too simple to be true, and even if we could
do it, it might limit possibilities to optimize user space, e.g. because
there is two ENCLU leaf functions (EMODPE, EACCEPTCOPY) and one ENCLS
leaf function (EMODPR), which can modify permissions.

A kernel syscall is essentially something that can be fully serviced
by the kernel. This is not such situation. The work is split.

BR, Jarkko
