Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A3F53AFB5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiFAWZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 18:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiFAWZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 18:25:52 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EB06446
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 15:25:50 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220601222544euoutp0215d64eac45a22cd170dd7461000544ce~0n4I3aWvT0730907309euoutp02X
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:25:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220601222544euoutp0215d64eac45a22cd170dd7461000544ce~0n4I3aWvT0730907309euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654122344;
        bh=o7I3DBtTGuYXyhj8t1Yuhi5GTNtTOSBL6ssawjuQ1rM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=ST29fSCJXQ9hus2IXA2ieP4uw7x16htW2WcK4pu0kTfhxoAlB4EQVhZdBqrMb8vgV
         pZfR7pywPggWA2ZiGMas9PmYIjrCt1LaEOLwnx1lG5dELcgQGQG7Uj9uEhswT+J1bg
         pHUUGgVCe+UxrkVVJTCeaImz7HcTuaErXjpATUdQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220601222543eucas1p29724fecf05555f495418f7f5f1b635b5~0n4H8_Lwf0069400694eucas1p2j;
        Wed,  1 Jun 2022 22:25:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EA.92.10067.767E7926; Wed,  1
        Jun 2022 23:25:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220601222542eucas1p22b5391bbb854871b63c6d9e099bdacee~0n4HF3kZr0038600386eucas1p2G;
        Wed,  1 Jun 2022 22:25:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220601222542eusmtrp17c8b491c3b9b79f777238579b4ad675d~0n4HFMtdA0738007380eusmtrp1C;
        Wed,  1 Jun 2022 22:25:42 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-30-6297e767c20d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B6.E8.09038.667E7926; Wed,  1
        Jun 2022 23:25:42 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220601222542eusmtip10a26c6e7b7a7e70eeb359295c4949a73~0n4Gmv1zj0182901829eusmtip1E;
        Wed,  1 Jun 2022 22:25:42 +0000 (GMT)
Message-ID: <fb44af37-daf7-974d-95fe-1a6c2cdab676@samsung.com>
Date:   Thu, 2 Jun 2022 00:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [V4] serial: core: Do stop_rx in suspend path for console if
 console_suspend is disabled
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ff029402-f90c-096a-7366-b58f53555ace@quicinc.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7rpz6cnGUyZp25xdtlBNovmxevZ
        LN7NlbG4vGsOm8WZxb3sFp83PGa0WHxpJZvF10uTmS2O33nK5MDpMbvhIovHplWdbB77565h
        95i4p87j8ya5ANYoLpuU1JzMstQifbsEroxbny8zFbwQqzg6ZS1bA+MuoS5GTg4JAROJc+/b
        GUFsIYEVjBITN6R0MXIB2V8YJSZvvswO4XxmlNiz+DAbTEdD61VGiMRyRom90yayQTgfGSVa
        964Dq+IVsJP40DCDFcRmEVCR+LRmMitEXFDi5MwnLCC2qECSxPxtrWBxYYF0iScLtzGB2MwC
        4hK3nsxnAhkqIrCSUWLR1T8sEIlYiY5HL8Ea2AQMJbredoEt4xSwl+g9eJcNokZeYvvbOcwg
        zRICbzgkvjTMh7rbRWL/64nMELawxKvjW9ghbBmJ05N7gBZwANn5En9nGEOEKySuvV4DVW4t
        cefcLzaQEmYBTYn1u/Qhwo4SU683M0J08knceCsIcQGfxKRt05khwrwSHW3QkFaTmHV8HdzO
        gxcuMU9gVJqFFCizkDw/C8kvsxD2LmBkWcUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY
        kE7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4S3ZNTVJiDclsbIqtSg/vqg0J7X4EKM0B4uSOG9y
        5oZEIYH0xJLU7NTUgtQimCwTB6dUA9NiD+290xYsU1vstPlqScupEyd+tuVpV5e4ZN7Y1b9Q
        5OCOXO9A59xGtqe3b6+cerUpKFWKu1//W7CDjtyKhH/8bmdNzP2mXU68tCzHwXxt5yf7n1uv
        Waat97jVLrHmqMrvguOZMQEem2sOntMyfMSt+olj60a7fYnrVnqekUs9UmUXenJrncFPzR4x
        puvMG3wkStb3VLkkbbU95SjHOi+56ZzR/ane67T5Pugf7/hb3RP+cGnDvNWrL35vl49pbZZV
        z9Cc7vszLFzngPbJzlORnyJznyUukjN69e75xS1/fpcwzo5f2WG8bM2Zc/c3L/5d3uqvVLm2
        3oF3on7bKf996dplhi+X7dC8vbHA44wSS3FGoqEWc1FxIgBoERcdtwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xu7ppz6cnGbxbZWBxdtlBNovmxevZ
        LN7NlbG4vGsOm8WZxb3sFp83PGa0WHxpJZvF10uTmS2O33nK5MDpMbvhIovHplWdbB77565h
        95i4p87j8ya5ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzM
        stQifbsEvYxbny8zFbwQqzg6ZS1bA+MuoS5GTg4JAROJhtarjF2MXBxCAksZJbZsn8wKkZCR
        ODmtAcoWlvhzrYsNoug9o8TRvQvYQRK8AnYSHxpmgBWxCKhIfFoD0cwrIChxcuYTFhBbVCBJ
        Yt7e1YwgtrBAusSThduYQGxmAXGJW0/mM4EMFRFYySgxddMxZohErMSrg89YILbtYZJ4+2op
        WDebgKFE11uQMzg5OAXsJXoP3mWDaDCT6NraxQhhy0tsfzuHeQKj0Cwkh8xCsnAWkpZZSFoW
        MLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzEbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4
        S3ZNTRLiTUmsrEotyo8vKs1JLT7EaAoMjYnMUqLJ+cBUkFcSb2hmYGpoYmZpYGppZqwkzutZ
        0JEoJJCeWJKanZpakFoE08fEwSnVwBT9MkA5J6O/SUR/2er1UXfyaqv51XZLJBWt/dJ7StX2
        ef6621skrzrbsUbrbFkxi2l7DSPr9U1qvwsMy7Vb8h5uNxWZLnbOyZrJi0NBOy/de0Wr9JTT
        X+fPLJi0sbjliuTs/DUSHp9c36ZoL1eaZMEwp+fpHBG76Ena6b9/PtYV/CpW/4R1p05z48wj
        3SU6hwwTz7jv+bHlbtbDVUeC3VPXKPXUKB0xnn/rUdKRFdmh61/+3J908tgyJ7X3OV8eT281
        TMl1v/r5tpDRku+/qtec+jYh5KUgC9OZ+BWP7Sc9rs05EiBcMFPu8afzU88UxT9f6ZX3iCGv
        g8lxid0XQ8NbLD4xJjsflWuZ7Pi98pESS3FGoqEWc1FxIgBIMvPjTQMAAA==
