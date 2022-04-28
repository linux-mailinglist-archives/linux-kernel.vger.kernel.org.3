Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C83A513839
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349090AbiD1P0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349092AbiD1P0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:26:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E65FB6E79
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:23:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C096561E9F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD09C385A0;
        Thu, 28 Apr 2022 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651159400;
        bh=fotImP6RjEaX7iNcOVKBbxLYwLOMLdnMO2tvTLVJfxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDVzZLWsl3lH8dn5oJJ4v8Ahr6iSPfe1t6jAyTAiIxBbvadQiMWISP+uOcoQ3CisD
         ZCQY3OyXU1AwDBw1NnXkqRZzVz+eTGSbsf22eegVnuWPC23RiKmDh1mznaL9LyG2Er
         j5ZtMKesZGM9EfUxFfAnX/bQDFUVhpO2f1rqP1Ro=
Date:   Thu, 28 Apr 2022 17:23:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adrien Thierry <athierry@redhat.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vchiq_arm: use standard print helpers
Message-ID: <YmqxZevQJpWuLlQ3@kroah.com>
References: <20220428150550.261499-1-athierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428150550.261499-1-athierry@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 11:05:49AM -0400, Adrien Thierry wrote:
> Replace the custom debug print macros with the standard dev_err() and
> friends.
> 
> This handles TODO item "Cleanup logging mechanism".
> 
> Signed-off-by: Adrien Thierry <athierry@redhat.com>
> ---
> 
> Changes since v1: removed function name in dev_dbg() calls
> 
>  .../interface/vchiq_arm/vchiq_arm.c           | 157 +++---
>  .../interface/vchiq_arm/vchiq_connected.c     |   7 +-
>  .../interface/vchiq_arm/vchiq_connected.h     |   4 +-
>  .../interface/vchiq_arm/vchiq_core.c          | 495 ++++++++----------
>  .../interface/vchiq_arm/vchiq_core.h          |  43 +-
>  .../interface/vchiq_arm/vchiq_debugfs.c       | 105 ----
>  .../interface/vchiq_arm/vchiq_dev.c           |  86 ++-
>  7 files changed, 341 insertions(+), 556 deletions(-)

Try doing this in smaller chunks.  There's a lot of churn here, and not
all of it is correct.

Try removing these one-function-at-a-time and then when it's all
finished, you can remove the debugfs and function calls as no one is
calling them.

That way it's also easier to review, as-is, this is a tough review.
Would you want to review this at once?

A few odd things that jumped out at me:

> @@ -1332,6 +1325,8 @@ vchiq_keepalive_thread_func(void *v)
>  	struct vchiq_state *state = (struct vchiq_state *)v;
>  	struct vchiq_arm_state *arm_state = vchiq_platform_get_arm_state(state);
>  
> +	struct device *dev = state->dev;
> +

Checkpatch should have warned you about the extra blank line here.  Put
all variables one after each other please.

> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
> @@ -27,7 +27,7 @@ static void connected_init(void)
>   * be made immediately, otherwise it will be deferred until
>   * vchiq_call_connected_callbacks is called.
>   */
> -void vchiq_add_connected_callback(void (*callback)(void))
> +void vchiq_add_connected_callback(struct device *dev, void (*callback)(void))

Pass in the real vchiq device pointer, not a struct device.

> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h
> @@ -4,7 +4,9 @@
>  #ifndef VCHIQ_CONNECTED_H
>  #define VCHIQ_CONNECTED_H
>  
> -void vchiq_add_connected_callback(void (*callback)(void));
> +#include <linux/device.h>

Don't include the .h file here, it shouldn't be needed if you make this
the same real device type.

>  
>  struct vchiq_state {
> +	struct device *dev;

Careful now, have you properly handled the reference counting?  I can't
tell so you should do this type of change on it's own to make it obvious
you handle it properly.

> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> @@ -37,6 +37,8 @@ static const char *const ioctl_names[] = {
>  	"CLOSE_DELIVERED"
>  };
>  
> +static struct miscdevice vchiq_miscdev;

That looks really odd.  If you create this, where are you initializing
it?  Did you test this code?

thanks,

greg k-h
