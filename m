Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30412595FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiHPQA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbiHPP75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FF02CDF3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B824A61138
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 15:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D58FC433D6;
        Tue, 16 Aug 2022 15:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660665522;
        bh=h71+JZ/0awNq3wQYEoePD4NcX3kk7FQlZzE4VDiel/s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q6drqwxHqmfYHJG2AlHcGazfHi1o0eomIkzGOGsoNqi79EndZKiVkiRhBCl6dpUxL
         uzn6hytH0lHJhMZrFU1RFt6WD1zJV330bDOwbDc3SeLLLiD/aLoRBSaRDVe/b+kBhU
         BhW/xkM/jKzwAsl2KHzmsXqN0t7ptWW2LM/qICl78YziDXxLmU9MjhFkfD8ACPpoor
         gyZuTXkw1JBkfs4XBy5om84qh1xXeyS4ieBTM9Lzjk2HFGk0DCZ2MMMjcZzrV1A3NG
         2bM+tdd+NBreWYuVlTg6XdmtQ0wWLqqSizXM4tFzqy27dbapmmCX+OciPc+vTzbJnG
         qrSdVyFo1xGgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AF7C15C02F9; Tue, 16 Aug 2022 08:58:41 -0700 (PDT)
Date:   Tue, 16 Aug 2022 08:58:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chang-Ho Cho <changho.cho11@gmail.com>
Cc:     jgross@suse.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
        peterz@infradead.org
Subject: Re: [PATCH v3 3/4] kernel/smp: add more data to CSD lock debugging
Message-ID: <20220816155841.GD2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <AEF6AAF1-0529-4661-AA6D-F9E41CE9DA44@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AEF6AAF1-0529-4661-AA6D-F9E41CE9DA44@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 07:53:49PM +0900, Chang-Ho Cho wrote:
> Hello, 
> 
> Google search brought me into this thread.  May I have update on the progress of this issue? Has anyone find root cause, solution or workaround?
> How can I get more about the problem?
> Windows 2008 R2 VM experiencing hang on QEMU-kvm with IPI handling issue. 

Here is a blog entry describing the bug that was causing me trouble:

https://paulmck.livejournal.com/62071.html

But although this appeared to be an IPI-loss problem, it was in fact
an interrupt storm.

Juergen, who you CCed, located a race-condition issue with a non-KVM
hypervisor, if I recall correctly.

Of course, much depends on the exact versions of your various OSes
and firmware.  One useful trick is to look for fixes since whichever
version of Linux you are using, and to backport those.  Also, for issues
with Windows, you are likely better served asking elsewhere.  Since you
are asking here, I am assuming that you have somehow proven that the
interrupt is being lost in KVM or QEMU rather than in the Windows guest.

Please note that observing the hang on QEMU/KVM but not on bare metal
is insufficient, given that the difference in timing can dramatically
change the probability of bugs occuring.

							Thanx, Paul
