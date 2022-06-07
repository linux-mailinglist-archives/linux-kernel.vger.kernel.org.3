Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1686953F343
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiFGBRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiFGBRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:17:15 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6335D2BE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:17:10 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220607011703epoutp02ad1d54d03ddfa6bc7a6e0ebc5a5c78b1~2McJO8yrd1514715147epoutp02L
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:17:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220607011703epoutp02ad1d54d03ddfa6bc7a6e0ebc5a5c78b1~2McJO8yrd1514715147epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654564623;
        bh=eXcdv1jsI+evK2KqJDyw8r7xO82o0milgSPLfZBcuw0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=aZ256YxvGi9ows2KHFiUSfzyFxEF82NjqPwMhxZzk30okWgpjT4HvwuSACXF9h+Et
         N1+/T+YJQto/l5aXBeIVV9fjX6ldgYCGDs1b+hj6sTqjIwnEHmNgrrIWsJE/45GbkO
         8LhU/Ir032Yi4a7B06nGBAFadjMC2jIglQRVDpm8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220607011702epcas1p467939ecddf8628dc2c91daa92d3dfeb0~2McIjloQv0412304123epcas1p4L;
        Tue,  7 Jun 2022 01:17:02 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.249]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LHCBQ6Dmnz4x9Q7; Tue,  7 Jun
        2022 01:17:02 +0000 (GMT)
X-AuditID: b6c32a38-4b5ff70000002872-5d-629ea70e77b6
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.C0.10354.E07AE926; Tue,  7 Jun 2022 10:17:02 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] zram_drv: add __GFP_NOMEMALLOC not to use
 ALLOC_NO_WATERMARKS
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Jaewon Kim <jaewon31.kim@samsung.com>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "avromanov@sberdevices.ru" <avromanov@sberdevices.ru>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sooyong Suk <s.suk@samsung.com>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        Chulmin Kim <cmlaika.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <Yp5oDD8mfsGtsSaB@google.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220607011702epcms1p10100c4e86e2e0334f7fabbfafa3a0698@epcms1p1>
Date:   Tue, 07 Jun 2022 10:17:02 +0900
X-CMS-MailID: 20220607011702epcms1p10100c4e86e2e0334f7fabbfafa3a0698
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmvi7f8nlJBjOPG1rMWb+GzaL/8n5G
        i5XzzrFZdG+eyWjR+/4Vk8XlXXPYLO6t+c9qsezre3aLDS2z2C0W/b3CbrF74yI2i8fruR14
        PGY3XGTx2DnrLrvHplWdbB6bPk1i9zgx4zeLR9+WVYweF9beZfXY+Wkzq8fnTXIBnFHZNhmp
        iSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAJysplCXmlAKF
        AhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswK9IoTc4tL89L18lJLrAwNDIxMgQoTsjN2HbjL
        WrBctOL/tEUsDYytgl2MnBwSAiYSHS0vmboYuTiEBHYwSvzomsnYxcjBwSsgKPF3hzCIKSwQ
        InFwXSxIuZCAksTZH1fYQWxhAV2Jpu7VLCA2m4C2xPsFk1hBbBGBQImNF2+wg4xkFrjKLNG5
        qp8RYhevxIz2pywQtrTE9uVbwVZxCmhJrN0mCREWlbi5+i07jP3+2HyoVhGJ1ntnmSFsQYkH
        P3dDxaUkznUfZwIZIyEQIfFijzpEOEfi/c45rBC2ucSzDS1gI3kFfCUeb/jABGKzCKhKNO9Z
        zgZR4yJx4coxsBpmAXmJ7W/nMIOMZBbQlFi/Sx+iRFFi5++5jBAlfBLvvvawwjy1Y94TJghb
        TaLl2VeouIzE33/PoGwPiV3v30ADuY1JYtrbxYwTGBVmIcJ5FpLNsxA2L2BkXsUollpQnJue
        WmxYYAKP2uT83E2M4LSrZbGDce7bD3qHGJk4GA8xSnAwK4nw+k+emyTEm5JYWZValB9fVJqT
        WnyI0RTo54nMUqLJ+cDEn1cSb2hiaWBiZmRiYWxpbKYkzts79XSikEB6YklqdmpqQWoRTB8T
        B6dUA1OTXeOpCfOz9r52mSf/Lyee90OsQukMt/oZ7BE7f/vadHqkCq2t26SSFcdo6Bcj1Sta
        unETA6Oyys3yaNm9ZZ+f236vCOv7dbPE/fAFjfSK6ze3BhQd5jBKap6X0f3ueKClqkbhNc9b
        Fp45obeZr+9mkLub2LGt78HuyRKqPUYv6nm+Mx9pX8Xg/yIl4bzG0h/hs3oX995c41N5YA6j
        +4rjrid+avdvZGvnvJ8Xs+STT6ixx5XY1yumVhjlCE1uC/s7J+Tm0v3Chc/O9Foc47X/0SYv
        VZw/2ZR525bf70x+7lyqfY7FKDm5xIehTHAOg6KGTNi72vBzVu+aFyya0/+psHfz8Qd1NmfO
        ayaZKbEUZyQaajEXFScCAFhPf+REBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603055341epcas1p2dd357326eea0cd818daf6f0db7c2aae1
