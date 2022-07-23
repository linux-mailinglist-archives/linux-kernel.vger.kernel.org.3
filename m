Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585F457EFC8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbiGWOnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiGWOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:43:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2752E1C915;
        Sat, 23 Jul 2022 07:43:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5CCA60B15;
        Sat, 23 Jul 2022 14:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB44C341C0;
        Sat, 23 Jul 2022 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658587395;
        bh=K8azZb2qkyv6voRZ6WF1fjauRYoudrM7tfG/bw1s03g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCcdBKY2vICpMx1OoWFd+YSvcsmnePg56LwozW2WDLrRKMPZd3OBSvjuIx2bsyshJ
         DvTDIHSvZLRyQ45A2C+i4WbsfUhmYpBWD5MejPbqZrY2ZF3t9UO4NeTw3pHfO6HzZP
         +77tmypez5z4rah/9I3tF7mm55oSAA5jcxi86Mu4=
Date:   Sat, 23 Jul 2022 16:43:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        keyrings <keyrings@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] keys/keyctl: Use kfree_rcu instead of kfree
Message-ID: <YtwI/3/Qp3lSKuls@kroah.com>
References: <20220723135035.199188-1-code@siddh.me>
 <YtwAHGISvlgXgXZM@kroah.com>
 <1822b7c129a.14411444236159.6380883938307880248@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1822b7c129a.14411444236159.6380883938307880248@siddh.me>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 08:05:27PM +0530, Siddh Raman Pant wrote:
> On Sat, 23 Jul 2022 19:35:16 +0530  Greg KH <gregkh@linuxfoundation.org> wrote:
> > That does not explain why this change is needed.  What problem does this
> > solve?  Why use RCU if you don't have to?  What functionality did you
> > just change in this commit and why?
> 
> We can avoid a race condition wherein some process tries to access them while
> they are being freed. For instance, the comment on `watch_queue_clear()` also
> states that:
>         /*
>          * Remove all the watches that are contributory to a queue.  This has the
>          * potential to race with removal of the watches by the destruction of the
>          * objects being watched or with the distribution of notifications.
>          */
> And an RCU read critical section is initiated in that function, so we should
> use kfree_rcu() to not unintentionally free it while it is in the critical
> section.

You need to explain all of this in a changelog text.  Don't say what you
do, but say why you are doing it.

> > And how was this tested?
> 
> It compiles locally for me, and I used syzbot on this along with testing the
> other `watch_queue_clear` patch, which generated no errors.

How does the watch queue stuff relate to this keyctl logic?

Again, be specific as to why you are doing things.

thanks,

greg k-h
