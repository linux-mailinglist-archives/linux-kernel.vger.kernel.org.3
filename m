Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6505ACF5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiIEJ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiIEJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:59:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443D921E1F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 02:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4EF5B81012
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:58:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1808C433D6;
        Mon,  5 Sep 2022 09:58:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VWFHvdWM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1662371936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=djzuTynXF33xQt9q6oEjyvObywHD8Hr3NC7Wxk5AXsI=;
        b=VWFHvdWMW4zOjNS0XpHuYj0C8Ifmw6QhsyJSAcgctde2p9CBH52A48LgfhTXfQtyaJz2Yf
        WWfKoJnB7TVplT2la6th76L6BFK/hpCMlDKq35Znht5NX/S7zFO+R6twnFNXvFN18DSEIr
        8unP9q4DYGX3c65pLM0vKVmj7+MrPIc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d15a05f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 5 Sep 2022 09:58:56 +0000 (UTC)
Date:   Mon, 5 Sep 2022 11:58:50 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, 89q1r14hd@relay.firefox.com,
        linux-kernel@vger.kernel.org, Wim Taymans <wtaymans@redhat.com>
Subject: Re: [PATCH] ALSA: usb-audio: Refcount multiple accesses on the
 single clock
Message-ID: <YxXIWv8dYmg1tnXP@zx2c4.com>
References: <20220516104807.16482-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220516104807.16482-1-tiwai@suse.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

On Mon, May 16, 2022 at 12:48:07PM +0200, Takashi Iwai wrote:
> When a clock source is connected to multiple nodes / endpoints, the
> current USB-audio driver tries to set up at each time one of them is
> configured.  Although it reads the current rate and updates only if it
> differs, some devices seem unhappy with this behavior and spew the
> errors when reading/updating the rate unnecessarily.
> 
> This patch tries to reduce the redundant clock setup by introducing a
> refcount for each clock source.  When the stream is actually running,
> a clock rate is "locked", and it bypasses the clock and/or refuse to
> change any longer.

This breaks things on 5.19+. Specifically, it causes pipewire and
pulseaudio to be stuck using 44.1khz rather than 48.0khz (or anything
else). The reason is that initially devices are started at 44.1khz, and
then the list of supported sample rates is read, and finally the best
one is chosen. With this commit, the returned list of sample rates is
locked at 44.1khz, which means pulseaudio and pipewire can't change it
to 48.0khz (or anything else).

This headscratcher is being tracked over at:
https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2620
where I triaged it to this commit.

Can we revert this for the time being and backport the revert to stable?
Or might you have some other fix idea in mind?

Thanks,
Jason
