Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D803598E12
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346085AbiHRUbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346067AbiHRUbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:31:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C60CD52F;
        Thu, 18 Aug 2022 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=iZYwlrrYfLQDglwnkyIXQe5gASgdsUP8JcbChxhpLxo=; b=kopqNJUVePtv167FLrWcxwxEpV
        1c0aCCnbVQDuQNc0kZRrXmRaVucktlUI4VcZ+ijW73MRl3RMlxiZ66W1nHrt6BOsvAzmOt9rlCBHg
        pFN/ui8tux9HhYU7WjUqX1nJKNMVBZh114k6xBIo/9mIZQYkyFMT+DXrtnAnWYVp9zNwEPt/b5YVP
        m2tliXUNU8fugq1Mq90ZCRYIIAXnlaEq3ePmNC1R1alhstSv3skQHGMtuX0Aiv8KzwMHhoOnDfB8t
        7n97sAb6OP3KJv1jliFkp6/R5oa5vZXBF+FHfZEPIq/6yOiXmq5AH86jIv8WdokbgMq8nxrZSspCN
        u5N1RvSQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOmAj-00AEzQ-L2; Thu, 18 Aug 2022 20:31:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B48E198026B; Thu, 18 Aug 2022 22:31:19 +0200 (CEST)
Date:   Thu, 18 Aug 2022 22:31:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joseph Salisbury <joseph.salisbury@canonical.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        bigeasy@linutronix.de, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC} Commit 8a99b6833c88 Moves Important Real-time Settings To
 DebugFS
Message-ID: <Yv6hl3D2TRL6jzrL@worktop.programming.kicks-ass.net>
References: <9e6a7216-9cb9-cba4-f150-1a0eaf56353c@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e6a7216-9cb9-cba4-f150-1a0eaf56353c@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 03:53:28PM -0400, Joseph Salisbury wrote:
> Hello,
> 
> Some Ubuntu users are using the tuned package with a 5.15.x based real-time
> kernel.  Tuned adjusts various sysctl options based on a specified profile. 
> This userspace package has stopped working > 5.13 due to the following
> commit:
> 
> 8a99b6833c88 "(sched: Move SCHED_DEBUG sysctl to debugfs)"
> 
> This commit moved some important real-time sysctl knobs to debugfs in
> 5.13-rc1.  It also appears some of the sysctl options were not moved,
> sched_min_granularity_ns, for example.
> 
> I was hoping to get some feedback on how to approach this.  Would upstream
> real-time consider accepting a patch to the 5.15 real-time patch set that
> reverts this commit?  Or a new patch that adds the sysctl settings back? 
> Any other ideas or feedback would be appreciated!

None of those knobs were available when SCHED_DEBUG=n, so relying on
them is your error to begin with.

Secondly, real-time? Which if those values affects anything in
SCHED_FIFO/RR/DEADLINE ?
