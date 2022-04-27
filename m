Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B58510DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356668AbiD0B0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242681AbiD0B0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A9686E55E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651022587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DpEof+0I0YCbwzONPoRmg0L/6pzi31MyKL13TiqlQ/U=;
        b=VdUNP2pvho5kJI6Kr93GIz2y+lKuE93aZk2Au141uDHJg9eprM0yTmK5yLkJiCHw8AZjXB
        0AaloJPh94iJM/Vnu9aBZ7kHBuGryhs251yh3uuLcc9vDN8dGLRiuyZB3u2Afsvd907OIU
        4c+ivHkt93oaM6q9z+cjHDccjH/daC8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-8Qyok9UXPvellTR8YIOXJA-1; Tue, 26 Apr 2022 21:23:01 -0400
X-MC-Unique: 8Qyok9UXPvellTR8YIOXJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40CFA3802AC4;
        Wed, 27 Apr 2022 01:23:01 +0000 (UTC)
Received: from rh (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C30BC28100;
        Wed, 27 Apr 2022 01:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=rh)
        by rh with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dchinner@redhat.com>)
        id 1njWOP-006YJ1-Jy; Wed, 27 Apr 2022 11:22:57 +1000
Date:   Wed, 27 Apr 2022 11:22:55 +1000
From:   Dave Chinner <dchinner@redhat.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v2 0/7] mm: introduce shrinker debugfs interface
Message-ID: <Ymia75Bh/sn/FQdV@rh>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
 <YmeK6/eZYaMo2Ltm@rh>
 <Ymggvr4Boc5JIf9j@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymggvr4Boc5JIf9j@carbon>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 09:41:34AM -0700, Roman Gushchin wrote:
> Can you, please, summarize your position, because it's a bit unclear.
> You made a lot of good points about some details (e.g. shrinkers naming,
> and I totally agree there; machines with hundreds of nodes etc), then
> you said the active scanning is useless and then said the whole thing
> is useless and we're fine with what we have regarding shrinkers debugging.

Better introspection the first thing we need. Work on improving
that. I've been making suggestions to help improve introspection
infrastructure.

Before anything else, we need to improve introspection so we can
gain better insight into the problems we have. Once we understand
the problems better and have evidence to back up where the problems
lie and we have a plan to solve them, then we can talk about whether
we need other user accessible shrinker APIs.

For the moment, exposing shrinker control interfaces to userspace
could potentially be very bad because it exposes internal
architectural and implementation details to a user API.  Just
because it is in /sys/kernel/debug it doesn't mean applications
won't start to use it and build dependencies on it.

That doesn't mean I'm opposed to exposing a shrinker control
mechanism to debugfs - I'm still on the fence on that one. However,
I definitely think that an API that directly exposes the internal
implementation to userspace is the wrong way to go about this.

Fine grained shrinker control is not necessary to improve shrinker
introspection and OOM debugging capability, so if you want/need
control interfaces then I think you should separate those out into a
separate line of development where it doesn't derail the discussion
on how to improve shrinker/OOM introspection.

-Dave.
-- 
Dave Chinner
dchinner@redhat.com

