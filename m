Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B805A95B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiIAL35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiIAL3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:29:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C535B48;
        Thu,  1 Sep 2022 04:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F07EEB824F5;
        Thu,  1 Sep 2022 11:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B578C433D7;
        Thu,  1 Sep 2022 11:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662031789;
        bh=DjYCxepA2d0Zh1cPmPtLxRdp/vMrxB28w9asViiX7Qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=junecTn4Ih0IUcrqTCrMjncSBOcDJhRNTLuuo4o1gEmRQ7OElTwICJY2m3CDL71yF
         H8C4QHZr9nEy4FtqZPNMpSJyIl5KpJDUU3XzSCiNEZVQpTsB511StY4tAMOfrAOrLi
         05TGVfMYcWDI5zfo/qsQK8yzbVQj8/rQMgb5MqJV53/Q11nyF4BRQ0RI5TQWjZMiwC
         l0BiVDAU2Q04Chpx1oWCDh5asLnM3OytkYPuqnda/Nmh9jpaWrzUWeD9iKghfRkgqj
         wBIxdSdaZr+8mUH+p/zwj9zmfMI7aQRgKfiHnkmzqveJXeU9UDVKsWrSwBvBAOUMD2
         QDGduz4pKB6iw==
Date:   Thu, 1 Sep 2022 13:29:47 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous
 fixes
Message-ID: <20220901112947.GA105556@lothringen>
References: <20220829134045.GA54589@lothringen>
 <1f7dd31b-f4d0-5c1c-ce28-c27f75c17f05@joelfernandes.org>
 <20220829194622.GA58291@lothringen>
 <CAEXW_YS593n8Gget+REaD-c8vT8Ht_AzOY0kXA_uc674LOyvVw@mail.gmail.com>
 <20220829204202.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830105324.GA71266@lothringen>
 <20220830114343.GS6159@paulmck-ThinkPad-P17-Gen-1>
 <20220830160316.GC71266@lothringen>
 <20220830162244.GA73392@lothringen>
 <Yw4+g/0yEf7fpHrh@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw4+g/0yEf7fpHrh@pc636>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 06:44:51PM +0200, Uladzislau Rezki wrote:
> Hello, Frederic.
> 
> > 
> > Although who knows, may be some periodic file operation while idle are specific
> > to Android. I'll try to trace lazy callbacks while idle and the number of grace
> > periods associated.
> > 
> > 
> Everything related to lazy call-backs is about not waking "nocb"
> kthreads in order to offload one or i should say few callbacks
> because it is more or less useless. Currently if incoming callback
> is the only one, it will kick a GP whereas a GP will kick nocb_kthread
> to offload.

Not sure this is only about not waking "nocb" kthreads. The grace period
kthread is also awaken in !NOCB and has quite some work to do. And there,
having a server expands the issue because you may have a lot of CPUs's extended
quiescent states to check.

Also in !NOCB, pending callbacks retain the timer tick of a CPU (see
rcu_needs_cpu()), and cpuidle relies on the tick to be stopped before
allowing the CPU into low power mode. So a lazy callback may delay a CPU from
entering into low power mode for a few milliseconds.

And I can observe those retained ticks on my idle box.

Thanks.
