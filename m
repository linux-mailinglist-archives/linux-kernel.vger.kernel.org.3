Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E825059B0BD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 00:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiHTWOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 18:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiHTWOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 18:14:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249242ED6A;
        Sat, 20 Aug 2022 15:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF80FB80022;
        Sat, 20 Aug 2022 22:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F80C433D7;
        Sat, 20 Aug 2022 22:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661033679;
        bh=Ixgj3jT3DQ1MXHhPNgXRORRDoTHm5QD9Q6G0pHrQczg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L4RhaSIbm4f2/Gbz+3fpyr1ld7m2UpUPB3QHpWjBabYUvfbxjDgKYsuKdIYL3KzpP
         hLxQNtEsUq/3NRZvhnArW2SWH0HAuN2C40LYPz7047G8zH4tfLRMVxVzD4Rc+j7X/S
         MPfGh+9MV+2qkdOQkTgWQb0Q3/mGkqKe9Qn+W4mQ=
Date:   Sat, 20 Aug 2022 15:14:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     matoro <matoro_mailinglist_kernel@matoro.tk>
Cc:     Sergei Trofimovich <slyich@gmail.com>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] ia64: fix clock_getre(CLOCK_MONOTONIC) to report ITC
 frequency
Message-Id: <20220820151438.d55718d341df99d5747caebb@linux-foundation.org>
In-Reply-To: <6d07209d000b671a3bc48003905652e8@matoro.tk>
References: <20220815054944.4130786-1-slyich@gmail.com>
        <20220817122103.ecbd08bd545385e5bf8e0d72@linux-foundation.org>
        <6d07209d000b671a3bc48003905652e8@matoro.tk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 17:57:42 -0400 matoro <matoro_mailinglist_kernel@matoro.tk> wrote:

> Hi Andrew, I came up with the prototype for this patch, but it was based 
> entirely on Sergei's investigation which was documented in 
> https://bugs.gentoo.org/596382.  I asked him to send it upstream because 
> I'm unable to attach my realname to it due to my job.

In that case it's unclear that your Signed-off-by: is appropriate?

: Developer's Certificate of Origin 1.1
: ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
: 
: By making a contribution to this project, I certify that:
: 
:         (a) The contribution was created in whole or in part by me and I
:             have the right to submit it under the open source license
:             indicated in the file; or
: 
:         (b) The contribution is based upon previous work that, to the best
:             of my knowledge, is covered under an appropriate open source
:             license and I have the right under that license to submit that
:             work with modifications, whether created in whole or in part
:             by me, under the same open source license (unless I am
:             permitted to submit under a different license), as indicated
:             in the file; or
: 
:         (c) The contribution was provided directly to me by some other
:             person who certified (a), (b) or (c) and I have not modified
:             it.
: 
:         (d) I understand and agree that this project and the contribution
:             are public and that a record of the contribution (including all
:             personal information I submit with it, including my sign-off) is
:             maintained indefinitely and may be redistributed consistent with
:             this project or the open source license(s) involved.


>  I can place a 
> signed-off-by with my handle but I understand that's normally against 
> kernel policy which is why I didn't.  Either way the bulk of the work 
> belongs to Sergei, I just scribbled it down, and he cleaned it up for 
> this submission.

I think I'll switch it to a Cc: :)
