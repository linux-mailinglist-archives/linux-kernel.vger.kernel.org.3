Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C59523536
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244495AbiEKORm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbiEKORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:17:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78F4531DDC;
        Wed, 11 May 2022 07:17:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F5ADED1;
        Wed, 11 May 2022 07:17:35 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB2473F66F;
        Wed, 11 May 2022 07:17:33 -0700 (PDT)
Date:   Wed, 11 May 2022 15:17:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH v1 1/5] ACPI: CPPC: Check _OSC for flexible address space
Message-ID: <20220511141731.rjyjmgvux43lsj3x@bogus>
References: <20220511134559.1466925-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220511134559.1466925-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:45:55PM +0200, Pierre Gondois wrote:
> ACPI 6.2 Section 6.2.11.2 'Platform-Wide OSPM Capabilities':
>   Starting with ACPI Specification 6.2, all _CPC registers can be in
>   PCC, System Memory, System IO, or Functional Fixed Hardware address
>   spaces. OSPM support for this more flexible register space scheme is
>   indicated by the “Flexible Address Space for CPPC Registers” _OSC bit
> 
> Otherwise (cf ACPI 6.1, s8.4.7.1.1.X), _CPC registers must be in:
> - PCC or Functional Fixed Hardware address space if defined
> - SystemMemory address space (NULL register) if not defined
> 
> Add the corresponding _OSC bit and check it when parsing _CPC objects.
>

Looks good, other than a minor nit below. Feel free to ignore that or
check what is Rafael's preference. Otherwise,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/bus.c       | 18 ++++++++++++++++++
>  drivers/acpi/cppc_acpi.c |  9 +++++++++
>  include/linux/acpi.h     |  2 ++
>  3 files changed, 29 insertions(+)
>
[...]

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d7136d13aa44..977d74d0465b 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -574,6 +574,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
>  #define OSC_SB_OSLPI_SUPPORT			0x00000100
>  #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
>  #define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
> +#define OSC_SB_CPC_FLEXIBLE_ADR_SP		0x00004000

I would prefer ADR_SPACE instead of ADR_SP.

-- 
Regards,
Sudeep
