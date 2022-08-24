Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D230F5A017E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbiHXSmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiHXSmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B49C78588
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661366535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34X7VFt8V3iE8XwzbGfHOBsqTvNr4hGuESvVJPfwn4E=;
        b=cOsCUrGLY+6BDCvLOkPFFtsFWQ7kkMG2YmwlXhNC2peMksTWPjK94r3yv6PyVGDQRt4uk5
        HLlm6F6qnJ03X97OOQfOJeZlotxUmLFuXWiVhwBKjPDOLByGDk0sal5PWrUHvCmpqKMopj
        bR9eUdwZBTe02bCMD5vJUOFFb15pGo8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-125-fPBSSi3GNBiLF0zWZZiFRw-1; Wed, 24 Aug 2022 14:42:13 -0400
X-MC-Unique: fPBSSi3GNBiLF0zWZZiFRw-1
Received: by mail-qt1-f197.google.com with SMTP id k9-20020ac80749000000b0034302b53c6cso13654297qth.22
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=34X7VFt8V3iE8XwzbGfHOBsqTvNr4hGuESvVJPfwn4E=;
        b=INS/zzSIvGl4+HYYxklkmXSLP5KRxXlDYXc4XHSnpOFUg8yYfxjOOY0sW0WIEIqX31
         s/KU6oWPrwyLOeOqmqNLJKghkNzn2lrw05PpHLX6sE7d8QpwY99A9HardSxlsds8vssn
         8xTiOEQpc1bvgCjkfeo2GrylI+WOLcGsGWvQ+S3um4jYXaULMVPHRtAXB4DBfvtV6DpT
         dlNB/txmQ0BLnGZhGPmuEod+8oIYbHfKIu00RzP6tKlp+bCUN71GjAJaFRRLFsT4RGEq
         K8TclsjC3iwesjiV0FbMIStOVNAmHBbUPZOzZ4nzYrcAov9C5LRY64pIzMISq/1fk7g6
         8urQ==
X-Gm-Message-State: ACgBeo06QLpx11e6yCznMvcXuum1ELFyW3jCwmW/F6lOiCyN6ZchueUG
        5KsfQcgT0xAl0vSBV9D3Q8vFXZSg2hCU91LPoLYveS4k779+F5ZTyx3njMd1TihtsL4xMeNmIRC
        mFJazuZhA00pno/rexI8Vp5KB
X-Received: by 2002:a37:952:0:b0:6ba:37c6:12ec with SMTP id 79-20020a370952000000b006ba37c612ecmr472051qkj.331.1661366533530;
        Wed, 24 Aug 2022 11:42:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6zZO3JsIuYFh83voDv4+f19vJAN66uxS7OW65PV5Ygvr7CcBVHQ5XqJSy6pDjQP2Ne3PP31Q==
X-Received: by 2002:a37:952:0:b0:6ba:37c6:12ec with SMTP id 79-20020a370952000000b006ba37c612ecmr472042qkj.331.1661366533349;
        Wed, 24 Aug 2022 11:42:13 -0700 (PDT)
Received: from [192.168.1.52] (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id r25-20020ae9d619000000b006bb2f555ba4sm15216878qkk.41.2022.08.24.11.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 11:42:12 -0700 (PDT)
Message-ID: <38e416b47bb30fa161e52f24ecbcf95015480fed.camel@redhat.com>
Subject: Re: [PATCH v2] dmaengine: idxd: avoid deadlock in
 process_misc_interrupts()
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Date:   Wed, 24 Aug 2022 11:42:11 -0700
In-Reply-To: <223e5a43-95a5-da54-0ff7-c2e088a072e3@intel.com>
References: <20220823162435.2099389-1-jsnitsel@redhat.com>
         <20220823163709.2102468-1-jsnitsel@redhat.com>
         <905d3feb-f75b-e91c-f3de-b69718aa5c69@intel.com>
         <20220824005435.jyexxvjxj3z7tc2f@cantor>
         <223e5a43-95a5-da54-0ff7-c2e088a072e3@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-24 at 10:45 -0700, Dave Jiang wrote:
>=20
> On 8/23/2022 5:54 PM, Jerry Snitselaar wrote:
> > On Tue, Aug 23, 2022 at 09:46:19AM -0700, Dave Jiang wrote:
> > > On 8/23/2022 9:37 AM, Jerry Snitselaar wrote:
> > > > idxd_device_clear_state() now grabs the idxd->dev_lock
> > > > itself, so don't grab the lock prior to calling it.
> > > >=20
> > > > This was seen in testing after dmar fault occurred on system,
> > > > resulting in lockup stack traces.
> > > >=20
> > > > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > > Cc: Vinod Koul <vkoul@kernel.org>
> > > > Cc: dmaengine@vger.kernel.org
> > > > Fixes: cf4ac3fef338 ("dmaengine: idxd: fix lockdep warning on
> > > > device driver removal")
> > > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > Thanks Jerry!
> > >=20
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > >=20
> > I noticed another problem while looking at this. When the device
> > ends
> > up in the halted state, and needs an flr or system reset, it calls
> > idxd_wqs_unmap_portal(). Then if you do a modprobe -r idxd, you hit
> > the WARN_ON in devm_iounmap(), because the remove code path calls
> > idxd_wq_portal_unmap(), and wq->portal is null. I'm not sure if it
> > just needs a simple sanity check in drv_disable_wq() to avoid the
> > call
> > in the case that it has already been unmapped, or if more cleanup
> > needs to be done, and possibly a state to differentiate between
> > halted + soft reset possible, versus halted + flr or system reset
> > needed.=C2=A0 You get multiple "Device is HALTED" messages during the
> > removal as well.
>=20
> Thanks!
>=20
> Fenghua, can you please take a look at this when you have a chance?=20
> Thank you!
>=20
>=20

Fenghua,

I see another potential issue. If a software reset is
attempted idxd_device_reinit() will be called which walks
the wqs, and if a wq has the state IDXD_WQ_ENABLED it calls
idxd_wq_enable(), but the first thing idxd_wq_enable() does
is see that the state is IDXD_WQ_ENABLED and returns 0.
Without the wq enable command being sent, it will not be
re-enabled, yes?

Regards,
Jerry

> >=20
> > Regards,
> > Jerry
> >=20
>=20

