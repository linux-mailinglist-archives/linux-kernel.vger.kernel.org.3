Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F58F48DBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbiAMQ03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiAMQ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:26:26 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A37C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:26:26 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id ie23-20020a17090b401700b001b38a5318easo11682778pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pk/7BdSIsGG0KgW2ujwUXsz/1xkMnjTcC1wzuA0ThFY=;
        b=tf39qpTYYXTMBM3CObcecGxp3FkDQyEZBRGKBPlHFsR9+29yZB+2/Qq6CYwe2gJd52
         2rBi8uQQVPuoeS+11OuU+8U0twJynTGbJ/xTpuV9EBwYfO8eFteYsr3uLSDT40umLav3
         GwVQR2PloZEF5aHo4McuaL2Zb7y/gf5FNFFIlUZnoco5lu1hN1ZyANjzKKgMsKugpGgS
         HBrWqkJ+B5NkZXfsdSDagsx58gMPGIk2LusHwU/0Z2tgZZMFjUMRzA0uExphH7ozO2nE
         iQ2zV6TpbvMxRDO6mpsUmviRl5Wq7Qheu1NEVfYeZNcaAiBgo/Ric8KuWCjm/eBAfI8Y
         aEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pk/7BdSIsGG0KgW2ujwUXsz/1xkMnjTcC1wzuA0ThFY=;
        b=1JioSDlgwFKQjp7xGY04TANIHXNExR746T3WO5lWyirg8rsOqXjLXn1JHw0dXWFKr9
         X2teBQqx0Mx3zY9nMONz0kWm6Kt3lAyTBCNf9YRDChPXVJIDjj0swmZlKcAfSKeSZ7KZ
         MWcqhG7ixcTsE1/M/v1qXoKhq9K/YfxdMAicmhduE+Wlc9XiYaC7YBggYTY58zJUWaBs
         /Vil0+CLFTkFcxScE0YORi29lSDtZJlHygh0aPoD0UxeU8JRBWPY5REBgwaJCqf7rkfr
         XHzYbccHA6L6567hQfvAE1Yv+CABzL1o7fkK6MS9DtMcz/zcuOjKU2ZBLuiCBnA7baJk
         A4Vw==
X-Gm-Message-State: AOAM532H75ze/J6T9Ug/iXkJ7euKOiMkimWCAnMtwq+8E6v/RIFDUPOW
        L7YB2xV8tB2hB7xK6zuoLXVQpw==
X-Google-Smtp-Source: ABdhPJw8++zFFzYtVrDAm00iNYzkqBasNxy1VfOaE+YpTnR/NdbhAr7HE+YmGoL6E7yRfzGFohDzqg==
X-Received: by 2002:a17:903:228b:b0:14a:8379:bb8b with SMTP id b11-20020a170903228b00b0014a8379bb8bmr1982710plh.110.1642091185545;
        Thu, 13 Jan 2022 08:26:25 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t6sm1090279pfg.92.2022.01.13.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:26:24 -0800 (PST)
Date:   Thu, 13 Jan 2022 16:26:21 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: x86: Forbid KVM_SET_CPUID{,2} after KVM_RUN
Message-ID: <YeBSrcNawgzvTzQ6@google.com>
References: <877dbbq5om.fsf@redhat.com>
 <5505d731-cf87-9662-33f3-08844d92877c@redhat.com>
 <20220111090022.1125ffb5@redhat.com>
 <87fsptnjic.fsf@redhat.com>
 <50136685-706e-fc6a-0a77-97e584e74f93@redhat.com>
 <87bl0gnfy5.fsf@redhat.com>
 <7e7c7e22f8b1b1695d26d9e19a767b87c679df93.camel@redhat.com>
 <87zgnzn1nr.fsf@redhat.com>
 <6ae7e64c53727f9f00537d787e9612c292c4e244.camel@redhat.com>
 <87wnj3n0k0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnj3n0k0.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022, Vitaly Kuznetsov wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> > For my nested AVIC work I would really want the APIC ID of a VCPU to be read-only
> > and be equal to vcpu_id.
> >
> 
> Doesn't APIC ID have topology encoded in it?

Yeah, APIC IDs are derived from the topology.  From the SDM (this doesn't
talk about core/SMT info, but that's included as well):

  The hardware assigned APIC ID is based on system topology and includes encoding
  for socket position and cluster information.

The SDM also says:

  Some processors permit software to modify the APIC ID. However, the ability of
  software to modify the APIC ID is processor model specific.

So I _think_ we could define KVM behavior to ignore writes from the _guest_, but
the APIC_ID == vcpu_id requirement won't fly as userspace expects to be able to
stuff virtual toplogy info into the APIC ID.
