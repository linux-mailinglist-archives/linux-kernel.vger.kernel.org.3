Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E44507959
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353776AbiDSSqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353671AbiDSSq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:46:27 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE8F3DDF5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:43:43 -0700 (PDT)
Date:   Tue, 19 Apr 2022 11:43:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650393821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GFIxKYdHlMseSO1tlyqNC0Z7+2W1DV8pV6RMcsFlSN4=;
        b=J32CmAVJlieNJwRkipeOQWjw09E4O5dhfP8kD80buHhuD7SiitrR8Jm5naMrbQQDIam+2T
        eNj2mvjCXN7eg2zF67LuKwz3ReZjWfv38baEg6aS2TZo3McQQ2ymVLj7LutgD14PNTtDlV
        RqXuecTfdJigZkk2ZgjXT5HvBG6tLqM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <Yl8C1nDr2jUnFn3V@carbon>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
 <20220418212709.42f2ba15e00999bb57086b27@linux-foundation.org>
 <Yl727M1Dxm+vC/R1@carbon>
 <20220419112549.a42f1d86b025112d3a3aaf8c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419112549.a42f1d86b025112d3a3aaf8c@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:25:49AM -0700, Andrew Morton wrote:
> On Tue, 19 Apr 2022 10:52:44 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:
> 
> > > Unclear.  At the end of what output?
> > 
> > This is how it looks like when the output is too long:
> > 
> > [root@eth50-1 sb-btrfs-24]# cat count_memcg
> > 1 226
> > 20 96
> > 53 811
> > 2429 2
> > 218 13
> > 581 29
> > 911 124
> > 1010 3
> > 1043 1
> > 1076 1
> > 1241 60
> > 1274 7
> > 1307 39
> > 1340 3
> > 1406 14
> > 1439 63
> > 1472 54
> > 1505 8
> > 1538 1
> > 1571 6
> > 1604 39
> > 1637 9
> > 1670 8
> > 1703 4
> > 1736 1094
> > 1802 2
> > 1868 2
> > 1901 52
> > 1934 592
> > 1967 32
> > 			< CUT >
> > 18797 1
> > 18830 1
> 
> We do that in-kernel?  Why?  That just makes parsers harder to write?
> If someone has issues then direct them at /usr/bin/less?

It comes from the sysfs limitation: it expects that the output should fit
into the PAGE_SIZE. If the number of cgroups (and nodes) is large, it's not
always possible. In theory something like seq_file API should be used, but
Idk how hard it's to mix it with the sysfs/debugfs API. I'll try to figure
this out.
