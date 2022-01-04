Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4346484701
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiADRbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiADRbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:31:34 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C3BC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 09:31:34 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id co15so31910555pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 09:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rOI9lx3ly2W5g+I//wMzwDwVhtW2WkhsJvnaYL+oVaA=;
        b=GM1vaX8nnsQ5aen4uuxpsO114wif5ycCG9Oq+Pc5m0xedO5AWvlwlk+0nur670mGKt
         onzOYTKoI9ivHrmZ5omlX7G/9g8vG1Dk7BMz+AhbgZkQYjM5XKrkVKn/mua46+jhsgFl
         2x7N1/izW3LtGJIoZWWYJyzycZQWJVLVQuROwTwUx6Lb7wS1WfjJ2ZYfADX8e7fCk4Gv
         3x2oDnc8GvPEK74RL4V15y2/q8Wd2PT6kYpMQXV19pxe40QE3h194kOApOsI9U9v5KmD
         d9EPsZeQajXh15idUScX3jRX2SE0PftIP1z+OqwywcvLzNIoSgKRELKr5w7K0PR0/UYB
         ULOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rOI9lx3ly2W5g+I//wMzwDwVhtW2WkhsJvnaYL+oVaA=;
        b=0ZF9ymql9fLEfMPQ/2e1UQFET8m9c2C++hsj4GcckErjEuzZ8fJPuwlHc+GUoddDir
         96gCvKfguXpuUChYurH2G2ZaQjkNs8Up58uMYp+Bg7A0HUCGaUIK92hJLvmbxn216cW2
         yRZ7AKyFY9a9DEt2pC7yf9QSmc6feffbNq41wBdgGL/c+v3qp7nGCGacb4hHzx3u11aw
         hN2jnjEytICBo4Nb94ewpaWwG8i6S+nCgY67v7XoJTc8CTyrUWGxuiyTJ2U5iUXVN8yA
         8b/hEAMI5wXsIdRHh0w/uyG2D5JtqtziP0y/jGrcL+exmS4gk29aP6Xu9c9JAvOsFr0F
         T8Ww==
X-Gm-Message-State: AOAM5307s9ijXLP/dNJ4TMuPa2vYflFA36FkqTnrDDi+pVWhVXwzEsOH
        +ckbAKAahXdoPJJRiHdgidHBcQ==
X-Google-Smtp-Source: ABdhPJyW9pN160gPJHaycV7mP2xi077B27olHyhgGOoe6nr/BCGbiHdtFfrcOodNTbojl/LtojMyPQ==
X-Received: by 2002:a17:902:8645:b0:149:7d71:c229 with SMTP id y5-20020a170902864500b001497d71c229mr39146383plt.141.1641317493940;
        Tue, 04 Jan 2022 09:31:33 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l22sm43563684pfc.167.2022.01.04.09.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:31:33 -0800 (PST)
Date:   Tue, 4 Jan 2022 17:31:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v3 kvm/queue 11/16] KVM: Add kvm_map_gfn_range
Message-ID: <YdSEcknuErGe0gQa@google.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-12-chao.p.peng@linux.intel.com>
 <YcS6m9CieYaIGA3F@google.com>
 <20211224041351.GB44042@chaop.bj.intel.com>
 <20211231023334.GA7255@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231023334.GA7255@chaop.bj.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021, Chao Peng wrote:
> On Fri, Dec 24, 2021 at 12:13:51PM +0800, Chao Peng wrote:
> > On Thu, Dec 23, 2021 at 06:06:19PM +0000, Sean Christopherson wrote:
> > > On Thu, Dec 23, 2021, Chao Peng wrote:
> > > > This new function establishes the mapping in KVM page tables for a
> > > > given gfn range. It can be used in the memory fallocate callback for
> > > > memfd based memory to establish the mapping for KVM secondary MMU when
> > > > the pages are allocated in the memory backend.
> > > 
> > > NAK, under no circumstance should KVM install SPTEs in response to allocating
> > > memory in a file.   The correct thing to do is to invalidate the gfn range
> > > associated with the newly mapped range, i.e. wipe out any shared SPTEs associated
> > > with the memslot.
> > 
> > Right, thanks.
> 
> BTW, I think the current fallocate() callback is just useless as long as
> we don't want to install KVM SPTEs in response to allocating memory in a
> file. The invalidation of the shared SPTEs should be notified through 
> mmu_notifier of the shared memory backend, not memfd_notifier of the
> private memory backend.

No, because the private fd is the final source of truth as to whether or not a
GPA is private, e.g. userspace may choose to not unmap the shared backing.
KVM's rule per Paolo's/this proposoal is that a GPA is private if it has a private
memslot and is present in the private backing store.  And the other core rule is
that KVM must never map both the private and shared variants of a GPA into the
guest.
