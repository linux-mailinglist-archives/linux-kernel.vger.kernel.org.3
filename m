Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C44507945
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357309AbiDSSfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357222AbiDSSeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:34:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EECB32F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECA8D6143D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 18:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035D2C385A7;
        Tue, 19 Apr 2022 18:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650392750;
        bh=XBqfyP6KAmo9qr7LY908MPyc4H5JRUEObbvlWE0N1lw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SExyzxBJW/aJrKEv8PfofSGkAceFkWaTn0TAvCJdsehvc3ELLrV8xQGZcTpDRubMP
         1PAHZyeAERbvHGu7b5Cq8QRqcK0urD9SbbrI7nM5m+EsBESE3icZae6kmQv36JB5Y9
         tBDEetP+qDzXvVUKdlmrWg5sPODpMx4hQh5mdXp4=
Date:   Tue, 19 Apr 2022 11:25:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-Id: <20220419112549.a42f1d86b025112d3a3aaf8c@linux-foundation.org>
In-Reply-To: <Yl727M1Dxm+vC/R1@carbon>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
        <20220418212709.42f2ba15e00999bb57086b27@linux-foundation.org>
        <Yl727M1Dxm+vC/R1@carbon>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 10:52:44 -0700 Roman Gushchin <roman.gushchin@linux.dev> wrote:

> > Unclear.  At the end of what output?
> 
> This is how it looks like when the output is too long:
> 
> [root@eth50-1 sb-btrfs-24]# cat count_memcg
> 1 226
> 20 96
> 53 811
> 2429 2
> 218 13
> 581 29
> 911 124
> 1010 3
> 1043 1
> 1076 1
> 1241 60
> 1274 7
> 1307 39
> 1340 3
> 1406 14
> 1439 63
> 1472 54
> 1505 8
> 1538 1
> 1571 6
> 1604 39
> 1637 9
> 1670 8
> 1703 4
> 1736 1094
> 1802 2
> 1868 2
> 1901 52
> 1934 592
> 1967 32
> 			< CUT >
> 18797 1
> 18830 1

We do that in-kernel?  Why?  That just makes parsers harder to write?
If someone has issues then direct them at /usr/bin/less?
