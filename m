Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6968C5197A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 08:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245487AbiEDG4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 02:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345171AbiEDG4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 02:56:04 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2110921244
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 23:52:20 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220504065214euoutp02fcf35f810fae654b7b73deb0888896ee~r1FGDyJxB1529215292euoutp02j
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:52:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220504065214euoutp02fcf35f810fae654b7b73deb0888896ee~r1FGDyJxB1529215292euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651647134;
        bh=/41Fr4dVW/yKJ7mqPwhKgiCpvp9cjFlMAW/KXfbhKIU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=VHaa721r793FAjGWukJxMSlnV52l5F03cH1e/UBeuikxdF8XH5LkN6WJ5DSslqh6l
         4f4A0xC0mrGva/VQhZCoKJK1Z+RA9+Snf3MOrW9EYnew3z9J1lozGsDz5lV2N5FKjA
         eFFAxZn0NACWuwdx2AYAEc7UiV6QiaO96Xo7NYxM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220504065214eucas1p2e451c9d84239955d88f389120c28afd1~r1FFyR28-1104311043eucas1p2f;
        Wed,  4 May 2022 06:52:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 50.06.09887.E9222726; Wed,  4
        May 2022 07:52:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220504065214eucas1p2caed306531082a9d677b4a4a279e4e92~r1FFgLxtv1105111051eucas1p2N;
        Wed,  4 May 2022 06:52:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220504065214eusmtrp106195fe16407f8ba3fe987d3d4b9290c~r1FFffxUR3149131491eusmtrp1X;
        Wed,  4 May 2022 06:52:14 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-91-6272229e2b23
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3B.0C.09522.E9222726; Wed,  4
        May 2022 07:52:14 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220504065213eusmtip2793e91bcc24acd1c6e86dd5cdb23c1c4~r1FE_Yd6Z3224332243eusmtip2M;
        Wed,  4 May 2022 06:52:13 +0000 (GMT)
