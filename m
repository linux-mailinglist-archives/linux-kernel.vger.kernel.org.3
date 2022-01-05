Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5218485704
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbiAERDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242121AbiAERD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:03:28 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A913C061212
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 09:03:28 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x15so52016plg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 09:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=20PcXM2SOqh0bhoeFDgkuJ5Ggj44o0SuiK3MzhyRmsU=;
        b=rsVhd0t9UYWasE9JkCnUdxw73v/C1RJiVYZucEuqofNaX7J+c9jjVQkj/bSH9/hzML
         1AQ45ueMsGZqHhb+ONFIOTRVECck4WDJiLkhJ0dCZbZRd5F9dDTBiVu7r7REZXD9nDtu
         Xwabj8vwZirYN27UmfT+MFejoQWUI9qJwppOAO8SVy7LPqm06bw6Rk+FSk4JnYLfNzKN
         6FSWMsczvkGo3kv1fgbZktu3eIC0s4j4r+mMRKUgyd5AhelCtF7hT13ZZzUMad8zhHYs
         NsjHcQfwZ6EHDGIT1RaMTzGYfSxfIcJSuUk+//z6aXiUfPd4LC0DhqXQ2LFXonhbNUZK
         5pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=20PcXM2SOqh0bhoeFDgkuJ5Ggj44o0SuiK3MzhyRmsU=;
        b=HPBR8zcHw0N/Hr37ymqa8SqPbznbMGmYo3QSjd3ntRqYYVRC0VMGb9P/iMCK9w7BUu
         ADa3TtanPPcEkDzlxdZsXr5fRBeLuILHWUMjosLoNR8sn5D6uQ2WgQfnfeHhv069qO4E
         8OZ3UGLWXdugdkShbKBaizhDjr1S65YgRgsipCP/vhAfkStMqX2qHzpyX2hGEXPxuyk6
         jgx2aP5ZLy8y9LW5HifMGAPalmImChGsbE1BSLG9K00MXyiNiE7v+4qlgM0UfZZ0Bh4x
         xx3o57EB+xt1g/aX+anY6gaoGVcHWnJA4v1xGa7/+5MSrPNPxFCCmsCCccG44c74Av5N
         kS3A==
X-Gm-Message-State: AOAM533anczImd984BxBlQ1q4ihOiqXHszot1ayoSyHAecQvT+iFE3zt
        8wW9LJA6dzmUhZriDcCKmlFtXg==
X-Google-Smtp-Source: ABdhPJxImFHzV2wP+eap8aozdummb4OVmFsl2PXCC7t1JdswItec85C5qV0TEmNNUwSf2xDAMgaO6g==
X-Received: by 2002:a17:90b:1c86:: with SMTP id oo6mr4975265pjb.165.1641402207756;
        Wed, 05 Jan 2022 09:03:27 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v3sm23315094pgl.64.2022.01.05.09.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:03:27 -0800 (PST)
Date:   Wed, 5 Jan 2022 17:03:23 +0000
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
Message-ID: <YdXPW+2hZDsgZD/a@google.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-12-chao.p.peng@linux.intel.com>
 <YcS6m9CieYaIGA3F@google.com>
 <20211224041351.GB44042@chaop.bj.intel.com>
 <20211231023334.GA7255@chaop.bj.intel.com>
 <YdSEcknuErGe0gQa@google.com>
 <20220105061410.GA25283@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105061410.GA25283@chaop.bj.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022, Chao Peng wrote:
> On Tue, Jan 04, 2022 at 05:31:30PM +0000, Sean Christopherson wrote:
> > On Fri, Dec 31, 2021, Chao Peng wrote:
> > > On Fri, Dec 24, 2021 at 12:13:51PM +0800, Chao Peng wrote:
> > > > On Thu, Dec 23, 2021 at 06:06:19PM +0000, Sean Christopherson wrote:
> > > > > On Thu, Dec 23, 2021, Chao Peng wrote:
> > > > > > This new function establishes the mapping in KVM page tables for a
> > > > > > given gfn range. It can be used in the memory fallocate callback for
> > > > > > memfd based memory to establish the mapping for KVM secondary MMU when
> > > > > > the pages are allocated in the memory backend.
> > > > > 
> > > > > NAK, under no circumstance should KVM install SPTEs in response to allocating
> > > > > memory in a file.   The correct thing to do is to invalidate the gfn range
> > > > > associated with the newly mapped range, i.e. wipe out any shared SPTEs associated
> > > > > with the memslot.
> > > > 
> > > > Right, thanks.
> > > 
> > > BTW, I think the current fallocate() callback is just useless as long as
> > > we don't want to install KVM SPTEs in response to allocating memory in a
> > > file. The invalidation of the shared SPTEs should be notified through 
> > > mmu_notifier of the shared memory backend, not memfd_notifier of the
> > > private memory backend.
> > 
> > No, because the private fd is the final source of truth as to whether or not a
> > GPA is private, e.g. userspace may choose to not unmap the shared backing.
> > KVM's rule per Paolo's/this proposoal is that a GPA is private if it has a private
> > memslot and is present in the private backing store.  And the other core rule is
> > that KVM must never map both the private and shared variants of a GPA into the
> > guest.
> 
> That's true, but I'm wondering if zapping the shared variant can be
> handled at the time when the private one gets mapped in the KVM page
> fault. No bothering the backing store to dedicate a callback to tell
> KVM.

Hmm, I don't think that would work for the TDP MMU due to page faults taking
mmu_lock for read.  E.g. if two vCPUs concurrently fault in both the shared and
private variants, a race could exist where the private page fault sees the gfn
as private and the shared page fault sees it as shared.  In that case, both faults
will install a SPTE and KVM would end up running with both variants mapped into the
guest.

There's also a performance penalty, as KVM would need to walk the shared EPT tree
on every private page fault.
