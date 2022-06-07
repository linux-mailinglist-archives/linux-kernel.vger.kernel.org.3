Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568FA53FA76
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbiFGJz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240374AbiFGJy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40F7DEEA7;
        Tue,  7 Jun 2022 02:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 910B4611E2;
        Tue,  7 Jun 2022 09:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A43C34115;
        Tue,  7 Jun 2022 09:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654595694;
        bh=mu9YFv5EFaeroOVseXHEkfLkjfXbtHgykbzu3uDDYIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljSiogaNUuASs3Cc3phluL7QI1o31CIW1C7M7Ich0JazceGZMk7niFigLQLza0EiY
         RWeLKEXpKssfmC29E5EYWx2Gv3FF5Baz6WeBPx5IPV+5qf1YrZidqaRdgzlTE9DWnZ
         sS+HXLfLYgLF1SZ+sKMDRmzB73pn4ckps+Dfhl2TuBQxSUUNKMjWPM68/V4cXo8Oak
         p+sYatsIC7xhAOeOdv9f8VNMtMEsaaaPeTrETvWxfw+r0GCwsFGE4VkPOukAIoPi6X
         kqYy0EpG5uYbDpcWWGvXVgm6nqG1KW0qd55ISNoyep18HyWJ/RsyyOHmwamZu7dRe/
         rDG03IoZ7ioyg==
Date:   Tue, 7 Jun 2022 12:52:58 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH v3] tpm: Add upgrade/reduced mode support for TPM1.2
 modules
Message-ID: <Yp8f+kBQLCKfBrOj@iki.fi>
References: <20220603084156.7090-1-stefan.mahnke-hartmann@infineon.com>
 <Yp8fFNMzBLAXdNig@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp8fFNMzBLAXdNig@iki.fi>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 12:49:11PM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 03, 2022 at 10:41:58AM +0200, Stefan Mahnke-Hartmann wrote:
> > In case a TPM in failure mode is detected, the TPM should be accessible
> > through a transparent communication channel for analysing purposes (e.g.
> > TPM_GetTestResult) or a field upgrade. Since a TPM in failure mode has
> > similar reduced functionality as in field upgrade mode, the flag
> > TPM_CHIP_FLAG_FIRMWARE_UPGRADE is also valid.
> > 
> > As described in TCG TPM Main Part1 Design Principles, Revision 116,
> > chapter 9.2.1. the TPM also allows an update function in case a TPM is
> > in failure mode.
> > 
> > If the TPM in failure mode is detected, the function tpm1_auto_startup()
> > sets TPM_CHIP_FLAG_FIRMWARE_UPGRADE flag, which is used later during
> > driver initialization/deinitialization to disable functionality which
> > makes no sense or will fail in the current TPM state. The following
> > functionality is affected:
> >  * Do not register TPM as a hwrng
> >  * Do not get pcr allocation
> >  * Do not register sysfs entries which provide information impossible to
> >    obtain in limited mode
> > 
> > Signed-off-by: Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
> > ---
> > Changelog:
> >  * v3:
> >    * Change kernel messages
> > 
> >  drivers/char/tpm/tpm.h      | 1 +
> >  drivers/char/tpm/tpm1-cmd.c | 7 ++++++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index 2163c6ee0d36..24ee4e1cc452 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -55,6 +55,7 @@ enum tpm_addr {
> >  #define TPM_WARN_DOING_SELFTEST 0x802
> >  #define TPM_ERR_DEACTIVATED     0x6
> >  #define TPM_ERR_DISABLED        0x7
> > +#define TPM_ERR_FAILEDSELFTEST  0x1C
> >  #define TPM_ERR_INVALID_POSTINIT 38
> >  
> >  #define TPM_TAG_RQU_COMMAND 193
> > diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> > index f7dc986fa4a0..cf64c7385105 100644
> > --- a/drivers/char/tpm/tpm1-cmd.c
> > +++ b/drivers/char/tpm/tpm1-cmd.c
> > @@ -709,7 +709,12 @@ int tpm1_auto_startup(struct tpm_chip *chip)
> >  	if (rc)
> >  		goto out;
> >  	rc = tpm1_do_selftest(chip);
> > -	if (rc) {
> > +	if (rc == TPM_ERR_FAILEDSELFTEST) {
> > +		dev_warn(&chip->dev, "TPM self test failed, switching to the firmware upgrade mode\n");
> > +		/* A TPM in this state possibly allows or needs a firmware upgrade */
> > +		chip->flags |= TPM_CHIP_FLAG_FIRMWARE_UPGRADE;
> > +		return 0;
> > +	} else if (rc) {
> >  		dev_err(&chip->dev, "TPM self test failed\n");
> >  		goto out;
> >  	}
> > -- 
> > 2.25.1
> > 
> 
> I think this looks good now, thanks for patience:
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

applied

BR, Jarkko
