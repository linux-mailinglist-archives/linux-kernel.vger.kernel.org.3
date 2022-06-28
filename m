Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86DF55E045
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245267AbiF1JMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343576AbiF1JMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:12:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58503120B3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9BE4616ED
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD9AC3411D;
        Tue, 28 Jun 2022 09:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656407568;
        bh=iXFPnwpsNa8MD5kdunG0bfFdOHKw1ogSnvL2uaEK/o4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlytBUTDP5a3dvid0CXhnwbOI3fPrJ2n+cfIibWmjWBNdjOEHJZvDgpCpDOSN/I5N
         t39hmpZX+c5cJeT1Or0SLMVVIbD9/fa6XQhmZSUYMAK70K5iRqygejGoeRaQLs3Cd7
         rIko6zH4ljQ3+AXWN83jJN+C9AY3Yzx9WncleAWM=
Date:   Tue, 28 Jun 2022 11:12:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] habanalabs: add unsupported functions
Message-ID: <YrrGDbUTxyZi2hdT@kroah.com>
References: <20220627202620.961350-1-ogabbay@kernel.org>
 <20220627202620.961350-5-ogabbay@kernel.org>
 <Yrqg+6bBxRMmomrm@kroah.com>
 <CAFCwf12mXA9u8+ZE6msZL4R11DsE8SVN2GxpxOfo=_0aGnY7nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12mXA9u8+ZE6msZL4R11DsE8SVN2GxpxOfo=_0aGnY7nQ@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:21:24AM +0300, Oded Gabbay wrote:
> On Tue, Jun 28, 2022 at 9:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jun 27, 2022 at 11:26:12PM +0300, Oded Gabbay wrote:
> > > There are a number of new ASIC-specific functions that were added
> > > for Gaudi2. To make the common code work, we need to define empty
> > > implementations of those functions for Goya and Gaudi.
> > >
> > > Some functions will return error if called with Goya/Gaudi.
> > >
> > > Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> > > ---
> > >  drivers/misc/habanalabs/gaudi/gaudi.c | 24 ++++++++++++++++++++++++
> > >  drivers/misc/habanalabs/goya/goya.c   | 24 ++++++++++++++++++++++++
> > >  2 files changed, 48 insertions(+)
> > >
> > > diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> > > index ae894335e9f8..f4581220ecd5 100644
> > > --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> > > +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> > > @@ -8588,6 +8588,11 @@ static void gaudi_ctx_fini(struct hl_ctx *ctx)
> > >       gaudi_internal_cb_pool_fini(ctx->hdev, ctx);
> > >  }
> > >
> > > +int gaudi_pre_schedule_cs(struct hl_cs *cs)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > >  static u32 gaudi_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
> > >  {
> > >       return gaudi_cq_assignment[cq_idx];
> > > @@ -8959,6 +8964,14 @@ static void gaudi_enable_events_from_fw(struct hl_device *hdev)
> > >               gaudi_irq_map_table[GAUDI_EVENT_INTS_REGISTER].cpu_id);
> > >  }
> > >
> > > +int gaudi_ack_mmu_page_fault_or_access_error(struct hl_device *hdev,
> > > +                                                     u64 mmu_cap_mask)
> > > +{
> > > +     dev_err(hdev->dev, "mmu_error function is not supported\n");
> >
> > Can userspace trigger this?  if so, make it debug, as you don't want to
> > give userspace a way to spam the logs.
> 
> Only via a debugfs node which is exposed only to root user.
> What is your recommendation in that case ?

What does this error message help out with?  Why not just return an
error and be done with it?  No need to spam the kernel log, right?

thanks,

greg k-h
