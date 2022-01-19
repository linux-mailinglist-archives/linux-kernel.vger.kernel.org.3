Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2444931F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350475AbiASAoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:44:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38960 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiASAox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:44:53 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642553092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YaYXKoQ7vJJgcH3sYkQxo1bd06/NJ6Ovp1W7eIcPyig=;
        b=tf1CLamzzG5D26q2kHvhOfwgHuK83W3UJsVUPywhq2CzIz4Z7O5/Od76c8KrnYxDSit5YG
        /g88o9fPSCHLgjjZE1acUrX+z/vyaSyLBprY8muflzEXoHkrMCilllhxFxyv8D/3bdtws2
        gtmhbAXvrfJT0Rfq+imGydghSqj8777CEjx1jjMev30E3AwLhCFkb0MVn3wd9+wtfXF7r0
        +uPj0bvPXT2ytX/GiU5DlE4NDG0w6wi3cSC/I3tTqZaSrUSBuDDQU8qBZogGZTEDcyRs8D
        ejrmRNIaj5yt9vJM7D5gplLpVEwozjngqdSYzpH43zCNHOZsARudM3Hk8h+05g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642553092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YaYXKoQ7vJJgcH3sYkQxo1bd06/NJ6Ovp1W7eIcPyig=;
        b=vHU5sSTJq7Ka3Ja1NkLS0dYcGtYc74o37W/nyszRwJxSnCeA4p4jfhmMcIjYdNGEVZb29U
        /0BnZuKs5QbWviDw==
To:     Marc Zyngier <maz@kernel.org>, Tong Zhang <ztong0001@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] genirq/msi: fix crash when handling Multi-MSI
In-Reply-To: <87iluh9kgx.ffs@tglx>
References: <20220117092759.1619771-1-ztong0001@gmail.com>
 <87ilui8yxt.wl-maz@kernel.org>
 <CAA5qM4CfExWdg=Gp8OshKgYsi0A82nzTA1Uqu6nc_MQmdBfWzg@mail.gmail.com>
 <87h7a28uhj.wl-maz@kernel.org> <87iluh9kgx.ffs@tglx>
Date:   Wed, 19 Jan 2022 01:44:52 +0100
Message-ID: <877dawa70b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18 2022 at 15:39, Thomas Gleixner wrote:
> On Mon, Jan 17 2022 at 11:36, Marc Zyngier wrote:
>> On Mon, 17 Jan 2022 10:10:13 +0000,
>> Tong Zhang <ztong0001@gmail.com> wrote:
>>> pci_msi_domain_check_cap (used by ops->msi_check(domain, info, dev))
>>> msi_domain_prepare_irqs
>>> __msi_domain_alloc_irqs
>>> msi_domain_alloc_irqs_descs_locked
>>> 
>>> What I am suggesting is commit 0f62d941acf9 changed how this return
>>> value is being handled and created a UAF
>>
>> OK, this makes more sense.
>>
>> But msi_domain_prepare_irqs() shouldn't fail in this case, and we
>> should proceed with the allocation of at least one vector, which isn't
>> happening here.
>>
>> Also, if __msi_domain_alloc_irqs() is supposed to return the number of
>> irqs allocated, it isn't doing it consistently.
>>
>> Thomas, can you shed some light on what is the intended behaviour
>> here?
>
> Let me stare at it.

It's a subtle issue I overlooked. The UAF is due to

err:
	pci_msi_unmask(entry, msi_multi_mask(entry));

in msi_capability_init() because the core has torn down and freed the
entry already.

The proposed patch "fixes" the issue for the PCI/MSI case, but could
cause a memory leak for other callers.

Not sure yet what the proper fix is, but that has to wait until tomorrow
when brain becomes awake again.

Thanks,

        tglx

