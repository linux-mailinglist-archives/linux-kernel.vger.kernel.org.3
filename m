Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2C58668F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiHAIra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiHAIr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:47:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB5032DB5;
        Mon,  1 Aug 2022 01:47:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C80B61008;
        Mon,  1 Aug 2022 08:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E94C433D6;
        Mon,  1 Aug 2022 08:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659343646;
        bh=xbJSzaTJLqf/iz1sUggkR2WIMbRuPaCeSIwGgeDNNw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEZ3ZGt7IBgk3rFNv6L+SpJp9GAYTM2u17D05UdDWVsQpSAQ+t6TkEM/juvVJLwBT
         YlBVqOlMJN8w4yn+p5K0j4SpZDcqRQellWTl2iFQM40T2SXcZEVIJfUWs4lXMuTCb6
         CSR1l9mRovyfJWAfhe4BuHHhPoQMXSOxUhs7RnXQ=
Date:   Mon, 1 Aug 2022 10:47:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Dipanjan Das <mail.dipanjan.das@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+c70d87ac1d001f29a058 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        Marius Fleischer <fleischermarius@googlemail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
Message-ID: <YueTG6Nla1pMcW/1@kroah.com>
References: <1822b768504.1d4e377e236061.5518350412857967240@siddh.me>
 <20220723135447.199557-1-code@siddh.me>
 <Ytv/4Tljvlt0PJ2r@kroah.com>
 <3558070.1658933200@warthog.procyon.org.uk>
 <182407602ce.190e58816827.7904364186178466266@siddh.me>
 <20220731181131.GB3569921@berlinger>
 <1825594fdb6.52eb2a02235647.5426665702277259900@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1825594fdb6.52eb2a02235647.5426665702277259900@siddh.me>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 12:16:43AM +0530, Siddh Raman Pant wrote:
> On Sun, 31 Jul 2022 23:41:31 +0530  Dipanjan Das <mail.dipanjan.das@gmail.com> wrote:
> > On Wed, Jul 27, 2022 at 09:50:52PM +0530, Siddh Raman Pant wrote:
> > > Thank you for explaining it!
> > > 
> > > I will send a v3. Should I add a Suggested-by tag mentioning you?
> > 
> > Sorry for jumping in.
> > 
> > We have reported the same bug in kernel v5.10.131 [https://lore.kernel.org/all/CANX2M5bHye2ZEEhEV6PUj1kYL2KdWYeJtgXw8KZRzwrNpLYz+A@mail.gmail.com]. We have been suggested to join this discussion so that we can have appropriate meta-information injected in this patch’s commit message to make sure that it gets backported to v5.10.y.  Therefore, we would like to be in the loop so that we can offer help in the process, if needed.
> > 
> 
> As you are suggesting for backporting, I should CC the stable list, or mail
> after it gets merged. You have reproduced it on v5.10, but the change seems to
> be introduced by c73be61cede5 ("pipe: Add general notification queue support"),
> which got in at v5.8. So should it be backported till v5.8 instead?

There are no active supported kernels other than the ones listed on
kernel.org, so 5.8 doesn't make much sense here, only 5.10 and 5.15 and
5.18 at the moment.

thanks,

greg k-h
