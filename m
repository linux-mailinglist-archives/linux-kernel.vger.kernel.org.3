Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D953D4C646B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiB1IMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiB1IL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:11:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCB2692B9;
        Mon, 28 Feb 2022 00:11:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68594B80E47;
        Mon, 28 Feb 2022 08:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2506C340E7;
        Mon, 28 Feb 2022 08:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646035878;
        bh=y1tdMpsiRpffhOx2vBGdYD8HZmjyMt0V4WvXxZ/HDI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+KDVirnh3eOYCFV8FXguYwOhS1tTrAiJ9F0r9TEI1UpdiS6lrWv/9qsq+Z7R/F8c
         bZdQLocTorrgNjW1WC7kweF/RNvrUKPNhmWTYwFwMOKrmMLK5+120uQ6abXSs3S2vR
         +OWwJrC6zjIjrqS72GmHxVXQzFpQqOp5lU/D03q9Dkwg0o+jwIbS+dSeia5FvTnFQf
         4V+bZGIfy/88ds4iki52ciHTi1GXFyz222Ssuh9RbjH0aL0vAJdlW1GE7eHRF2fY03
         9iVW81iOYpG++HKlentvm3Vp/hOT9P12a3Ko93wjxX3eZy0PlpsU5BEU4SEtqrIk+/
         sF/PnIeE17wwQ==
Date:   Mon, 28 Feb 2022 00:11:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v4 0/3] block: show crypto capabilities in sysfs
Message-ID: <YhyDpNN/Yoajneg/@sol.localdomain>
References: <20220124215938.2769-1-ebiggers@kernel.org>
 <YhL3obBiHO92EcEc@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhL3obBiHO92EcEc@sol.localdomain>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2022 at 06:23:29PM -0800, Eric Biggers wrote:
> On Mon, Jan 24, 2022 at 01:59:35PM -0800, Eric Biggers wrote:
> > This series adds sysfs files that expose the inline encryption
> > capabilities of request queues.
> > 
> > Patches 1 and 2 are some related cleanups for existing blk-sysfs code.
> > Patch 3 is the real change; see there for more details.
> > 
> > This series applies to v5.17-rc1.
> > 
> > Changed v3 => v4:
> >    - Reworded a comment in patch 2.
> >    - Updated dates in sysfs documentation.
> >    - Added more Reviewed-by tags.
> > 
> > Changed v2 => v3:
> >    - Moved the documentation into Documentation/ABI/stable/sysfs-block,
> >      and improved it a bit.
> >    - Write "/sys/block/" instead of "/sys/class/block/".
> >    - Added Reviewed-by tags.
> > 
> > Changed v1 => v2:
> >    - Use sysfs_emit() instead of sprintf().
> >    - Use __ATTR_RO().
> > 
> > Eric Biggers (3):
> >   block: simplify calling convention of elv_unregister_queue()
> >   block: don't delete queue kobject before its children
> >   blk-crypto: show crypto capabilities in sysfs
> > 
> 
> Any more feedback on this?
> 

Jens, can you apply this for 5.18?  Is there anything else you're waiting for?

- Eric
