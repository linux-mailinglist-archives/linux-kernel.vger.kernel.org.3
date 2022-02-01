Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079C54A575F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 07:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiBAGv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 01:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiBAGv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 01:51:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EC0C061714;
        Mon, 31 Jan 2022 22:51:26 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f17so29978383wrx.1;
        Mon, 31 Jan 2022 22:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=S05DVhqTbT+RB8o3R8uA/qBzUeAzOrmXjeGdK13aL5M=;
        b=pY+DZqlkix3Hh7KLGHZ5P2UHhaSPBQYNmENarMRBgqL2biDOtWQSDSSf2QRXqqHlqK
         DSGEdQIxuwNFFHU20+e39VMKU4Gosvw+R2CaF8NB2FUbgiBfwZAhKuXBihLDbGpcGd8M
         PTJ6AeCxz9QFr41hWgCdpyNSCywA6XmBh9ANKi1BvBUXm5iCDdoojOf1Y3CwlNIf2QKq
         ZV+WSyaDibJwTvan310JiI2sk+oHUCVNL9nCE0+bI/yZQ2SCVw0A3UPFUjJzwdfasbt+
         i7NeiQQdsOsgLGxtkIm22/AfajQNzrS9F2Z013MptzwOa5SsCdE9kiNMgl8MSh8polT6
         Kagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=S05DVhqTbT+RB8o3R8uA/qBzUeAzOrmXjeGdK13aL5M=;
        b=1YV9IuCqUlUdbJi9U1Fs2iD9HtaXyRbYfFh0O61H6sURBODKFm+16yq3Cr+YFp5x1c
         1OgpJSP5T84+/kM6zvwQS25KOfq/Ue94waD+5xgMIEqnEc2PPVckv9g3MT8lQKjL4BBM
         GWuowRf5ogJkc48qAUiWyWWiZrU5j3TBCB3X4Ju3gKt8CkM1WeflSwq0fG4d/YUCLQrY
         Qe/h8JUBd57FIjtvgBoziY2EsdpNycuGdjnEGf8lXiKUkYIfH6SFSaX45mqKShuUgPAD
         xXbDWlhmLiambZDGF2WzgYla/mI7Tzm4gKqiFlggYUX1EK/sl0PDZXDMelFk/ezZAkuP
         xBsg==
X-Gm-Message-State: AOAM530IhpkrcsMweMYVvBMxiesIF8igqytFDO2xMTr6ojOknavXVhx+
        GQ/nLVfyW1T/H5TSi3nsaXmvncxHZdw=
X-Google-Smtp-Source: ABdhPJxLGPjz01812V0ogRMuAlkgcOqgFWL13OeAHt6/+fHJqtPANawDYJy5IAOZPslwyZZ4zXMLVg==
X-Received: by 2002:a05:6000:2c5:: with SMTP id o5mr20240075wry.225.1643698284851;
        Mon, 31 Jan 2022 22:51:24 -0800 (PST)
Received: from [10.152.0.6] ([85.203.46.180])
        by smtp.gmail.com with ESMTPSA id f13sm14557268wri.44.2022.01.31.22.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 22:51:24 -0800 (PST)
Subject: Re: [BUG] tty: serial: possible deadlock in uart_remove_one_port()
 and uart_hangup()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <ab5d9322-6bea-9845-c61b-fb68e3bb3a87@gmail.com>
 <YfUPlYwoWpMjhvpR@kroah.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <027e2ecd-ccb3-d772-dc31-951039fdeedf@gmail.com>
Date:   Tue, 1 Feb 2022 14:51:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YfUPlYwoWpMjhvpR@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/29 17:57, Greg KH wrote:
> On Sat, Jan 29, 2022 at 05:34:05PM +0800, Jia-Ju Bai wrote:
>> Hello,
>>
>> My static analysis tool reports a possible deadlock in the tty driver in
>> Linux 5.10:
> 5.10 was released over a year ago and over 100 thousand changes ago.
> Please redo your check on 5.16 at the oldest.

My static analysis tool checks the tty driver in Linux 5.16, and also 
finds this possible deadlock:

uart_remove_one_port()
   mutex_lock(&port->mutex); --> Line 3032 (Lock A)
   wait_event(state->remove_wait, ...); --> Line 3034 (Wait X)
   mutex_unlock(&port->mutex); --> Line 3036 (Unlock A)

uart_hangup()
   mutex_lock(&port->mutex); --> Line 1669 (Lock A)
   uart_flush_buffer()
     uart_port_unlock()
       uart_port_deref()
         wake_up(&uport->state->remove_wait); --> Line 68 (Wake X)
   mutex_unlock(&port->mutex); --> Line 1686 (Unlock A)

When uart_remove_one_port() is executed, "Wait X" is performed by 
holding "Lock A". If uart_hangup() is executed at this time, "Wake X" 
cannot be performed to wake up "Wait X" in uart_remove_one_port(), 
because "Lock A" has been already hold by uart_remove_one_port(), 
causing a possible deadlock.

I am not quite sure whether this possible problem is real and how to fix 
it if it is real.
Maybe we can call wait_event() before mutex_lock() in 
uart_remove_one_port().
Any feedback would be appreciated, thanks :)


Best wishes,
Jia-Ju Bai

