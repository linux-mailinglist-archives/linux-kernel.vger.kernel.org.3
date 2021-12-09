Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB9C46E29B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhLIGka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:40:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232047AbhLIGk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639031815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsK4QJUaSZXa5TJT2c4xQUlL2CmJjpAOfFB8ZXJJNPs=;
        b=G1xvt2KDoc1Dzbmrvcyj8D/YLEIIlgmnB7b5g1h/HVCL90fkgLAPzh0FoCQhQQw2MMlU+T
        VQzrIw+a0WslFStQtMvvEi0nJUHNMoT3TNj2igVe3O6ukshVxyrcUqmQu3kWk4WfEIY60m
        QeKPNYY/WINhJIpI6uD1vCYKdTO5ols=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-77QLfWBEOm2RkS8nX1z5Gg-1; Thu, 09 Dec 2021 01:36:50 -0500
X-MC-Unique: 77QLfWBEOm2RkS8nX1z5Gg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12A86100CC99;
        Thu,  9 Dec 2021 06:36:49 +0000 (UTC)
Received: from starship (unknown [10.40.192.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BC0D19C59;
        Thu,  9 Dec 2021 06:36:45 +0000 (UTC)
Message-ID: <e87ba370fd853452e763cf36c1cf94fa251185de.camel@redhat.com>
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        kvm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 09 Dec 2021 08:36:44 +0200
In-Reply-To: <YbFIGSeukbquyoQ5@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
         <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
         <8c6c38f3cc201e42629c3b8e5cf8cdb251c9ea8d.camel@redhat.com>
         <6f0dc26c78c151814317d95d4918ffddabdd2df1.camel@redhat.com>
         <YbFIGSeukbquyoQ5@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-09 at 00:04 +0000, Sean Christopherson wrote:
> On Thu, Dec 09, 2021, Maxim Levitsky wrote:
> > Host crash while running 32 bit VM and another 32 bit VM nested in it:
> > 
> > [  751.182290] BUG: kernel NULL pointer dereference, address: 0000000000000025
> > [  751.198234] #PF: supervisor read access in kernel mode
> > [  751.209982] #PF: error_code(0x0000) - not-present page
> > [  751.221733] PGD 3720f9067 P4D 3720f9067 PUD 3720f8067 PMD 0 
> > [  751.234682] Oops: 0000 [#1] SMP
> > [  751.241857] CPU: 8 PID: 54050 Comm: CPU 8/KVM Tainted: G           O      5.16.0-rc4.unstable #6
> > [  751.261960] Hardware name: LENOVO 20UF001CUS/20UF001CUS, BIOS R1CET65W(1.34 ) 06/17/2021
> > [  751.280475] RIP: 0010:is_page_fault_stale.isra.0+0x2a/0xa0 [kvm]
> 
> ...
> 
> > Oh well, not related to the patch series but just that I don't forget.
> > I need to do some throughfull testing on all the VMs I use.
> 
> This is my goof, I'll post a fix shortly.
> 
Thanks!

Best regards,
	Maxim Levitsky

