Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B424A74CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345530AbiBBPli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiBBPlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:41:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356C4C061714;
        Wed,  2 Feb 2022 07:41:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE497B82FB3;
        Wed,  2 Feb 2022 15:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91563C004E1;
        Wed,  2 Feb 2022 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643816494;
        bh=q0vtIwN6HPkWQOS4+eyubzHjbM7ri9+tcZROTO3idNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQFpyvzW+1ECeXH6pbXWrACYdlNLEh5hMaYxHQmnjbwBPYvuTmqBLFLTfmxiNf7bb
         5rIr1OakamGjK6T4tjEi5aCY6PZQX22APOgybADtQHMPmChGqjTKClxYPJW+Jgm8Pi
         2qtPwC2W1/RsCopYysJzyLMOhJ1RdoQZtGXKTp3esCouPqPNrf4PJcVgiORgBO5lNC
         X/4Idr6bB47BJO0VqXg9Tyr+CgI5vruq+i/sTGqS9QsS2ZPbQoNXM9yAO7+GgwXrBX
         LoQWddPi+52XF+MgyyntkSVP/Xoe4j6IjNjqBsjkrs1Er9LUoGzwYBdJb05cE3SB5k
         xIebLutsaw99Q==
Date:   Wed, 2 Feb 2022 07:41:31 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv2 7/7] nvme: add support for enhanced metadata
Message-ID: <20220202154131.GA3077632@dhcp-10-100-145-180.wdc.com>
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-8-kbusch@kernel.org>
 <aaf56d4b-8554-e677-119e-9d23c921fe0a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf56d4b-8554-e677-119e-9d23c921fe0a@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 02:28:53PM +0100, Hannes Reinecke wrote:
> On 2/1/22 20:01, Keith Busch wrote:
> > +			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> > +			break;
> > +		case NVME_NVM_NS_64B_GUARD:
> > +			integrity.profile = &nvme_pi_type1_crc64

I just noticed this should be type3, not type1...

> > +			integrity.tag_size = sizeof(u16) + 6;
> > +			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> > +			break;
> > +		default:
> > +			integrity.profile = NULL;
> > +			break;
> > +		}
> >   		break;
> >   	case NVME_NS_DPS_PI_TYPE1:
> >   	case NVME_NS_DPS_PI_TYPE2:
> > -		integrity.profile = &t10_pi_type1_crc;
> > -		integrity.tag_size = sizeof(u16);
> > -		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> > +		switch (ns->guard_type) {
> > +		case NVME_NVM_NS_16B_GUARD:
> > +			integrity.profile = &t10_pi_type1_crc;
> > +			integrity.tag_size = sizeof(u16);
> > +			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
> > +			break;
> > +		case NVME_NVM_NS_64B_GUARD:
> > +			integrity.profile = &nvme_pi_type1_crc64;
> > +			integrity.tag_size = sizeof(u16);
> 
> Is that correct? Shouldn't it be '8' like in the above case?

For type1 and 2, I believe tag_size refers to the "application" tag,
which is 2 bytes here.

The reason it is 8 bytes for type3 is because there is no ref tag, so
that portion of the metadata becomes part of the opaque application
tag_size.

> > @@ -3104,7 +3218,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
> >   	if (ret < 0)
> >   		return ret;
> > -	ret = nvme_configure_acre(ctrl);
> > +	ret = nvme_configure_host_options(ctrl);
> >   	if (ret < 0)
> >   		return ret;
> 
> This could be made into a separate patch, is it's not directly related to PI
> support.

Well, the driver can't read the new PI formats without enabling host
supported features for it. Enabling the feature tells the controller
we're going to check for it, so I don't think we could reasonably split
this part into a prep patch from the part that sets up the PI formats.
