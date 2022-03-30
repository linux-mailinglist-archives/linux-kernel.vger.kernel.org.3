Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB004EC7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347769AbiC3PFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbiC3PFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:05:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95556BE26;
        Wed, 30 Mar 2022 08:03:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F9ADB81D54;
        Wed, 30 Mar 2022 15:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7BDC340EC;
        Wed, 30 Mar 2022 15:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648652607;
        bh=++ynPGFrylC0ID3MoiYnwhVsfuMIg5Z81rn450BMlno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMCSXeY3SHU/Io9ZdX7NZ51F/fL2WoLShF22cAAgDsJPZs0/QDsh/HK5BS+jdGLIp
         E72mgjIVFMqwuOZpTBHFi7gTgByDrBrOgctt7IVJTtfuU08UpRiLPbb6S1LeLby2tJ
         Liwl4FY5W20uxCdWuevSPp795QAZV1eNWoSNbKBda/tUU5SglMMO67RP9VTB6JjjvQ
         BvBdyFwgFbvuzY7ZWRsz3XvH+TTmFiyBj8XuN115zbZocp6Sf58tnJsxynmj6saWNW
         Wcxsc+xBcewCgk+LKNqviZMlNZMEYAq8qDfJBCBUhfB9VQN4y+UsAeBvZwCo9vvkoH
         qPhbwZC9boNkA==
Date:   Wed, 30 Mar 2022 18:02:27 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
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
Message-ID: <YkRxA0g4O29Sv14Y@iki.fi>
References: <e1c04077-0165-c5ec-53be-7fd732965e80@intel.com>
 <Yi65sM+yCvZU0/am@iki.fi>
 <7ff5e217-4042-764b-3d32-49314f00ff54@intel.com>
 <YjK5ZWJRQX+lyUxS@iki.fi>
 <690d3d8e-6214-dcdd-daaa-48a380114ad7@intel.com>
 <YjO7WWEbGPbPCe3/@iki.fi>
 <c4133781-ed3c-4a8b-eef4-96894399cf4d@intel.com>
 <YjZ0OAQU/5OLamdY@iki.fi>
 <061e2afb-289a-c687-7631-61e24ecc71fe@intel.com>
 <YkRwi6ukQ8sRaYeB@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkRwi6ukQ8sRaYeB@iki.fi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 06:00:30PM +0300, Jarkko Sakkinen wrote:
> On Mon, Mar 28, 2022 at 04:22:35PM -0700, Reinette Chatre wrote:
> > Hi Jarkko,
> > 
> > On 3/19/2022 5:24 PM, Jarkko Sakkinen wrote:
> > > On Thu, Mar 17, 2022 at 05:11:40PM -0700, Reinette Chatre wrote:
> > >> Hi Jarkko,
> > >>
> > >> On 3/17/2022 3:51 PM, Jarkko Sakkinen wrote:
> > >>> On Thu, Mar 17, 2022 at 03:08:04PM -0700, Reinette Chatre wrote:
> > >>>> Hi Jarkko,
> > >>>>
> > >>>> On 3/16/2022 9:30 PM, Jarkko Sakkinen wrote:
> > >>>>> On Mon, Mar 14, 2022 at 08:32:28AM -0700, Reinette Chatre wrote:
> > >>>>>> Hi Jarkko,
> > >>>>>>
> > >>>>>> On 3/13/2022 8:42 PM, Jarkko Sakkinen wrote:
> > >>>>>>> On Fri, Mar 11, 2022 at 11:28:27AM -0800, Reinette Chatre wrote:
> > >>>>>>>> Supporting permission restriction in an ioctl() enables the runtime to manage
> > >>>>>>>> the enclave memory without needing to map it.
> > >>>>>>>
> > >>>>>>> Which is opposite what you do in EAUG. You can also augment pages without
> > >>>>>>> needing the map them. Sure you get that capability, but it is quite useless
> > >>>>>>> in practice.
> > >>>>>>>
> > >>>>>>>> I have considered the idea of supporting the permission restriction with
> > >>>>>>>> mprotect() but as you can see in this response I did not find it to be
> > >>>>>>>> practical.
> > >>>>>>>
> > >>>>>>> Where is it practical? What is your application? How is it practical to
> > >>>>>>> delegate the concurrency management of a split mprotect() to user space?
> > >>>>>>> How do we get rid off a useless up-call to the host?
> > >>>>>>>
> > >>>>>>
> > >>>>>> The email you responded to contained many obstacles against using mprotect()
> > >>>>>> but you chose to ignore them and snipped them all from your response. Could
> > >>>>>> you please address the issues instead of dismissing them? 
> > >>>>>
> > >>>>> I did read the whole email but did not see anything that would make a case
> > >>>>> for fully exposed EMODPR, or having asymmetrical towards how EAUG works.
> > >>>>
> > >>>> I believe that on its own each obstacle I shared with you is significant enough
> > >>>> to not follow that approach. You simply respond that I am just not making a
> > >>>> case without acknowledging any obstacle or providing a reason why the obstacles
> > >>>> are not valid.
> > >>>>
> > >>>> To help me understand your view, could you please respond to each of the
> > >>>> obstacles I list below and how it is not an issue?
> > >>>>
> > >>>>
> > >>>> 1) ABI change:
> > >>>>    mprotect() is currently supported to modify VMA permissions
> > >>>>    irrespective of EPCM permissions. Supporting EPCM permission
> > >>>>    changes with mprotect() would change this behavior.
> > >>>>    For example, currently it is possible to have RW enclave
> > >>>>    memory and support multiple tasks accessing the memory. Two
> > >>>>    tasks can map the memory RW and later one can run mprotect()
> > >>>>    to reduce the VMA permissions to read-only without impacting
> > >>>>    the access of the other task.
> > >>>>    By moving EPCM permission changes to mprotect() this usage
> > >>>>    will no longer be supported and current behavior will change.
> > >>>
> > >>> Your concurrency scenario is somewhat artificial. Obviously you need to
> > >>> synchronize somehow, and breaking something that could be done with one
> > >>> system call into two separates is not going to help with that. On the
> > >>> contrary, it will add a yet one more difficulty layer.
> > >>
> > >> This is about supporting multiple threads in a single enclave, they can
> > >> all have their own memory mappings based on the needs. This is currently
> > >> supported in mainline as part of SGX1.
> > 
> > 
> > Could you please comment on the above?
> 
> 
> I've probably spent probably over two weeks of my life addressing concerns
> to the point that I feel as I was implementing this feature (that could be
> faster way to get it done).
> 
> So I'll just wait the next version and see how it is like and give my
> feedback based on that. It's not really my problem to address every
> possible concern.

Once v3 is out, I'll check what I think is right, and what is wrong
and might send some fixups and see where that leads to. I think it
is more costructive way to move forward. Repeating same arguments
leads to nowhere.

BR, Jarkko
