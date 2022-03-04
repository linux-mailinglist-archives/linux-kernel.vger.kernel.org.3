Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7481B4CD772
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiCDPOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbiCDPOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:14:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E409F1B124C;
        Fri,  4 Mar 2022 07:13:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98267143D;
        Fri,  4 Mar 2022 07:13:51 -0800 (PST)
Received: from lpieralisi (unknown [10.57.37.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96D4F3F73D;
        Fri,  4 Mar 2022 07:13:49 -0800 (PST)
Date:   Fri, 4 Mar 2022 15:13:44 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux@armlinux.org.uk, lenb@kernel.org, robert.moore@intel.com,
        james.morse@arm.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: Re: [PATCH v5 RESEND 0/2] ACPI: Arm Generic Diagnostic Dump and
 Reset device
Message-ID: <YiIsYzGeeYWPQKsp@lpieralisi>
References: <20220304054003.152319-1-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304054003.152319-1-ilkka@os.amperecomputing.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 09:40:01PM -0800, Ilkka Koskinen wrote:
> Hi Lorenzo,
> 
> Would you prefer this version, which doesn't have platform
> device/driver any more?

I thought about that and in order to keep consistency it is better to
keep the platform device model, so please resend the latest version
platform device based and I will ACK it (hopefully it is not too late
for v5.18).

Please note before resending it that sdei_event_unregister() requires a
retry loop since it can return -EINPROGRESS (see sdei_unregister_ghes()).

Thanks,
Lorenzo

> 
> --Ilkka
> 
> 
> ----
> 
> Arm Generic Diagnostic Dump and Reset device enables a maintainer to
> request OS to perform a diagnostic dump and reset a system via SDEI
> event or an interrupt. This patchset adds support for the SDEI path.
> 
> I do have a patch to enable the interrupt path as well but I'm holding
> it back since AGDI table is missing interrupt configuration fields
> (trigger type etc.).
> 
> The recently published specification is available at
> https://developer.arm.com/documentation/den0093/latest
> 
> The patchset was tested on Ampere Altra/Mt. Jade.
> 
> The patchset applies on top of
>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm bleeding-edge (9db71e8e3027)
> 
> I also tested it works on top of Shuai Xue's new patches in bleeding-edge branch (c6f4ba2d2b9a)
> 
> From v1:
>      * Moved pdata to the stack and dropped unnecessary kzalloc() in agdi_init()
>      * Changed the ACPICA patch upstreaming order comment in the paragraph above
> 
> From v2:
>      * The first patch was split. The most of it was merged to ACPICA project
>        at first and later ported to linux-acpi
>        (fd919e37cb15914c6fe13e13d530a4f732407c6d). The rest are in the first
>        patch.
> 
> From v3:
>      Fixed:
> 	* Moved header files in alphabetical order and removed unnecessary ones
> 
> From v4:
> 	* Platform device/driver stuff removed
> 	* acpi_agdi_init() call moved from device_initcall to acpi_init() 
> 	* Slightly modified Kconfig text to keep checkpatch happy
> 
> Ilkka Koskinen (2):
>   ACPI: tables: Add AGDI to the list of known table signatures
>   ACPI: AGDI: Add support for Arm Generic Diagnostic Dump and Reset
>     device
> 
>  drivers/acpi/arm64/Kconfig  | 10 +++++++
>  drivers/acpi/arm64/Makefile |  1 +
>  drivers/acpi/arm64/agdi.c   | 52 +++++++++++++++++++++++++++++++++++++
>  drivers/acpi/bus.c          |  2 ++
>  drivers/acpi/tables.c       |  2 +-
>  include/linux/acpi_agdi.h   | 13 ++++++++++
>  6 files changed, 79 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/arm64/agdi.c
>  create mode 100644 include/linux/acpi_agdi.h
> 
> -- 
> 2.17.1
> 
