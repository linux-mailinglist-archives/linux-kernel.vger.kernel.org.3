Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466725AF68C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiIFVCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiIFVC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:02:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAFAA74EB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ahAQHE+1iY9jvcUUdT9evfOPFE+6F0GSGPnh72g4V/Q=; b=VhDEBnkyj7coyyzA54oFVLlrMP
        oKLICLLOw7M+tjyB9dG0vGsW0034q2Pmi1xrRWccCls5l7cy9oAxWKMGDERQgBGThrYF2cuo+VpLJ
        TRyrVUviAoDvU/BQpFrZBe1ngt1gU1PWXtUztGA9r1cC2HluF8dcPflmnL17DFZhhOF+mVl0lH1RL
        c0pKWr8M6h/FUf3ZuO1AIVuV4cFHJF6/qTEGN6ZilhSKDhzg/xDkxh8yHw+MBxoPn3Txt68KsOxUQ
        twjkPEpTntJQM2R42/EagEWnOjDkT0bs0cNy2YRoEk21LfmbJxv4CkFlvVTpK+wVEqUrMvieZb9U3
        xjfLAWVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVfiC-00AlOm-Mi; Tue, 06 Sep 2022 21:02:24 +0000
Date:   Tue, 6 Sep 2022 22:02:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v4 1/3] drm: Use XArray instead of IDR for minors
Message-ID: <Yxe1YDcVfqbjgT6a@casper.infradead.org>
References: <20220906201629.419160-1-michal.winiarski@intel.com>
 <20220906201629.419160-2-michal.winiarski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220906201629.419160-2-michal.winiarski@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:16:27PM +0200, Michał Winiarski wrote:
> IDR is deprecated, and since XArray manages its own state with internal
> locking, it simplifies the locking on DRM side.
> Additionally, don't use the IRQ-safe variant, since operating on drm
> minor is not done in IRQ context.
> 
> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>

I have a few questions, but I like where you're going.

> @@ -98,21 +98,18 @@ static struct drm_minor **drm_minor_get_slot(struct drm_device *dev,
>  static void drm_minor_alloc_release(struct drm_device *dev, void *data)
>  {
>  	struct drm_minor *minor = data;
> -	unsigned long flags;
>  
>  	WARN_ON(dev != minor->dev);
>  
>  	put_device(minor->kdev);
>  
> -	spin_lock_irqsave(&drm_minor_lock, flags);
> -	idr_remove(&drm_minors_idr, minor->index);
> -	spin_unlock_irqrestore(&drm_minor_lock, flags);
> +	xa_release(&drm_minors_xa, minor->index);

Has it definitely been unused at this point?  I would think that
xa_erase() (an unconditional store) would be the correct function to
call.

> @@ -122,20 +119,12 @@ static int drm_minor_alloc(struct drm_device *dev, unsigned int type)
>  	minor->type = type;
>  	minor->dev = dev;
>  
> -	idr_preload(GFP_KERNEL);
> -	spin_lock_irqsave(&drm_minor_lock, flags);
> -	r = idr_alloc(&drm_minors_idr,
> -		      NULL,
> -		      64 * type,
> -		      64 * (type + 1),
> -		      GFP_NOWAIT);
> -	spin_unlock_irqrestore(&drm_minor_lock, flags);
> -	idr_preload_end();
> -
> +	r = xa_alloc(&drm_minors_xa, &id, NULL,
> +		     XA_LIMIT(64 * type, 64 * (type + 1) - 1), GFP_KERNEL);
>  	if (r < 0)
>  		return r;
>  
> -	minor->index = r;
> +	minor->index = id;

Wouldn't it be better to call:

	r = xa_alloc(&drm_minors_xa, &minor->index, NULL,
			XA_LIMIT(64 * type, 64 * (type + 1) - 1), GFP_KERNEL);

I might also prefer a little syntactic sugar like:

#define DRM_MINOR_LIMIT(type)	XA_LIMIT(64 * (type), 64 * (type) + 63)

but that's definitely a matter of taste.

> @@ -172,9 +161,12 @@ static int drm_minor_register(struct drm_device *dev, unsigned int type)
>  		goto err_debugfs;
>  
>  	/* replace NULL with @minor so lookups will succeed from now on */
> -	spin_lock_irqsave(&drm_minor_lock, flags);
> -	idr_replace(&drm_minors_idr, minor, minor->index);
> -	spin_unlock_irqrestore(&drm_minor_lock, flags);
> +	entry = xa_store(&drm_minors_xa, minor->index, &minor, GFP_KERNEL);
> +	if (xa_is_err(entry)) {
> +		ret = xa_err(entry);
> +		goto err_debugfs;
> +	}
> +	WARN_ON(entry);

Might be better as an xa_cmpxchg()?

> @@ -187,16 +179,13 @@ static int drm_minor_register(struct drm_device *dev, unsigned int type)
>  static void drm_minor_unregister(struct drm_device *dev, unsigned int type)
>  {
>  	struct drm_minor *minor;
> -	unsigned long flags;
>  
>  	minor = *drm_minor_get_slot(dev, type);
>  	if (!minor || !device_is_registered(minor->kdev))
>  		return;
>  
>  	/* replace @minor with NULL so lookups will fail from now on */
> -	spin_lock_irqsave(&drm_minor_lock, flags);
> -	idr_replace(&drm_minors_idr, NULL, minor->index);
> -	spin_unlock_irqrestore(&drm_minor_lock, flags);
> +	xa_erase(&drm_minors_xa, minor->index);

This isn't an exact replacement, but I'm not sure whether that makes a
difference.  xa_erase() allows allocation of this ID again while
idr_replace() means that lookups return NULL, but the ID remains in
use.  The equivalent of idr_replace() is:
	xa_store(&drm_minors_xa, minor->index, NULL, GFP_KERNEL);

> @@ -215,13 +204,10 @@ static void drm_minor_unregister(struct drm_device *dev, unsigned int type)
>  struct drm_minor *drm_minor_acquire(unsigned int minor_id)
>  {
>  	struct drm_minor *minor;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&drm_minor_lock, flags);
> -	minor = idr_find(&drm_minors_idr, minor_id);
> +	minor = xa_load(&drm_minors_xa, minor_id);
>  	if (minor)
>  		drm_dev_get(minor->dev);
> -	spin_unlock_irqrestore(&drm_minor_lock, flags);

This is also not an exact equivalent as the dev_drm_get() is now outside
the lock.  Does that matter in this case?  I don't know the code well
enough to say.  If you want it to be equivalent, then:

	xa_lock(&drm_minors_xa);
	minor = xa_load(&drm_minors_xa, minor_id);
	if (minor)
		drm_dev_get(minor->dev);
	xa_unlock(&drm_minors_xa);

would be the code to use.

> @@ -1037,7 +1023,7 @@ static void drm_core_exit(void)
>  	unregister_chrdev(DRM_MAJOR, "drm");
>  	debugfs_remove(drm_debugfs_root);
>  	drm_sysfs_destroy();
> -	idr_destroy(&drm_minors_idr);
> +	xa_destroy(&drm_minors_xa);

I don't know if this is the right call.  xa_destroy() is the exact
replacement, but if the xarray should already be empty (and it should,
right?) then asserting the xa_empty() is true may be the better call
to make.


Phew, that was a lot of comments/questions.  I hope that was useful!
