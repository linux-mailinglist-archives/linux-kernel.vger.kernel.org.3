Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716C3528950
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbiEPP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244552AbiEPP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:56:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1B519FF4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652716585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CgyJ1bZZA2Xr1Oc6Ya/N2yM31d0pFi9AId2A5XTR4BY=;
        b=fmtrZst76bd9l1CpdVZwlZvL++C3VUtpEApcNzM5VjpT3BMkmfotbD4hgjEdRl638NYCw6
        Ae6WNKmMSh3UmddIlj3de4dVqIdp4d47vV2YVLmz7UooxZcSnr/z0SHepIPyT1LJyyb85M
        qxQFkHZTsZwdeEDUuu9euhdhDp5hkPo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-J5Nz8hgrOHueTZmlA0JEew-1; Mon, 16 May 2022 11:56:22 -0400
X-MC-Unique: J5Nz8hgrOHueTZmlA0JEew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8DED803D45;
        Mon, 16 May 2022 15:56:21 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E06A440C1244;
        Mon, 16 May 2022 15:56:21 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 24GFuLGH031395;
        Mon, 16 May 2022 11:56:21 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 24GFuLp9031391;
        Mon, 16 May 2022 11:56:21 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 16 May 2022 11:56:21 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: fix objtool regression on x32 systems
In-Reply-To: <YoJwtCeVzYUm6Uhg@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LRH.2.02.2205161145070.30905@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2205161041260.11556@file01.intranet.prod.int.rdu2.redhat.com> <YoJwtCeVzYUm6Uhg@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 May 2022, Peter Zijlstra wrote:

> On Mon, May 16, 2022 at 11:06:36AM -0400, Mikulas Patocka wrote:
> > The patch 4abff6d48dbc ("objtool: Fix code relocs vs weak symbols") makes
> > the kernel unbootable.  The patch c087c6e7b551 ("objtool: Fix type of
> > reloc::addend") attempts to fix it by replacing 'int' with 'long'.
> > 
> > However, we may be running on a system with x32 ABI and 'long' on x32 is
> > 32-bit, thus the patch c087c6e7b551 doesn't really change anything and we
> > still end up with miscompiled kernel.  This patch replaces 'long' with
> > 'long long', so that the 64-bit kernel is correctly compiled on a x32
> > system.
> 
> Hurmph.. you're building a 64bit kernel on a x32 hosted machine? And
> this is the *only* thing that goes sideways?

I use the x32 ABI (that is 64-bit mode with addresses truncated to 
32-bit). gcc compiled for the x32 ABI is about 5% to 10% faster than gcc 
compiled for the amd64 ABI. I installed the x32 gcc from Debian Ports.

> I suspect quite a bit of objtool assumes LP64 and won't quite work right
> on ILP32 and we've just been lucky so far.

With this patch, the compiled kernel works. With kernels 5.17 or older, it 
also works. I bisected it and the breakage is caused by the commit 
4abff6d48dbc.

Mikulas

