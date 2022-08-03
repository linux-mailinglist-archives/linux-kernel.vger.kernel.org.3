Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FBF588689
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiHCEbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHCEbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7001F4E873;
        Tue,  2 Aug 2022 21:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07DCD612E4;
        Wed,  3 Aug 2022 04:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65352C433D6;
        Wed,  3 Aug 2022 04:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659501092;
        bh=RXun5C6qA7jQQI2I72/bNDDoxKPWHaRc4EfuqcLowAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WhzkYpLX1hzGXOO1Jw3AF1Pd/TW9ezk3A+J2l+fZELKdb9Ggsn8QOuXYs+IYDBs/m
         9BhnFijXHyIgJtDIi43RA8Woe2/BfT9TAxeIPmpYKJY9M1ipagl3EvWgf43LU30jXt
         tFRrdwTRmJLdvbTCNyT96kDoWmtkwfy7iApzzZrhMQQLCHbzqIF4TQH2FZ0XIRqi/+
         m5GuY42JTY9YLc33tJdbZZFjSzu/7wyAKVSn/2Xqw5mxtkD8svBik/WPIBmNR8Uw7D
         pHfpgeYJXUgSpwzWPZ/RBVkpJy6l08GdpUKWjgpVe8RfSpzuwCFHXOEIimRDKvHTtP
         tFWwzWnKYI0zg==
Date:   Tue, 2 Aug 2022 21:31:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Sherry Yang <sherry.yang@oracle.com>, dchinner@redhat.com,
        allison.henderson@oracle.com, chandanrlinux@gmail.com,
        bfoster@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] xfs: initialize error in xfs_defer_finish_one
Message-ID: <Yun6I/drpxG4L4RO@magnolia>
References: <20220801190311.65703-1-sherry.yang@oracle.com>
 <20220801204902.GA3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801204902.GA3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 06:49:02AM +1000, Dave Chinner wrote:
> On Mon, Aug 01, 2022 at 12:03:11PM -0700, Sherry Yang wrote:
> > Path through non-void function 'xfs_defer_finish_one' may return error
> > uninitialized if no iteration of 'list_for_each_safe' occurs. Fix this
> > by initializing error.
> 
> I didn't think this situation was possible - how do we get deferred
> work queued with no work items on it?
> 
> If we can return an uninitialised error from xfs_defer_finish_one()
> because of an empty queued work, then something else has gone wrong
> earlier in the work deferral process. If this can actually happen,
> then we need to fix whatever is creating the empty work rather than
> paper over it by initialising the error being returned for empty
> works...

/me bets this is a response to a static checker that doesn't know that
list_empty(&dfp->dfp_work) == false in all circumstances.  It's not
possible for tp->t_dfops to contain an xfs_defer_pending with no work
items.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
