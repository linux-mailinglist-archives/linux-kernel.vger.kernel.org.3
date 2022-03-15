Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD2F4D9E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349481AbiCOPRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiCOPRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6ADC24E3BE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647357358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kyz2RUFrfzcWwytFdN8JKP5rzgj6KOwPxkBy/7oRIpU=;
        b=Cy3r530evXgrG340mX7jJxJ5swqRPFdF0k8tvOlQVj/Ik7ZAOS6tL1kL3+uwZUUIvpTAzZ
        guc0+v+Zx5ezZotq2S56/7iMpkndyOL+zxEKvX+Gagmgwd3+jn9QDSqt4HH3PNMFxx67ds
        re3iEz8FjOOo4IILh7RC2LQeyxGMypA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-5HhUcH77MxGnxjSdmOjeqg-1; Tue, 15 Mar 2022 11:15:57 -0400
X-MC-Unique: 5HhUcH77MxGnxjSdmOjeqg-1
Received: by mail-wr1-f70.google.com with SMTP id a5-20020adfdd05000000b001f023fe32ffso5382057wrm.18
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kyz2RUFrfzcWwytFdN8JKP5rzgj6KOwPxkBy/7oRIpU=;
        b=QtIWRToIp85bA9SxJSBR3oyK+bEJuwl8gBqibcFTZw8vLvDXmNPB9X2kXyLJT9d2+X
         MNtI9Bq0xiXzVYen31teqMJSmMRilz2JyPjD42nO3OheapsK1J28s11enCmtb8KOTzKy
         tT1X8GhgfJL74D9oA1jFw86sa3wpq6SWL03tUGIrDthbDd6AkFEInvH11ZOkghCGkD6y
         A0cCpEiUAuM2MMYBtKNLAK1bf8A6Si/4h/FFxec+a3Cx1rSiRltuaCGZL/sjGIJA0s+k
         KuheVq/mfSrsdRKji2h7j0FfPnDS11YWcfigZlCgDlHDsL2UqJvGxmJGLW6qG50A41th
         8HjA==
X-Gm-Message-State: AOAM531TQbklhtE6yf91IYD1F5PHsOnpOSLidAFTJU5STXuk6z+VQQ2j
        aWwGaegar/N35lMN/uMAT040Ca8ccV0AinbTXP+WcyHrfwTbwTzN4OkqXHuEKMONxnJWio52wIL
        CXp+LakGYbghCXFpwaBt0o/Sz
X-Received: by 2002:a05:6000:3c3:b0:203:6976:6942 with SMTP id b3-20020a05600003c300b0020369766942mr20348016wrg.584.1647357355931;
        Tue, 15 Mar 2022 08:15:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypmXByJXceCvTyDTeaeG4rtFjn8ylgA1heE6UhT+IFbX4r7V634CRa98A5VvIu9kER2FggTQ==
X-Received: by 2002:a05:6000:3c3:b0:203:6976:6942 with SMTP id b3-20020a05600003c300b0020369766942mr20347991wrg.584.1647357355683;
        Tue, 15 Mar 2022 08:15:55 -0700 (PDT)
Received: from redhat.com ([2.53.2.35])
        by smtp.gmail.com with ESMTPSA id ay24-20020a05600c1e1800b00389a420e1ecsm2498962wmb.37.2022.03.15.08.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 08:15:55 -0700 (PDT)
Date:   Tue, 15 Mar 2022 11:15:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tom Rix <trix@redhat.com>
Cc:     jasowang@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
        lingshan.zhu@intel.com, sgarzare@redhat.com,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] vDPA/ifcvf: match pointer check to use
Message-ID: <20220315111456-mutt-send-email-mst@kernel.org>
References: <20220315124130.1710030-1-trix@redhat.com>
 <20220315092656-mutt-send-email-mst@kernel.org>
 <512a392d-23d7-c25b-7576-571001f28288@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512a392d-23d7-c25b-7576-571001f28288@redhat.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 08:03:26AM -0700, Tom Rix wrote:
> 
> On 3/15/22 6:28 AM, Michael S. Tsirkin wrote:
> > On Tue, Mar 15, 2022 at 05:41:30AM -0700, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > > 
> > > Clang static analysis reports this issue
> > > ifcvf_main.c:49:4: warning: Called function
> > >    pointer is null (null dereference)
> > >    vf->vring->cb.callback(vring->cb.private);
> > >    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > The check
> > >    vring = &vf->vring[i];
> > >    if (vring->cb.callback)
> > > 
> > > Does not match the use.  Change dereference so they match.
> > > 
> > > Fixes: 79333575b8bd ("vDPA/ifcvf: implement shared IRQ feature")
> > Thanks a lot! I squashed this into the offending patch - no point in
> > breaking bisect. Pushed to linux. However I'm now
> > having second thoughts about applying that patchset - I'd like
> > soma analysis explaining how this got through testing.
> 
> static analysis is something i do treewide.
> 
> There are currently ~2500 issues in linux-next, do not panic! many are false
> positives.
> 
> It is pretty easy to setup and once you have a baseline you can filter only
> your files.
> 
> Tom

Thanks for that info! I was actually directing this question to the
contributor since the code does not look like it could have ever
worked. I don't have the hardware in question myself.


> > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > ---
> > >   drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> > > index 3b48e717e89f7..4366320fb68d3 100644
> > > --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> > > +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> > > @@ -46,7 +46,7 @@ static irqreturn_t ifcvf_vqs_reused_intr_handler(int irq, void *arg)
> > >   	for (i = 0; i < vf->nr_vring; i++) {
> > >   		vring = &vf->vring[i];
> > >   		if (vring->cb.callback)
> > > -			vf->vring->cb.callback(vring->cb.private);
> > > +			vring->cb.callback(vring->cb.private);
> > >   	}
> > >   	return IRQ_HANDLED;
> > > -- 
> > > 2.26.3

