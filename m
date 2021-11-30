Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989AD462DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbhK3Hnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:43:40 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35616 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbhK3Hni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:43:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5D73DCE1805;
        Tue, 30 Nov 2021 07:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E728C53FC7;
        Tue, 30 Nov 2021 07:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638258015;
        bh=8wHaU3NHGbY/iJw1XdoqJNIjIYIPqE1uNtdpLBq7lZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7aIryWTg2VKm7DFY10PkVCnbWl2pWL06C32W6i0wOuJGyLfioy46rnZyBHd48U8C
         tVfm3Iq2TmxEOUz8xCaGUGKHgDmrEYLhGeGDHdEaEU/YNrZpKaeCL0NI65FM2SxCzq
         FDMsDfa8kp9N2fD8B3FmuOG5ZJd1VHbf3VojyOf5BaOMJygnYi576xjq70fu7YZOLL
         IiJDbuJpURfiGakdXXxy/DzI1BlRDWNBu6MfjmVW53vaWToH+yWUa+hn+wPZe2Mm/R
         40SPmFHryI3/FMGl3GAsXllhmUHOHFygjXMGMD5JzOQ59zWk5srOahAsmOM+kxl/zp
         +CnvY7HzlrDhg==
Date:   Mon, 29 Nov 2021 23:40:13 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 3/3] blk-crypto: show crypto capabilities in sysfs
Message-ID: <YaXVXU77yvKUyVwg@sol.localdomain>
References: <20211130040306.148925-1-ebiggers@kernel.org>
 <20211130040306.148925-4-ebiggers@kernel.org>
 <8745aed7-d4b6-eb8d-60ad-f4d768d62a62@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8745aed7-d4b6-eb8d-60ad-f4d768d62a62@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 07:49:54AM +0100, Hannes Reinecke wrote:
> >    - "modes" is a sub-subdirectory, since there may be multiple supported
> >      crypto modes, and sysfs is supposed to have one value per file.
> > 
> Why do you have a sub-directory here?
> From what I can see, that subdirectory just contains the supported modes, so
> wouldn't it be easier to create individual files like 'mode_<modename>'
> instead of a subdirectory?

It is a group of attributes, so it makes sense to group them together rather
than put them all in the parent directory alongside other attributes.  It also
allows the use of proper names like "AES-256-XTS" rather than weird names like
"mode_AES-256-XTS" or "mode_aes_256_xts".

- Eric
