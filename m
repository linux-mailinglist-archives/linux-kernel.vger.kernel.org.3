Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9695F48CBB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356798AbiALTPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357161AbiALTPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:15:04 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DE5C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:14:51 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s30so11596781lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=igVDWcMipF0SatFt9p6gNS2Y828EjA5ZzPFbjDN4w8s=;
        b=ZWWedQq2A4EN9KB+CRMjVwqfQ/K1up/vwGXDtcnByaN/WoonWF25/SCIWCrjK8xz0Y
         7H+uXrxtCbFyEOSIwciKYoUEevYu3KPy/M+dg8KmzPfA2wRC+EEo3MN80sRDsYvl8ya1
         ayoOP76A/t9AtPZaVOvMfMDuup94Fut3p2jGJ5oP3MJwEa5PCOq/an+JBZF+Mkn1D3Ro
         08JO/UCPXrBhBQzGpzSRc+c9BSEJpkiKcltxVeaWdFl5HHcYQqrKQTs1TYes7jjmAfc4
         eQkwiuP6dhERXlBcyWQYTEjwwxfmz1tPsTpTsCu2+mI4Hymn+wBWE/muNjkbJpjIyhIx
         tu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=igVDWcMipF0SatFt9p6gNS2Y828EjA5ZzPFbjDN4w8s=;
        b=jptH6VHGLs145VRCRSACz2i9Ti4hZFupTBXnAnqwVRnlnc61ZMVXGPRvtMq32HqCAb
         L7974GiowCrHgqj0txLQFJCn/Tw5B38YE/0sP4dtMbDyonm0U2mmuNzGIJZzPaDnuXtp
         G6o6IiZWcNwJCmlys3qQt/WXsK4SzmK+bHrR9wluyOqrj62soGdfbAo0Ff3X+1FlWxwY
         sBUrAFzPzd+TPYSHb8DntQ9SCclw9qO9Sl564RPaTq5kwKDKH2otBF1sbt+xLUsVaJIz
         WMdbYqYDn97nFAoakdAu6Am/D8Uhc/9kLtcrZe4DYYVElbIUJEqKQYluGPxuDT6LGI6B
         k8/Q==
X-Gm-Message-State: AOAM532IMtM/G5DlA9hXzv5nemH71QL3sAA8R2QyprlYOueHfOTMQU2/
        9TJ4IDU0D1C3bduDqSqB/91jTw==
X-Google-Smtp-Source: ABdhPJzlfxAT+7HQhcd4fAWklADHKI95H3h5K1MM3L4iC2TQORXo0ZIlDg8+0aydimE2hYeywaPhYA==
X-Received: by 2002:a2e:b791:: with SMTP id n17mr622707ljo.307.1642014889495;
        Wed, 12 Jan 2022 11:14:49 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p17sm67328lfu.233.2022.01.12.11.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 11:14:47 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id E8448103A6D; Wed, 12 Jan 2022 22:15:10 +0300 (+03)
Date:   Wed, 12 Jan 2022 22:15:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/7] mm: Add support for unaccepted memory
Message-ID: <20220112191510.6uqdflbreuet7bnx@box.shutemov.name>
References: <20220111113314.27173-1-kirill.shutemov@linux.intel.com>
 <20220111113314.27173-2-kirill.shutemov@linux.intel.com>
 <3a68fabd-eaff-2164-5609-3a71fd4a7257@intel.com>
 <d84e242f-f7f6-4fb0-8f22-bcc790a296a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d84e242f-f7f6-4fb0-8f22-bcc790a296a0@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 12:31:10PM +0100, David Hildenbrand wrote:
> 
> > 
> > Looking at stuff like this, I can't help but think that a:
> > 
> > 	#define PageOffline PageUnaccepted
> > 
> > and some other renaming would be a fine idea.  I get that the Offline 
> > bit can be reused, but I'm not sure that the "Offline" *naming* should 
> > be reused.  What you're doing here is logically distinct from existing 
> > offlining.
> 
> Yes, or using a new pagetype bit to make the distinction clearer.
> Especially the function names like maybe_set_page_offline() et. Al are
> confusing IMHO. They are all about accepting unaccepted memory ... and
> should express that.

"Unaccepted" is UEFI treminology and I'm not sure we want to expose
core-mm to it. Power/S390/ARM may have a different name for the same
concept. Offline/online is neutral terminology, familiar to MM developers.

What if I change accept->online in function names and document the meaning
properly?

> I assume PageOffline() will be set only on the first sub-page of a
> high-order PageBuddy() page, correct?
> 
> Then we'll have to monitor all PageOffline() users such that they can
> actually deal with PageBuddy() pages spanning *multiple* base pages for
> a PageBuddy() page. For now it's clear that if a page is PageOffline(),
> it cannot be PageBuddy() and cannot span more than one base page.

> E.g., fs/proc/kcore.c:read_kcore() assumes that PageOffline() is set on
> individual base pages.

Right, pages that offline from hotplug POV are never on page allocator's
free lists, so it cannot ever step on them.

-- 
 Kirill A. Shutemov
