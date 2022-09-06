Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123DE5AF43E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIFTLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiIFTLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:11:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C9DA2D97;
        Tue,  6 Sep 2022 12:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45657B819F7;
        Tue,  6 Sep 2022 19:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900FEC433C1;
        Tue,  6 Sep 2022 19:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662491472;
        bh=I2thZSdsMA3fAvQeM9frwdjRPaDPr7Ghu/hTt+TPzy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCJaUttRCTAa7ZyovROYIPZpH2DCmCqtP430NHFmrESACmlK0JcaP0r69c1ZtfYYl
         S2oH/cGOWmqUyrsz9IwSmehKBiiG9pd0F9fEOkfDRIUEXiTpmFrbDpwcJM1vSh8DDZ
         Esatx2eS7D2pdwLmRw4aZTcAcC5zLn4ozmz4n4yGVP2JTqmF4bHQ8MuzK6X9rXnONY
         LcyYoMstLFMVGz2RJ4p1lazjpapwQcXpCzxblRMW+7I85//IVSie++B0fVDAWbzubg
         E0YAUtQV/2/CUI9XS4EKysseVpwdf/bW5e0vV4e/1Z9ukNFkk0PXPsm4VlS4x4wBuO
         mbfkvFFtUzieA==
Date:   Tue, 6 Sep 2022 21:11:10 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <20220906191110.GA187950@lothringen>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen>
 <cde6586e-ae61-5e85-3c9a-1ce7dd2464ed@joelfernandes.org>
 <64f5770c-df37-8975-200d-7908de23fa73@joelfernandes.org>
 <da45d265-52f9-6314-7fcd-ea71e2bf4cec@joelfernandes.org>
 <4f6061f0-0de7-2916-dc6e-9f5af9b944c0@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f6061f0-0de7-2916-dc6e-9f5af9b944c0@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 12:43:52PM -0400, Joel Fernandes wrote:
> On 9/6/2022 12:38 PM, Joel Fernandes wrote:
> Ah, now I know why I got confused. I *used* to flush the bypass list before when
> !lazy CBs showed up. Paul suggested this is overkill. In this old overkill
> method, I was missing a wake up which was likely causing the boot regression.
> Forcing a wake up fixed that. Now in v5 I make it such that I don't do the flush
> on a !lazy rate-limit.
> 
> I am sorry for the confusion. Either way, in my defense this is just an extra
> bit of code that I have to delete. This code is hard. I have mostly relied on a
> test-driven development. But now thanks to this review and I am learning the
> code more and more...

Yeah this code is hard.

Especially as it's possible to flush from both sides and queue the timer
from both sides. And both sides read the bypass/lazy counter locklessly.
But only call_rcu_*() can queue/increase the bypass size whereas only
nocb_gp_wait() can cancel the timer. Phew!

Among the many possible dances between rcu_nocb_try_bypass()
and nocb_gp_wait(), I haven't found a way yet for the timer to be
set to LAZY when it should be BYPASS (or other kind of accident such
as an ignored callback).

In the worst case we may arm an earlier timer than necessary
(RCU_NOCB_WAKE_BYPASS instead of RCU_NOCB_WAKE_LAZY for example).

Famous last words...


> Thanks,
> 
>  - Joel
> 
> 
> 
