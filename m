Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC0347BA1E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 07:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhLUGnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 01:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbhLUGnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 01:43:42 -0500
X-Greylist: delayed 544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Dec 2021 22:43:41 PST
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5FEC061574;
        Mon, 20 Dec 2021 22:43:41 -0800 (PST)
Received: from [10.36.2.165] (unknown [178.17.145.105])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 52E65260245;
        Tue, 21 Dec 2021 07:34:33 +0100 (CET)
Message-ID: <ce0bf57c-7d96-5c33-6ab5-a64d772dee21@selasky.org>
Date:   Tue, 21 Dec 2021 07:34:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 0/3] Fix streaming on/off logic
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com, pb@linuxtv.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <cover.1632689033.git.mchehab+huawei@kernel.org>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <cover.1632689033.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/21 22:51, Mauro Carvalho Chehab wrote:
> As discussed on:
> 	https://github.com/hselasky/webcamd/issues/16
> 
> the dib0700 had a regression on Kernel 2.6.39. Such regression didn't
> affect most devices, in practice, as it seems to happen only under
> certain circunstances.
> 
> Michael came up with a solution for the issue (already submitted to
> the ML) but let's take the opportunity to do a cleanup, as the resulting
> code was still touching both adapters when an stream off command
> was issued to one adapter, turning on the other one.
> 
> After the change, each adapter is idependently controlled by
> a separate bit, as can be shown when its debug message
> is turned on (tested on a dual-adapter device: Hauppauge
> WinTV Nova TD):
> 
> [608855.124780] adapter 1, streaming ON: 0f 10 12
> [608868.189827] adapter 0, streaming ON: 0f 10 13
> [608879.584330] adapter 1, streaming OFF: 0f 00 11
> [608887.014772] adapter 0, streaming OFF: 0f 00 10
> 
> Mauro Carvalho Chehab (2):
>    media: dib0700: cleanup start/stop streaming logic
>    media: dib0700: Only touch one bit when start/stop an adapter
> 
> Michael Kuron (1):
>    media: dib0700: fix undefined behavior in tuner shutdown
> 
>   drivers/media/usb/dvb-usb/dib0700_core.c | 28 +++++++++++-------------
>   1 file changed, 13 insertions(+), 15 deletions(-)
> 

Were these patches upstreamed yet?

--HPS
