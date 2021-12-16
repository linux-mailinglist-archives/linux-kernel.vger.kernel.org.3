Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB56A477CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbhLPT6e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Dec 2021 14:58:34 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49704 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbhLPT6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:58:33 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 58604CED18;
        Thu, 16 Dec 2021 20:58:32 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211213185620-mutt-send-email-mst@kernel.org>
Date:   Thu, 16 Dec 2021 20:58:31 +0100
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FF8BA713-6DD2-485B-9ADC-02006126BC60@holtmann.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211209162149-mutt-send-email-mst@kernel.org>
 <20211213054357-mutt-send-email-mst@kernel.org>
 <20211213185620-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

>>>>> Device removal is clearly out of virtio spec: it attempts to remove
>>>>> unused buffers from a VQ before invoking device reset. To fix, make
>>>>> open/close NOPs and do all cleanup/setup in probe/remove.
>>>> 
>>>> so the virtbt_{open,close} as NOP is not really what a driver is suppose
>>>> to be doing. These are transport enable/disable callbacks from the BT
>>>> Core towards the driver. It maps to a device being enabled/disabled by
>>>> something like bluetoothd for example. So if disabled, I expect that no
>>>> resources/queues are in use.
>>>> 
>>>> Maybe I misunderstand the virtio spec in that regard, but I would like
>>>> to keep this fundamental concept of a Bluetooth driver. It does work
>>>> with all other transports like USB, SDIO, UART etc.
>>>> 
>>>>> The cost here is a single skb wasted on an unused bt device - which
>>>>> seems modest.
>>>> 
>>>> There should be no buffer used if the device is powered off. We also don’t
>>>> have any USB URBs in-flight if the transport is not active.
>>>> 
>>>>> NB: with this fix in place driver still suffers from a race condition if
>>>>> an interrupt triggers while device is being reset. Work on a fix for
>>>>> that issue is in progress.
>>>> 
>>>> In the virtbt_close() callback we should deactivate all interrupts.
>>>> 
>>>> Regards
>>>> 
>>>> Marcel
>>> 
>>> So Marcel, do I read it right that you are working on a fix
>>> and I can drop this patch for now?
>> 
>> ping
> 
> 
> If I don't hear otherwise I'll queue my version - it might not
> be ideal but it at least does not violate the spec.
> We can work on not allocating/freeing buffers later
> as appropriate.

I have a patch, but it is not fully tested yet.

Regards

Marcel

