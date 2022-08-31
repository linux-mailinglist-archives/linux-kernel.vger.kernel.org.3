Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6575A810A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiHaPSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiHaPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:18:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B421AD5DD2;
        Wed, 31 Aug 2022 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661959083; x=1693495083;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=TxLO0JiUZbqETHUngAijiycnecMsPeNwFP5Opt7eQo4=;
  b=m28TBWYbYlLp4NMuoDXUKMmF6aUHVuEpdGz8fdFXRrp7XaTEliqGbuW0
   Ne2BauCrI37gX9Mz5LywoJ5kNys+yKP7/ZWhowlclOnZHH2csOvzNAhjR
   qZO+fxwDaf7T2GXRw1n0hb2tb48jsj6DUwiRG08n8JsmH/apqoww2t99k
   BAzdBzZkQQnDGkiEKZuTGYnyCeRlu1J8SDSDJTt2cbEwewuxAgpImGUtX
   preoJ+8VqZa4aNJKrrvKA1/SUkcxyzEHkA+d2S4rcYIW9YGRRLdiC0P2J
   wo+rwsdKdNBfQam+Z1iLFjI6qEEzYes4Y5l8FF1zZZLo4FhGJLYJOb6dc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="295473519"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="295473519"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 08:18:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="563066045"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.212.96.122])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 31 Aug 2022 08:18:01 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "jarkko@kernel.org" <jarkko@kernel.org>,
        "Huang, Kai" <kai.huang@intel.com>
Cc:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-2-jarkko@kernel.org>
 <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
 <1b3308a364317d36ad41961ea9cfee24aa122f02.camel@intel.com>
 <Yw7EX5GCrEaLzpHV@kernel.org>
 <d07577c3f0b4b3fff0ce470c56f91fb634653703.camel@intel.com>
 <Yw7LJa7eRG+WZ0wv@kernel.org>
 <c3c085d69311ed759bff5bb325a2c182d423f91f.camel@intel.com>
 <Yw7OEh7QP8tb7BR1@kernel.org>
 <a91f65ad5c392b6e34f07bc6d3f35c89a76a98db.camel@intel.com>
Date:   Wed, 31 Aug 2022 10:18:00 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1rrt4aecwjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <a91f65ad5c392b6e34f07bc6d3f35c89a76a98db.camel@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai
On Tue, 30 Aug 2022 22:17:08 -0500, Huang, Kai <kai.huang@intel.com> wrote:

> On Wed, 2022-08-31 at 05:57 +0300, jarkko@kernel.org wrote:
>> On Wed, Aug 31, 2022 at 02:55:52AM +0000, Huang, Kai wrote:
>> > On Wed, 2022-08-31 at 05:44 +0300, jarkko@kernel.org wrote:
>> > > On Wed, Aug 31, 2022 at 02:35:53AM +0000, Huang, Kai wrote:
>> > > > On Wed, 2022-08-31 at 05:15 +0300, jarkko@kernel.org wrote:
>> > > > > On Wed, Aug 31, 2022 at 01:27:58AM +0000, Huang, Kai wrote:
>> > > > > > On Tue, 2022-08-30 at 15:54 -0700, Reinette Chatre wrote:
>> > > > > > > Hi Jarkko,
>> > > > > > >
>> > > > > > > On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
>> > > > > > > > In sgx_init(), if misc_register() for the provision  
>> device fails, and
>> > > > > > > > neither sgx_drv_init() nor sgx_vepc_init() succeeds, then  
>> ksgxd will be
>> > > > > > > > prematurely stopped.
>> > > > > > >
>> > > > > > > I do not think misc_register() is required to fail for the  
>> scenario to
>> > > > > > > be triggered (rather use "or" than "and"?). Perhaps just
>> > > > > > > "In sgx_init(), if a failure is encountered after ksgxd is  
>> started
>> > > > > > > (via sgx_page_reclaimer_init()) ...".
>> > > > > >
>> > > > > > IMHO "a failure" might be too vague.  For instance, failure  
>> to sgx_drv_init()
>> > > > > > won't immediately result in ksgxd to stop prematurally.  As  
>> long as KVM SGX can
>> > > > > > be initialized successfully, sgx_init() still returns 0.
>> > > > > >
>> > > > > > Btw I was thinking whether we should move  
>> sgx_page_reclaimer_init() to the end
>> > > > > > of sgx_init(), after we make sure at least one of the driver  
>> and the KVM SGX is
>> > > > > > initialized successfully.  Then the code change in this patch  
>> won't be necessary
>> > > > > > if I understand correctly.  AFAICT there's no good reason to  
>> start the ksgxd at
>> > > > > > early stage before we are sure either the driver or KVM SGX  
>> will work.
>> > > > >
>> > > > > I would focus fixing the existing flow rather than reinventing  
>> the flow.
>> > > > >
>> > > > > It can be made to work, and therefore it is IMHO correct action  
>> to take.
>> > > >
>> > > > From another perspective, the *existing flow* is the reason which  
>> causes this
>> > > > bug.  A real fix is to fix the flow itself.
>> > >
>> > > Any existing flow in part of the kernel can have a bug. That
>> > > does not mean that switching flow would be proper way to fix
>> > > a bug.
>> > >
>> > > BR, Jarkko
>> >
>> > Yes but I think this is only true when the flow is reasonable.  If  
>> the flow
>> > itself isn't reasonable, we should fix the flow (given it's easy to  
>> fix AFAICT).
>> >
>> > Anyway, let us also hear from others.
>>
>> The flow can be made to work without issues, which in the
>> context of a bug fix is exactly what a bug fix should do.
>> Not more or less.
>
> No. To me the flow itself is buggy.  There's no reason to start ksgxd()  
> before
> at least SGX driver is initialized to work.
>

Will it cause racing if we expose dev nodes to user space before
ksgxd is started and sensitization done?

> Patching the buggy flow is more like a workaround, but isn't a real fix.
>
>>
>> You don't gain any measurable value for the user with this
>> switch idea.
>
> There is actual gain by moving sgx_page_reclaimer_init() to  
> sgx_drv_init(), or
> only calling sgx_page_reclaimer_init() when sgx_drv_init() returns  
> success:
>
> If somehow sgx_drv_init() fails to initialize, ksgxd() won't run.
>
> Currently, if SGX driver fails to initialize but virtual EPC initializes
> successfully, ksgxd() still runs. However it achieves nothing but only  
> wastes
> CPU cycles.
>
>

You still need ksgxd for sanitizing (at least) and swapping (potentially)
even if only virtual EPC initializes.

Thanks
Haitao
