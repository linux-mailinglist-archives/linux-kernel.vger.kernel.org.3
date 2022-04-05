Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E424F237C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiDEGmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiDEGmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:42:46 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23CE506F4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:40:47 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220405064044epoutp019e00d5fe5a88a87f53fed4ffc998b58e~i7Nw6tl3T2873528735epoutp01y
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:40:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220405064044epoutp019e00d5fe5a88a87f53fed4ffc998b58e~i7Nw6tl3T2873528735epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649140844;
        bh=AGDcIVWKuM0iLeBsDgZsrsbO80+RisT3bm2qxbskRg4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=U8FVdoDK62AgxEIzedG18DxgWFjlKSSeDgIk+o+jQLUjPKlsAMOzx3oJWQ1AfXV0T
         Jm1TbWnPOM2SNEZmB8nlsL+UJEAwd5afsqUpaYFtYumsq+3Y14z3O2NAPY1agfCj10
         u1fMrAQVTiPYQAQP57FhOYQiq5fh+lXfraBspT8Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220405064043epcas2p3b05a6ed1c73bae131f95e1d35e7ed272~i7Nwc5TS-2285922859epcas2p3B;
        Tue,  5 Apr 2022 06:40:43 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KXdLx42GHz4x9Q1; Tue,  5 Apr
        2022 06:40:41 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.69.10444.864EB426; Tue,  5 Apr 2022 15:40:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220405064040epcas2p3e5d3687bf67384c85d61c5d4ee24acaf~i7NtGidre2065120651epcas2p3H;
        Tue,  5 Apr 2022 06:40:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220405064040epsmtrp2c4f2f37859554611fe724b4eebdf65cb~i7NtF0oag0813708137epsmtrp2u;
        Tue,  5 Apr 2022 06:40:40 +0000 (GMT)
