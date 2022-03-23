Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B43F4E5A47
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 21:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbiCWVAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbiCWVA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:00:29 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F9551580
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:58:59 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id y3-20020a056830070300b005cd9c4d03feso1942173ots.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDtBM5hqbvt4+JqyFSZXBMrTnrXWPNoWcMzp99D0f7E=;
        b=chKJefI0XjtrFUxYi0ulFeOo3TsayjUm6ihkCAycSOVj3vIU/VPkc1NANoW4c/ceq9
         L2t8lhWDI4J3znBEsh+8Qc7QTKFC0dzQZRk/3zNXshdmVP2tRb+jPmUXZssuaUOtSfoK
         x8p9qn0Gm4zxRU8vfbNXMLOQMRsmQnW3Lro7UMlwj+KXEBp+rpSnY1M+w6Occr7GDxNT
         ZDbxkD/wSR1exsMEPJfvpnxpg2xeHrsY8u1HuELGor4ysauNpyo8xPsb3ZaQIHvuUn9g
         6pArBDYAA9PDBjKqmG+RCxxQX3Jd9IE0Cogh+6RDsnZV+oNU1vJoNiTpXs27VFkzrrRo
         3j4A==
X-Gm-Message-State: AOAM533IBa7pGqQlk/W8Lv8QdRbEL9ekDFb1e/39iDg5Htu3Gn37rpgR
        Rv0vIlRXk/kwI8O4LUr99Q==
X-Google-Smtp-Source: ABdhPJzYzYyUCn05VBIHs6elEIxo+MAFz8ymy/NOBTak3xXBZk/S2Y+QrbXRNfyWP2g9YCNWV6rmTg==
X-Received: by 2002:a05:6830:138d:b0:5b2:4b0a:a4fa with SMTP id d13-20020a056830138d00b005b24b0aa4famr840268otq.380.1648069138311;
        Wed, 23 Mar 2022 13:58:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o185-20020acabec2000000b002ecf1218c53sm437366oif.15.2022.03.23.13.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:58:57 -0700 (PDT)
Received: (nullmailer pid 441174 invoked by uid 1000);
        Wed, 23 Mar 2022 20:58:56 -0000
Date:   Wed, 23 Mar 2022 15:58:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
Subject: Re: [PATCH v3 16/21] x86/resctrl: Pass the required parameters into
 resctrl_arch_rmid_read()
Message-ID: <YjuKEB9RbDa/68ll@robh.at.kernel.org>
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-17-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217182110.7176-17-james.morse@arm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 06:21:05PM +0000, James Morse wrote:
> resctrl_arch_rmid_read() is intended as the function that an
> architecture agnostic resctrl filesystem driver can use to
> read a value in bytes from a hardware register. Currently the function
> returns the MBM values in chunks directly from hardware.
> 
> To convert this to bytes, some correction and overflow calculations
> are needed. These depend on the resource and domain structures.
> Overflow detection requires the old chunks value. None of this
> is available to resctrl_arch_rmid_read(). MPAM requires the
> resource and domain structures to find the MMIO device that holds
> the registers.
> 
> Pass the resource and domain to resctrl_arch_rmid_read(). This make

s/make/makes/

> rmid_dirty() too big, instead merge it with its only caller, the name is
> kept as a local variable.

... big. Instead, merge it with its only caller, and the name...

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>  * Typos.
>  * Kerneldoc fixes.
> 
> This is all a little noisy for __mon_event_count(), as the switch
> statement work is now before the resctrl_arch_rmid_read() call.
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 31 +++++++++++++++------------
>  include/linux/resctrl.h               | 16 +++++++++++++-
>  2 files changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index b6ad290fda8d..277c22f8c976 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -167,10 +167,14 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>  		memset(am, 0, sizeof(*am));
>  }
>  
> -int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> +			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  {
>  	u64 msr_val;
>  
> +	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))

We already tested this and disabled preemption. (At least from some 
caller AFAICT from this patch.) I'd assume we'd want the fs code to 
handle preemption disable and checking cpumask. In any case, it should 
be clear what guarantees resctrl_arch_rmid_read() has.

> @@ -278,7 +281,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  	cpu = get_cpu();
>  	list_for_each_entry(d, &r->domains, list) {
>  		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
> -			err = resctrl_arch_rmid_read(entry->rmid,
> +			err = resctrl_arch_rmid_read(r, d, entry->rmid,
>  						     QOS_L3_OCCUP_EVENT_ID,
>  						     &val);
>  			if (err || val <= resctrl_cqm_threshold)
