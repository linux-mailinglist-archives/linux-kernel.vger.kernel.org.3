Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C5F58B78E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 20:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiHFSRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 14:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiHFSRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 14:17:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423B7E09E;
        Sat,  6 Aug 2022 11:17:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED9FBB80025;
        Sat,  6 Aug 2022 18:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58426C433C1;
        Sat,  6 Aug 2022 18:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659809830;
        bh=QHRRYvNA6G97q4w79f4DS/RKd/lOD5ATdLWGXP3ojas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebyKoDUJuSx4P+31hLjPqIjnDTJ65Xj0SY4Lqs6DcZAcPUNGZocqZY1eqAFA2tvrg
         8tB7vZZS1SVnT1UnyeYJPTRvg1TwJDBlP9GVBXAbSc++Uxin1T/aTqf5oy1kp7x4DM
         6P4I01ST2PMpVWA6/usd/b7Sgvz8f+D420ZCHhrFkyb/i7C9QaK8cO9IChT3ZVliZe
         nz6Zi2SOEtdXhb1WZYgQAJA8LPFl48rcuIHNfqPQ/M2Vix68NrW+8w1RsHmlDtx6u7
         GjwI0Fmzn5cHWV6dcqM2x2f3INo8v9CMwLEe4wn/OXqf6ZfgxQLeMXaJNg3i+RRubN
         wZcwb9Jh/O7+Q==
Date:   Sat, 6 Aug 2022 21:17:08 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jarkko Sakkinen <jarkko@profian.com>,
        Harald Hoyer <harald@profian.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SE..." 
        <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: ccp: Load the firmware twice when SEV API
 version < 1.43
Message-ID: <Yu6wJKS39HyuD4XN@kernel.org>
References: <20220804010223.3619-1-jarkko@kernel.org>
 <77cbdadb-b86c-f8ab-4992-f1963a9fa1e9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77cbdadb-b86c-f8ab-4992-f1963a9fa1e9@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 09:59:44AM -0500, Tom Lendacky wrote:
> On 8/3/22 20:02, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko@profian.com>
> > 
> > SEV-SNP does not initialize to a legit state, unless the firmware is
> > loaded twice, when SEP API version < 1.43, and the firmware is updated
> > to a later version. Because of this user space needs to work around
> > this with "rmmod && modprobe" combo. Fix this by implementing the
> > workaround to the driver.
> > 
> > Reported-by: Harald Hoyer <harald@profian.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
> > ---
> >   drivers/crypto/ccp/sev-dev.c | 22 +++++++++++++++++++---
> >   1 file changed, 19 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> > index 799b476fc3e8..f2abb7439dde 100644
> > --- a/drivers/crypto/ccp/sev-dev.c
> > +++ b/drivers/crypto/ccp/sev-dev.c
> 
> > @@ -1274,6 +1285,7 @@ void sev_pci_init(void)
> >   {
> >   	struct sev_device *sev = psp_master->sev_data;
> >   	int error, rc;
> > +	int i;
> >   	if (!sev)
> >   		return;
> > @@ -1283,9 +1295,13 @@ void sev_pci_init(void)
> >   	if (sev_get_api_version())
> >   		goto err;
> > -	if (sev_version_greater_or_equal(0, 15) &&
> > -	    sev_update_firmware(sev->dev) == 0)
> > -		sev_get_api_version();
> > +	/*
> > +	 * SEV-SNP does not work properly before loading the FW twice in the API
> > +	 * versions older than SEV 1.43.
> > +	 */
> > +	for (i = 0; i < sev_version_greater_or_equal(0, 15) + sev_version_less(1, 43); i++)
> > +		if (sev_update_firmware(sev->dev) == 0)
> > +			sev_get_api_version();
> 
> I prefer to have this logic in the sev_update_firmware() function.
> 
> And while the loop is correct, it isn't obvious. Something in
> sev_update_firmware() that just does:
> 
> 	ret = sev_do_cmd(SEV_CMD_DOWNLOAD_FIRMWARE, data, &error);
> 
> 	if (!ret && sev_version_greater_or_equal(0, 15) && sev_version_less(1, 43))
> 		ret = sev_do_cmd(SEV_CMD_DOWNLOAD_FIRMWARE, data, &error);
> 
> And place a comment before the second command that references the reason
> for the second download.
 
OK, I'll do that. Thank you.

BR, Jarkko
