Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5717451190D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbiD0OWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbiD0OWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:22:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D066EC4D;
        Wed, 27 Apr 2022 07:18:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4640761DDC;
        Wed, 27 Apr 2022 14:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149FFC385A9;
        Wed, 27 Apr 2022 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651069134;
        bh=P8Re4rNifMUZz02aR6/5ZozvQhzoiFhDq0hEGf/tYts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJRGjGMv6tJ4OmJ+tITFtZxSrxV+Z9f+GNWODbIlt5TvtckI4h7rtBbFHoeaQDCWU
         /y+VgPCgKm32JQbTeJXvsn+aoJIcan79HYsiE/wBhTnJM8rDyBtlcW61w+X5c+YLLg
         Le+quAgvn64nWhhnjUD58tzQJTBOm3uRq7orBR4o=
Date:   Wed, 27 Apr 2022 16:18:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware_loader: use kernel credentials when reading
 firmware
Message-ID: <YmlQy7jnIY6Wh7/2@kroah.com>
References: <20220422013215.2301793-1-tweek@google.com>
 <20220427135823.GD71@qian>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427135823.GD71@qian>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:58:23AM -0400, Qian Cai wrote:
> On Fri, Apr 22, 2022 at 11:32:15AM +1000, Thiébaud Weksteen wrote:
> >  drivers/base/firmware_loader/main.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> > index 94d1789a233e..8f3c2b2cfc61 100644
> > --- a/drivers/base/firmware_loader/main.c
> > +++ b/drivers/base/firmware_loader/main.c
> > @@ -735,6 +735,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
> >  		  size_t offset, u32 opt_flags)
> >  {
> >  	struct firmware *fw = NULL;
> > +	struct cred *kern_cred = NULL;
> > +	const struct cred *old_cred;
> >  	bool nondirect = false;
> >  	int ret;
> >  
> > @@ -751,6 +753,18 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
> >  	if (ret <= 0) /* error or already assigned */
> >  		goto out;
> >  
> > +	/*
> > +	 * We are about to try to access the firmware file. Because we may have been
> > +	 * called by a driver when serving an unrelated request from userland, we use
> > +	 * the kernel credentials to read the file.
> > +	 */
> > +	kern_cred = prepare_kernel_cred(NULL);
> 
> This triggers quite some leak reports from kmemleak.
> 
> unreferenced object 0xffff0801e47690c0 (size 176):
>   comm "kworker/0:1", pid 14, jiffies 4294904047 (age 2208.624s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>      kmem_cache_alloc
>      prepare_kernel_cred
>      _request_firmware
>      firmware_request_nowarn
>      firmware_request_nowarn at drivers/base/firmware_loader/main.c:933
>      nvkm_firmware_get [nouveau]
>      nvkm_firmware_get at drivers/gpu/drm/nouveau/nvkm/core/firmware.c:92
>      nvkm_firmware_load_name [nouveau]
>      nvkm_acr_lsfw_load_bl_inst_data_sig [nouveau]
>      gm200_gr_load [nouveau]
>      gf100_gr_new_ [nouveau]
>      tu102_gr_new [nouveau]
>      nvkm_device_ctor [nouveau]
>      nvkm_device_pci_new [nouveau]
>      nouveau_drm_probe [nouveau]
>      local_pci_probe
>      work_for_cpu_fn
>      process_one_work

Ugh, yeah, a put_cred() is not called after this.

I'll go revert this commit for now as it needs more work.

thanks,

greg k-h
