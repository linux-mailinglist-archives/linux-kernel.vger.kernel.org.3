Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294DE5329C2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiEXLyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiEXLyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:54:19 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EDA5D192
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:54:13 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220524115409euoutp0286ada8a227741c4e75a6f4030b752904~yCGZ1yVyn1698716987euoutp02J
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:54:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220524115409euoutp0286ada8a227741c4e75a6f4030b752904~yCGZ1yVyn1698716987euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653393249;
        bh=yT/79pn8tfNbkmklbfRodID9kX1dePZImAH6HmhhX8I=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=gnlxr01a0kcn1+hNmLjNHo9QRrSMmysU8kgyE8VEVvC8qxyFpMRckQc/sO3r6NT7M
         mxKYxgTutkJTmNwZmKL17Lhc5Hso9SNdmACK6m12dYszBNISiBfdkRfkKqHlQwJKSg
         FLbGi6jHjJwwtIJddCdiZyFghR1HGZ9wBorqn9F0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220524115408eucas1p1a7b32022daa40fceed58ddd532a2bebb~yCGZaqBFb0501305013eucas1p1l;
        Tue, 24 May 2022 11:54:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4D.24.10260.067CC826; Tue, 24
        May 2022 12:54:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220524115408eucas1p1ddda7aae4db0a65a7d67d6f8c59d404b~yCGZA2Wvx0273402734eucas1p1a;
        Tue, 24 May 2022 11:54:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220524115408eusmtrp1d3c1948dd7b38679ed339ac66513e630~yCGY-7yRG1897318973eusmtrp1c;
        Tue, 24 May 2022 11:54:08 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-1d-628cc760f75e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CA.D4.09404.067CC826; Tue, 24
        May 2022 12:54:08 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220524115407eusmtip2b29283fa052f60b6370ab701558e655a~yCGYa_tCb2983429834eusmtip2g;
        Tue, 24 May 2022 11:54:07 +0000 (GMT)
Message-ID: <3866c083-0064-ac9a-4587-91a83946525d@samsung.com>
Date:   Tue, 24 May 2022 13:54:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [V4] serial: core: Do stop_rx in suspend path for console if
 console_suspend is disabled
Content-Language: en-US
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org
In-Reply-To: <bf7eec57-6ad6-2c1a-ea61-0e1d06fc77f5@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djPc7oJx3uSDD51GlucXXaQzaJ58Xo2
        i3dzZSwu75rDZnFmcS+7xecNjxktFl9ayWbx9dJkZovjd54yOXB6zG64yOKxaVUnm8f+uWvY
        PSbuqfP4vEkugDWKyyYlNSezLLVI3y6BK+Pr+wuMBZMlKqZ0fmRrYHwv3MXIySEhYCIx8e1L
        NhBbSGAFo8TqLwldjFxA9hdGibO/77BDOJ8ZJfYducIK0/H32FNGiMRyRoldN/cxQTgfGSXe
        /GxkBqniFbCTuNP/AGwui4CqxNedi5gg4oISJ2c+YQGxRQWSJN68uQpWLyyQLvFk4TawGmYB
        cYlbT+aD2WwChhJdb7vYQBaICKxklFh09Q8LRFGsRMejl0AncXBwCthLXGgthAjLSzRvnc0M
        Ui8h8IJDorljPjvE2S4SE3d+gnpBWOLV8S1QcRmJ05N7WEDmSAjkS/ydYQwRrpC49noNM4Rt
        LXHn3C82kBJmAU2J9bv0IcKOElOvNzNCdPJJ3HgrCHEBn8SkbdOZIcK8Eh1tQhDVahKzjq+D
        23nwwiXmCYxKs5DCZBaS32ch+WUWwt4FjCyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcx
        AtPR6X/Hv+5gXPHqo94hRiYOxkOMEhzMSiK8KWE9SUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        kzM3JAoJpCeWpGanphakFsFkmTg4pRqY5ErZal27H5yef+F6s5qJ/fxF59ac4md/tVn3caw+
        S9LFfCMGzdyOXWnJltKKJzw+qfb9+P3NOSffW/CErOdr7sm16RpZZ2843tyg9cVcbXPIod3+
        L9o5589pvTBJjfNIxh8WHRHBqBg2Ho/Y7QvYTrLf3bmnWa33ePYpvfBPLiXedkdufE9d+vXW
        14NX9/ybm5p24sPDvaV/fLqnpk+okfq+6zh71s6Q8PuPuz3Wb+OVXqHE/PRF4mUtyfsp8x39
        aiJOuumIvmX8oly6J32TlVLbES6NI5Gi81/FZnXpcxVeCd7TslnR5FaqM4vr9f218Xtu17aZ
        eK2dJXLo7JSp0Stf6N3l7Xq0YsuK/MAXSizFGYmGWsxFxYkAY0pknrYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xe7oJx3uSDDYeEbY4u+wgm0Xz4vVs
        Fu/mylhc3jWHzeLM4l52i88bHjNaLL60ks3i66XJzBbH7zxlcuD0mN1wkcVj06pONo/9c9ew
        e0zcU+fxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsbX9xcYCyZLVEzp/MjWwPheuIuRk0NCwETi77GnjF2MXBxCAksZJZZdeMUIkZCR
        ODmtgRXCFpb4c62LDaLoPaPE5MePwBK8AnYSd/ofsIHYLAKqEl93LmKCiAtKnJz5hKWLkYND
        VCBJ4shhfpCwsEC6xJOF28BKmAXEJW49mQ9mswkYSnS9hZgvIrCSUWLqpmPMEEWxEq8OPmMB
        sYUE6iTeHwcp4uDgFLCXuNBaCFFiJtG1tYsRwpaXaN46m3kCo9AsJFfMQrJuFpKWWUhaFjCy
        rGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMwW3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeFPC
        epKEeFMSK6tSi/Lji0pzUosPMZoCg2Iis5Rocj4wCeSVxBuaGZgamphZGphamhkrifN6FnQk
        CgmkJ5akZqemFqQWwfQxcXBKNTCx8XbcsT7669/zzjv37JNM7G5vK8tw5xN/6HL3TezptxMm
        rlm78cCOqZ7OWw9Oqb6jeHlVx8Trf545tx4LEu/aeH3ZI5Gtx2pmPb1ePOOiiUHsyixhw9XK
        866FfJnO8Sjw3mMv+b1KrR5q+xlUGOT3JVfLbuJXuT2PwUZ39mYL87vix7/Y+caEtyU67Hy0
        ik0oI820Ppzxdua738HnWOMKuVemWW/uv2L+6s3mbaufHL3JN3PCjrsRDh/eXVBYOXPr7mlf
        e1l4C3f27nk0Vdqxu6G/c15VYcZHnXSnLTzFV5veVD1MOq35z/757b1KCU4muUs3ajN1/T0Y
        ddhqxuPjXQnhf8rLDrx8lhkS7q16RomlOCPRUIu5qDgRAFo4T8NKAwAA
