Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506FD501C00
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345707AbiDNTga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345705AbiDNTg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:36:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A61DED902;
        Thu, 14 Apr 2022 12:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z6NO35KE2Lguj4JWi+iLnZSkryiHS70xMnjy6Usv8+0=; b=WsFWGMnRLs2cKSk1AHbHn+6lbq
        GlViERsBnVWzXCVa1IxA2XFoZc/vgZT98MNb83dnSQpsXJqzuEIbnder6nkWJ5gkZEJ6QamglotGM
        LtOBLInohgkkYtF5kBT5SQQHRlTFtdBbERanbnRw/rnywpj5uYzoNkIVjsL25cNbuhcBg9PM85eRm
        fowdvJkzNi8GncNbjuLyNWsMrlAaWfZoCAoZpph4voSTsFNPS5t5/4BhxkTGPWwgrV+1upUpqPJrK
        eB02eypVNOVtZ08bE6Rn3d/BPAbMASBMghG6flep15moulVwr8MstTQzODLP922h/TwH2jb6gIMFD
        W4iihIjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf5E2-00FSBz-U7; Thu, 14 Apr 2022 19:33:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3FA9F30027B;
        Thu, 14 Apr 2022 21:33:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B96B322A1704; Thu, 14 Apr 2022 21:33:53 +0200 (CEST)
Date:   Thu, 14 Apr 2022 21:33:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v2 02/12] device-core: Add dev->lock_class to enable
 device_lock() lockdep validation
Message-ID: <Ylh3ISDToV5y9/4P@hirez.programming.kicks-ass.net>
References: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164982969858.684294.17819743973041389492.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220413084309.GV2731@worktop.programming.kicks-ass.net>
 <CAPcyv4huZVNkxa7-rQ_J=nVN77+5F1AJg5vi6kLHp8t5khcwHA@mail.gmail.com>
 <Ylf0dewci8myLvoW@hirez.programming.kicks-ass.net>
 <CAPcyv4hFabn6H064HTrH8=GQ-cxsOk4xEK8s66JQxQavfgAzGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hFabn6H064HTrH8=GQ-cxsOk4xEK8s66JQxQavfgAzGw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:17:13AM -0700, Dan Williams wrote:

> One more sanity check... So in driver subsystems there are cases where
> a device on busA hosts a topology on busB. When that happens there's a
> need to set the lock class late in a driver since busA knows nothing
> about the locking rules of busB.

I'll pretend I konw what you're talking about ;-)

> Since the device has a longer lifetime than a driver when the driver
> exits it must set dev->mutex back to the novalidate class, otherwise
> it sets up a use after free of the static lock_class_key.

I'm not following, static storage has infinite lifetime.

> I came up with this and it seems to work, just want to make sure I'm
> properly using the lock_set_class() API and it is ok to transition
> back and forth from the novalidate case:
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 990b6670222e..32673e1a736d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -405,6 +405,29 @@ struct cxl_nvdimm_bridge
> *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd);
>  #define __mock static
>  #endif
> 
> +#ifdef CONFIG_PROVE_LOCKING
> +static inline void cxl_lock_reset_class(void *_dev)
> +{
> +       struct device *dev = _dev;
> +
> +       lock_set_class(&dev->mutex.dep_map, "__lockdep_no_validate__",
> +                      &__lockdep_no_validate__, 0, _THIS_IP_);
> +}
> +
> +static inline int cxl_lock_set_class(struct device *dev, const char *name,
> +                                    struct lock_class_key *key)
> +{
> +       lock_set_class(&dev->mutex.dep_map, name, key, 0, _THIS_IP_);
> +       return devm_add_action_or_reset(dev, cxl_lock_reset_class, dev);
> +}
> +#else
> +static inline int cxl_lock_set_class(struct device *dev, const char *name,
> +                                    struct lock_class_key *key)
> +{
> +       return 0;
> +}
> +#endif

Under the assumption that the lock is held (lock_set_class() will
actually barf if @lock isn't held) this should indeed work as expected
(although I think you got the @name part 'wrong', I think that's
canonically something like "&dev->mutex" or something).
