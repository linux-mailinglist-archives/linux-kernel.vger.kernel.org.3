Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E883565327
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiGDLRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiGDLRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:17:50 -0400
X-Greylist: delayed 138 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Jul 2022 04:17:49 PDT
Received: from p3plsmtpa09-03.prod.phx3.secureserver.net (p3plsmtpa09-03.prod.phx3.secureserver.net [173.201.193.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBD6F58B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:17:49 -0700 (PDT)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id 8K37oHcGkhLDC8K38oUuWd; Mon, 04 Jul 2022 04:15:31 -0700
X-CMAE-Analysis: v=2.4 cv=LfT5VhTi c=1 sm=1 tr=0 ts=62c2cbd3
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=GPr1rYa5ujshtZzWUQMA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Mon, 4 Jul 2022 12:15:29 +0100
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        joro@8bytes.org, will@kernel.org, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, hpa@zytor.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] iommu/vt-d: Show region type in
 arch_rmrr_sanity_check()
Message-ID: <20220704111529.6pdlueeu2beo64ha@ava.usersys.com>
References: <20220611204859.234975-1-atomlin@redhat.com>
 <20220611204859.234975-3-atomlin@redhat.com>
 <99632b76-3039-34a5-7615-b25e716e2621@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99632b76-3039-34a5-7615-b25e716e2621@arm.com>
X-CMAE-Envelope: MS4xfKPF35BvRczXniDFtllcvlL8GhpE6MwRfhiS3R7g0tcxEjsnemJKc93ZWS+yS/omPfyX3CX2HKI+uDxSceFX+Nymms5bGNwU1w6647Ll8b6U4mN+wAt5
 4C4D+z8FELgriEIm0J8Df1u8+3sw8RwqjLMbn7thchaJjGza86QkjqnGbualmIbbXquClhk0t0nHPscnfQOqQVksv7v9Ti4RfBMAc+1xpu4HedaeIjt3o4vO
 IfjTwebIVCsWeKWM4H5WWOWrDlMoiZ/JeVCvH8IUiIvtATkOZ6HOLvtdYxljGjwpmr91xARF0V2Uz/Sgemv4lGQkX+6nO8OiDu/gNuiN6CNfVJC4WXXVcTe0
 cvcr555yOPnn/Ny4V65OksAFEuodgPIEm0d23BL5RFzwLezBbT9KYbpSGQCwdQNOfglAFCf8AZqv4wsStB0oI2ZDTmWRsYBhEqqOT7txveTerZ/bU2+TE133
 leWa1SUfK8twe3NM7u5zEJoiRFHo5RLytQYAX9mVbm86ibl7psl+88ZmKsnA74mMPyChHM0+nkAKEIs55UOj8emQPKFnHI4Bi1yMmg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-07-04 11:39 +0100, Robin Murphy wrote:
> On 2022-06-11 21:48, Aaron Tomlin wrote:
> > This patch will attempt to describe the region type in the event
> > that a given RMRR entry is not within a reserved region.
> 
> Hmm, is this useful information for the user? You'd hope the firmware vendor
> knows the memory map already, but either way, is it particularly likely that
> anyone would be noticing and caring about this warning in a context where
> they couldn't just scroll further up the log and cross-reference the full
> memory map listing? If so, it might be worth clarifying what that use-case
> is, since as it stands there doesn't seem to be much justification for the
> "why" here.

Hi Robin,

Thanks for looking at this.

Honestly, the only justification for the modification/or proposed changes
is to have more insight when this statement is provided in total isolation
and the RAM map listing (as per e820__print_table()) is no longer available
to reference.

> > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > index 95b994cf80cd..165e9a444bb9 100644
> > --- a/arch/x86/kernel/e820.c
> > +++ b/arch/x86/kernel/e820.c
> > @@ -1073,7 +1073,7 @@ void __init e820__finish_early_params(void)
> >   const char *__init e820_type_to_string(struct e820_entry *entry)
> >   {
> > -	switch (entry->type) {
> > +	switch (entry && entry->type) {
> 
> Have you tested this for anything other than E820_TYPE_RAM? I think
> sufficiently up-to-date compilers should warn you here anyway.

I have not.


Kind regards,

-- 
Aaron Tomlin