Message-ID: <3175262f-5d89-1f57-eb27-9df4d9ad8565@samsung.com>
Date:   Wed, 4 May 2022 08:52:14 +0200
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
In-Reply-To: <87pmkton7h.fsf@jogness.linutronix.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djP87rzlIqSDH5/VbBoXryezWLblfmM
        Fgtmc1tc3jWHzeL/46+sFvs6HjBZ7N64iM1i86apzA4cHrMbLrJ4tOy7xe7x7tw5do/9c9ew
        e2xeUu+xfstVFo/Pm+QC2KO4bFJSczLLUov07RK4MpZO+sFacJa74sTnBUwNjNs4uxg5OSQE
        TCSmNU1l7GLk4hASWMEoce96GzOE84VRYtPlZywQzmdGidWvFjDBtMzsmgDVspxRYuqGXiYI
        5yOjxP0zO9hBqngF7CQmdX4Cs1kEVCSmLTnNCBEXlDg58wkLiC0qkCQxd989oH0cHMICERJt
        e0NBwswC4hK3nswHWyYi4C2x6vVedpD5zAJfGSUmT/4PNodNwFCi620XG4jNKWAs0Tr5OiNE
        s7zE9rdzwH6QEHjDIXGqZwMjxNkuEqdb77FB2MISr45vYYewZSROT+5hATlCQiBf4u8MY4hw
        hcS112uYIWxriTvnfrGBlDALaEqs36UPEXaUmPKrjx2ik0/ixltBiAv4JCZtm84MEeaV6GgT
        gqhWk5h1fB3czoMXLjFPYFSahRQms5A8PwvJL7MQ9i5gZFnFKJ5aWpybnlpslJdarlecmFtc
        mpeul5yfu4kRmJpO/zv+ZQfj8lcf9Q4xMnEwHmKU4GBWEuF1XlqQJMSbklhZlVqUH19UmpNa
        fIhRmoNFSZw3OXNDopBAemJJanZqakFqEUyWiYNTqoHJgCvvqXH9J1ejtMnFgd5/asKunb9k
        r8n/c5aXQTZnXAaLzvYFS9ntjEU6gxrnz4w0NU/buYMle247j2nyFEUrjbi50hMWL94psfDh
        o2LR0qeLEtc8kv3yhS/AzSXg22T/E0cn/1m23vlBwG3/29vVrQpYDE4WdsteWcjEJLS8OYXn
        zR+nC+vaXpxeNP+V6ZStM7z+3bm5RW3O3a6sAIvbCyMeZDFeO/XBsF8s8d7VNyk6RxqaHyoW
        60mzfHaL+NrVWvGvaHd0k0zQi2Nz395V3XTrpYKCh9nv5T85Ghfx1r97Vr5xdZ3gtsVGve/d
        fBYkCCnz71hyK2zq+ZRs6VaR1uY4TuGZjSeDVj+0PtWlxFKckWioxVxUnAgAEoHb+bwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7rzlIqSDLrvcls0L17PZrHtynxG
        iwWzuS0u75rDZvH/8VdWi30dD5gsdm9cxGaxedNUZgcOj9kNF1k8WvbdYvd4d+4cu8f+uWvY
        PTYvqfdYv+Uqi8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2
        NimpOZllqUX6dgl6GUsn/WAtOMtdceLzAqYGxm2cXYycHBICJhIzuyYwdjFycQgJLGWUON7Z
        xg6RkJE4Oa2BFcIWlvhzrYsNxBYSeM8osWOVEYjNK2AnManzE1g9i4CKxLQlpxkh4oISJ2c+
        YQGxRQWSJF5sew4U5+AQFoiQeN8LFmYWEJe49WQ+E4gtIuAtser1XnaQG5gFvjJKrP3wDOqg
        t6wSvy62gA1lEzCU6HoLcQSngLFE6+TrjBCTzCS6tnZB2fIS29/OYZ7AKDQLyR2zkCychaRl
        FpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjcduxn5t3MM579VHvECMTB+MhRgkO
        ZiURXuelBUlCvCmJlVWpRfnxRaU5qcWHGE2BgTGRWUo0OR+YEPJK4g3NDEwNTcwsDUwtzYyV
        xHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpjkb0hlNR8rmdsWe26R77eWr+tYS5kDAy/8LZhU
        oGnYveBOhqfXTcH5Dv5FfMEVV1y6nDfnsLiZf5u9YK+ivccXxv9TN1c3/itQUja4nm4oeqvW
        acKWO+uTPVy0PuUttejTtZilXsqn9YNPsajwqoyWCbOhw9lJ7o6Hw85cNp8WNrciXMb5z72e
        p9u+8nLpS1cc96x2PhI5P8ZYvEbZ/twulz3q6w+dFC5dtfrPpvZra3k/31z62TzwybV4ZxUD
        q09R6grcl79MtpPPcUu9GVe00CVXeb5T4GuNewcjKhc2KG1NmMOv2nw4UGxeO//mTNVmG4Fl
        TFefpTMt173IEvRAPMFCKev68pRtrw0DlFiKMxINtZiLihMB87Pfg1ADAAA=
X-CMS-MailID: 20220504065214eucas1p2caed306531082a9d677b4a4a279e4e92
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
        <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
        <87k0b6blz2.fsf@jogness.linutronix.de>
        <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
        <87y1zkkrjy.fsf@jogness.linutronix.de>
        <601d6979-7462-6f20-0d60-2fcfcf1e405b@samsung.com>
        <87pmkton7h.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 04.05.2022 07:56, John Ogness wrote:
> On 2022-05-03, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>> I suppose if you login via ssh and check /proc/interrupts, then type
>>> some things over serial, then check /proc/interrupts again, you will
>>> see there have been no interrupts for the uart. But interrupts for
>>> other devices are happening. Is this correct?
>> Right. The counter for ttyAML0 is not increased when lockup happens
>> and I type something to the uart console.
> Hmmm. This would imply that the interrupts are disabled fo the UART.
>
> Just to be sure that we haven't corrupted something in the driver, if
> you make the following change, everything works, right?
>
> --------- BEGIN PATCH ------
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index c7973266b176..1eaa323e335c 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3578,7 +3578,7 @@ static int __init printk_activate_kthreads(void)
>   	struct console *con;
>   
>   	console_lock();
> -	printk_kthreads_available = true;
> +	//printk_kthreads_available = true;
>   	for_each_console(con)
>   		printk_start_kthread(con);
>   	console_unlock();
> --------- END PATCH ------
>
> The above change will cause the kthreads to not print and instead always
> fallback to the direct method.

With the above change console always works.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

