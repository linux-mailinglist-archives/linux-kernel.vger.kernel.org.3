Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7702D49C72B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbiAZKMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:12:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239709AbiAZKMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643191973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YLLMjXe8Y984uSaV8UIQRt4tj6QyBzicSXco+B26HtQ=;
        b=EAYP7y7yZlTtJfNuH70wNDlDjmhlme+zJJIyPZyg8o9nlDdZp20CxZ6pOa3Sb/plX6cej7
        FYeewcr7ss3Tknnov3Fr5Ce7nw9saNhSoDlhrjsF00doED4YnQve4CQhL2Y3L/1NbpMQZu
        9nttRVDRAf2g1bFLR6wJzUI6Wn0lRXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-5d4ldEoyM6aXB6gy3S0T5Q-1; Wed, 26 Jan 2022 05:12:50 -0500
X-MC-Unique: 5d4ldEoyM6aXB6gy3S0T5Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 945018519E2;
        Wed, 26 Jan 2022 10:12:48 +0000 (UTC)
Received: from starship (unknown [10.40.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A950078DE9;
        Wed, 26 Jan 2022 10:12:45 +0000 (UTC)
Message-ID: <6cf58a4cd925726ef10481d38f9f4e8090f5023d.camel@redhat.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     dwmw@amazon.co.uk, iommu@lists.linux-foundation.org,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, tglx@linutronix.de, will@kernel.org
Date:   Wed, 26 Jan 2022 12:12:44 +0200
In-Reply-To: <CAHbf0-F8Uemcu8FVcZvY0CPOf4kFXOcaCzWF1ZCwkpa3tyut3A@mail.gmail.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
         <20220125150832.1570-1-mike@fireburn.co.uk>
         <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
         <CAHbf0-FJ0c1yAumKCnXLKKFN=tzeJxSd3HyP=dUOBgBTxVG5fw@mail.gmail.com>
         <7809c3253a997330102b9d779206312d6b3bcaf1.camel@redhat.com>
         <CAHbf0-F8Uemcu8FVcZvY0CPOf4kFXOcaCzWF1ZCwkpa3tyut3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-26 at 09:54 +0000, Mike Lothian wrote:
> On Wed, 26 Jan 2022 at 07:34, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > Could you post the whole dmesg, or at least:
> > 
> > dmesg | grep AMD-Vi
> > 
> > 
> > What CPU does your system have?
> > 
> > I suspect that your system doesn't GA log feature enabled in the IOMMU, and the code never checks
> > for that, and here it fails enabling it, which  before my patches was just
> > ignoring it silently.
> > 
> > 
> > Best regards,
> >         Maxim Levitsky
> > > Hope that helps
> > > 
> > > Mike
> > > 
> 
> Hi
> 
> It's an AMD Ryzen 9 5900HX
> 
> [    0.186350] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:160
> [    0.186353] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:160
> [    0.186354] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:160
> [    0.186355] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:160
> [    0.355628] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
> [    0.356134] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> [    0.356136] AMD-Vi: Extended features (0x206d73ef22254ade): PPR
> X2APIC NX GT IA GA PC GA_vAPIC
> [    0.356140] AMD-Vi: Interrupt remapping enabled
> [    0.356141] AMD-Vi: Virtual APIC enabled
> [    0.356142] AMD-Vi: X2APIC enabled
> [    0.431377] AMD-Vi: AMD IOMMUv2 loaded and initialized
> 
> I've attached the dmesg, I notice that some boots it doesn't happen
> 
> Cheers
> 
> Mike

Great, your system does seem to support GA log 
(but a patch to check if, other that assume blindly that it is supported is 
something that should be done).

So could you bump the LOOP_TIMEOUT like by 10x or so and see if the problem goes away?

(that code should be rewritten to time based wait and not just blindly loop like that,
I also can prepare a patch for that as well).

Best regards,
	Maxim Levitsky