X-CMS-MailID: 20220524115408eucas1p1ddda7aae4db0a65a7d67d6f8c59d404b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220524115408eucas1p1ddda7aae4db0a65a7d67d6f8c59d404b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220524115408eucas1p1ddda7aae4db0a65a7d67d6f8c59d404b
References: <1652692810-31148-1-git-send-email-quic_vnivarth@quicinc.com>
        <bf7eec57-6ad6-2c1a-ea61-0e1d06fc77f5@samsung.com>
        <CGME20220524115408eucas1p1ddda7aae4db0a65a7d67d6f8c59d404b@eucas1p1.samsung.com>
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.2022 23:32, Marek Szyprowski wrote:
> Hi,
>
> On 16.05.2022 11:20, Vijaya Krishna Nivarthi wrote:
>> For the case of console_suspend disabled, if back to back suspend/resume
>> test is executed, at the end of test, sometimes console would appear to
>> be frozen not responding to input. This would happen because, during
>> resume, rx transactions can come in before system is ready, malfunction
>> of rx happens in turn resulting in console appearing to be stuck.
>>
>> Do a stop_rx in suspend sequence to prevent this.
>>
>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>> ---
>> v4: moved the change to serial core to apply for all drivers
>> v3: swapped the order of conditions to be more human readable
>> v2: restricted patch to contain only stop_rx in suspend sequence
>> v1: intial patch contained 2 additional unrelated changes in vicinity
>> ---
>
> This patch landed recently in linux-next as commit c9d2325cdb92 
> ("serial: core: Do stop_rx in suspend path for console if 
> console_suspend is disabled").
>
> Unfortunately it breaks console operation on my test systems after 
> system suspend/resume cycle if 'no_console_suspend' kernel parameter 
> is present. System properly resumes from suspend, the console displays 
> all the messages and even command line prompt, but then doesn't react 
> on any input. If I remove the 'no_console_suspend' parameter, the 
> console is again operational after system suspend/resume cycle. Before 
> this patch it worked fine regardless the 'no_console_suspend' parameter.
>
> If this matters, the test system is ARM 32bit Samsung Exynos5422-based 
> Odroid XU3lite board.


One more information. This issue can be easily reproduced with QEMU. It 
happens both on ARM 32bit and ARM 64bit QEMU's 'virt' machines when 
'no_console_suspend' is added to kernel's cmdline.


>
>>   drivers/tty/serial/serial_core.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c 
>> b/drivers/tty/serial/serial_core.c
>> index 82a1770..9a85b41 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -2211,9 +2211,16 @@ int uart_suspend_port(struct uart_driver *drv, 
>> struct uart_port *uport)
>>       }
>>       put_device(tty_dev);
>>   -    /* Nothing to do if the console is not suspending */
>> -    if (!console_suspend_enabled && uart_console(uport))
>> +    /*
>> +     * Nothing to do if the console is not suspending
>> +     * except stop_rx to prevent any asynchronous data
>> +     * over RX line. Re-start_rx, when required, is
>> +     * done by set_termios in resume sequence
>> +     */
>> +    if (!console_suspend_enabled && uart_console(uport)) {
>> +        uport->ops->stop_rx(uport);
>>           goto unlock;
>> +    }
>>         uport->suspended = 1;
>
> Best regards

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

