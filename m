Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D205092C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382781AbiDTWaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiDTW37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:29:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AB84161D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:27:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650493630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ISyay/uqbWd7Dt973ko6wNJSC2hspTBvodOEXTRk5EU=;
        b=gFaXdlLtGTumpM5AMCWB9t8RkAoHUBpMdLhnqptQhmbivTh/O5/4yF3SCt1Dj6avfEAIjo
        AiPYEdOzJI3p8z29CNM1zz60dREIpy769X8Ar4bXC3Rp79WorDr4/CcbJnnxrLt3mQ0SlI
        yUvr6yTL1RJIobwXT/tcBd296CFN6DEOLHWKjulWLQyNJ1JbbnnsVQFbsgl8p5Aryye/K1
        aIiYc8panFWT9W3sTG63yBPX36g0mBUbji3N0co5XHZ85B8DKlPRdCxE/l3y408SJOlDhY
        o4E1hH2yNsbOpKyIEEakfJ5wUhM3Qo4UCbitqWUGUn4ErshoGOGc3v3fCcbmIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650493630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ISyay/uqbWd7Dt973ko6wNJSC2hspTBvodOEXTRk5EU=;
        b=Fv/3UYFWkfRmkAbnb2DcmPCDR+tON41BXWc2LcrtW0p/m9892wc7QuAptcb7MAhxkBbmAZ
        +E0kUHN8i+oXsQDQ==
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     tarumizu.kohei@fujitsu.com
Subject: Re: [PATCH v3 7/9] x86: Add hardware prefetch control support for x86
In-Reply-To: <20220420030223.689259-8-tarumizu.kohei@fujitsu.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
 <20220420030223.689259-8-tarumizu.kohei@fujitsu.com>
Date:   Thu, 21 Apr 2022 00:27:09 +0200
Message-ID: <87czhbtmpu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kohei!

On Wed, Apr 20 2022 at 12:02, Kohei Tarumizu wrote:
> +#define BROADWELL_L2_HWPF_FIELD		BIT_ULL(0)
> +#define BROADWELL_L2_ACLPF_FIELD	BIT_ULL(1)
> +#define BROADWELL_DCU_HWPF_FIELD	BIT_ULL(2)
> +#define BROADWELL_DCU_IPPF_FIELD	BIT_ULL(3)

Prefetch control is supported on a lot of CPU models and all except Xeon
PHI have the same MSR layout. ATOMs do not support L2_ACL and DCU_IP,
but that's it. So there is absolutely nothing broadwell specific here.

> +static int broadwell_get_hwpf_enable(u64 reg, unsigned int level)
> +static int broadwell_modify_hwpf_enable(u64 *reg, unsigned int level, u64 val)
> +static int broadwell_get_ippf_enable(u64 reg, unsigned int level)
> +static int broadwell_modify_ippf_enable(u64 *reg, unsigned int level, u64 val)
> +static int broadwell_get_aclpf_enable(u64 reg, unsigned int level)
> +static int broadwell_modify_aclpf_enable(u64 *reg, unsigned int level, u64 val)

Why do we need six explicit functions, which are pretty much copy and paste?

The only difference is the bit they operate on. It's just a matter of
proper wrapper structs.

/* Global */
struct pfctl_attr {
	unsigned int		level;
	unsigned int		type;
	struct device_attribute	**attr;
};

/* x86 */
enum {
	TYPE_L12_BASE,
	TYPE_L12_PLUS,
	TYPE_L12_XPHI,
};

struct x86_pfctl_attr {
	struct device_attribute		attr;
	u64				mask;
};

static ssize_t pfctl_show(struct device *pfctl_dev, struct device_attribute *attr, char *buf)
{
	struct x86_pfctl_attr *xa = container_of(attr, struct x86_pfctl_attr, attr);
	int cpu = pfctl_dev_get_cpu(pfctl_dev);
	u64 val;

	rdmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, &val);
	return sprintf(buf, "%d\n", val & xa->mask ? 0 : 1);
}

static DEFINE_MUTEX(pfctl_mutex);

static ssize_t pfctl_store(struct device *cache_dev, struct device_attribute *attr,
			   const char *buf, size_t size)
{
	struct x86_pfctl_attr *xa = container_of(attr, struct x86_pfctl_attr, attr);
	int cpu = pfctl_dev_get_cpu(pfctl_dev);
	bool enable;
	u64 val;

	if (strtobool(buf, &enable) < 0)
		return -EINVAL;

	/* MSR_MISC_FEATURE_CONTROL is per core, not per thread */
	mutex_lock(&pfctl_mutex);
	rdmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, &val);
	if (enable)
		val &= ~xa->mask;
	else
		val |= xa->mask;
	wrmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, val);
	mutex_unlock(&pfctl_mutex);
	return 0;
}

#define PFCTL_ATTR(_name, _level, _type, _bit)				\
	struct x86_pfctl_attr attr_l##_level##_##_name = {		\
		.attr	= __ATTR(_name, 0600, pfctl_show, pfctl_store),	\
		.mask = BIT_ULL(_bit), }

static PFCTL_ATTR(prefetch,     1, CACHE_TYPE_DATA,    2);
static PFCTL_ATTR(prefetch,     2, CACHE_TYPE_UNIFIED, 0);
static PFCTL_ATTR(prefetch_ip,  1, CACHE_TYPE_DATA,    3);
static PFCTL_ATTR(prefetch_acl, 2, CACHE_TYPE_UNIFIED, 1);

static struct device_attribute *l1_attrs[] __ro_after_init = {
	&attr_l1_prefetch.attr,
	&attr_l1_prefetch_ip.attr,
	NULL,
};

static struct device_attribute *l2_attrs[] __ro_after_init = {
	&attr_l2_prefetch.attr,
	&attr_l2_prefetch_acl.attr,
	NULL,
};

static const struct pfctl_group pfctl_groups[] = {
	{
		.level = 1,
		.type = CACHE_TYPE_DATA,
		.attrs = l1_attrs,
	},
	{
		.level = 2,
		.type = CACHE_TYPE_UNIFIED,
		.attrs = l2_attrs,
	},
	{
		.attrs = NULL,
	},
};

static const __initconst struct x86_cpu_id pfctl_match[] = {
	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_D,	TYPE_L12_BASE),
	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	TYPE_L12_BASE),
	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		TYPE_L12_PLUS),
	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		TYPE_L12_PLUS),
	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	TYPE_L12_XPHI),
        { },
};

static __init int pfctl_init(void)
{
	const struct x86_cpu_id *m;

	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
		return -ENODEV;

	m = x86_match_cpu(pfctl_match);
	if (!m)
		return -ENODEV;

	switch (m->driver_data) {
	case TYPE_L12_BASE:
		l1_attrs[1] = NULL;
		l2_attrs[1] = NULL;
		break;
	case TYPE_L12_PLUS:
		break;
	case TYPE_L12_XPHI:
		attr_l1_prefetch.mask = BIT_ULL(0);
		attr_l2_prefetch.mask = BIT_ULL(1);
		break;
	default:
		return -ENODEV;
	};

	return pfctl_register_attrs(pfctl_groups);
}
late_initcall(pfctl_init);

See? One show() and one store() function which operates directly at the
attribute level and supports all known variants of bits in the control
MSR. No magic global constants, no visible management, no hardcoded
type/level relations... Simple and straight forward.

All what the core code needs to do is to populate the attributes in the
sys/.../cache/index$N/ directories when level and type matches.

I'm pretty sure you can simplify the A64FX code in a very similar way.

Thanks,

        tglx
