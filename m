Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51715917C7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 02:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiHMAYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 20:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiHMAYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 20:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A7CDA3D60
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 17:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660350284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D+F48GZrNmKWUhdl+zaXl1w6N+t4Zw3HE18peH9oyp0=;
        b=Jt+QW/KIZbAwkWpxZNJV7j2dAgTMiJhvmlZvg7YxsiXyIQTiixK4qn//dO1nAWfzDGj9Ns
        qFnxR9v2ryNb6jqNsIEbYSIBSh2bK8yFepqLw6PeBOcD1YPu+HfQNzD+HuW5GotBvC5XNt
        WKtkQBoWSAKZBgak+ulfjrG4X+F1Hbs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-BCAHucJXNv2sttbzvrBPPQ-1; Fri, 12 Aug 2022 20:24:40 -0400
X-MC-Unique: BCAHucJXNv2sttbzvrBPPQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1564B3C0219A;
        Sat, 13 Aug 2022 00:24:39 +0000 (UTC)
Received: from localhost (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3593403178;
        Sat, 13 Aug 2022 00:24:37 +0000 (UTC)
Date:   Sat, 13 Aug 2022 08:24:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v10 1/8] crash: introduce arch/*/asm/crash.h
Message-ID: <YvbvQ5+cmExVNaGE@MiWiFi-R3L-srv>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-2-eric.devolder@oracle.com>
 <YvCCOY+mRshu1tHi@MiWiFi-R3L-srv>
 <52d40562-ee6f-bb89-6d21-2d6baf67053d@oracle.com>
 <YvYhYdV6F2zH4o3X@MiWiFi-R3L-srv>
 <2b44bbd1-6e6f-40d1-73ac-19348d1ef48a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b44bbd1-6e6f-40d1-73ac-19348d1ef48a@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/22 at 04:23pm, Eric DeVolder wrote:
> 
> 
> On 8/12/22 04:46, Baoquan He wrote:
> > On 08/08/22 at 10:18am, Eric DeVolder wrote:
> > > 
> > > 
> > > On 8/7/22 22:25, Baoquan He wrote:
> > > > Hi Eric,
> > > > 
> > > > On 07/21/22 at 02:17pm, Eric DeVolder wrote:
> > > > > The use of __weak is being eliminated within kexec sources.
> > > > > The technique uses macros mapped onto inline functions in
> > > > > order to replace __weak.
> > > > > 
> > > > > This patchset was using __weak and so in order to replace
> > > > > __weak, this patch introduces arch/*/asm/crash.h, patterned
> > > > > after how kexec is moving away from __weak and to the macro
> > > > > definitions.
> > > > 
> > > > Are you going to replace __weak in kexec of arll ARCHes? I don't see
> > > > your point why all these empty header files are introduced. Wondering
> > > > what's impacted if not adding these empty files?
> > > 
> > > Hi Baoquan,
> > > In this patchset, to file include/linux/crash_core.h I added the line #include <asm/crash.h>.
> > > I patterned this after how include/linux/kexec.h does #include <asm/kexec.h>.
> > 
> > I am sorry, Eric, it looks not so good. I understand you want to pattern
> > asm/kexe.h, but we need consider reality. Introducing a dozen of empty
> > header file and not being able to tell when they will be filled doesn't
> > make sense.
> > 
> > Includig <asm/crash.h> where needed is much simpler. I doubt if your way
> > can pass other reviewers' line. Can you reconsider?
> 
> If I include <asm/crash.h> where needed, which is kernel/crash_core.c, then
> the other archs will fail build if that file doesn't exist. A couple of
> options, which do you think is better to pursue?
> 
> - use asm/kexec.h instead of asm/crash.h; it appears all the architectures
> already have this file in place
> 
> - go ahead and put the appropriate crash macros/inline functions into each
> arch asm/crash.h so that the files are not just empty, and leave the use of
> asm/crash.h

I think we can do this in two steps.

Firstly, make do with asm/kexec.h since all other ARCHes put crash related stuff
into asm/kexec.h, except of x86. 

Secondly, clean up to put those crash marco/inline functions into
asm/crash.h.

The 2nd step can be done in a independent patchset. What do you think?

