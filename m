Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB6351CC35
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346416AbiEEWjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386467AbiEEWia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B6E6007A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A28B61F51
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4FAC385A4;
        Thu,  5 May 2022 22:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651790084;
        bh=fIcmMOB4OTzUhPRJw5zxd1he8Ws9Ea91j5a5noC1OwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dDjiqn3iXIxsl95pJLRm9hrJchx4WfXEocyDn8SVGogcQ5ZgMmKnU384LgZ4FZvGP
         cjgJqRC9zMQbrvZDuSbZJQboS77aP9g4SNbH88A0AC0dxpNfh0xc6f9SX6tp/JwV94
         q2boySmrpnWmzzZqy8AB0OIdh4Qd7DbjWk6tC+fI=
Date:   Thu, 5 May 2022 23:10:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        John Stultz <john.stultz@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        YC Hung <yc.hung@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [RESEND PATCH v7 1/1] firmware: mediatek: add adsp ipc protocol
 interface
Message-ID: <YnQ9UzeyMTkmyGgD@kroah.com>
References: <20220505053048.13804-1-tinghan.shen@mediatek.com>
 <20220505053048.13804-2-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505053048.13804-2-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 01:30:48PM +0800, Tinghan Shen wrote:
> From: TingHan Shen <tinghan.shen@mediatek.com>
> 
> Some of mediatek processors contain
> the Tensilica HiFix DSP for audio processing.
> 
> The communication between Host CPU and DSP firmware is
> taking place using a shared memory area for message passing.
> 
> ADSP IPC protocol offers (send/recv) interfaces using
> mediatek-mailbox APIs.
> 
> We use two mbox channels to implement a request-reply protocol.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Signed-off-by: TingHan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> Reviewed-by: YC Hung <yc.hung@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/firmware/Kconfig                      |   1 +
>  drivers/firmware/Makefile                     |   1 +
>  drivers/firmware/mediatek/Kconfig             |   9 +
>  drivers/firmware/mediatek/Makefile            |   2 +
>  drivers/firmware/mediatek/mtk-adsp-ipc.c      | 161 ++++++++++++++++++
>  .../linux/firmware/mediatek/mtk-adsp-ipc.h    |  65 +++++++
>  6 files changed, 239 insertions(+)
>  create mode 100644 drivers/firmware/mediatek/Kconfig
>  create mode 100644 drivers/firmware/mediatek/Makefile
>  create mode 100644 drivers/firmware/mediatek/mtk-adsp-ipc.c
>  create mode 100644 include/linux/firmware/mediatek/mtk-adsp-ipc.h

Why do you have a .h file, and export symbols in your .c file, yet you
have no user of these symbols or header file?

Without a user, we can not take this, sorry.

This should just be one single .c file.

Also, why a whole subdirectory for just one .c file?

thanks,

greg k-h
