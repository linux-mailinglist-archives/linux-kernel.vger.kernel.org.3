Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2A494723
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 07:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358665AbiATGNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 01:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiATGNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 01:13:08 -0500
X-Greylist: delayed 86091 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jan 2022 22:13:07 PST
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52BFC061574;
        Wed, 19 Jan 2022 22:13:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4751126BA39;
        Thu, 20 Jan 2022 06:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1642659185; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references:
         disposition-notification-to; bh=60ROdBoSgjYj6mcg5VXjSIMxW+vxIg8IHtPdRD0C6Gw=;
        b=JMh64o2tVBlsbnPLsKs2ZjwT6bd74SVLAZ6M7aekxTyin13S2hlzsL57R7I3gBAN1MuvtN
        hDr8cAV1lttcORORSa2sHLZ60TLXNRH7nalBTT+VU+K2ta2KTfBr2cSkKmCEvGl7+4LyPw
        +jcBPeiw9dVpijggr8R8xfZaKq5bauMbybBP7INGiolruCM4qrAv5NF1WPI8TcZQbnNVDo
        qw4Ig4w/mhRzbrOVuUR8charo2ZmRXOrnHQHc0dnFmg+x0+Qj1TKMtA+M77WgvYQJ1xgOw
        D1s2X/pAnCxHiUku8repbVEN1KwLXwy3EXHm80lyjWXoED08+tB0uomCPmECWA==
Subject: Re: [PATCH v4 2/2] Bluetooth: hci_h5: Add power reset via gpio in
 h5_btrtl_open
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220119061723.2862683-1-adeep@lexina.in>
 <20220119061723.2862683-3-adeep@lexina.in>
 <2591AB28-2072-4345-907D-17AAA49B21CE@holtmann.org>
From:   Vyacheslav <adeep@lexina.in>
Message-ID: <57978333-f2d2-ca7e-947b-8d184fe30d94@lexina.in>
Date:   Thu, 20 Jan 2022 09:13:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2591AB28-2072-4345-907D-17AAA49B21CE@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

19.01.2022 22:32, Marcel Holtmann wrote:
> Hi Vyacheslav,
> 
>> Add power reset via enable-gpios in h5_btrtl_open function.
> 
> this is too sparse commit message. Add explation and if possible also references on why that is needed.

While testing the RTL8822CS SDIO WiFi/BT adapter, I found that in some 
cases the kernel could not initialize it. However, manually resetting 
the adapter via gpio allows it to start correctly.
Apparently at system start the adapter is in an undefined state 
(including the unknown state of gpio after starting uboot). A forced 
reset helps to initialize the adapter in most cases. Experimentally it 
was found that 100ms is enough to reset.

Since I am new to wireless drivers feel free correct me.

-- 
Vyacheslav Bocharov
