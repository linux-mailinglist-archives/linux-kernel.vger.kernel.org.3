Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CB857F543
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 15:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiGXNoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiGXNoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 09:44:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D838FEE0D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 06:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94C7CB80D55
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 13:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4120C3411E;
        Sun, 24 Jul 2022 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658670291;
        bh=O/cOxJ9L63ifoCe9+9dSUAXEslu7LZkosYany1YVKqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2AI7e3RI40QvP6QDjf3L9ESDBHQgX9rnJULejuUNTcp+Nryo6T1folQJhAWos8WXR
         IpPuvjNDCu6KQ8I+ldfeqCs8cZGPC1UIB+8jy7gKcum4GbRbGfnB9MMGL0hsFNJD/o
         iYRY2zub1YqcB3DBAKdiwKf7zIEImWklVSA7CujI=
Date:   Sun, 24 Jul 2022 15:44:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: Re: [PATCH v6 02/14] mei: add slow_fw flag to the mei auxiliary
 device
Message-ID: <Yt1Mz3xni/UG4vPP@kroah.com>
References: <20220724082428.218628-1-tomas.winkler@intel.com>
 <20220724082428.218628-3-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724082428.218628-3-tomas.winkler@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 11:24:16AM +0300, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> Add slow_fw flag to the mei auxiliary device info
> to inform the mei driver about slow underlying firmware.
> Such firmware will require to use larger operation timeouts.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> ---
>  include/linux/mei_aux.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
> index 587f25128848..a29f4064b9c0 100644
> --- a/include/linux/mei_aux.h
> +++ b/include/linux/mei_aux.h
> @@ -11,6 +11,7 @@ struct mei_aux_device {
>  	struct auxiliary_device aux_dev;
>  	int irq;
>  	struct resource bar;
> +	bool slow_fw;

Please spell this out "slow_firmware", and also document it somewhere.

thanks,

greg k-h
