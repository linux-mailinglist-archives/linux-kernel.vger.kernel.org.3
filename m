Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D67651D18C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345263AbiEFGqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiEFGqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:46:49 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF4366216
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:43:06 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220506064304euoutp02a4d0353be6679c8b21af4cecd63816dd~scPppVwz-2171821718euoutp02S
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:43:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220506064304euoutp02a4d0353be6679c8b21af4cecd63816dd~scPppVwz-2171821718euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651819384;
        bh=hjoiNwTZmjBErobwlkOZRpzJDBfEyeEsA1fWNSkgy3g=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=vHlMcrW2EMNdRKjbznD6ycqUtiVgbNmAD+iZ3rBvJBFhyNOq3Q6Vb/m149AxjjxBl
         B3R2iAhJ1hECh4w2opvAA7fMIr0hfLGIoyNWeI6sMMx1JiAi2EWyThOTtd53VqrAfW
         0ombFRW/SC3r+9Nn4/tcv8U6azBXf1HeBU+0aRsQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220506064303eucas1p13ae9527f6e3a6e308b33abeda4da2e7e~scPpFbc1h2851628516eucas1p1U;
        Fri,  6 May 2022 06:43:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 82.05.09887.773C4726; Fri,  6
        May 2022 07:43:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220506064303eucas1p2d3b8b554e34a95c3e00b35a439f18f55~scPotQIBf1239712397eucas1p2Z;
        Fri,  6 May 2022 06:43:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220506064303eusmtrp1020d4f62294cdb215f2698f784ec69bb~scPosU5OU0717607176eusmtrp1B;
        Fri,  6 May 2022 06:43:03 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-bc-6274c37761b1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A0.E4.09522.673C4726; Fri,  6
        May 2022 07:43:02 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220506064302eusmtip16a6d6fa73bb6f1688da79a920562ee87~scPoJlYMy1425014250eusmtip10;
        Fri,  6 May 2022 06:43:02 +0000 (GMT)
