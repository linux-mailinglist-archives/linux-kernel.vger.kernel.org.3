Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D6953AB84
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355038AbiFARFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354482AbiFARFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:05:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D36A2057;
        Wed,  1 Jun 2022 10:05:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40F49B81BAF;
        Wed,  1 Jun 2022 17:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D6EC385B8;
        Wed,  1 Jun 2022 17:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654103147;
        bh=8PvTrJ4NZ2k8/lqN9pvyCo5ga1hoTph28CWah3BKaHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7gFQPymOetNwksStQlKw2poXarD4KWfVmz1vQ6rRFq1VrLo3+YIknGZ4gZg63A9u
         x39Q2L6OWmQ/IXy1fzQG76lljCtIDRLl7KsfnSwOC0w2pImiuW49vjJQW6k6tqb0no
         IB83+JbLnrwvToFjC4nAp14S2fObybfWxjg6wZ/wfdDsiPGHlSzKXKH1CGWbYWdd/h
         3lmFAhapCMnWAYM9+9I94zvcavJYY7V5/p6sqp2KkL4c8xJtO6uqMQzrT2/5i4EufZ
         1xSzovur2+pNHV3zMji9beI0MmvyQYlz0YAF2WF16nD0GOaStx6ZzRgaA2mvWg499B
         bUr7GjGEXpbdg==
Date:   Wed, 1 Jun 2022 10:05:45 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
Subject: Re: [PATCH] scsi: ufs: add a quirk to disable FUA support
Message-ID: <YpecaXfIxZBHIcfj@google.com>
References: <20220531201053.3300018-1-jaegeuk@kernel.org>
 <d3038c9e-c9ec-16e9-bad4-8b1de5e23ba6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3038c9e-c9ec-16e9-bad4-8b1de5e23ba6@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01, Adrian Hunter wrote:
> On 31/05/22 23:10, Jaegeuk Kim wrote:
> > UFS stack shows very low performance of FUA comparing to write and cache_flush.
> > Let's add a quirk to adjust it.
> > 
> > E.g., average latency according to the chunk size of write
> > 
> > Write(us/KB)	4	64	256	1024	2048
> > FUA		873.792	754.604	995.624	1011.67	1067.99
> > CACHE_FLUSH	824.703	712.98	800.307	1019.5	1037.37
> 
> Wouldn't it depend on how much data might be in the cache?

I've got this average latency from 100 commands of write+cache_flush vs.
write(FUA). I think the cached data should be the same as this chunk
size.

> Do you have real-world use-cases where the difference is measurable?

I'm approaching this based on 1) f2fs uses FUA for checkpoint and fsync,
and 2) iomap uses FUA for O_DIRECT|O_DSYNC case [1].

[1] https://lore.kernel.org/lkml/20220527205955.3251982-1-jaegeuk@kernel.org/

> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  drivers/scsi/ufs/ufshcd.c | 3 +++
> >  drivers/scsi/ufs/ufshcd.h | 5 +++++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > index 3f9caafa91bf..811f3467879c 100644
> > --- a/drivers/scsi/ufs/ufshcd.c
> > +++ b/drivers/scsi/ufs/ufshcd.c
> > @@ -5035,6 +5035,9 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
> >  	 */
> >  	sdev->silence_suspend = 1;
> >  
> > +	if (hba->quirks & UFSHCD_QUIRK_BROKEN_FUA)
> > +		sdev->broken_fua = 1;
> > +
> >  	ufshcd_crypto_register(hba, q);
> >  
> >  	return 0;
> > diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> > index 94f545be183a..6c480c6741d6 100644
> > --- a/drivers/scsi/ufs/ufshcd.h
> > +++ b/drivers/scsi/ufs/ufshcd.h
> > @@ -602,6 +602,11 @@ enum ufshcd_quirks {
> >  	 * support physical host configuration.
> >  	 */
> >  	UFSHCD_QUIRK_SKIP_PH_CONFIGURATION		= 1 << 16,
> > +
> > +	/*
> > +	 * This quirk disables FUA support.
> > +	 */
> > +	UFSHCD_QUIRK_BROKEN_FUA				= 1 << 17,
> 
> Wouldn't it be more appropriate to make it a UFS_DEVICE_QUIRK_
> since it presumably depends on the UFS device not the host controller?
> 
> Also, as already commented by others, there needs to be a user of
> the quirk

Since I asked SoC vendors can verify the performance with this quirk,
I need to wait for their reply. Meanwhile, I'm willing to disable FUA in Pixel
devices, which I cannot post any patch directly to LKML.

Agreed that, if there's no other user in upstream, I'm okay to drop
this.

> 
> >  };
> >  
> >  enum ufshcd_caps {
