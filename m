Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D5E510C72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355996AbiDZXOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiDZXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:14:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013D15F4E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F709B823EF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A8FC385AC;
        Tue, 26 Apr 2022 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651014661;
        bh=sqQfYjjF/r86CeFsB63WxaaPTzmwp2vYEsl7OATmzNQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AsCel1eBnB72AQnTInD6rZXEgUskgLbFriBxFq7lhRjUiS0uhTSd0ySHV569l7uz7
         NKh4+8BLI14VKNIzdgObSUKJH84dEubCGXiEe0lVxK9Wt+Re9LaCHbvNvUlFDnQu3d
         A2dRMQAKR0irtjQ+dpHJl7IB62L7/hxqtwbCLNOj5B3ncar4JCsj+N/gq/4N9jXj0u
         jK7+HbJnU4AOM91fLG4YyQzjGosmrTKtSeZGrBEJlFYe61P1KEKrX6viN/UoNeH3TP
         qCFxmNePlsod0GQ0igPdAvJEhohoy0v28H80CVI0p+Qw6p2e7xgIZA8G+UOwDayQqG
         vDwQd1EGabydg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E92785C0530; Tue, 26 Apr 2022 16:11:00 -0700 (PDT)
Date:   Tue, 26 Apr 2022 16:11:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christoph Bartoschek <bartoschek@google.com>
Cc:     Chris Mason <clm@fb.com>, Giuseppe Scrivano <gscrivan@redhat.com>,
        linux-kernel@vger.kernel.org,
        "riel@surriel.com" <riel@surriel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RFC fs/namespace] Make kern_unmount() use
 synchronize_rcu_expedited()
Message-ID: <20220426231100.GL4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <8E281DF1-248F-4861-A3C0-2573A5EFEE61@fb.com>
 <20220426065917.3123488-1-bartoschek@google.com>
 <20220426140919.GD4285@paulmck-ThinkPad-P17-Gen-1>
 <CAAQBG5jnvSxcjwr+L5nuxwh87bv=D=tzU325W2Zp3DVpn-VmcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAQBG5jnvSxcjwr+L5nuxwh87bv=D=tzU325W2Zp3DVpn-VmcQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 12:58:34AM +0200, Christoph Bartoschek wrote:
> > 3. https://lore.kernel.org/lkml/20220218183114.2867528-1-riel@surriel.com/
> >         Refined queue_rcu_work() approach.
> >
> > #1 should work, but the resulting IPIs are not going to make the real-time
> > guys happy.  #2 and #3 have been subject to reasonably heavy testing
> > and did fix a very similar issue to the one that you are reporting,
> > but last I knew there were doubts about the concurrency consequences.
> >
> > Could you please give at least #3 a shot and see if it helps you?
> 
> I have tried #3 and it works well with my testcases as far as I can see it.

Thank you for giving it a try!

Al, are further adjustments needed to make this patch cover all the
corner cases?

							Thanx, Paul
