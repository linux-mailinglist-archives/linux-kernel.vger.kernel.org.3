Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12994E4459
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbiCVQkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbiCVQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:39:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35F25DA7F;
        Tue, 22 Mar 2022 09:38:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7615561380;
        Tue, 22 Mar 2022 16:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D083BC340EC;
        Tue, 22 Mar 2022 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647967107;
        bh=8ch5mqYdbCJuCsCkXweGICnpYvia0/ZTsJXceSH6eJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6EFRFcbqq0MH4RGKDBcvnPOBumFG3JKuY9d6rv8yWJ7OdUNSxZrGyNpY447B2ZdY
         9fqiJPPSMkduuWg8QLOuH6GGXhA5vISLYL5SDveJ6DwlVSqjI5KuhXf/sRqX9uDrDx
         1CZHEYa9l+zHfg4VJwJwl1242arMJHYi9MyCd9ZaOsXO9CqAv0seQDrkLSVIVLYNIe
         pqpyGrmoX7R7H3g4jU3784353OrW8KQhqyT9W1dKs89OwmHQTSruX+BtSAOIWd4uw5
         /6fRb48h8ITB0j9iUXq9jb3WBSo9NI38iMhHQYBBSNraMCkLHlcIjZ/TAckGe8YwVR
         l0PjT/7EaJT9A==
Date:   Tue, 22 Mar 2022 09:38:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [kbuild] [djwong-xfs:djwong-wtf 349/351]
 fs/xfs/xfs_bmap_util.c:1372 xfs_map_free_extent() warn: missing error code
 'error'
Message-ID: <20220322163827.GQ8241@magnolia>
References: <202203190831.AYu7l0vX-lkp@intel.com>
 <20220321215908.GL8241@magnolia>
 <20220322054726.GR336@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322054726.GR336@kadam>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 08:47:26AM +0300, Dan Carpenter wrote:
> On Mon, Mar 21, 2022 at 02:59:08PM -0700, Darrick J. Wong wrote:
> > On Mon, Mar 21, 2022 at 10:33:02AM +0300, Dan Carpenter wrote:
> > > b82670045aab66 Darrick J. Wong 2022-01-06  1365  
> > > b82670045aab66 Darrick J. Wong 2022-01-06  1366  	error = xfs_alloc_find_freesp(tp, pag, cursor, end_agbno, &len);
> > > b82670045aab66 Darrick J. Wong 2022-01-06  1367  	if (error)
> > > b82670045aab66 Darrick J. Wong 2022-01-06  1368  		goto out_cancel;
> > > b82670045aab66 Darrick J. Wong 2022-01-06  1369  
> > > b82670045aab66 Darrick J. Wong 2022-01-06  1370  	/* Bail out if the cursor is beyond what we asked for. */
> > > b82670045aab66 Darrick J. Wong 2022-01-06  1371  	if (*cursor >= end_agbno)
> > > b82670045aab66 Darrick J. Wong 2022-01-06 @1372  		goto out_cancel;
> > > 
> > > This looks like it should have an error = -EINVAL;
> > 
> > Nope.  If xfs_alloc_find_freesp moves @cursor goes beyond end_agbno, we
> > want to exit early so that the xfs_map_free_extent caller will return to
> > userspace.
> > 
> > --D
> 
> I'm generally pretty happy with this static checker rule.  Returning
> success on a failure path almost always results if something bad like a
> NULL deref or a use after free.  But false positives are a real risk
> because it's tempting to add an error code to this and introduce a bug.
> 
> Smatch will not print the warning if error is set within 4 lines of the
> goto.
> 	error = 0;
> 	if (*cursor >= end_agbno)
> 		goto out_cancel;

The trouble is, if I do that:

	error = xfs_alloc_find_freesp(...);
	if (error)
		goto out_cancel;

	error = 0;
	if (*cursor >= end_agbno)
		goto out_cancel;

then I'll get patch reviewers and/or tools complaining about setting
error to zero unnecessarily.  Either way we end up with a lot of code
golf for something the compiler will probably remove for us.

Question: Can sparse detect that the if() test involves a comparison
between a non-pointer function argument and a dereferenced pointer
argument?  Would that be sufficient to detect functions that advance a
cursor passed in by the caller and return early when the cursor moves
outside of a range also specified by the caller?

--D

> Another option is that people have started adding comments to these
> blocks in response to the checker warning.
> 
> Or if you had a different idea about how to silence the checker warning
> I can also probably implement that.
> 
> regards,
> dan carpenter
> 
> 
