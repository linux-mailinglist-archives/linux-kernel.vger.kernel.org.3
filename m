Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855E3595EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiHPPJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiHPPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:09:16 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF5B40567
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:08:49 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id h8so8053531qvs.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=jCfzmsaJkoQJC8MYEAYlkMCx+Qt2qJB+LOZPkMBY/7c=;
        b=Mx2n3/vhqVZHE2rdobJ03fqOILzNK0m/5Osj8zPriu/pGGEdHUz8I0whLf3rAMfYeN
         NgqSPyLjPC86OoMA0XPSBX8L0D7EjXD+1L7IcJeQZXhdkYHzw63rQwLeFWzFJfWhk61g
         LAJHtmLSFCuKnMeMuUdGMmUTZWDJfUQhaCUExbmRShmWrqSebijUZR3xK15lnW1DphpN
         ztQd1/+qoxgkOkT/fbcmPjSz6EvZJ9bBncAc5wPfy+96+4nFdiRSrEAyX4I2zYWIrM5D
         HrChwoG6iex74H3VY4tbPRbZFWYfUqHh/GXoyHVeRS5I2OQdoNmf8xyeC+It/ykn+42q
         cgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=jCfzmsaJkoQJC8MYEAYlkMCx+Qt2qJB+LOZPkMBY/7c=;
        b=bYsqFTRtDHykeQBFafmB5/cqMXWeLM67UK63Q+aiY8Z1qizKvu+sCZ/KZUfbG+9ml9
         zFnaKYF/0UsdVzkpULlY+RBsepJHWtqK5dRFeBT+rK+6waJi9/I8HHrLbBmnxZhpgMof
         V9vy/3Kc2oZGL0NaekGP6DdUn1CRHs+ThJmMA4a75KLSgXXLwXqQ1cPbXVhKZNI67ACQ
         2kX3MaAQPtjaWDVkYwt4M0HljStOBKuz2pyl6P4rimC773qe7it0InwODky3a+8ntUbD
         2t83TZCKO3FEs2E9F9GvaNL8aQnY171EC9DB3rd+TK5Dp0vp3IW6jSt5bCb2PHz/nceJ
         w3Gw==
X-Gm-Message-State: ACgBeo0jpvg0N1AM7Rx1DCXO45c+zECj5SNmL/AtNTId95d73PnVQdWA
        ui/NUWbwDbjMFkjb4OjO45vJOiT18G2k1g==
X-Google-Smtp-Source: AA6agR4QLkvgHt1IvmI8LJqyu3M5wcfM1KRSie8R7GDRxEAi5JTMAfbVrSQofjCD4cAfQHXiXDlwNg==
X-Received: by 2002:a05:6214:e86:b0:476:6129:25fc with SMTP id hf6-20020a0562140e8600b00476612925fcmr17997640qvb.9.1660662528244;
        Tue, 16 Aug 2022 08:08:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id k20-20020a05620a415400b006bb83c2be40sm450368qko.59.2022.08.16.08.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 08:08:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1oNyBS-002n0A-JL;
        Tue, 16 Aug 2022 12:08:46 -0300
Date:   Tue, 16 Aug 2022 12:08:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Diana Craciun <diana.craciun@oss.nxp.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] vfio/fsl-mc: Fix a typo in a comment
Message-ID: <Yvuy/qUwU7StueDV@ziepe.ca>
References: <2b65bf8d2b4d940cafbafcede07c23c35f042f5a.1659815764.git.christophe.jaillet@wanadoo.fr>
 <YvKJTKYv2htxM1n/@ziepe.ca>
 <db505c50-e855-5e94-1f09-173310177bda@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db505c50-e855-5e94-1f09-173310177bda@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 05:00:50PM +0200, Christophe JAILLET wrote:
> Le 09/08/2022 à 18:20, Jason Gunthorpe a écrit :
> > On Sat, Aug 06, 2022 at 09:56:13PM +0200, Christophe JAILLET wrote:
> > > L and S are swapped/
> > > s/VFIO_FLS_MC/VFIO_FSL_MC/
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > All the dev_ logging functions in the file have the "VFIO_FSL_MC: "
> > > prefix.
> > > As they are dev_ function, the driver should already be displayed.
> > > 
> > > So, does it make sense or could they be all removed?
> > > ---
> > >   drivers/vfio/fsl-mc/vfio_fsl_mc.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> > > index 3feff729f3ce..66d01db1d240 100644
> > > --- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> > > +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> > > @@ -110,7 +110,7 @@ static void vfio_fsl_mc_close_device(struct vfio_device *core_vdev)
> > >   	if (WARN_ON(ret))
> > >   		dev_warn(&mc_cont->dev,
> > > -			 "VFIO_FLS_MC: reset device has failed (%d)\n", ret);
> > > +			 "VFIO_FSL_MC: reset device has failed (%d)\n", ret);
> > 
> > WARN_ON already prints, this is better written as
> > 
> > WARN(ret, "VFIO_FSL_MC: reset device has failed (%d)\n", ret);
> 
> Or maybe, just:
> if (ret)
> 	dev_warn(&mc_cont->dev,
> 		 "VFIO_FSL_MC: reset device has failed (%d)\n", ret);
> 
> This keep information about the device, avoid the duplicate printing related
> to WARN_ON+dev_warn and is more in line with error handling in other files.
> 
> Do you agree or do you prefer a v2 as you proposed with WARN()?

If the original author wrote WARN I would not degrade it to just a
dev_warn.

Jason
