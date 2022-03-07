Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521694CF2FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiCGHz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiCGHzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:55:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2664474A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:54:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A52EB81020
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224A2C340EF;
        Mon,  7 Mar 2022 07:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646639666;
        bh=nSHbSNLVLura+a601pjRTuAdhTA5vDw6fiYHhx3TNLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zIimn5Sx+tC7b+DMFcIIkUqq8UryWrQvKOuJInbgqBVfSSygtbuqc0cDSPChgRwaI
         tyLVJNxFVqZZA5nzyQD7i61k7OdjoKF+3ZFydQbqnW2Si6iwzYO+WgKMBnldFgHAfo
         m64ryOlKQUmo0QQTAOXbRw8Hqmc6LkDBEqScMw/8=
Date:   Mon, 7 Mar 2022 08:54:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oh Eomji <eomji.oh@samsung.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        JaeHun Jung <jh0801.jung@samsung.com>
Subject: Re: [PATCH 1/2] sound: usb: Add vendor's hooking interface
Message-ID: <YiW6L9nv1+GwDEpd@kroah.com>
References: <CGME20220307022409epcas2p4a2955a746c87d66564556e18ab94845f@epcas2p4.samsung.com>
 <1646619720-97113-1-git-send-email-eomji.oh@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646619720-97113-1-git-send-email-eomji.oh@samsung.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 11:21:59AM +0900, Oh Eomji wrote:
> In mobile, a co-processor can be used with USB audio to improve power
> consumption.  To support this type of hardware, hooks need to be added
> to the USB audio subsystem to be able to call into the hardware when
> needed.
> 
> The main operation of the call-backs are:
>   - Initialize the co-processor by transmitting data when initializing.
>   - Change the co-processor setting value through the interface
>     function.
>   - Configure sampling rate
>   - pcm open/close
>   - other housekeeping

You need to supply the users of the callbacks/hooks, otherwise we can
not properly evaluate them, nor can we accept them.

I have been saying this for over a year, please submit ALL of the needed
parts for these hooks to even be able to be considered.  Otherwise they
will just be ignored for the obvious reasons stated numerous times in
the past.

thanks,

greg k-h
