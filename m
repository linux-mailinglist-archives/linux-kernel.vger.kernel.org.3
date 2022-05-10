Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFDF521DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345482AbiEJPT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345238AbiEJPTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:19:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F049703C1;
        Tue, 10 May 2022 07:56:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BC0113D5;
        Tue, 10 May 2022 07:56:48 -0700 (PDT)
Received: from bogus (unknown [10.57.0.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54C773F73D;
        Tue, 10 May 2022 07:56:46 -0700 (PDT)
Date:   Tue, 10 May 2022 15:56:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "erhard_f@mailbox.org" <erhard_f@mailbox.org>
Subject: Re: [PATCH] mailbox: pcc: Fix an invalid-load caught by the address
 sanitizer
Message-ID: <20220510145640.xx2b3umlrylorxgs@bogus>
References: <20220509141716.1270-1-mario.limonciello@amd.com>
 <20220510144656.nxbayvxdfcia3ykm@bogus>
 <BL1PR12MB5157994820103C599B3E2565E2C99@BL1PR12MB5157.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5157994820103C599B3E2565E2C99@BL1PR12MB5157.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 02:49:12PM +0000, Limonciello, Mario wrote:
> [Public]
> 
> > -----Original Message-----
> > From: Sudeep Holla <sudeep.holla@arm.com>
> > Sent: Tuesday, May 10, 2022 09:47
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Jassi Brar <jassisinghbrar@gmail.com>; Sudeep Holla
> > <sudeep.holla@arm.com>; linux-acpi@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH] mailbox: pcc: Fix an invalid-load caught by the address
> > sanitizer
> > 
> > On Mon, May 09, 2022 at 09:17:16AM -0500, Mario Limonciello wrote:
> > > `pcc_mailbox_probe` doesn't initialize all memory that has been allocated
> > > before the first time that one of it's members `txdone_irq` may be
> > > accessed.
> > >
> > > This leads to a an invalid load any time that this member is accessed:
> > > [    2.429769] UBSAN: invalid-load in drivers/mailbox/pcc.c:684:22
> > > [    2.430324] UBSAN: invalid-load in drivers/mailbox/mailbox.c:486:12
> > > [    4.276782] UBSAN: invalid-load in drivers/acpi/cppc_acpi.c:314:45
> > >
> > > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugz
> > illa.kernel.org%2Fshow_bug.cgi%3Fid%3D215587&amp;data=05%7C01%7Cm
> > ario.limonciello%40amd.com%7C2a6407ffdf5944577aee08da3293f29b%7C3dd
> > 8961fe4884e608e11a82d994e183d%7C0%7C0%7C637877908262860256%7CUn
> > known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> > Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=lTXBFYCNnM
> > Pt6KnL34rQWXT%2BZvdEwvmIdMWGI%2BfluCo%3D&amp;reserved=0
> > > Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into
> > pcc_mbox_probe")
> > 
> > Thanks for catching and fixing this.
> > 
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > --
> > Regards,
> > Sudeep
> 
> I'll take the credit for fixing, but I realized I forgot to add a link and attribution 
> to the original reporter.  Here are some more tags to add:
>

Ah OK. Not sure if the tools pick up the tags added like this. If not
better to post a version with all tags added which makes it easy to apply.
I see the reporter has tested it as well, so guess tested-by can be added
as well.

> Reported-by: erhard_f@mailbox.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215587

-- 
Regards,
Sudeep
