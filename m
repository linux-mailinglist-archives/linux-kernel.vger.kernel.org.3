Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCF3589CEA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbiHDNkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbiHDNkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:40:35 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C774A657D;
        Thu,  4 Aug 2022 06:40:34 -0700 (PDT)
Received: from jpiotrowski-Surface-Book-3 (ip-005-146-194-026.um05.pools.vodafone-ip.de [5.146.194.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 022C720FFD69;
        Thu,  4 Aug 2022 06:40:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 022C720FFD69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659620434;
        bh=Wvk7LWnN0rvaXsUOte9cvrwZSRKd0TjIvDD1VIvrzMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZhcDv3iZ9iuFXhM4Qx9qbXf6u5uOak0z8jkeYbGA6Zc5nfdLO3TVkaU7cPyNLABbi
         Auwc9+aRImu/0iF/2UCYjPh00gf9BgLuISJcPOhEsMbQYZo8LEvJWqGaDmbjXl47Z7
         nJDakPwYREHUJqFhkXdKfjFUH10tdG4RaqnZBlFs=
Date:   Thu, 4 Aug 2022 15:39:30 +0200
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <YuvMEm4PwTtSL8Ig@jpiotrowski-Surface-Book-3>
References: <20220804010223.3619-1-jarkko@kernel.org>
 <58e8f9dc-a8d3-a2a5-2dd7-0783355e2567@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58e8f9dc-a8d3-a2a5-2dd7-0783355e2567@amd.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 08:13:35AM -0500, Tom Lendacky wrote:
> On 8/3/22 20:02, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko@profian.com>
> > 
> > SEV-SNP does not initialize to a legit state, unless the firmware is
> > loaded twice, when SEP API version < 1.43, and the firmware is updated
> > to a later version. Because of this user space needs to work around
> > this with "rmmod && modprobe" combo. Fix this by implementing the
> > workaround to the driver.
> 
> The SNP hypervisor patches are placing a minimum supported version
> requirement for the SEV firmware that exceeds the specified version
> above [1] (for the reason above, as well as some others), so this patch
> is not needed, NAK.
> 
> [1] https://lore.kernel.org/lkml/87a0481526e66ddd5f6192cbb43a50708aee2883.1655761627.git.ashish.kalra@amd.com/
> 
> Thanks,
> Tom

Hi Tom,

Is there any particular reason for this restriction? Does SNP not work with API
version <v1.51? Do you have a link to a changelog that describes the changes
between different firmware versions?

Thanks,
Jeremi

> 
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
> > @@ -76,6 +76,9 @@ static void *sev_es_tmr;
> >   #define NV_LENGTH (32 * 1024)
> >   static void *sev_init_ex_buffer;
> > +/*
> > + * SEV API version >= maj.min?
> > + */
> >   static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
> >   {
> >   	struct sev_device *sev = psp_master->sev_data;
> > @@ -89,6 +92,14 @@ static inline bool sev_version_greater_or_equal(u8 maj, u8 min)
> >   	return false;
> >   }
> > +/*
> > + * SEV API version < maj.min?
> > + */
> > +static inline bool sev_version_less(u8 maj, u8 min)
> > +{
> > +	return !sev_version_greater_or_equal(maj, min);
> > +}
> > +
> >   static void sev_irq_handler(int irq, void *data, unsigned int status)
> >   {
> >   	struct sev_device *sev = data;
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
> >   	/* If an init_ex_path is provided rely on INIT_EX for PSP initialization
> >   	 * instead of INIT.
