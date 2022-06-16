Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE954E65E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiFPPs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiFPPs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:48:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D789E3A5E4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=J4jPWp33wI6h8Ur/ZqXqPougpPgiQTbckyhfVsNptl0=; b=ibHuKqDYB9Y71kakQ/FkADzCCy
        Vu++A1coFokOEZ4BYtplTPzg7JBfHXccVca4Eqi0+rsNpXzuJ0WSDGlPGVe1mgGs8zEG8WlNgs96e
        JIKvdbGuQCOqPpgZeo8QLfAfRMZ6jFdZawMYzwQ+Psx8U0AU6ikbg5CR0YVNzuIlZEFFEHzcZBhsL
        1e1o9XfGsJXRFcASEl7jVr1TUOEQLs/Pb/ztPrO4W8v/wU7t0Pt1znpVo6jAVXbZMjYG/28S7qIiH
        5lbdIu2kNS7oHpk8Q+Z/uNsUEUAYw6df2IjROYlUksdkZuKWY4MlNqxc9Cf3SNUVmd3kwJ3gAfyw7
        SA0bKfsQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1rjB-008Rpl-69; Thu, 16 Jun 2022 15:48:14 +0000
Message-ID: <b844d2f5-3187-1d53-da14-1d1cf99d0f4e@infradead.org>
Date:   Thu, 16 Jun 2022 08:48:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2 2/2] drm: xlnx: dsi: Add Xilinx MIPI DSI-Tx subsystem
 driver
Content-Language: en-US
To:     Venkateshwar Rao Gannavarapu 
        <venkateshwar.rao.gannavarapu@xilinx.com>,
        laurent.pinchart@ideasonboard.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        vgannava@xilinx.com
References: <1655389056-37044-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
 <1655389056-37044-3-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1655389056-37044-3-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/22 07:17, Venkateshwar Rao Gannavarapu wrote:
> diff --git a/drivers/gpu/drm/xlnx/Kconfig b/drivers/gpu/drm/xlnx/Kconfig
> index f9cf93c..a75bd76 100644
> --- a/drivers/gpu/drm/xlnx/Kconfig
> +++ b/drivers/gpu/drm/xlnx/Kconfig
> @@ -1,3 +1,15 @@
> +config DRM_XLNX_DSI
> +	tristate "Xilinx DRM DSI Subsystem Driver"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on DRM && OF
> +	select DRM_KMS_HELPER
> +	select DRM_MIPI_DSI
> +	select DRM_PANEL_BRIDGE
> +	help
> +	  DRM bridge driver for Xilinx programmable DSI subsystem controller.
> +	  choose this option if you hava a Xilinx MIPI-DSI Tx subsytem in

	  Choose

> +	  video pipeline.

-- 
~Randy
