Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095CA492896
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbiAROj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245596AbiAROj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:39:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8464FC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 06:39:28 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642516766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8FzwLn6QhkjWOJPvQFfLGKg9NeOr8S3LYPkXtc320u0=;
        b=St3eBuBZ/F0CROeqTq2RABGHuQ/toJl5+SIMqZJO+VRanPNow9wXTK3UOo1uVkq3Y5hp3n
        NY2XYVeCmfgwuiO0jz9ybEkvK8COvdTUXm3HVqhHS7ObPdkRplDdhjWaoml5RY10sqH93o
        mRYcH2RnOKf8znx77EkVptAD+fyZq1Zy+j7nuaDH2DYrmIj90LsUJvIQrki7Bf9uHxWYPD
        9KWITF890gYBVxQkG2CIMtRJwbNgEMkRRkslVY52O8dqGSKAjhI8OaN8tB/zRlbCJTCNL1
        mwmPe4jlex3gGhQO5zl1Ta2CY/vsRbKPuUUlKoIvVBQ+lKXQjOejdOY0ZJH8kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642516766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8FzwLn6QhkjWOJPvQFfLGKg9NeOr8S3LYPkXtc320u0=;
        b=p6XR/lahExYGbDJOBET2pFfE9V9sBKuP/U/WjjJeQXPT9nJNKUrOpa2l3euPT4TpOBS/f2
        D1bILl4F/XmCfrCA==
To:     Marc Zyngier <maz@kernel.org>, Tong Zhang <ztong0001@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] genirq/msi: fix crash when handling Multi-MSI
In-Reply-To: <87h7a28uhj.wl-maz@kernel.org>
References: <20220117092759.1619771-1-ztong0001@gmail.com>
 <87ilui8yxt.wl-maz@kernel.org>
 <CAA5qM4CfExWdg=Gp8OshKgYsi0A82nzTA1Uqu6nc_MQmdBfWzg@mail.gmail.com>
 <87h7a28uhj.wl-maz@kernel.org>
Date:   Tue, 18 Jan 2022 15:39:26 +0100
Message-ID: <87iluh9kgx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17 2022 at 11:36, Marc Zyngier wrote:
> On Mon, 17 Jan 2022 10:10:13 +0000,
> Tong Zhang <ztong0001@gmail.com> wrote:
>> pci_msi_domain_check_cap (used by ops->msi_check(domain, info, dev))
>> msi_domain_prepare_irqs
>> __msi_domain_alloc_irqs
>> msi_domain_alloc_irqs_descs_locked
>> 
>> What I am suggesting is commit 0f62d941acf9 changed how this return
>> value is being handled and created a UAF
>
> OK, this makes more sense.
>
> But msi_domain_prepare_irqs() shouldn't fail in this case, and we
> should proceed with the allocation of at least one vector, which isn't
> happening here.
>
> Also, if __msi_domain_alloc_irqs() is supposed to return the number of
> irqs allocated, it isn't doing it consistently.
>
> Thomas, can you shed some light on what is the intended behaviour
> here?

Let me stare at it.
