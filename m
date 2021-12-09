Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF68446DF30
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241322AbhLIAIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241304AbhLIAIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:08:18 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A8AC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 16:04:45 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso3439066pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 16:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MjUeHzzA4V17niQyufwkdrBEp0f65mLMF1fq0crIpW0=;
        b=b+3DMK2d5mC+XSKmwavtEEUhdxeN1Sx6VF8/i5xEOkF77+HhxFlS7HOatJxHNY6/nb
         PJfVeM/FZc53xg2Gm0RZKK3pjNka3g8c/tYglsPigPaiobRgBBAPlGbUvxoHlsHCHiUc
         YehYKmEOkc5137JM/L8YYXEfZTttkn66sk9+26uVrXO6Efykk+1T5nWhC7z4ZoGxT5zY
         qfP3qKjUB45LJk3MFpQvmhN2An5vk5coeZt786iJr9cey0YWSe2SZw3NC+Tjk7qc+S/P
         nBgfKZ2T3uD1CJW9x1r5EhNEYNtGIDrpOIuLhWfyb8yBYCpN0gd+nvxAsJloYZ9tf3QQ
         ZGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MjUeHzzA4V17niQyufwkdrBEp0f65mLMF1fq0crIpW0=;
        b=oOUxk+ORmrgeqPwZx0Ak+Pa02KabEmgADs7z8ZgwPJZ5E4radb/vvvGUgeVGnc/mkm
         /t7o5FulrQJvLfsqtVW34uq0FKm9Lf1vXdm1rfHIk8IsYlh+HBadWksu/nOHFGKGqEN9
         cGk+d6lD3YetOXHbA+wPA3TGIQRLhsQxd7pAKBTjUiE+7RCD/tLF+fkszfSNyWEFVHTc
         ggtjfXPWKG3y3n4r4UmdGTOe05/jcAHy64tRviVBgy864h3WpdP4OD9PCscgbzboNAz6
         aytOvahOWyAK0ouVoRZebxEcbEqLzAS/ehqa9NgFn/VwoeQnmRkT1Oxqz4Svv3CVvOnz
         lRfg==
X-Gm-Message-State: AOAM53370Swzp7Udz/rOAbO3EEL3FUc6At3xhFppesl/BfpyWNB77qR6
        hwzc/MknlIEFRZpG5xTAz3d4LQ==
X-Google-Smtp-Source: ABdhPJyiv63F9ZJKJny3hjVwxro5UZyYEhLuM/dB7Sc4H0wX9hjkGjpGw/qXP8w5pVdLRhJLyjjXmQ==
X-Received: by 2002:a17:90b:1b0a:: with SMTP id nu10mr11290342pjb.35.1639008285121;
        Wed, 08 Dec 2021 16:04:45 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z4sm4946183pfh.15.2021.12.08.16.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 16:04:44 -0800 (PST)
Date:   Thu, 9 Dec 2021 00:04:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        kvm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
Message-ID: <YbFIGSeukbquyoQ5@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
 <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
 <8c6c38f3cc201e42629c3b8e5cf8cdb251c9ea8d.camel@redhat.com>
 <6f0dc26c78c151814317d95d4918ffddabdd2df1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f0dc26c78c151814317d95d4918ffddabdd2df1.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021, Maxim Levitsky wrote:
> Host crash while running 32 bit VM and another 32 bit VM nested in it:
> 
> [  751.182290] BUG: kernel NULL pointer dereference, address: 0000000000000025
> [  751.198234] #PF: supervisor read access in kernel mode
> [  751.209982] #PF: error_code(0x0000) - not-present page
> [  751.221733] PGD 3720f9067 P4D 3720f9067 PUD 3720f8067 PMD 0 
> [  751.234682] Oops: 0000 [#1] SMP
> [  751.241857] CPU: 8 PID: 54050 Comm: CPU 8/KVM Tainted: G           O      5.16.0-rc4.unstable #6
> [  751.261960] Hardware name: LENOVO 20UF001CUS/20UF001CUS, BIOS R1CET65W(1.34 ) 06/17/2021
> [  751.280475] RIP: 0010:is_page_fault_stale.isra.0+0x2a/0xa0 [kvm]

...

> Oh well, not related to the patch series but just that I don't forget.
> I need to do some throughfull testing on all the VMs I use.

This is my goof, I'll post a fix shortly.
