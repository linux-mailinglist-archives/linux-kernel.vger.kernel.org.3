Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3114FFE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiDMS7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbiDMS7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C0D26C94C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649876233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jePF+LAlrZY2/MlviRtzxuX6DXExsTmifHJyr3S1mXY=;
        b=Jl64X2RqQkY+q9IJsw0Qu6LZYyw+cN1pUuoOHCdH4lIVtinmS8Y+/yo6ZRfQ3K4ghviHrX
        Yr9rEOKymZFg9UPSMXeNL6G1y+X4rcnTreckdEFDC8eM76q6xuUrwb37SfbxYH6g1VNs7w
        wT8GclnxUf6NjJxleuGjvkUHWScLzkk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-tPSen3hIMfiy-CklOwv1cw-1; Wed, 13 Apr 2022 14:57:09 -0400
X-MC-Unique: tPSen3hIMfiy-CklOwv1cw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F168C29DD9AC;
        Wed, 13 Apr 2022 18:57:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.129])
        by smtp.corp.redhat.com (Postfix) with SMTP id 32B191457F23;
        Wed, 13 Apr 2022 18:57:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Apr 2022 20:57:08 +0200 (CEST)
Date:   Wed, 13 Apr 2022 20:57:04 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220413185704.GA30360@redhat.com>
References: <20220412114421.691372568@infradead.org>
 <20220412114853.842942162@infradead.org>
 <20220413132451.GA27281@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413132451.GA27281@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13, Oleg Nesterov wrote:
>
> I like 1-2 but I need to read them (and other patches) again, a
> couple of nits right now.

Sorry, didn't have time to do this today, and now I am already sleeping.

But... on a second thought, it seems there is a better solution. If nothing
else it is simpler and doesn't duplicate the wait_task_inactive() logic.

How about the patch below instead? On top of 1/5.

Yes,yes, incomplete. in particular see the "!!!!!!!!!" comments. Just to
explain the idea.

Oleg.

