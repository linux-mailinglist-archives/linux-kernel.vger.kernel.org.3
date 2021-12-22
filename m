Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D11F47D148
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbhLVLuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhLVLuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:50:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15B5C061574;
        Wed, 22 Dec 2021 03:50:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A1B6B81B9C;
        Wed, 22 Dec 2021 11:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5384C36AE5;
        Wed, 22 Dec 2021 11:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640173812;
        bh=D9/QMJD0TS6RQjnDBm7/4H3QQSqZqItVjLEOdt11SSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MFzxMQwq1ilB6fbzZykT8agWnHn/vv4yaR4JsPXQG93CbpwcGEFhK/hM1YMssRDK8
         fanWrqPmuBWk59DvDwp6GS6oRjsCeOzMuz88hNWgZ46r7Ch6m0+wmJY+NCXghVf9Db
         xOYV17OcbRX91z7SzEUCHL0yOno1IWf2zlQMnkGs4PXJtOLycuDTGv52dWNrYCiyng
         iL9vrYZYmkXnDgBY1w+A11JdWRzjuxELCNqXtNzs1ZF1dG0zY4b418vjoSF51EXLmJ
         tRSOiqpwsPpHdYc7kKhB7vyXLRlOXCLi2Noej7i3RaveBXZegzWUXzPp2RSazhptRe
         Nr7D/cRHMSMOA==
Date:   Wed, 22 Dec 2021 12:50:08 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com, pb@linuxtv.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix streaming on/off logic
Message-ID: <20211222125008.705ec458@coco.lan>
In-Reply-To: <ce0bf57c-7d96-5c33-6ab5-a64d772dee21@selasky.org>
References: <cover.1632689033.git.mchehab+huawei@kernel.org>
        <ce0bf57c-7d96-5c33-6ab5-a64d772dee21@selasky.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 21 Dec 2021 07:34:27 +0100
Hans Petter Selasky <hps@selasky.org> escreveu:

> On 9/26/21 22:51, Mauro Carvalho Chehab wrote:
> > As discussed on:
> > 	https://github.com/hselasky/webcamd/issues/16
> > 
> > the dib0700 had a regression on Kernel 2.6.39. Such regression didn't
> > affect most devices, in practice, as it seems to happen only under
> > certain circunstances.
> > 
> > Michael came up with a solution for the issue (already submitted to
> > the ML) but let's take the opportunity to do a cleanup, as the resulting
> > code was still touching both adapters when an stream off command
> > was issued to one adapter, turning on the other one.
> > 
> > After the change, each adapter is idependently controlled by
> > a separate bit, as can be shown when its debug message
> > is turned on (tested on a dual-adapter device: Hauppauge
> > WinTV Nova TD):
> > 
> > [608855.124780] adapter 1, streaming ON: 0f 10 12
> > [608868.189827] adapter 0, streaming ON: 0f 10 13
> > [608879.584330] adapter 1, streaming OFF: 0f 00 11
> > [608887.014772] adapter 0, streaming OFF: 0f 00 10
> > 
> > Mauro Carvalho Chehab (2):
> >    media: dib0700: cleanup start/stop streaming logic
> >    media: dib0700: Only touch one bit when start/stop an adapter
> > 
> > Michael Kuron (1):
> >    media: dib0700: fix undefined behavior in tuner shutdown
> > 
> >   drivers/media/usb/dvb-usb/dib0700_core.c | 28 +++++++++++-------------
> >   1 file changed, 13 insertions(+), 15 deletions(-)
> >   
> 
> Were these patches upstreamed yet?

Those were merged on media upstream tree. They should likely be
merged upstream before v5.17-rc1.

> 
> --HPS



Thanks,
Mauro
