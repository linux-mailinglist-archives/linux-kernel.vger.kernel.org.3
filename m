Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759F95686BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiGFLc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGFLcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:32:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942D527147
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 04:32:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p9so3274102plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=djsBeJZau7lSlteYS5ExIsD/YzkbqOh5CqDcrItHqWo=;
        b=q2UJC5/Cnpc58uqNx0FCca8xGpc66+6rq2Xm8KGHbhU2M7vYmIRYGWLWgUdl5xYfVV
         fe10NqBZ5OARcmDRhDM5BORiXY7rYLbgJ8fF5EPIXa+n/Q+Xk6IweCvRJFlrsheIL6MM
         HtrPv11Up7KEulqIw7br/sztHfIiI/eN9oA27f3enPkpoizepbsKphwrxLu1dRR8F/QX
         k6DdPrexx7eo/gdavDTn7XZBzYMHheDXu5Ej/2JnWLFKyujh4uU5F0ATGn//VMnpEmHQ
         KoieRZjlTw3xngmhn36FxsZDfDu3xrOkWgBpL1YM11ZVHvUbHTDymrBKmvciUbEa6Mjs
         Bg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=djsBeJZau7lSlteYS5ExIsD/YzkbqOh5CqDcrItHqWo=;
        b=YAEmQuInBexg2nfVc6sp2rGAMJUxTVlEQdkgFiLeAa0V+eC96pd2NYjYH8MtGDRS3D
         Ta/ZcteQrhpiwvBvWfZEkaxEWfFIVeI0M8ayk5xTLtJlUQmstdG0nhYESZmT6AFLlEIn
         BKiytZCcbl1ca7yjkfrOMIL/Vz9PIDE6n0Dq82NOZ5xW04fGeHAo5wcagwtULRZu5FLs
         2DgYRdgSN8yN/qm1kd0u8x7OLphvbLsNrxHK+x1o5gnx50Fld8vi/7O+PUGRHyYTaNum
         Ol2sOb+dpXzi8kOPvgLSAzCAx53OYMmRUBkFWPymINfEiSdsbl+jLtcE6SssZ4ObP7mc
         xV+g==
X-Gm-Message-State: AJIora8SxbWI0tyU+pJeHiA1Kdp+j2OtLbTaaQI6vJ1fK5TU3hp8tShz
        vkIu43uhXDOGBvWn9fH7v5iTVpF1m1Li5w==
X-Google-Smtp-Source: AGRyM1tJvjoUduIGT5ixeVfZRRRPGpZ0t27INoMLuNKZT9DE21cIpoQrKzOjWiSXuzhcKSrrFCR0XA==
X-Received: by 2002:a17:90a:4e05:b0:1ec:8de4:1dd5 with SMTP id n5-20020a17090a4e0500b001ec8de41dd5mr47976415pjh.242.1657107172707;
        Wed, 06 Jul 2022 04:32:52 -0700 (PDT)
Received: from MBP ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902b61500b0016b81679c2asm19849405pls.214.2022.07.06.04.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 04:32:52 -0700 (PDT)
References: <20220630161220.53449-1-schspa@gmail.com>
 <87mtdu15ok.wl-maz@kernel.org> <m2bkua148a.fsf@gmail.com>
 <a5ca4db3db9ef101258cab94d6b7e045@kernel.org> <m2sfnlvwup.fsf@gmail.com>
 <87letd0wqm.wl-maz@kernel.org> <m2h740zz1i.fsf@gmail.com>
 <87edyyn2a5.wl-maz@kernel.org>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Schspa Shi <schspa@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix 64 bit mmio handle
Date:   Wed, 06 Jul 2022 19:29:58 +0800
In-reply-to: <87edyyn2a5.wl-maz@kernel.org>
Message-ID: <m25ykawk7f.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Marc Zyngier <maz@kernel.org> writes:

> On Fri, 01 Jul 2022 15:22:51 +0100,
> Schspa Shi <schspa@gmail.com> wrote:
>> 
>> 
>> Marc Zyngier <maz@kernel.org> writes:
>> 
>> >> 
>> >> I have running some static code analysis software upon 
>> >> Kernel code.
>> >> Seeing there is possible overflow.
>> >> 
>> >> maks << 1U << ((len * 8) -1);
>> >> 
>> >> The AI don't know, len is only the value of 1, 2, 4, and 
>> >> make this
>> >> a warnings
>> >> 
>> >> I tring to analysis this, but didn't realize the real 
>> >> scenario of
>> >> sign extension, and finally sent this problematic patch.
>> >> 
>> >> I do see some uninitialized memory reads (the values are not 
>> >> used
>> >> in the end, just as temporary space for API execution),
>> >> do we need to fix these?
>> > 
>> > You need to be more descriptive here. What uninitialised 
>> > reads? In
>> > general, pointing at the code and providing a full 
>> > description of
>> > what
>> > you think is incorrect would really help...
>> > 
>> > 	M.
>> One example is
>> int vgic_v3_has_attr_regs(struct kvm_device *dev, struct
>> kvm_device_attr *attr)
>> {
>> 	...
>>    case KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS: {
>> 		u64 reg, id;
>> 
>> 		id = (attr->attr & KVM_DEV_ARM_VGIC_SYSREG_INSTR_MASK);
>> 		return vgic_v3_has_cpu_sysregs_attr(vcpu, 0, id, &reg);
>> 	}
>> 
>> }
>> 
>> The funcion vgic_v3_has_cpu_sysregs_attr will read reg's value 
>> to
>> params without initialization. There should have no problems,
>> because the register value never used.
>
> Thanks for pointing this out.
>
> I spent some time looking at this, and this is only the tip of 
> the
> iceberg. The whole userspace interaction with the GIC sysregs is 
> ugly
> (at best), and needs some love.
>
> I've written a small series[1] cleaning things up, which needs 
> testing
> (I've just checked that it was compiling correctly). I'd 
> appreciate
> you running your tool on it.
>

I have run static code analysis software upon this branch, and the
warnings have gone.

> 	M.
>
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/sysreg-cleanup-5.20


-- 
BRs
Schspa Shi
