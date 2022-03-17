Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9E14DBDD3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 05:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiCQE4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 00:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiCQEzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 00:55:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B0314032;
        Wed, 16 Mar 2022 21:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D6D60F0A;
        Thu, 17 Mar 2022 04:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A975C340E9;
        Thu, 17 Mar 2022 04:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647491373;
        bh=Neci+Gx7EQANLBllG8qEVqee6Rk06O2hKQ7VcxDD5SA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rFLzPGJitUQLpWpLvTLS6Pd9Jo9WbMANCy0sdJZCliVpMsCuoWElqZck021vKBfC2
         X1IA5SndaNeP11C/Oo90JsRhM0Kuu8o4A9wZ1s2DveLwpmoorBwH3DE+Rmw5oyX3Iz
         3OVLbMNIWRMBBj28wgNSAzh+9Fm5XuDQLJUC7oQwDpdF1Kk2auKjEtEDcyHsrGRU0Z
         CoR4JkjZJFXB6OIvKsvidB15RkIvMLdetr/GR59XqZdLCu0IPch5lgmCci1ZYuHo8S
         U+TEDBU4G6d64B+WK+YLs7jTwdWoL3ysvoLBXot9FnuRNq4HP6ia6cHObSQecE8ZB7
         PEQpKhDtyc0pw==
Date:   Thu, 17 Mar 2022 06:30:29 +0200
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
Message-ID: <YjK5ZWJRQX+lyUxS@iki.fi>
References: <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <YimWaAqEnXHbLdjh@iki.fi>
 <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net>
 <Yis8LV99mORcLYs6@iki.fi>
 <Yis9rA8uC/0bmWCF@iki.fi>
 <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com>
 <YiuQx+X9UQ2l22un@iki.fi>
 <e1c04077-0165-c5ec-53be-7fd732965e80@intel.com>
 <Yi65sM+yCvZU0/am@iki.fi>
 <7ff5e217-4042-764b-3d32-49314f00ff54@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff5e217-4042-764b-3d32-49314f00ff54@intel.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 08:32:28AM -0700, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 3/13/2022 8:42 PM, Jarkko Sakkinen wrote:
> > On Fri, Mar 11, 2022 at 11:28:27AM -0800, Reinette Chatre wrote:
> >> Supporting permission restriction in an ioctl() enables the runtime to manage
> >> the enclave memory without needing to map it.
> > 
> > Which is opposite what you do in EAUG. You can also augment pages without
> > needing the map them. Sure you get that capability, but it is quite useless
> > in practice.
> > 
> >> I have considered the idea of supporting the permission restriction with
> >> mprotect() but as you can see in this response I did not find it to be
> >> practical.
> > 
> > Where is it practical? What is your application? How is it practical to
> > delegate the concurrency management of a split mprotect() to user space?
> > How do we get rid off a useless up-call to the host?
> > 
> 
> The email you responded to contained many obstacles against using mprotect()
> but you chose to ignore them and snipped them all from your response. Could
> you please address the issues instead of dismissing them? 

I did read the whole email but did not see anything that would make a case
for fully exposed EMODPR, or having asymmetrical towards how EAUG works.

I had the same discussion with Haitao about PROT_NONE earlier, and am
fully aware that PROT_READ is required.

BR, Jarkko
