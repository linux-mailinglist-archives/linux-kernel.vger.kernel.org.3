Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2EC4D8AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243474AbiCNRhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243330AbiCNRhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:37:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B2C9FC1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2500BB80EA8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3E3C340E9;
        Mon, 14 Mar 2022 17:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647279351;
        bh=23aGtBZ+roTpnSTpxgU+DVYehJCSbai+m5P8j3ght4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aS96RNBHOWtZ2Oa9UTMul1NAoszWh1lDejKFfG3GocyL5aZTUWWXW3pyaKmjckJY/
         Nf2GH2QdHuP5ms3Ad4coPZ2kz05CVoVxdfsKhYkBp7IT7pTY9juZZlbtJl/51nDBHx
         wIj3Uuy2qQfXCLJCO07Aq/FhqA806LDolCnAIkAc=
Date:   Mon, 14 Mar 2022 18:35:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: vt6656: Remove unused 5GHz support
Message-ID: <Yi9868MQr4CQLgIV@kroah.com>
References: <cover.1646935331.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646935331.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 07:54:02PM +0100, Philipp Hortmann wrote:
> vt6655 (PCI) and vt6656 (USB) do only support 2.4GHz band and not 5GHz band.
> Both drivers do allow only one vendor id and device id.
> So no other devices are covered by those drivers.
> Because of this the following priv->rf_type cannot occure:
> RF_AIROHA7230
> RF_VT3342A0
> 
> ---
> Tested with vt6656 on mini PCIe card (connected over USB)
> which is using rf_type: RF_VT3226D0 (2.4GHz only)
> Tested with vt6656 as USB Plugin Module
> which is using rf_type: RF_AL2230S (2.4GHz only)
> In order to combine vt665x infrastructure it is important
> that vt6655 is also not using this code. (Patch already provided)
> vt6655 on mini PCI Module is using
> rf_type: RF_AIROHA (2.4GHz only)
> 
> Philipp Hortmann (5):
>   staging: vt6656: Remove unused rf_type in channel.c
>   staging: vt6656: Remove unused rf_type in baseband.c
>   staging: vt6656: Remove unused rf_type in rf.c; top level
>   staging: vt6656: Remove unused rf_type in rf.c; unused variables
>   staging: vt6656: Remove unused rf_type in card.c
> 
>  drivers/staging/vt6656/baseband.c |  16 +-
>  drivers/staging/vt6656/card.c     |  16 --
>  drivers/staging/vt6656/channel.c  |  96 +------
>  drivers/staging/vt6656/rf.c       | 413 +-----------------------------
>  4 files changed, 10 insertions(+), 531 deletions(-)
> 
> -- 
> 2.25.1
> 
> 

If you could send follow-on patchs for the kernel test bot warnings,
that would be great.

thanks,

greg k-h
