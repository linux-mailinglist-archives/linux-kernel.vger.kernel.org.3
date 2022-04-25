Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13CD50ECB0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiDYXho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiDYXhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:37:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E6489CC2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:34:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4DB361570
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DB8C385A4;
        Mon, 25 Apr 2022 23:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650929676;
        bh=Eb05Em8JyGymAnY18gau+jnazmwGgMGqqJHMO8BcqEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mDZAIzTbhfrTVINNUPKfY3iFdNiym/TmrJK94cBioGkuUjv6wwjvUSb1gNy5Y8eQk
         xZ07TFcINLWAe8jbTzAjwgLE9MHOQKbczWol+deAepUCLMLdV1cBKtccb79shkG91/
         ROexynsf2fwPoqxl108PqlQ7E6blmB/OuOPCwaiQ=
Date:   Mon, 25 Apr 2022 16:34:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Julius Hemanth Pitti <jpitti@cisco.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, Ingo Molnar <mingo@elte.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Eli Cohen <elic@nvidia.com>
Subject: Re: [proc/sysctl]  1dd38979b2:
 BUG:kernel_NULL_pointer_dereference,address
Message-Id: <20220425163434.5f8f47e8c301ea30c2f94a5a@linux-foundation.org>
In-Reply-To: <YmcqCVLv3HQ+Kxeq@bombadil.infradead.org>
References: <20220425083302.GD21864@xsang-OptiPlex-9020>
        <YmbvxQVNFESRwxxU@bombadil.infradead.org>
        <20220425144607.2c2588e6b1f00ab8a6f3f6ea@linux-foundation.org>
        <YmcqCVLv3HQ+Kxeq@bombadil.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 16:08:57 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:

> On Mon, Apr 25, 2022 at 02:46:07PM -0700, Andrew Morton wrote:
> > On Mon, 25 Apr 2022 12:00:21 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:
> > 
> > > Andrew, can we drop this patch for now?
> > 
> > I've been sitting on (ie, forgotten about) this patch
> > (https://lore.kernel.org/all/20200709235115.56954-1-jpitti@cisco.com/T/#u)
> 
> Jesh, yeah I see.
> 
> > for two years.  Evidently waiting for you/Kees/Ingo to provide
> > guidance.  So sure, the need seems very unurgent so I can drop it.
> 
> Well Keew as OK with it, but I yeah I can't decipher the issue at this
> point in time.
> 
> > However I fail to see how that patch could have caused this crash.  I'm
> > suspecting a bisection error?
> > 
> > Maybe something is unwell in drivers/vdpa/vdpa_user/vduse_dev.c.
> 
> At a quick glance, yes it could very well by vduse_init() is messy and
> races somehow with init, but if a race does lurk here my instincts tell
> me this can't be the only place.
> 
> Not sure if leaving a patch in place more time to see how else things
> can explode is worth it.

Confused.  Are you thinking that the above-linked patch was somehow
involved in this crash?  If so, but how?  All it does it to permit
unprivileged reads to four ints via proc_dointvec_minmax()?