X-CMS-MailID: 20220601222542eucas1p22b5391bbb854871b63c6d9e099bdacee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220524115408eucas1p1ddda7aae4db0a65a7d67d6f8c59d404b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220524115408eucas1p1ddda7aae4db0a65a7d67d6f8c59d404b
References: <1652692810-31148-1-git-send-email-quic_vnivarth@quicinc.com>
        <bf7eec57-6ad6-2c1a-ea61-0e1d06fc77f5@samsung.com>
        <CGME20220524115408eucas1p1ddda7aae4db0a65a7d67d6f8c59d404b@eucas1p1.samsung.com>
        <3866c083-0064-ac9a-4587-91a83946525d@samsung.com>
        <ff029402-f90c-096a-7366-b58f53555ace@quicinc.com>
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01.06.2022 13:24, Vijaya Krishna Nivarthi wrote:
> On 5/24/2022 5:24 PM, Marek Szyprowski wrote:
>> On 23.05.2022 23:32, Marek Szyprowski wrote:
>>> Hi,
>>>
>>> On 16.05.2022 11:20, Vijaya Krishna Nivarthi wrote:
>>>> For the case of console_suspend disabled, if back to back 
>>>> suspend/resume
>>>> test is executed, at the end of test, sometimes console would 
>>>> appear to
>>>> be frozen not responding to input. This would happen because, during
>>>> resume, rx transactions can come in before system is ready, 
>>>> malfunction
>>>> of rx happens in turn resulting in console appearing to be stuck.
>>>>
>>>> Do a stop_rx in suspend sequence to prevent this.
>>>>
>>>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>>>> ---
>>>> v4: moved the change to serial core to apply for all drivers
>>>> v3: swapped the order of conditions to be more human readable
>>>> v2: restricted patch to contain only stop_rx in suspend sequence
>>>> v1: intial patch contained 2 additional unrelated changes in vicinity
>>>> ---
>>> This patch landed recently in linux-next as commit c9d2325cdb92
>>> ("serial: core: Do stop_rx in suspend path for console if
>>> console_suspend is disabled").
>>>
>>> Unfortunately it breaks console operation on my test systems after
>>> system suspend/resume cycle if 'no_console_suspend' kernel parameter
>>> is present. System properly resumes from suspend, the console displays
>>> all the messages and even command line prompt, but then doesn't react
>>> on any input. If I remove the 'no_console_suspend' parameter, the
>>> console is again operational after system suspend/resume cycle. Before
>>> this patch it worked fine regardless the 'no_console_suspend' 
>>> parameter.
>>>
>>> If this matters, the test system is ARM 32bit Samsung Exynos5422-based
>>> Odroid XU3lite board.
>>
>> One more information. This issue can be easily reproduced with QEMU. It
>> happens both on ARM 32bit and ARM 64bit QEMU's 'virt' machines when
>> 'no_console_suspend' is added to kernel's cmdline.
>>
> Ideally, as comments indicate, the set_termios should have done 
> stop_rx at begin and start_rx at end to take care of this issue.
>
> This is probably missing in your driver. Can we check if this can be 
> fixed? 

Sure, just point me what need to be added in amba-pl011.c and 
samsung_tty.c. I've briefly compared the suspend/resume paths of those 
drivers with other drivers and I don't see anything missing there.

> OR other option is
>
> Add a start_rx in uart_resume_port after call to set_termios to handle 
> this scenario for other drivers.
>
> Please let me know if there are any concerns for this options.

IMHO this looks like an issue that affects lots of drivers and it should 
be handled in the core.

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

