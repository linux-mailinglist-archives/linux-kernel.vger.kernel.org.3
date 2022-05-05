Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396C551BE53
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbiEELps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbiEELpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:45:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A57053E0D;
        Thu,  5 May 2022 04:42:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 385B7106F;
        Thu,  5 May 2022 04:42:05 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31B5B3FA27;
        Thu,  5 May 2022 04:42:03 -0700 (PDT)
Date:   Thu, 5 May 2022 12:42:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robert.moore@intel.com" <robert.moore@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
Message-ID: <20220505114200.ys6ilkkcsakkbnkc@bogus>
References: <20220419205432.46021-1-bwicaksono@nvidia.com>
 <20220419205432.46021-3-bwicaksono@nvidia.com>
 <20220504182633.a3mwuiohfqtjvpep@bogus>
 <SN6PR12MB4719E05A6BC7CAA2C00F35EFA0C39@SN6PR12MB4719.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR12MB4719E05A6BC7CAA2C00F35EFA0C39@SN6PR12MB4719.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 10:08:39PM +0000, Besar Wicaksono wrote:
> Hi Sudeep,
> 
> > Any particular reason why you would like to rush and push this without
> > the actual driver to probe the device being added here ?
> 
> I plan to have two patch series, one for ACPI patch (this patch) and one for
> driver patch. My understanding is the driver patch will depend on this
> patch, but not the other way. So, I thought it would be better to get this
> patch approved first. However, if it helps the review of this patch, I am
> hoping to post the driver patch by end of the week and will CC you on that
> one.

Sure please do that. IMO, the driver is usually upstreamed first along with
the DT bindings(in ACPI case either the spec change or the std namespace node)
The actual addition of the device happens via DT. ACPI APMT needs creation
of device here but I prefer to see the driver first.

> 
> > I really don't prefer this name:
> > 1. arm-coresight-pmu is much better than "csite". I see the short form
> >    used elsewhere in the kernel is just "cs" as in cs_etm,...etc
> > 2. Since APMT is more generic than just coresight(I understand coresight
> >    was the initial motivation for the generic specification) and also
> >    the type list seem to cover memory controller, SMMU,..etc, does
> >    it make sense to call it "arm-generic-pmu" or something similar.
> 
> Between these two, I would prefer arm-coresight-pmu just to anticipate
> another standard in the future from ARM. The APMT, to my understanding, is
> applicable only to CoreSight based PMUs. Using "coresight" as part of the
> device name is reasonable.

I read the APMT spec again and it has very little reference to coresight
though it is weirdly labelled as Coresight PMU for no sane reasons(Sorry I
know it's Arm to blame here and I bet something to do with marketing).

Anyways the APMT spec on its own covers all types of PMUs as I stated earlier.
So I prefer "arm-generic-pmu" or something better if you can come up with. I
am fine if you would like to retain arm-coresight-pmu when you post driver as
that's what the spec is labelled as.

Once you post the driver we can debate on that and come up with better name
with all the concerned parties involved.

> 
> > Not sure if the same device name will be re-used or PMUs can be registered
> > with different name under perf subsystem, but the name matters for the user
> > space tools and decoders. They may use the name or type information to analyse
> > the data samples.
> >
> > So it is better to wait for all those discussion as part of the driver
> > upstreaming before you use this device name unless we are absolutely sure
> > the PMUs can be registered with different names in the driver(which could
> > be possible, I just don't know)
> >
> > Apart from this name, I am OK with the changes here and happy to ack if it
> > is OK to merge this without any driver to probe this device yet.
> 
> I believe using a different name to register the PMU is possible.
> In the current driver patch, we use a different name format to register the
> PMU: arm_csite_pmu<numeric id>. Certainly the "csite" needs to change as
> well 😊. Another example like ARM CCI PMU uses device name "ARM-CCI PMU",
> but it is registered to perf subsystem as "CCI_400" or "CCI_500".
>

Agreed, those are details we can discuss once you post with all the
maintainers involved.

> If there is no objection, I can post update to this patch and go ahead with
> "arm-coresight-pmu" for the device name.

Sure as I mentioned above that should be fine. I will then raise it with
the maintainers how we managed to labelled the spec to confuse it with other
components. I prefer whatever we add must be easy to identify and doesn't
conflict with existing PMUs(like ARM CPU PMUs, or the coresight ETM PMUs,
..etc)

In short, just post the driver the way you prefer and let us start the
discussion there.

-- 
Regards,
Sudeep
