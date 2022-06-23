Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB72556FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiFWBPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbiFWBPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:15:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2C442A05;
        Wed, 22 Jun 2022 18:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 881DC61C17;
        Thu, 23 Jun 2022 01:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03F4C34114;
        Thu, 23 Jun 2022 01:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655946937;
        bh=xqcTL/3jppseog32Q/cRYr4hD4nyTzEcHPyEaxWsfws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTekgcxCVKrsc4qj00SGAisdR2dSQReWHffNPc1KQQ7GBWCEghLaY0477f7kTfhgy
         Uy5f97iPZjBj6krAoV5zHx9maKa4NnTlRiGeuN3e2xxCZiKkECiFVAaIXqIklGae2y
         C1jL4JPY/ShldmiQT64nGGq3f6WKEUFCauc/3yUFUNDp6ee7qVMB0zBFQ+uPMwP7RN
         tpBdeAUYo50BeKWquBdipibso009OAtsKe0ucHJmwg2OJj2DjIH9pkxTUHxfgp2FrF
         mKDqMIgdINbEPwd4wIs+FylrW55a4asIYX/jmvGz4HE06Jlm1pj2t9n2kH1l8Z0LFA
         0GYbuHYtxiSzQ==
Date:   Wed, 22 Jun 2022 18:15:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Stephen Zhang <starzhangzsd@gmail.com>
Cc:     dchinner@redhat.com, zhangshida <zhangshida@kylinos.cn>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3] xfs: add check before calling xfs_mod_fdblocks
Message-ID: <YrO+uap429yrLKD6@magnolia>
References: <20220621084238.1235880-1-zhangshida@kylinos.cn>
 <YrKdZc0fBBDWGjld@magnolia>
 <CANubcdXyM2t0M0Ks3=6Hm12_SVm50vGaTBboj5CBF2LygOkUog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANubcdXyM2t0M0Ks3=6Hm12_SVm50vGaTBboj5CBF2LygOkUog@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 01:57:31PM +0800, Stephen Zhang wrote:
> > I understand that calling __xfs_ag_resv_init on an AG with a maximally
> > sized data structure can result in @hidden_space being zero here, but
> > why does that matter enough to change the code?  Are you experiencing
> > problems when this happens?  Unnecessary slowdowns at mount time?
> > Something else?
> >
> > This is v3 of a patch and I still can't tell why I should care ...?
> 
> After applying this patch, we can avoid to call xfs_mod_fdblocks when
> delta equals 0. So we can reduce unnecessary operations here.

Yeah, I get that, but what is the real world impact of those unnecessary
operations?  Have you run fstests to make sure this change doesn't trip
over some weird subtlety in the code?  Do the anticipated benefits
justify diverting my time to figuring out if we've really covered all
the corner cases?

IOWS: don't waste our time on theoretical improvements.  There are
/plenty/ of things in 5.19 that need real attention, like generic/522
corrupting things and recoveryloop tests that trip over log recovery.

--D
