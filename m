Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E974C9B00
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 03:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiCBCLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 21:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiCBCLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 21:11:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C2AA6512;
        Tue,  1 Mar 2022 18:10:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B9D85CE20CB;
        Wed,  2 Mar 2022 02:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63914C340EE;
        Wed,  2 Mar 2022 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646187022;
        bh=U/4xh9QWn0bXibryx90ssRbqx36g3p2I2thEq7GTMCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pVsWhWV7BIZYQF2Kwu6QyzAUJ/vzzeq1zqk8T+YySwRKjcg0Xk2SK6YCOFWR2+aZO
         AOCOqics4mI+YL9ur5c4LWbP5H8v4+TpUdydbqolTlybvWXnr7zWXkAarYWRGOZjof
         Rtp5c0N7Cm0nIVuMNrj8LqDcbkdsj4tENObCwfmkJ7rkvo/ViGwv1uT4BEwTRL+Jxd
         CA1Nw2Z58JPF4Afbjrc2c+Hk0FOJLo8sQm5IreVuXwjYt/+TN8jfNdiWYgnMpVogKI
         yqzsr7jBOVh1/HpJUrfPU351igwoY/nD2ECr/OFe4yj8yoK21pIGrmmt3eXAOuzL7y
         iegcfO/rgo7Eg==
Date:   Wed, 2 Mar 2022 03:11:06 +0100
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
Message-ID: <Yh7SOgqdFxJdVPMq@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi>
 <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
 <Yh4fGORDaJyVrJQW@iki.fi>
 <Yh4i4hVcnfZ8QDAl@iki.fi>
 <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com>
 <Yh7Q5fbOtr+6YWaS@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh7Q5fbOtr+6YWaS@iki.fi>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 03:05:25AM +0100, Jarkko Sakkinen wrote:
> > The work that follows this series aimed to do the integration with user
> > space policy.
> 
> What do you mean by "user space policy" anyway exactly? I'm sorry but I
> just don't fully understand this.
> 
> It's too big of a risk to accept this series without X taken care of. Patch
> series should neither have TODO nor TBD comments IMHO. I don't want to ack
> a series based on speculation what might happen in the future.

If I accept this, then I'm kind of pre-acking code that I have no idea what
it looks like, can it be acked, or am I doing the right thing for the
kernel by acking this. 

It's unfortunately force majeure situation for me. I simply could not ack
this, whether I want it or not.

BR, Jarkko
