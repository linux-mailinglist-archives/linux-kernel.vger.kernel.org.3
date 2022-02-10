Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6A14B122F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243894AbiBJP6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:58:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243877AbiBJP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:58:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6F6CD6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:58:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC7D461CAE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE13C004E1;
        Thu, 10 Feb 2022 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644508687;
        bh=fJz0mfpB47QMQtMUTnDAOyZFLprkCOZTHFgVXNMTvCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQdu/gY1hIYhmwvrgNpyofmzlsCOxzGe2azh+1Mlr3oBKY1Rl09Xl7aChZiJXZYB6
         ve1k4JTINR8Pwn8hwVAL0BsApSNlGT7vQtlq6HqVLlTj9j4XKk3XE9jnd+75UNznvn
         3hI7hCU8y8UD6hfBFUtJMu18RmUsuAuhg2dxL7em3RGS7et4okrWr2oGKow6FVw6ru
         bz8qHIY95KCn6kbDwXhQsNVdlAWf5N+vZIm3P7wICE2Wh+j9AzytW/XWNsGGTr6a3m
         Qevy7h6XkkHYO/UIt/N6T0pPEte13kdDMSspnVtfGnZg/NNXCRCSvkZANvKbTz6gfn
         n2kXkGtpCvF2A==
Date:   Thu, 10 Feb 2022 16:58:04 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v3 7/7] arm64: support PREEMPT_DYNAMIC
Message-ID: <20220210155804.GA567552@lothringen>
References: <20220209153535.818830-1-mark.rutland@arm.com>
 <20220209153535.818830-8-mark.rutland@arm.com>
 <20220209195709.GA557593@lothringen>
 <YgTdHfmubmk1rUi8@FVFF77S0Q05N>
 <YgT+eHjtgrHl+wWw@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgT+eHjtgrHl+wWw@FVFF77S0Q05N>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 12:00:56PM +0000, Mark Rutland wrote:
> On Thu, Feb 10, 2022 at 09:38:37AM +0000, Mark Rutland wrote:
> > On Wed, Feb 09, 2022 at 08:57:09PM +0100, Frederic Weisbecker wrote:
> > > On Wed, Feb 09, 2022 at 03:35:35PM +0000, Mark Rutland wrote:
> > > > Note that PREEMPT_DYNAMIC is `def bool y`, so this will default to
> > > > enabled.
> > > 
> > > It should probably be "def_bool y if HAVE_STATIC_CALL_INLINE"...
> > 
> > Sure; I'm more than happy to fold that into patch 5.
> 
> For the moment I've made that:
> 
> 	def_bool y if HAVE_PREEMPT_DYNAMIC_CALL
> 
> ... since that fit more neatly with the other bits I had to add, and didn't
> change the existing behaviour of 32-bit x86.
> 
> Please shout if you think that should be HAVE_STATIC_CALL_INLINE specifically!

I seem to remember peterz didn't mind keeping it default y as long as
HAVE_STATIC_CALL*. So I guess that's fine.

Thanks!
