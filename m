Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6877E521DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244669AbiEJPO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345103AbiEJPNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:13:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B90A95047C;
        Tue, 10 May 2022 07:47:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 850AB12FC;
        Tue, 10 May 2022 07:47:03 -0700 (PDT)
Received: from bogus (unknown [10.57.0.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B4C33F73D;
        Tue, 10 May 2022 07:47:02 -0700 (PDT)
Date:   Tue, 10 May 2022 15:46:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: pcc: Fix an invalid-load caught by the address
 sanitizer
Message-ID: <20220510144656.nxbayvxdfcia3ykm@bogus>
References: <20220509141716.1270-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509141716.1270-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:17:16AM -0500, Mario Limonciello wrote:
> `pcc_mailbox_probe` doesn't initialize all memory that has been allocated
> before the first time that one of it's members `txdone_irq` may be
> accessed.
>
> This leads to a an invalid load any time that this member is accessed:
> [    2.429769] UBSAN: invalid-load in drivers/mailbox/pcc.c:684:22
> [    2.430324] UBSAN: invalid-load in drivers/mailbox/mailbox.c:486:12
> [    4.276782] UBSAN: invalid-load in drivers/acpi/cppc_acpi.c:314:45
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215587
> Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe")

Thanks for catching and fixing this.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