Message-ID: <b7c81f02-039e-e877-d7c3-6834728d2117@samsung.com>
Date:   Fri, 6 May 2022 08:43:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.0
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
In-Reply-To: <87zgjvd2zb.fsf@jogness.linutronix.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7rlh0uSDC7slLFoXryezWLblfmM
        Fgtmc1tc3jWHzeL/46+sFvs6HjBZ7N64iM1i86apzA4cHrMbLrJ4tOy7xe7x7tw5do/9c9ew
        e2xeUu+xfstVFo/Pm+QC2KO4bFJSczLLUov07RK4Mrbdf8Bc8JO9YvXsZuYGxt1sXYwcHBIC
        JhLnPhp1MXJxCAmsYJR40byIBcL5wihx6N0WKOczo8SyZa3sXYycYB0ft31jhEgsZ5TY+qCb
        CcL5yChx8vsZJpAqXgE7iWervzOD2CwCKhI/N56GigtKnJz5hAXEFhVIknjz5iozyB3CAhES
        bXtDQcLMAuISt57MBysXEfCWWPV6LzvIfGaBr4wSkyf/ZwRJsAkYSnS97WIDsTkFjCXOX93D
        DNEsL7H97RxmkAYJgS8cEpsfHWeBONtF4uL381AvCEu8Or4FypaROD25hwUSGPkSf2cYQ4Qr
        JK69XsMMYVtL3Dn3CxxezAKaEut36UOEHSWm/Opjh+jkk7jxVhDiAj6JSdumM0OEeSU62oQg
        qtUkZh1fB7fz4IVLzBMYlWYhhcksJM/PQvLLLIS9CxhZVjGKp5YW56anFhvlpZbrFSfmFpfm
        pesl5+duYgQmptP/jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeIVnlSQJ8aYkVlalFuXHF5XmpBYf
        YpTmYFES503O3JAoJJCeWJKanZpakFoEk2Xi4JRqYGLIWJRy8Pzj6ila1e8mbD1+yj5Cwm7+
        sjsTBVeespykP/1nNU/nF92kILmJ/713M4c+XuKjvHu+8s55JfWSculGr8TPCX4KrTHf8qt+
        q6m2kelPlfadujYO295NEOTb1+a4RGKFz59mwY4ls1rZbNSbhe072rbURvTnq3+oPWtdtbJW
        cNtnnnfiObFndxzy/1h64PFdlYiUmkTn7qTXe4wlr/4um/9I+4rj9puvgtQWMwR680e5vXT5
        vjj/xonHrmve1kjc+Bqaon82irvW+U3M7V8Sk6/PKarQEJLUmP0r61ls1VnNny+mbSg/z6/w
        qrR0h/HzrOqIF4cOH3K5fo07vPflyecnbG3nzp3yN0KJpTgj0VCLuag4EQDKIV3KuwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7plh0uSDBqf21g0L17PZrHtynxG
        iwWzuS0u75rDZvH/8VdWi30dD5gsdm9cxGaxedNUZgcOj9kNF1k8WvbdYvd4d+4cu8f+uWvY
        PTYvqfdYv+Uqi8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2
        NimpOZllqUX6dgl6GdvuP2Au+MlesXp2M3MD4262LkZODgkBE4mP274xgthCAksZJZ5NEIGI
        y0icnNbACmELS/y51gVUzwVU855R4vflH0wgCV4BO4lnq78zg9gsAioSPzeehooLSpyc+YSl
        i5GDQ1QgSeLIYX4QU1ggQuJ9LwtIBbOAuMStJ/PBqkUEvCVWvd7LDjKeWeAro8TaD88YIXZN
        Z5V4OOM1O0gVm4ChRNfbLrCjOQWMJc5f3cMMMclMomtrFyOELS+x/e0c5gmMQrOQnDELycJZ
        SFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzAatx37uXkH47xXH/UOMTJxMB5i
        lOBgVhLhFZ5VkiTEm5JYWZValB9fVJqTWnyI0RQYFhOZpUST84HpIK8k3tDMwNTQxMzSwNTS
        zFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgSk4Ky3zchaz0ymRDad/dQvyhoUX5r+5sDzt
        44K//ael5rovCVrT28n+7+eboOVMNzp9HNzY+honsc/vMf+2bXJ3CMfWoOMZyUsuMf6qvSUn
        ZP1/ys9VMpz7Hwnvb5gl+Cx10s3Vl264eJ77u5nhr2mD1X3OTv+FmysWCn1tj/ulIXo6qvKm
        dV+D5K+p6aL9ntv3dDk1ezlf9r02/8b0S6YRi4WmWM9f9rDiW+napwfY2hd8eLHs0nzTy58F
        cpbstJ6Q5b/x2Ewr27qdLr+vKf6sC+iO3hf7dlWWx4nwpZxNa+dIqa5897Dw6evasLWaFRsX
        MzH9XbIxOlnp4tHkBYXpbMtC1KS2KdSlCpt3iTsosRRnJBpqMRcVJwIAb6N4I08DAAA=
X-CMS-MailID: 20220506064303eucas1p2d3b8b554e34a95c3e00b35a439f18f55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c
References: <Ymfgis0EAw0Oxoa5@alley> <Ymfwk+X0CHq6ex3s@alley>
        <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
        <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com> <Ymjy3rHRenba7r7R@alley>
        <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
        <87fslyv6y3.fsf@jogness.linutronix.de>
        <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
        <87k0b6blz2.fsf@jogness.linutronix.de>
        <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com> <Ym/Z7PYPqvWPEjuL@alley>
        <45849b63-d7a8-5cc3-26ad-256a28d09991@samsung.com>
        <87pmktm2a9.fsf@jogness.linutronix.de>
        <87a6bwapij.fsf@jogness.linutronix.de>
        <87zgjvd2zb.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 06.05.2022 00:33, John Ogness wrote:
> On 2022-05-05, John Ogness <john.ogness@linutronix.de> wrote:
>> I will go through and check if all access to AML_UART_CONTROL is
>> protected by port->lock.
> The startup() callback of the uart_ops is not called with the port
> locked. I'm having difficulties identifying if the startup() callback
> can occur after the console was already registered via meson_uart_init()
> and could be actively printing, but I see other serial drivers are
> protecting their registers in the startup() callback with the
> port->lock.
>
> Could you try booting the meson hardware with the following change? (And
> removing any previous debug changes I posted?)

Bingo! It looks that the startup() is called when getty initializes 
console. This fixed the issues observed on the Amlogic Meson based boards.

Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

