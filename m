Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AAF589742
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiHDFHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237625AbiHDFHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:07:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB14E2250C;
        Wed,  3 Aug 2022 22:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C52961852;
        Thu,  4 Aug 2022 05:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FCFC433C1;
        Thu,  4 Aug 2022 05:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659589654;
        bh=dntzueFUayg8EwtWI0uD8IPo2JnX77id+CydyT8ad2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afgqW7AmIsubIaZXxhWapTsgZQ8aMbjZDKgvMoR8wisyjeNYlL/zA/ydpJOh7BMCQ
         BNq6f5toPXQQSab81c6m/cBha4GnfTKoYsC2FQD9A63nkdCSgd98Bx8d2qCH3nIzBM
         6uNRq+8kRY7kL6pGHie22QuIpD7zabm+/GV/461nwgIf0XTgk2noxdBBRPHBZGZ8y+
         6TFIkJNGHDFoJzwPFf8RNERe+NNdFljC5AECmF3dtle7lW1Zz36Zb8MiiCHH1TBML9
         xQqcco3wVr/iLI304DtdXx93lfIw1FzEucxhmmAlP0tpusQ/ua/0oqKgPta91HdZf/
         6h76lhzzZ3MlQ==
Date:   Wed, 3 Aug 2022 22:07:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Sherry Yang <sherry.yang@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        "chandanrlinux@gmail.com" <chandanrlinux@gmail.com>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] xfs: initialize error in xfs_defer_finish_one
Message-ID: <YutUFo9nB1ubWtb6@magnolia>
References: <20220801190311.65703-1-sherry.yang@oracle.com>
 <20220801204902.GA3600936@dread.disaster.area>
 <Yun6I/drpxG4L4RO@magnolia>
 <DB9D3780-165D-4E49-823D-4D5253E64905@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9D3780-165D-4E49-823D-4D5253E64905@oracle.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 11:42:21PM +0000, Sherry Yang wrote:
> 
> > On Aug 2, 2022, at 9:31 PM, Darrick J. Wong <djwong@kernel.org> wrote:
> > 
> > On Tue, Aug 02, 2022 at 06:49:02AM +1000, Dave Chinner wrote:
> >> On Mon, Aug 01, 2022 at 12:03:11PM -0700, Sherry Yang wrote:
> >>> Path through non-void function 'xfs_defer_finish_one' may return error
> >>> uninitialized if no iteration of 'list_for_each_safe' occurs. Fix this
> >>> by initializing error.
> >> 
> >> I didn't think this situation was possible - how do we get deferred
> >> work queued with no work items on it?
> >> 
> >> If we can return an uninitialised error from xfs_defer_finish_one()
> >> because of an empty queued work, then something else has gone wrong
> >> earlier in the work deferral process. If this can actually happen,
> >> then we need to fix whatever is creating the empty work rather than
> >> paper over it by initialising the error being returned for empty
> >> works...
> > 
> > /me bets this is a response to a static checker that doesn't know that
> > list_empty(&dfp->dfp_work) == false in all circumstances.  It's not
> > possible for tp->t_dfops to contain an xfs_defer_pending with no work
> > items.
> 
> Hi Darrick, 
> 
> You’re correct. This is a false positive bug detected by our static code 
> analysis tool. Sorry for the noise.

Well, thank /you/ for running smatch/sparse/whatever on the XFS code
base.  Let us know if you find any other oddities, since it does tend to
find things every now and then. :)

--D

> Sherry
> > 
> > --D
> > 
> >> Cheers,
> >> 
> >> Dave.
> >> -- 
> >> Dave Chinner
> >> david@fromorbit.com
> 
