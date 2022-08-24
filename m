Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C1859F077
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 02:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiHXAyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 20:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiHXAyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2363C883FF
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 17:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661302479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mJ2AxATAvltTLcK4EIcLhHTsShpwyuL8fLYe2MzIEMw=;
        b=h64vq1pN9kRozVIuW7pbQDSkg3ELvFIzkGRHwFwjkKfFnvNLEyqS8eVni8p4+MtySLp/yK
        QsxDRW7dMuyK1utP/XCJ+RgQqgNn5zfNAXTOncZgYEKh9A1Ij/X7Qw5yLWdJ4YgarrQtfw
        kFcmUNSriVhwmgfpu1jNX1i2fAWbHIs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-368-Q7TmKqbSOBSa1blrw4mb8g-1; Tue, 23 Aug 2022 20:54:38 -0400
X-MC-Unique: Q7TmKqbSOBSa1blrw4mb8g-1
Received: by mail-qv1-f70.google.com with SMTP id n9-20020a0cfbc9000000b00496bb293f1fso8192501qvp.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 17:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=mJ2AxATAvltTLcK4EIcLhHTsShpwyuL8fLYe2MzIEMw=;
        b=ovRiG/4QK2JqdcIWu3iNDHv7Qem/D5xWdLNP7l4xYFU7OvGweidVSPrxAr2SaEHnnK
         Nps6D1FQS38O6Tc5XUCorg20mFLJkYp9MkAGzprhOAjLHXMies6GjgNgw0kYfMclPVAT
         +vL30guQBzTwAetT/po//jAbl1NvMUgKVXP9jsy8VDJLIi+D1tTRNoXPSIKlciMcRnLR
         1uZBxg3MCBHq3pT9X1FsCJkNrQhBeqs0pHiZR/lZ9U1gADVxtL5sD4APdbNcPZMt0xb0
         plLIoPjn16oCJsTIqxC9MyYY85RTtOhzFNHEbgB1rLYjbMXOZzHvarnbFFC8Cdd7l5wd
         YaOQ==
X-Gm-Message-State: ACgBeo3G0rUnNSMMNIE2WNwdEqFonx+KGILwakkYb0Z8WFuG5Lgv3Pad
        Bfpt3Ed1S/Uf1+gBwAdAiB3csWBq9BAw2yo+/Vh+7d+P6pC49SmsClzykPekB9YzlrdxNJAwS9z
        P+O8GX3RYFVWn5GkEfGvhun+7
X-Received: by 2002:ac8:59cc:0:b0:344:6b04:26df with SMTP id f12-20020ac859cc000000b003446b0426dfmr21723995qtf.208.1661302477655;
        Tue, 23 Aug 2022 17:54:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6agXqBP7WlVJI4qXtGQYvolC0S7vaCx+krWytFSqnd+I2CsB8CpxWhGHKC3wMizB4TZlFPZw==
X-Received: by 2002:ac8:59cc:0:b0:344:6b04:26df with SMTP id f12-20020ac859cc000000b003446b0426dfmr21723982qtf.208.1661302477477;
        Tue, 23 Aug 2022 17:54:37 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id g2-20020ac87742000000b003445d06a622sm11871028qtu.86.2022.08.23.17.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 17:54:37 -0700 (PDT)
Date:   Tue, 23 Aug 2022 17:54:35 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: avoid deadlock in
 process_misc_interrupts()
Message-ID: <20220824005435.jyexxvjxj3z7tc2f@cantor>
References: <20220823162435.2099389-1-jsnitsel@redhat.com>
 <20220823163709.2102468-1-jsnitsel@redhat.com>
 <905d3feb-f75b-e91c-f3de-b69718aa5c69@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <905d3feb-f75b-e91c-f3de-b69718aa5c69@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 09:46:19AM -0700, Dave Jiang wrote:
> 
> On 8/23/2022 9:37 AM, Jerry Snitselaar wrote:
> > idxd_device_clear_state() now grabs the idxd->dev_lock
> > itself, so don't grab the lock prior to calling it.
> > 
> > This was seen in testing after dmar fault occurred on system,
> > resulting in lockup stack traces.
> > 
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: dmaengine@vger.kernel.org
> > Fixes: cf4ac3fef338 ("dmaengine: idxd: fix lockdep warning on device driver removal")
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> Thanks Jerry!
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 

I noticed another problem while looking at this. When the device ends
up in the halted state, and needs an flr or system reset, it calls
idxd_wqs_unmap_portal(). Then if you do a modprobe -r idxd, you hit
the WARN_ON in devm_iounmap(), because the remove code path calls
idxd_wq_portal_unmap(), and wq->portal is null. I'm not sure if it
just needs a simple sanity check in drv_disable_wq() to avoid the call
in the case that it has already been unmapped, or if more cleanup
needs to be done, and possibly a state to differentiate between
halted + soft reset possible, versus halted + flr or system reset
needed.  You get multiple "Device is HALTED" messages during the
removal as well.

Regards,
Jerry

