Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3887D52672D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382414AbiEMQfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344683AbiEMQfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 240A52646
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652459731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQfd09AP/gq8POaUyhiUEVQH1+5iVG2OnErFJHZMVgI=;
        b=BkyhyCbYUIcYUifYf7KpHE0bh6s/2+c9OCrvEvs8ZxgRQUsB3WUcwSi1UwiyuiBeBBpINl
        9Ef5spV/yF4fzkOqC8THUY3xIJlo55srwDkxCHMXWQd1FvaW3zDu2He6KS7lT153kAYQYg
        Q72dx7Lyw34O8FH1RC7+EJ5f0EKoZ4c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-qhYgxGdEOtiIYiu1OcJd6w-1; Fri, 13 May 2022 12:35:26 -0400
X-MC-Unique: qhYgxGdEOtiIYiu1OcJd6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63FE2382ECDC;
        Fri, 13 May 2022 16:35:25 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.16.240])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FE8340D2820;
        Fri, 13 May 2022 16:35:25 +0000 (UTC)
Date:   Fri, 13 May 2022 12:35:23 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mkoutny@suse.com, tj@kernel.org
Subject: Re: [PATCH] kselftest/cgroup: fix test_stress.sh to use OUTPUT dir
Message-ID: <Yn6Iy6btkZlviqEj@lorien.usersys.redhat.com>
References: <20220512143439.26104-1-pauld@redhat.com>
 <f819f288-7f67-77d1-5d92-f0a5545c1c48@redhat.com>
 <Yn6ICiu58nllccYx@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn6ICiu58nllccYx@lorien.usersys.redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 12:32:15PM -0400 Phil Auld wrote:
> On Fri, May 13, 2022 at 12:19:24PM -0400 Waiman Long wrote:
> > 
> > On 5/12/22 10:34, Phil Auld wrote:
> > > Running cgroup kselftest with O= fails to run the with_stress test due
> > > to hardcoded ./test_core. Find test_core binary using the OUTPUT directory.
> > > 
> > > Fixes: 1a99fcc035fb ("selftests: cgroup: Run test_core under interfering stress")
> > > Signed-off-by: Phil Auld <pauld@redhat.com>
> > > ---
> > >   tools/testing/selftests/cgroup/test_stress.sh | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/cgroup/test_stress.sh b/tools/testing/selftests/cgroup/test_stress.sh
> > > index 15d9d5896394..109c044f715f 100755
> > > --- a/tools/testing/selftests/cgroup/test_stress.sh
> > > +++ b/tools/testing/selftests/cgroup/test_stress.sh
> > > @@ -1,4 +1,4 @@
> > >   #!/bin/bash
> > >   # SPDX-License-Identifier: GPL-2.0
> > > -./with_stress.sh -s subsys -s fork ./test_core
> > > +./with_stress.sh -s subsys -s fork ${OUTPUT}/test_core
> > 
> > 
> > I would suggest using "${OUTPUT:-.}" as the variable OUTPUT may not be
> > defined if test_stress.sh is run interactively.
> >
> 
> I worked both ways as is.
> 
>

But I'm not sure why :)  Yours is probably better.


Cheers,
Phil


> > Cheers,
> > Longman
> > 
> 
> -- 

-- 

