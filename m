Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1255246F7E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 01:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhLJAP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 19:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhLJAP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:15:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5782C061746;
        Thu,  9 Dec 2021 16:12:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96A2CB82738;
        Fri, 10 Dec 2021 00:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD31C004DD;
        Fri, 10 Dec 2021 00:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639095140;
        bh=4aKAeoN4suDpHo5yFRX2emDEEMK5Gvc6Tr3BuzrOKRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXJyunXAA48u8yap72Qy/XKfd+O3idWCcn7hc/SAwleagOyaEeJhK2XKk2d9HSWiJ
         fWImO6weRdLfFrcDFJM9p/38BmNCLTNC4c2V+sl7FBwsN08kYDSWwtEG/Cn640fjk5
         fDQgLTR32tP+LMLkd8LrCg1Hhvzz9jmV65YmaQrEusvP4CeB0w+l4/FSSbgDJdZbkV
         mNC7jGeeeO2asyHwzuTL/J70/l9D/EXR7PW/RjKaKS2ULMivNWtULeO4NZ1w1eP8Mi
         iix4h2Bk/eDW1teGlhIKZK+V/q1TjK1owS9zqoYTIJkuu+XjwDuGdlttdlCUTZQgKm
         UWdCu26V580fg==
Date:   Thu, 9 Dec 2021 16:12:18 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 3/3] blk-crypto: show crypto capabilities in sysfs
Message-ID: <YbKbYsFFW77AxYEO@sol.localdomain>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-4-ebiggers@kernel.org>
 <6ff4d074-7508-4f4c-de06-f36899668168@acm.org>
 <YbKT/lcp6iZ+lD4n@sol.localdomain>
 <de725f08-2f98-56fc-8305-baf93f867af3@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de725f08-2f98-56fc-8305-baf93f867af3@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 04:02:07PM -0800, Bart Van Assche wrote:
> On 12/9/21 3:40 PM, Eric Biggers wrote:
> > On Thu, Dec 09, 2021 at 02:51:59PM -0800, Bart Van Assche wrote:
> > > Has it been considered to report each value separately, e.g. 512\n4096\n
> > > instead of 0x1200\n?  I think the former approach is more friendly for shell
> > > scripts.
> > 
> > I don't think that would be acceptable to the sysfs folks, as they only allow
> > one value per file.  I suppose a bitmask could be viewed as unacceptable too,
> > but it seemed to make sense here, given that the data unit sizes are always
> > powers of 2, and the hardware reports them as bitmasks.
> 
> In case Greg wouldn't have the time to reply, I think the following quote from
> Documentation/filesystems/sysfs.txt is relevant in this context: "Attributes
> should be ASCII text files, preferably with only one value per file. It is
> noted that it may not be efficient to contain only one value per file, so it is
> socially acceptable to express an array of values of the same type."
> 
> Thanks,

It should be, but I thought that Greg had complained about people doing that
before, and required strictly one value per file.  So we would need his opinion.

Note that a bitmask isn't hard to handle in a shell script:

	mask=$(</sys/block/sda/queue/crypto/modes/AES-256-XTS)
	if (( mask & 4096 )); then
		echo "4096-byte data units supported"
	fi

But I could see how someone could prefer something like

	if grep -q '\<4096\>' /sys/block/sda/queue/crypto/modes/AES-256-XTS; then
		echo "4096-byte data units supported"
	fi

- Eric
