Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2149CC06
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbiAZOO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiAZOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:14:25 -0500
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969FAC061747;
        Wed, 26 Jan 2022 06:14:25 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ADC0A284992;
        Wed, 26 Jan 2022 14:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1643206457; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references:
         disposition-notification-to; bh=zSeUci3vg054JmvwuBWDHBaCd3Dw4eWxI2aAH6Z4kfU=;
        b=vdyVkyFNapCvR0GVXQljHd4CFBTht7wRCcVWs3zsrjVxlouOMTxRUentMVu6LpLouKBUcI
        QMeOWMTsnQhwGsaRf4Ze+rjDshSLqIKaoN49nFKAE8uFXsH6cq0a9ZIRnHNUX2BGGGasaM
        9scaHtDxAzxXRfujR1bq39JdWUaHkAkYGJYUf0KFCJs+2TK27hvfIrtBWtCou7Iof9lgmP
        FOFWamXON55fxJzTUm6DNgiZHJcTuAtoSMDCYWjIhiJChdDmdLXq/F1cEdtOGQXzzPLOGs
        pzHkK2dXPsueAzTwXH2G+QjCffl+KBOEYF/lPEd00rJdfamil/9Of6hfIk+lXQ==
Subject: Re: [PATCH v7 0/2] Bluetooth: hci_h5: btrtl: Add support for
 RTL8822CS hci_ver 0x08
To:     Marcel Holtmann <marcel@holtmann.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
References: <20220126073905.3637841-1-adeep@lexina.in>
 <9CE136E5-3BEC-42CB-8A19-644E2B4D0D10@holtmann.org>
From:   Vyacheslav <adeep@lexina.in>
Message-ID: <dee7346e-cb1f-27b0-d460-86b86660bd2d@lexina.in>
Date:   Wed, 26 Jan 2022 17:14:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9CE136E5-3BEC-42CB-8A19-644E2B4D0D10@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


26.01.2022 16:40, Marcel Holtmann wrote:
> Hi Vyacheslav,
> 
>> Add a variation of RTL8822CS with hci_ver = 0x08. This is fully similar
>> to RTL8822CS with hci_ver = 0x0a observed on the Tanix TX6 Android set-top
>> box and JetHome JetHub H1.
>>
>> While testing the RTL8822CS SDIO WiFi/BT adapter, I found that in some
>> cases the kernel could not initialize it. However, manually resetting the
>> adapter via gpio allows it to start correctly.
>> Apparently at system start the adapter is in an undefined state (including
>> the unknown state of gpio after starting uboot). A forced reset helps to
>> initialize the adapter in most cases. Experimentally it was found that
>> 100ms is enough to reset.
>> So, add power reset via enable-gpios in h5_btrtl_open function.
>>
>> Changes from v6..v4:
>> - fix patch description
>> Changes from v3:
>> - add has_msft_ext option
>> Changes from v2:
>> - align the patches for bluetooth-next
>> Changes from v1:
>> - remove Signed-off-by chbgdn <chbgdn@gmail.com> as not reachable
>>
>> Vyacheslav Bocharov (2):
>>   Bluetooth: btrtl: Add support for RTL8822C hci_ver 0x08
>>   Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open
>>
>> drivers/bluetooth/btrtl.c  | 8 ++++++++
>> drivers/bluetooth/hci_h5.c | 5 +++++
>> 2 files changed, 13 insertions(+)
> 
> both patches have been applied to bluetooth-next tree.

Thanks!

> 
> Regards
> 
> Marcel
> 

