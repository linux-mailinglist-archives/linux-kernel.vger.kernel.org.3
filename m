Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC914E5730
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbiCWRNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245717AbiCWRM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:12:56 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4058978078
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:11:26 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d62so2435482iog.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CJcX+FxfEaq/uuvyNw1S0dCzP3seuy40H9PTEBUtNog=;
        b=fXE+Kpe5mhnSbe/ssGX6libNH578T7NVZN12czfPzITa139jE0x1ySGcfvG+WKJjTi
         d3LHju2WyVXWJ2SytyErBrbsQgim8wyCLw+KogL1nV1VAceywJnBvg4MZRHblXA/Vw7A
         ZPoJNjse+tY7jHR0vXSljSWIkqiAUXs+rKI5+Ye+eiflCFhTuEdZigb1PKXsQTcqoesi
         IjGYxpfZYCThIhQ6ySoJqBXZGN8/Igu5f5soFBBe5sg3gHrk28RSHWmtQqhKnH7wNKSg
         YnEiaqEpvHzsYlk6AsBxyC/fSm3MV+McLzjUYT7jbxINXTt0Fd6SMCvjfhFaG1YKRSlU
         jmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJcX+FxfEaq/uuvyNw1S0dCzP3seuy40H9PTEBUtNog=;
        b=2F9owBYBgfKFEnkWW1wbugn/w1pdeWB/qquLW9QKI2RYIpklh/g30vtb119kdd8WJ0
         AQOBf3Cfvko2URz/5eQ4HvNxy3gtp9Kr46+1/CouJ38aFFjik3kTSP4RjYMCMiSjoEWq
         e/1ZmqeDZZY3mGC6X7XqNNUWhwumLqp8DGsTRoDUGMs7+VqhTYfdXlkX8IFnehHLaNWi
         nyQO7zMlrTM/63jdvUt8KSb5kDu4zJaoWWVBi+pisIC5usE+SqaSQWfIt+rGCvYJKVpL
         qcDUnIBMspUH6lbmdaMXYbCtQ9yC8LynAKzX2rM47IxybK8ZLMTemuSLxOiXASV1CHhw
         JHbQ==
X-Gm-Message-State: AOAM531x6EhLOWsLqop5Wr50RKWkkiFPiJNgTS8zAV0aZ27WD98+AeQa
        9Z+qOcmniBggX4Z7EZq1Iho4pA==
X-Google-Smtp-Source: ABdhPJwZ1i6jce/UGoZtD6TdoDDyrgcMcbsRlWhHkHftWonzln3+byrRitd4L+UzDPjYxXM296EnIg==
X-Received: by 2002:a05:6638:34a3:b0:321:3908:3224 with SMTP id t35-20020a05663834a300b0032139083224mr472421jal.75.1648055485420;
        Wed, 23 Mar 2022 10:11:25 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id t11-20020a922c0b000000b002c85834eb06sm256878ile.47.2022.03.23.10.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:11:24 -0700 (PDT)
Date:   Wed, 23 Mar 2022 17:11:21 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
Subject: Re: [PATCH v5 02/22] KVM: arm64: Add SDEI virtualization
 infrastructure
Message-ID: <YjtUufdsWYxqdGa+@google.com>
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-3-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322080710.51727-3-gshan@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

More comments, didn't see exactly how all of these structures are
getting used.

On Tue, Mar 22, 2022 at 04:06:50PM +0800, Gavin Shan wrote:

[...]

> diff --git a/arch/arm64/include/uapi/asm/kvm_sdei_state.h b/arch/arm64/include/uapi/asm/kvm_sdei_state.h
> new file mode 100644
> index 000000000000..b14844230117
> --- /dev/null
> +++ b/arch/arm64/include/uapi/asm/kvm_sdei_state.h
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Definitions of various KVM SDEI event states.
> + *
> + * Copyright (C) 2022 Red Hat, Inc.
> + *
> + * Author(s): Gavin Shan <gshan@redhat.com>
> + */
> +
> +#ifndef _UAPI__ASM_KVM_SDEI_STATE_H
> +#define _UAPI__ASM_KVM_SDEI_STATE_H
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/types.h>
> +
> +/*
> + * The software signaled event is the default one, which is
> + * defined in v1.1 specification.
> + */
> +#define KVM_SDEI_INVALID_EVENT	0xFFFFFFFF

Isn't the constraint that bit 31 must be zero? (DEN 0054C 4.4 "Event
number allocation")

> +#define KVM_SDEI_DEFAULT_EVENT	0
> +
> +#define KVM_SDEI_MAX_VCPUS	512	/* Aligned to 64 */
> +#define KVM_SDEI_MAX_EVENTS	128

I would *strongly* recommend against having these limits. I find the
vCPU limit especially concerning, because we're making KVM_MAX_VCPUS
ABI, which it definitely is not. Anything that deals with a vCPU should
be accessed through a vCPU FD (and thus agnostic to the maximum number
of vCPUs) to avoid such a complication.

> +struct kvm_sdei_exposed_event_state {
> +	__u64	num;
> +
> +	__u8	type;
> +	__u8	signaled;
> +	__u8	priority;
> +	__u8	padding[5];
> +	__u64	notifier;

Wait, isn't this a kernel function pointer!?

> +};
> +
> +struct kvm_sdei_registered_event_state {

You should fold these fields together with kvm_sdei_exposed_event_state
into a single 'kvm_sdei_event' structure:

> +	__u64	num;
> +
> +	__u8	route_mode;
> +	__u8	padding[3];
> +	__u64	route_affinity;

And these shouldn't be UAPI at the VM scope. Each of these properties
could be accessed via a synthetic/'pseudo-firmware' register on a vCPU FD:

> +	__u64	ep_address[KVM_SDEI_MAX_VCPUS];
> +	__u64	ep_arg[KVM_SDEI_MAX_VCPUS];
> +	__u64	registered[KVM_SDEI_MAX_VCPUS/64];
> +	__u64	enabled[KVM_SDEI_MAX_VCPUS/64];
> +	__u64	unregister_pending[KVM_SDEI_MAX_VCPUS/64];
> +};
> +
> +struct kvm_sdei_vcpu_event_state {
> +	__u64	num;
> +
> +	__u32	event_count;
> +	__u32	padding;
> +};
> +
> +struct kvm_sdei_vcpu_regs_state {
> +	__u64	regs[18];
> +	__u64	pc;
> +	__u64	pstate;
> +};
> +
> +struct kvm_sdei_vcpu_state {

Same goes here, I strongly recommend you try to expose this through the
KVM_{GET,SET}_ONE_REG interface if at all possible since it
significantly reduces the UAPI burden, both on KVM to maintain it and
VMMs to actually use it.

--
Thanks,
Oliver