X-AuditID: b6c32a45-4fdff700000228cc-9c-624be46868c1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.82.24342.764EB426; Tue,  5 Apr 2022 15:40:40 +0900 (KST)
Received: from KORCO006858 (unknown [10.229.18.72]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220405064039epsmtip2e6314ae5982b52b513a44d516fcd5061~i7Ns8-M3k3244732447epsmtip2b;
        Tue,  5 Apr 2022 06:40:39 +0000 (GMT)
From:   "Jaewon Kim" <jaewon02.kim@samsung.com>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Jiri Slaby'" <jirislaby@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Chanho Park'" <chanho61.park@samsung.com>
In-Reply-To: <YkvNQJ5hBhQKCwcU@kroah.com>
Subject: RE: [PATCH 1/1] tty: serial: samsung: add spin_lock for interrupt
 and console_write
Date:   Tue, 5 Apr 2022 15:40:39 +0900
Message-ID: <001601d848b8$10c97490$325c5db0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQIGb4zGqJBuoSbl8bInG1JCGdzaKQGgf2fpAhFXrQICNgTaqaxVSdrA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmuW7GE+8kg42PlC0ezNvGZnF5v7ZF
        8+L1bBbv5spYnD+/gd1i0+NrrBaXd81hs5hxfh+TxZnFvewOnB6bVnWyeeyfu4bdY/OSeo++
        LasYPT5vkgtgjcq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ
        0HXLzAG6RkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1pi
        ZWhgYGQKVJiQndGz+wJbwT2BihVLzrM0MM7i7WLk5JAQMJG4/fc7WxcjF4eQwA5GiQMzFrJA
        OJ8YJb596GSHcL4xSuxseAFUxgHWcu6OBUR8L6PE3t3/oYpeMEqcm72HDWQum4CuxM6Nr9hB
        bBEBc4m5D4+D2cwCB5kkTvXygNicApoSxxa3gNULC8RJzNi1HcxmEVCR2PH+J5jNK2ApcXPa
        TWYIW1Di5MwnLBBz5CW2v53DDPGDgsTPp8tYIeIiErM725gh9rpJnGycwARynITASg6J/4/e
        sUA0uEjsmtjCCmELS7w6voUdwpaS+PxuLxuEXSxxvOc7VHMDo8TZOwegGowlZj1rZwQFBTPQ
        B+t36UNCRVniyC2o2/gkOg7/ZYcI80p0tAlBNKpJ3J96Dmq6jMSkIyuZJjAqzULy2Swkn81C
        8s0shF0LGFlWMYqlFhTnpqcWGxUYwiM7OT93EyM4oWq57mCc/PaD3iFGJg7GQ4wSHMxKIrw5
        QZ5JQrwpiZVVqUX58UWlOanFhxhNgWE9kVlKNDkfmNLzSuINTSwNTMzMDM2NTA3MlcR5vVI2
        JAoJpCeWpGanphakFsH0MXFwSjUwrZ5+2OfqArVWoTjXTIfl1b5ea0MV17bu5+duNJgWI/g+
        O+9Q7VOLu0VLmjc7J+2yffXuxY3zafkiF6/sOZ9zwm1FXciM8JATrv3xAszbfk8yuOonGaH9
        omySdPTbV93Pthj3GwsZ6YtLTN28dIawwKoay423+ZoFNGx5vz0rOpT1SqG7MvUiX1Du1htS
        273DLsUmXbpwj3fHTqEpJ3Z+Y1Hmm5JuseXl0mUb5jLf2Hf8D7Pz7JzCuLdz1W22aT7c8Znf
        h8VLep5XauF3A8NFbr5PzK1vMkfy7DG58GzXoqjLFVIvftUW2C4/XrnpeP4l6R8xu/f/DBDi
        fnU/xseQY/aKxX6yqkm3XLZ7MUuYK7EUZyQaajEXFScCAJD1fnMxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXjfjiXeSQe92JosH87axWVzer23R
        vHg9m8W7uTIW589vYLfY9Pgaq8XlXXPYLGac38dkcWZxL7sDp8emVZ1sHvvnrmH32Lyk3qNv
        yypGj8+b5AJYo7hsUlJzMstSi/TtErgyenZfYCu4J1CxYsl5lgbGWbxdjBwcEgImEufuWHQx
        cnIICexmlLg3PRXElhCQkVj+rI8NwhaWuN9yhLWLkQuo5hmjxK73f1hBEmwCuhI7N75iB7FF
        BMwl5j48zg5SxCxwnEli2ZsWdoiOB4wSex6uYgGp4hTQlDi2uAVsrLBAjMTtiafB4iwCKhI7
        3v8Ei/MKWErcnHaTGcIWlDg58wkLyKXMAnoSbRsZQcLMAvIS29/OYYa4TkHi59NlrBBxEYnZ
        nW3MEAe5SZxsnMA0gVF4FpJJsxAmzUIyaRaS7gWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz
        0vWS83M3MYIjS0tzB+P2VR/0DjEycTAeYpTgYFYS4c0J8kwS4k1JrKxKLcqPLyrNSS0+xCjN
        waIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgemELve6BwafFlZO1O2c/XPNNPmrEVzirGcW
        sVryZbhOs/j6sVfzh/+qt6HeUy8+5TAKSO14ulFvbaRphtantufvYk75zi+YkvVoneBNaYm8
        S7nfL15tWCSXW39yVlrNbOaJcTy9trtLHmU+Sq7+xxMTJcm87fjqZbaRn/xFSt8sM1Q07Jzm
        1royROcBz3SvgjPK68zv3QjhjOf+/DO8enOEgea9tq4diXJ13AcCTt9QefbKe/FdBfnDzdEn
        rsaf2vzZb23kadlHAWtCDq/eZpLpuqklUmv6zKtLXfiSk5438tcw1ObeOZxzR9jKijWc81sz
        k8rxlcfe89doiOtMmXrA5v2kUJ+apzdv8r+M7VFiKc5INNRiLipOBACXg3/7GwMAAA==
X-CMS-MailID: 20220405064040epcas2p3e5d3687bf67384c85d61c5d4ee24acaf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220405033448epcas2p397080e15c54369d24eaf94c2a27bd06c
References: <20220405033854.110374-1-jaewon02.kim@samsung.com>
        <CGME20220405033448epcas2p397080e15c54369d24eaf94c2a27bd06c@epcas2p3.samsung.com>
        <20220405033854.110374-2-jaewon02.kim@samsung.com>
        <YkvNQJ5hBhQKCwcU@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 22. 4. 5. 14:01, Greg Kroah-Hartman wrote:
> On Tue, Apr 05, 2022 at 12:38:54PM +0900, Jaewon Kim wrote:
> > The console_write and IRQ handler can run concurrently.
> > Problems may occurs console_write is continuously executed while the
> > IRQ handler is running.
> >
> > Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> > ---
> >  drivers/tty/serial/samsung_tty.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> 
> What commit does this fix?

This is not an issue caused by anohter commits.
There was potential issue from the beginning.

Other drivers were fixed, but samsung_tty was not.
PL011 patch : https://lkml.org/lkml/2012/2/1/495


> 
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index e1585fbae909..d362e8e114f1 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -2480,12 +2480,26 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
> >  			     unsigned int count)
> >  {
> >  	unsigned int ucon = rd_regl(cons_uart, S3C2410_UCON);
> > +	unsigned long flags;
> > +	int locked = 1;
> 
> bool?

It is return value of spin_trylock()
I used int because mose drivers used int.
If you guide to change int to bool, I will change it.

> 
> >
> >  	/* not possible to xmit on unconfigured port */
> >  	if (!s3c24xx_port_configured(ucon))
> >  		return;
> >
> > +	local_irq_save(flags);
> > +	if (cons_uart->sysrq)
> > +		locked = 0;
> > +	else if (oops_in_progress)
> > +		locked = spin_trylock(&cons_uart->lock);
> > +	else
> > +		spin_lock(&cons_uart->lock);
> > +
> >  	uart_console_write(cons_uart, s, count,
> > s3c24xx_serial_console_putchar);
> > +
> > +	if (locked)
> > +		spin_unlock(&cons_uart->lock);
> > +	local_irq_restore(flags);
> 
> Why is irq_save required as well as a spinlock?

No special reason.
I will change spin_trylock() -? spin_trylock_irqsave().
spin_lock -> spin_lock_irqsave().
And, remove local_irq_save/restore.
It looks more clean.


> 
> thanks,
> 
> greg k-h

Thanks
Jaewon Kim