References: <Yp5oDD8mfsGtsSaB@google.com>
        <20220603055747.11694-1-jaewon31.kim@samsung.com>
        <Yp5ZnkYEA5xrUksX@google.com>
        <20220606125939.ae37867e43b8b8b07fa06ca7@linux-foundation.org>
        <CGME20220603055341epcas1p2dd357326eea0cd818daf6f0db7c2aae1@epcms1p1>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
>--------- Original Message ---------
>Sender : Minchan Kim <minchan@kernel.org>
>Date : 2022-06-07 05:48 (GMT+9)
>Title : Re: [PATCH] zram_drv: add __GFP_NOMEMALLOC not to use ALLOC_NO_WATERMARKS
> 
>On Mon, Jun 06, 2022 at 12:59:39PM -0700, Andrew Morton wrote:
>> On Mon, 6 Jun 2022 12:46:38 -0700 Minchan Kim <minchan@kernel.org> wrote:
>> 
>> > On Fri, Jun 03, 2022 at 02:57:47PM +0900, Jaewon Kim wrote:
>> > > The atomic page allocation failure sometimes happened, and most of them
>> > > seem to occur during boot time.
>> > > 
>> > > <4>[   59.707645] system_server: page allocation failure: order:0, mode:0xa20(GFP_ATOMIC), nodemask=(null),cpuset=foreground-boost,mems_allowed=0
>> >
>> > ...
>> >
>> > > 
>> > > The kswapd or other reclaim contexts may not prepare enough free pages
>> > > for too many atomic allocations occurred in short time. But zram may not
>> > > be helpful for this atomic allocation even though zram is used to
>> > > reclaim.
>> > > 
>> > > To get one zs object for a specific size, zram may allocate serveral
>> > > pages. And this can be happened on different class sizes at the same
>> > > time. It means zram may consume more pages to reclaim only one page.
>> > > This inefficiency may consume all free pages below watmerk min by a
>> > > process having PF_MEMALLOC like kswapd.
>> > 
>> > However, that's how zram has worked for a long time(allocate memory
>> > under memory pressure) and many folks already have raised min_free_kbytes
>> > when they use zram as swap. If we don't allow the allocation, swap out
>> > fails easier than old, which would break existing tunes.


Hello.

Yes correct. We may need to tune again to swap out as much as we did.

But on my experiment, there were quite many zram allocations which might
be failed unless it has the ALLOC_NO_WATERMARKS. I thought the zram
allocations seem to be easy to affect atomic allocation failure.

>> 
>> So is there a better way of preventing this warning?  Just suppress it
>> with __GFP_NOWARN?
> 
>For me, I usually tries to remove GFP_ATOMIC alllocation since the
>atomic allocation can be failed easily(zram is not only source for
>it). Otherwise, increase min_free_kbytes?
> 

I also hope driver developers to handle this atomic allocation failure.
However this selinux stuff, context_struct_to_string, is out of their domain.
Do I need to report this to selinux community? Actualy I got several
different callpaths to reach this context_struct_to_string.

Yes we may need to increase min_free_kbytes. But I have an experience where
changing wmark_min from 4MB to 8MB did not work last year. Could you share 
some advice about size?

Thank you
