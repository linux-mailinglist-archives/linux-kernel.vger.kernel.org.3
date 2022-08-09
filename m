Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367D758DFF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346000AbiHITMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346397AbiHITLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:11:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BD22186;
        Tue,  9 Aug 2022 11:58:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BC65B81662;
        Tue,  9 Aug 2022 18:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329C6C433D6;
        Tue,  9 Aug 2022 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660071535;
        bh=XTBFh7yoTFr2i4RUTPJqLED6xHogeLuIDMQ2VyzUQr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZDdgijPBsZ6QGE/PLz0GiaQ/epIcNz9hIhJZ4mkHKcJdpDggaCBPsnAcxUz5RKxy
         gvYvOj7irKjorlSTcQNQw40Ljb8UZWx2kJmHL2WUv/aFjeiJvomtXAJCkW696KM9Ly
         HrAcX3W6FcmBYOcavCbd+yAXCYA5SKNGAXm0SyyL9b8FuWmIkfGHKeyoxwCsiqedBu
         3tQysPMu6ByYQDI+xJolWoUQn7N3ahSgzYhmPyJTikbbyj1oKELQ1aSvxe6p6vFiT+
         iCmOws85RRmGML/SPAdXA6tPD9S/PzpjzmNganj95M3xQqeG5HBpqtb8uyRcfxZScJ
         SOKapxedDSqKw==
Date:   Tue, 9 Aug 2022 21:58:51 +0300
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
Subject: Re: [PATCH] crypto: ccp: Add a quirk to firmware update
Message-ID: <YvKua80NyjOcGgTD@kernel.org>
References: <20220808001537.6479-1-jarkko@kernel.org>
 <0a3a790d-989f-2f76-f636-62fbd925a776@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a3a790d-989f-2f76-f636-62fbd925a776@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 10:57:16AM -0500, Tom Lendacky wrote:
> On 8/7/22 19:15, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko@profian.com>
> 
> Looks good, just some minor commit message and comment changes requested.
> 
> > 
> > A quirk for fixing the committed TCB version, when upgrading from earlier
> > firmware version than 1.33.01. This is a known issue, and the documented
> 
> ", when upgrading from earlier firmware version than 1.33.01" => "when
> upgrading from a firmware version earlier than 1.50"
> 
> > workaround is to load the firmware twice.
> > 
> > The issue realizes in a machine where the upgrade is done from firmware
> > reporting having SEV API version 1.49, and requires the following
> > workaround:
> 
> Replace the above paragraph with just: "Currently, this issue requires the
> following workaround:"
> 
> > 
> > sudo modprobe -r kvm_amd
> > sudo modprobe -r ccp
> > sudo modprobe ccp
> > sudo modprobe kvm_amd
> > 
> > Implement this workaround inside kernel by checking whether the API
> > version is less than 1.50, and if so, download the firmware twice.
> > This addresses the TCB version issue.
> > 
> > Link: https://lore.kernel.org/all/de02389f-249d-f565-1136-4af3655fab2a@profian.com/
> > Reported-by: Harald Hoyer <harald@profian.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
> > ---
> >   drivers/crypto/ccp/sev-dev.c | 16 ++++++++++++++--
> >   1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> > index 799b476fc3e8..8ae26c5c64f6 100644
> > --- a/drivers/crypto/ccp/sev-dev.c
> > +++ b/drivers/crypto/ccp/sev-dev.c
> > @@ -742,6 +742,11 @@ static int sev_update_firmware(struct device *dev)
> >   	struct page *p;
> >   	u64 data_size;
> > +	if (!sev_version_greater_or_equal(0, 15)) {
> > +		dev_dbg(dev, "DOWNLOAD_FIRMWARE not supported\n");
> > +		return -1;
> > +	}
> > +
> >   	if (sev_get_firmware(dev, &firmware) == -ENOENT) {
> >   		dev_dbg(dev, "No SEV firmware file present\n");
> >   		return -1;
> > @@ -774,6 +779,14 @@ static int sev_update_firmware(struct device *dev)
> >   	data->len = firmware->size;
> >   	ret = sev_do_cmd(SEV_CMD_DOWNLOAD_FIRMWARE, data, &error);
> > +
> > +	/*
> > +	 * A quirk for fixing the committed TCB version, when upgrading from
> > +	 * earlier firmware version than 1.33.01.
> 
> s/1.33.01/1.50/
> 
> Thanks,
> Tom

Thanks Tom, I'll address the issues and send a new version.

BR, Jarkko
