Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E832354B246
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241873AbiFNN3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiFNN3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:29:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2567312742;
        Tue, 14 Jun 2022 06:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0174B81879;
        Tue, 14 Jun 2022 13:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331AEC3411B;
        Tue, 14 Jun 2022 13:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655213343;
        bh=YEx73vfnRAnHRBrz3PVeIi0/8rfDtL+oBfNabAeQlks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1j05TVhIBjoG+yVNALTqiebQc3iaVllOkF3KyI17HMtZRW0vM9CIkJAEPJqrW/sq1
         cIxXPaCYiJAElrrjwQyZfvFY7df7t/LnOG72Jx/8daQ5CLtNoqKv0RcXWms+WI5zmC
         azueH7QKGohSeoaA1D3eKgzY4b3KtGMGASp8Mj7I=
Date:   Tue, 14 Jun 2022 15:29:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yekai(A)" <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 3/3] crypto: hisilicon/qm - defining the device
 isolation strategy
Message-ID: <YqiNHOfXHRtaQyZV@kroah.com>
References: <20220614122943.1406-1-yekai13@huawei.com>
 <20220614122943.1406-4-yekai13@huawei.com>
 <YqiCaTAaRoq7c0y0@kroah.com>
 <b597023a-5569-f4be-1e30-78d0d961dfdc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b597023a-5569-f4be-1e30-78d0d961dfdc@huawei.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 09:24:08PM +0800, yekai(A) wrote:
> > >  struct hisi_qm {
> > >  	enum qm_hw_ver ver;
> > >  	enum qm_fun_type fun_type;
> > > @@ -335,6 +341,9 @@ struct hisi_qm {
> > >  	struct qm_shaper_factor *factor;
> > >  	u32 mb_qos;
> > >  	u32 type_rate;
> > > +	struct list_head uacce_hw_errs;
> > > +	atomic_t uacce_ref; /* reference of the uacce */
> > 
> > That is not how reference counts work, sorry.  Please use 'struct kref'
> > for a real reference count, never roll your own.
> > 
> > thanks,
> > 
> > greg k-h
> > .
> > 
> 
> this atomic_t reference is lightweight than 'struct kref',

It's the same size, why would it be "lighter"?  Why do you need it to be
lighter, what performance issue is there with a kref?

> this reference
> means whether the task is running. So would it be better to use atomic_t
> reference?

I do not know, as "running or not running" is a state, not a count or a
reference.  why does this have to be atomic at all?

thanks,

greg k-h
