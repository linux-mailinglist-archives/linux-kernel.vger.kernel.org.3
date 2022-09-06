Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAD35AE38B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbiIFIzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbiIFIzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:55:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB96119288;
        Tue,  6 Sep 2022 01:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52B8E61350;
        Tue,  6 Sep 2022 08:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728B5C433D6;
        Tue,  6 Sep 2022 08:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662454515;
        bh=A8VKRtYKUm9wCQHpRouUBvdnM8FexdjJBSs3MkiJec0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JcReit0zD6HMNAAudT8BsvNj5dLWEg+F9ELdMbYV8+ZvzNoGWyUBt2Kl5DBs0ScUt
         HvEVJ0PbOz4tQeszOR8rIrZTGXx7gtRARIB5HIsMQBZUhb3VEetwbskgz6OUlhTawv
         HjbCrm/3B2u/Ipi/bKUvIsWeQZPjFfWXim362y96yLir6nWGCbnugK8URcjcVT8KsN
         5rIDdaDl7czGsGLcznKSwBKhIxM4ILt0nhBOitG0vRlpf8xoC93SFNY2t12tPkgaA3
         HDeTUZ9D7QzAxjflfmX9Ly8+eWN/GkhBl360v+9+Kxr/NH9vX4nPpzJgGgr5ZPmU5l
         HsqN9sqKgrrow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 445B55C0834; Tue,  6 Sep 2022 01:55:12 -0700 (PDT)
Date:   Tue, 6 Sep 2022 01:55:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <20220906085512.GI4315@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <67122ae3-d69e-438c-18fc-a8de6e40201e@joelfernandes.org>
 <20220905125949.GA173859@lothringen>
 <d82fec15-af9a-6ff6-69dd-a315cdca9892@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d82fec15-af9a-6ff6-69dd-a315cdca9892@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 04:32:26PM -0400, Joel Fernandes wrote:
> 
> 
> On 9/5/2022 8:59 AM, Frederic Weisbecker wrote:
> > I'd rather see an updated patch (not the whole patchset but just this one) rather
> > than deltas, just to make sure I'm not missing something in the whole picture.
> > 
> > Thanks.
> 
> There is also the previous patch which needs a fix up you suggested.
> 
> I will reply to individual patches with in-line patch (for you), as well as
> refreshing whole series since it might be easier for Paul to apply them together.

To say nothing of the greater probability that the result will match
your intent.  ;-)

							Thanx, Paul
