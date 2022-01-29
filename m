Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46FC4A2D6A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 10:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiA2JeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 04:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiA2JeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 04:34:08 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF153C061714;
        Sat, 29 Jan 2022 01:34:08 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d187so8348996pfa.10;
        Sat, 29 Jan 2022 01:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=e1+s0tV2NM8ycsoAVvvJcxRRSB8Uzk8N0RZeeZJQsso=;
        b=kt6gKqVAY+cBpVjOfFNLBtBUEc8nMw7OglSpM5bVIByxFuPLATjnZfWszxFv4vLKFI
         HhcIjvxG58KoWPX1vd0lcVTpsESMIOrQkArVC5RgQQ3zm3A8vQlaCgpsoVNsAzbI/CU3
         ofV7vEKM6gB/7JpRPSRS23+tnJ9swYc9/S896sL1V14fjVU33a/mgIj7PutG9sLIqmFC
         AxYxJ7Itm2400CqMSnWo2wk7V8CdNmiNe4FIPG1GoTuEAyu+PCJVfeKlt8oMHL/TsZab
         WWM9jvNmaOaErCNSoqGHe0pI3wtBv2/Cnm/bdZ6TAkD2qIQgsPnzlM8JcpJCR3Li4fEx
         AOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=e1+s0tV2NM8ycsoAVvvJcxRRSB8Uzk8N0RZeeZJQsso=;
        b=RpzRgambnnmNhwTb+6rb/qXFzC8hP7yBsp7cRgIGcX/E5fYUAclNa7RmaOW7feqEML
         P7emCofh4slCsuhj0kV1zHL4KPuVsmfxtlSZiS8dF6lwBc7idD893n1YwlpS1HQNWICp
         steejZ3Y9Wu74tHO8dRHoPiceLxj5wNqbMnIJi/d4XljPts8HTfk762NXoX5s8ttIsbq
         J6n2CCv09RGy+Ceegrn8T0fpH8sZvpIR02GjAUkD0XY/6nyB3ILIK8ZGR7nl7c9Yb9w2
         vl30//Ve21/Ba1+5QbcwUNn5ilXPW5NMRNvJT6wWWOQxbMCvmBe6ZVYEs4DCyUn08//t
         MeYg==
X-Gm-Message-State: AOAM533VbrgLJcuw8MnIPXEtr3itAzTqarvozpbCkQ568Ya8ZxOqLz4J
        le5/f+XnHzP/2MP6TzwRcXLSLGS8gYY=
X-Google-Smtp-Source: ABdhPJy4G8FisyqpC2Ulu4u+DCrnruoB6Ktq8bxKJ7ApwZGx2xEnqk82iS0MmDevTzj4HMPuVrIk2Q==
X-Received: by 2002:aa7:95b2:: with SMTP id a18mr11718184pfk.39.1643448847776;
        Sat, 29 Jan 2022 01:34:07 -0800 (PST)
Received: from [192.168.1.101] ([166.111.139.99])
        by smtp.gmail.com with ESMTPSA id x17sm11160250pfu.135.2022.01.29.01.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 01:34:07 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] tty: serial: possible deadlock in uart_remove_one_port() and
 uart_hangup()
To:     Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <ab5d9322-6bea-9845-c61b-fb68e3bb3a87@gmail.com>
Date:   Sat, 29 Jan 2022 17:34:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My static analysis tool reports a possible deadlock in the tty driver in 
Linux 5.10:

uart_remove_one_port()
   mutex_lock(&port->mutex); --> Line 3017 (Lock A)
   wait_event(state->remove_wait, ...); --> Line 3019 (Wait X)
   mutex_unlock(&port->mutex); --> Line 3021 (Unlock A)

uart_hangup()
   mutex_lock(&port->mutex); --> Line 1667 (Lock A)
   uart_flush_buffer()
     uart_port_unlock()
       uart_port_deref()
         wake_up(&uport->state->remove_wait); --> Line 68 (Wake X)
   mutex_unlock(&port->mutex); --> Line 1684 (Unlock A)

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


