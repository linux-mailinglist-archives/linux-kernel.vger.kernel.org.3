Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09140514C66
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349846AbiD2OLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377154AbiD2OLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:11:17 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F84685944
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:07:23 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220429135334euoutp01d4bfca43955b6db73f3fd383e46141fe~qYmiIRWoS0325003250euoutp01j
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:53:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220429135334euoutp01d4bfca43955b6db73f3fd383e46141fe~qYmiIRWoS0325003250euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651240414;
        bh=0VAhn2JbS8HsCUQk6e21RHHU2VGIiodKXd5WObE+o0s=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=hkHitVgRdfRDiMgKa05w/C3LEsrMhxxr2NYgBjyGwdQ5Oe+Y6brGktwi89nA/zxuC
         8TITMBiOBlZjPyFCG5Hf2wvf7DDeReUuK2GEL2nfzby74tWgur6XglbNX0PqtgUPPp
         gXCbWWuNwDTUJcOcg3oXgmPKXTT6L1vpupkC8pWo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220429135334eucas1p1abf0f1f46a376a73d660515541a96631~qYmh5BO143245632456eucas1p1V;
        Fri, 29 Apr 2022 13:53:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AE.0E.10009.EDDEB626; Fri, 29
        Apr 2022 14:53:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220429135333eucas1p2283a518d0f595d2101e662af4878dc99~qYmhlrMNI0878208782eucas1p2j;
        Fri, 29 Apr 2022 13:53:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220429135333eusmtrp26ec90e961dd9caf6df74cb144b53d0a3~qYmhk9ZAm2499424994eusmtrp2M;
        Fri, 29 Apr 2022 13:53:33 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-81-626bedde3dec
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 47.B8.09522.DDDEB626; Fri, 29
        Apr 2022 14:53:33 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220429135333eusmtip2495b17828f100ae10d2d1482eaad124b~qYmg7jDsY1977219772eusmtip2T;
        Fri, 29 Apr 2022 13:53:33 +0000 (GMT)
Message-ID: <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
Date:   Fri, 29 Apr 2022 15:53:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <87fslyv6y3.fsf@jogness.linutronix.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djPc7r33mYnGazs57JoXryezWLblfmM
        Fgtmc1tc3jWHzeL/46+sFvs6HjBZ7N64iM1i86apzA4cHrMbLrJ4tOy7xe7x7tw5do/9c9ew
        e2xeUu+xfstVFo/Pm+QC2KO4bFJSczLLUov07RK4Ms79/s1ccEKiov/pHvYGxufCXYycHBIC
        JhKLl3czdjFycQgJrGCUuN08mR3C+cIo8XZCL5TzmVFix7+nbDAty3f2sEAkljNKPFx2Bqr/
        I6PE+mcNjCBVvAJ2EgvXLwazWQRUJRYebWeDiAtKnJz5hAXEFhVIkpi77x5zFyMHh7BAhETb
        3lCQMLOAuMStJ/OZQGwRAW+JVa/3gl3BLPCVUWLy5P9gM9kEDCW63naBzeQUMJZ4uv4hI0Sz
        vMT2t3OYQRokBL5wSKydeoAR4mwXiUddD1kgbGGJV8e3sEPYMhL/d4Js4wCy8yX+zjCGCFdI
        XHu9hhnCtpa4c+4XG0gJs4CmxPpd+hBhR4kpv/rYITr5JG68FYS4gE9i0rbpzBBhXomONiGI
        ajWJWcfXwe08eOES8wRGpVlIYTILyfOzkPwyC2HvAkaWVYziqaXFuempxYZ5qeV6xYm5xaV5
        6XrJ+bmbGIGp6fS/4592MM599VHvECMTB+MhRgkOZiUR3i+7M5KEeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ8yZnbkgUEkhPLEnNTk0tSC2CyTJxcEo1MAlofIl+KWTe13zsR3qs9r3Uxo36ujOb
        90m/4o/hj4ib/ldurvfb399+mbCWH/27P6J+0s83m/a8n3zVZ+bdV2nr1gHVBM96d4/1hrPt
        up3vTuWG7X/4favSnnRd/txP914G9icZ/M3XvNhmkjTl8qVgqSsOlV3v7zlnZXqIF9U3XJwU
        sUA/6GGKjnaHGfOK6rWJMfGP5B9GdXaYxdfWTDq/1/rv1O0J1qtq1m4w+mrgfG5DzR2vgHVi
        bct0cqUnnl4Y9Tk4attunmiZRsZYT5tpAR+1H4msrTtgFnv06MMNbL+WJk57lPPog8UB80KH
        oyIHnNV/ZGTFb1zrfYQ3IMh9ysyzqkuMhOSqDcyeKbEUZyQaajEXFScCAGzC46a8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7p332YnGex+qmvRvHg9m8W2K/MZ
        LRbM5ra4vGsOm8X/x19ZLfZ1PGCy2L1xEZvF5k1TmR04PGY3XGTxaNl3i93j3blz7B77565h
        99i8pN5j/ZarLB6fN8kFsEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb
        2aSk5mSWpRbp2yXoZZz7/Zu54IRERf/TPewNjM+Fuxg5OSQETCSW7+xh6WLk4hASWMooMfnY
        IjaIhIzEyWkNrBC2sMSfa11sEEXvGSU6p59iAUnwCthJLFy/mBHEZhFQlVh4tJ0NIi4ocXLm
        E7AaUYEkiRfbngPVcHAIC0RIvO8FCzMLiEvcejKfCcQWEfCWWPV6LzvIfGaBr4wSaz88Y4RY
        dplZ4tet+WBD2QQMJbredoHZnALGEk/XP2SEmGQm0bW1C8qWl9j+dg7zBEahWUjumIVk4Swk
        LbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGJHbjv3cvINx3quPeocYmTgYDzFK
        cDArifB+2Z2RJMSbklhZlVqUH19UmpNafIjRFBgYE5mlRJPzgSkhryTe0MzA1NDEzNLA1NLM
        WEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBKZBBouX97N41pg6u0+Z0piw1O9KY53Q/Zypb
        16t23v6rpZ+Sz/uvs3u2Z9bj27HRc0TtZ/2/pyxw+e68OStefKli3i3c4Mpq+2p9E7d0+p/S
        6TymAdzrtfO+MzzaFizxivOV1Mu0bU/9BJ5dST7vsOjJ/daSREM5Y8HshY8Xb134e5ag3f0r
        07kDml9/TzPlOnNs/i7lBNfDB9fX3J0veLXztfPqsp0SdXO0Z67fzXmb9c+eqsn/Tsyzuvkp
        NpWp+8Dfltzr3GV1bS+WzheUSqmVXqC/s+LvjPY4jRnllkLvd27RKXQ8fPPBr2UT/557Pr/o
        dll54OacLSu4Wmcc/ByZ22r6+lfbuo6PRlkfTkxWYinOSDTUYi4qTgQArtAwzFEDAAA=
