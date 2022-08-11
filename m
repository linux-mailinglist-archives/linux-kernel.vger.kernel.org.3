Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BD858F57A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 03:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiHKBDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 21:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHKBDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 21:03:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FED3647DE;
        Wed, 10 Aug 2022 18:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 299B360FA0;
        Thu, 11 Aug 2022 01:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31649C433D7;
        Thu, 11 Aug 2022 01:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660179819;
        bh=Q2mxISmrGxnsGwg5SIOETjIYCqZ3F2g+PyM3nILie6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHccdFX5SMjLhI+sYpCZFR+uPhf3k+weepC/SRPC+r8VEm5psmgwu3wXmNYsAmTTF
         t1ZJg4qLMFMYT/xTKpx5M15UKr+t/CLnaeDdjwT/elGCgK9oTSN58Aj6sEdIDrflI+
         o4fhEp/vJSyxq/wYfj8p0UNw/5CQtDAifc2tZN9hMFdG5l2iO6sSSxNTCbHcMuerb2
         dDg2GJwm2t8TR9aZLYyZiMtPhEFG51bM9DdZtrJyFkui8qNoKC/H7OS8CPPL4gniQc
         6a3A5VXRaj4aoHKV4fADLcJsJD9uc41HgLjVvUrkhzUNq8YbI44S5KGQ3VGqMMkWDN
         rw0pZox3fmCVQ==
Date:   Thu, 11 Aug 2022 04:03:33 +0300
From:   "jarkko@kernel.org" <jarkko@kernel.org>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "dave@sr71.net" <dave@sr71.net>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Message-ID: <YvRVZQKklqnbf9oQ@kernel.org>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
 <op.1p2k13ibwjvjmi@hhuan26-mobl1.mshome.net>
 <35d7254cafde24b722b167c6a3566592d903acd2.camel@intel.com>
 <f16af3f7887d26cde9073d443c1b796c945bc042.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f16af3f7887d26cde9073d443c1b796c945bc042.camel@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 10:17:31AM +0000, Huang, Kai wrote:
> On Tue, 2022-08-02 at 14:21 +1200, Kai Huang wrote:
> > > 
> > > Tested-by: Haitao Huang <haitao.huang@intel.com>
> > > 
> > > Thanks
> > > Haitao
> > 
> > Hi Haitao,
> > 
> > Could you also help to test in a VM?
> > 
> > You will also need below patch in order to use EDECCSSA in the guest:
> > 
> > https://lore.kernel.org/lkml/20220727115442.464380-1-kai.huang@intel.com/
> > 
> > When you create the VM, please use -cpu host.
> > 
> 
> Hi Haitao,
> 
> Do you have any update?
> 
> If it's not easy for you to verify in VM, could you let me know how to set up
> the testing machine so I can have a try?

I can give ack for this, given that it is so obvious:

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

Would give reviewed-by if there was ucode update available, and I
could test this.

BR, Jarkko
