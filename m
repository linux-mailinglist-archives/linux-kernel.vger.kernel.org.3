Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E819E539844
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242698AbiEaUxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiEaUxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:53:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399139CF6C;
        Tue, 31 May 2022 13:53:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD66361323;
        Tue, 31 May 2022 20:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD5BC3411C;
        Tue, 31 May 2022 20:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654030415;
        bh=Omau7Iujh3SBXH38YaZtA++1lnNyLLiJqRL7Ib/B9uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AX2/Q1m71wsiKUH4EqNImGLGUFIS7wUgtI+mW9BZTxGWTgZ+dBHke8Wo2Dzh09yHH
         3Y9OCoutiibNWDinpQesOaQQxS+TsvrAX7/xWuiT/A5bn6o/06PPulnxtEwwe6gY8f
         WGPVpsAGlT8OO41eXjHHexz7BkU1eisoMComzlZUJ9Gn8ub7+G4VHCs7mrEtYbHnVf
         Lmgfz6wFm1954JcD2oI262mhxZrlaeWaD3K77r6VOhnaNzHLa1SmXsJC1n8BQiTLc9
         SSNZBh4O2CkDDfjdxGd9jSskj+/+5CUSapgR93AcrsplNQOb6F/rKRZJm2PRehwy16
         QWEnfe20zauMA==
Date:   Tue, 31 May 2022 13:53:33 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
Subject: Re: [PATCH] scsi: ufs: add a quirk to disable FUA support
Message-ID: <YpaATWTiipNERoVF@google.com>
References: <20220531201053.3300018-1-jaegeuk@kernel.org>
 <YpZ71MU7+DRedq5S@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpZ71MU7+DRedq5S@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31, Eric Biggers wrote:
> On Tue, May 31, 2022 at 01:10:53PM -0700, Jaegeuk Kim wrote:
> > UFS stack shows very low performance of FUA comparing to write and cache_flush.
> > Let's add a quirk to adjust it.
> > 
> > E.g., average latency according to the chunk size of write
> > 
> > Write(us/KB)	4	64	256	1024	2048
> > FUA		873.792	754.604	995.624	1011.67	1067.99
> > CACHE_FLUSH	824.703	712.98	800.307	1019.5	1037.37
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
> >  };
> 
> "Broken" is ambiguous.  IIUC, the issue is that FUA performance is very bad, not
> that it doesn't work.  Can you clarify the intent in the comment?

My intent is FUA was supposed to be better than write+cache_flush.

> 
> Also, this patch does nothing by itself.  Which UFS host driver(s) need this
> quirk bit?  Can you update them to use it?  Or do they all need this, in which
> case a quirk bit would be unnecessary?

Likewise other quick bits, using this is up to SoC or UFS vendors. I
think that combination is up to OEMs who is building the product.

> 
> - Eric