X-CMS-MailID: 20220429135333eucas1p2283a518d0f595d2101e662af4878dc99
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c
References: <20220421212250.565456-1-john.ogness@linutronix.de>
        <20220421212250.565456-15-john.ogness@linutronix.de>
        <878rrs6ft7.fsf@jogness.linutronix.de> <Ymfgis0EAw0Oxoa5@alley>
        <Ymfwk+X0CHq6ex3s@alley>
        <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
        <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com> <Ymjy3rHRenba7r7R@alley>
        <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
        <87fslyv6y3.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 27.04.2022 18:15, John Ogness wrote:
> On 2022-04-27, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> Here is the full serial console log:
>>
>> https://protect2.fireeye.com/v1/url?k=087c101e-57e728e3-087d9b51-000babff317b-69d8576a8b9d481f&q=1&e=5f72c413-9d23-4e64-98e4-377fcc2038de&u=https%3A%2F%2Fpastebin.com%2FE5CDH88L
> Here are a few ideas from me:
>
> 1. For next-20220427 the printk-threaded series was slightly changed. I
> do not expect it to work any different, but I would prefer we are
> debugging the current version. If possible, could you move to
> next-20220427?

I've moved to next-20220429. Nothing changed compared to next-20220427.


> 2. I noticed you boot with the kernel boot arguments "earlycon" and
> "no_console_suspend". Could you try booting without this? I expect this
> will make no difference.

Well, nothing changed.


> 3. It looks like the problem happens quite late in the boot process. I
> expect it is due to some userspace process that is running that is
> interacting with printk (either /dev/kmsg or /proc/kmsg) and is causing
> problems. If you boot with init=/bin/sh then I expect the system is
> running fine. (You don't have much of a system running, but it should
> not hang.) We need to isolate which userspace process is triggering the
> issue.

The same issue happens if I boot with init=/bin/bash


> 4. Have you tried issuing magic sysrq commands on the serial line? (For
> example, sending a break signal and then the letter 't' or sending a
> break signal and then the letter 'c'?) That might trigger various dumps
> so that we can see the system state.
>
> 5. You are not running a VT console, so the graphics driver should not
> be affecting the printk subsystem at all. I expect your autologin is
> also starting various services and programs. If you disable the
> automatic login and instead manually login (perhaps as another user) can
> you manually start those services one at a time to see at what point the
> system hangs?
>
> Thanks for you help with this!

I found something really interesting. When lockup happens, I'm still 
able to log via ssh and trigger any magic sysrq action via 
/proc/sysrq-trigger (triggering it from UART console via break doesn't 
work).

It turned out that the UART console is somehow blocked, but it receives 
and buffers all the input. For example after issuing "echo 
 >/proc/sysrq-trigger" from the ssh console, the UART console has been 
updated and I see the magic sysrq banner and then all the commands I 
blindly typed in the UART console! However this doesn't unblock the console.

Here is the output of 't' magic sys request:

https://pastebin.com/fjbRuy4f

If you have any more suggestion what to check let me know.

This issue must be somehow related to the way the UART driver works on 
the Amlogic Meson boards. The other boards based on different SoCs 
(Exynos, QCOM, BCM) I have in my test farm (with the same userspace and 
configuration) work fine with those patches.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

