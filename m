Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA05A73CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiHaCQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiHaCQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E8C7647E;
        Tue, 30 Aug 2022 19:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A3666191C;
        Wed, 31 Aug 2022 02:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E731FC433D6;
        Wed, 31 Aug 2022 02:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661912164;
        bh=Ea0i+xlOeHCTTHU9/7iuQnw+cJvR7da0sKZ4LoOMoVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+jLm4NoNJctmJuXBz9wntYcJM98EtBADyrRMxGY758hra9PXARJ9+f5lVWrG+2Oi
         P2XXRnC+BgDsMmQSk2lKoGE4jxKWA2qiUo65g/ofPUXm1ELN51aDxRyaqVsoCYnjGa
         BRsAWs78qawWa0lsng67pRu0OzdWbVq23VbcMH6tpVUio8BIPRKnwubJZb7hnQ9Y1K
         zGJ88HJq1fwf3muYd1XR10ZlVCyoGJeG2XTOa3TgxGjcFX6ufL5W71HCRQQLT60rbQ
         9hU/990wz6+PIoNDQq/dmCF64eh1Q8YdePTWjjgO0YD9B7cYcLBpmEYhrmvGtyPLD2
         O5LAqYcPv6vQA==
Date:   Wed, 31 Aug 2022 05:15:59 +0300
From:   "jarkko@kernel.org" <jarkko@kernel.org>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Message-ID: <Yw7EX5GCrEaLzpHV@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-2-jarkko@kernel.org>
 <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
 <1b3308a364317d36ad41961ea9cfee24aa122f02.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b3308a364317d36ad41961ea9cfee24aa122f02.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 01:27:58AM +0000, Huang, Kai wrote:
> On Tue, 2022-08-30 at 15:54 -0700, Reinette Chatre wrote:
> > Hi Jarkko,
> > 
> > On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> > > In sgx_init(), if misc_register() for the provision device fails, and
> > > neither sgx_drv_init() nor sgx_vepc_init() succeeds, then ksgxd will be
> > > prematurely stopped.
> > 
> > I do not think misc_register() is required to fail for the scenario to
> > be triggered (rather use "or" than "and"?). Perhaps just
> > "In sgx_init(), if a failure is encountered after ksgxd is started
> > (via sgx_page_reclaimer_init()) ...".
> 
> IMHO "a failure" might be too vague.  For instance, failure to sgx_drv_init()
> won't immediately result in ksgxd to stop prematurally.  As long as KVM SGX can
> be initialized successfully, sgx_init() still returns 0.
> 
> Btw I was thinking whether we should move sgx_page_reclaimer_init() to the end
> of sgx_init(), after we make sure at least one of the driver and the KVM SGX is
> initialized successfully.  Then the code change in this patch won't be necessary
> if I understand correctly.  AFAICT there's no good reason to start the ksgxd at
> early stage before we are sure either the driver or KVM SGX will work.

I would focus fixing the existing flow rather than reinventing the flow.

It can be made to work, and therefore it is IMHO correct action to take.

> Btw currently EPC pages assigned to KVM guest cannot be reclaimed, so
> theoretically ksgxd can be moved to sgx_drv_init(), but who knows someday we
> will decide to make KVM guest EPC pages to be able to be reclaimed. :)

I'm open to changes but it is in my opinion out of context for this.

> 
> 
> 
> -- 
> Thanks,
> -Kai
> 
> 

BR, Jarkko
