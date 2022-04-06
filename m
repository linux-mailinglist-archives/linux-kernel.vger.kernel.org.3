Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D898A4F6085
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiDFNuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiDFNtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:49:55 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95586D7E4F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:19:41 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220406111935epoutp031af369afb39550622f28852b55929798~jSqhYRb4s2430924309epoutp031
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 11:19:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220406111935epoutp031af369afb39550622f28852b55929798~jSqhYRb4s2430924309epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649243975;
        bh=TwPRNUgzLWCbzSZnDZ4iM0eSFQXP3kQv578fyPQRESs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=M7H2qV0ZXM9n5IACx770R9RmibXfaJ1k1N/7qhcfSJBgrjAgXOQbrRlEs0VUbln6D
         nLfUO3mVCnaxGzJJvsuXN20sxOBARMe2iOk6jj9kbNZFWZ4NRJNObjVQ859jsNcnjK
         SfL4NoWaoUk9o2Cn0J0St+QtzSKvifH+1FrK2Dgw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220406111934epcas2p17564478a7c2789f0f3d8a1b11682b67b~jSqg6hiQb1722217222epcas2p1k;
        Wed,  6 Apr 2022 11:19:34 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KYMVF3fcLz4x9Q2; Wed,  6 Apr
        2022 11:19:33 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.E5.40405.5477D426; Wed,  6 Apr 2022 20:19:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220406111933epcas2p17492e6b45283591a238da6e74368866e~jSqfHdVAY0477904779epcas2p19;
        Wed,  6 Apr 2022 11:19:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220406111933epsmtrp200731ed364e059a614dde51837345a2a~jSqfGtjrX0936809368epsmtrp25;
        Wed,  6 Apr 2022 11:19:33 +0000 (GMT)
X-AuditID: b6c32a46-ba1ff70000009dd5-34-624d7745abb0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.77.24342.4477D426; Wed,  6 Apr 2022 20:19:32 +0900 (KST)
Received: from KORCO006858 (unknown [10.229.18.72]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220406111932epsmtip14a4a969aaa60ab1b0aca0c5b28f88214~jSqe4qIrL0665706657epsmtip12;
        Wed,  6 Apr 2022 11:19:32 +0000 (GMT)
From:   "Jaewon Kim" <jaewon02.kim@samsung.com>
To:     "'Jiri Slaby'" <jirislaby@kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Chanho Park'" <chanho61.park@samsung.com>
In-Reply-To: <98c359ba-9563-3da0-d968-ae40cee9d45f@kernel.org>
Subject: RE: [PATCH 1/1] tty: serial: samsung: add spin_lock for interrupt
 and console_write
Date:   Wed, 6 Apr 2022 20:19:32 +0900
Message-ID: <004401d849a8$30b87d00$92297700$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQKAReulhVQQuLhL7TJZSLDDSdoOSgMPy/dDAfNn9KQCezrJxgHj4kEfAXOAyuerPBVLAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmua5ruW+Swa2jMhYP5m1js7i8X9ui
        efF6Not3c2Uszp/fwG6x6fE1VovLu+awWcw4v4/J4sziXnYHTo9NqzrZPPbPXcPusXlJvUff
        llWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
        6Lpl5gBdo6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2x
        MjQwMDIFKkzIzji+Zh1jwWTuip7DK1kaGB9wdDFyckgImEhsvfCRqYuRi0NIYAejxI+vR1kg
        nE+MEt0tD9ghnG+MEh0rDzPDtPQs/cwIkdjLKHH+71o2COcFo8T0q/eYQKrYBHQldm58xQ5i
        iwgkSPzuewNWxCwwg0miZ9lLsFGcAnYS7+dNBSsSFoiTmLFrO1ARBweLgIrEse/uIGFeAUuJ
        +7PWMkHYghInZz5hAbGZBeQltr+dA3WRgsTPp8tYIeIiErM725gh9oZJnG/8AvachMBSDokd
        E5+wQTS4SHy5vhPKFpZ4dXwLO4QtJfH53V6oeLHE8Z7vUM0NjBJn7xxghUgYS8x61s4Iciiz
        gKbE+l36IKaEgLLEkVtQt/FJdBz+yw4R5pXoaBOCaFSTuD/1HNR0GYlJR1YyTWBUmoXks1lI
        PpuF5JtZCLsWMLKsYhRLLSjOTU8tNiowgsd2cn7uJkZwStVy28E45e0HvUOMTByMhxglOJiV
        RHircn2ShHhTEiurUovy44tKc1KLDzGaAoN6IrOUaHI+MKnnlcQbmlgamJiZGZobmRqYK4nz
        eqVsSBQSSE8sSc1OTS1ILYLpY+LglGpgCu1/fe+1iIG0wMo2Kw67GpMzhkk+m1WWTo0onPEu
        /v70iLdcr8RWcU/m/fh3zbMt+qeeK0wM5bO0E5lQymW3QHXJ87C9CkFp6SzXOB4siFnEbjFL
        jN9v0na18PCVIZk99+Ou5D5dw7F7ShnLdMeTNgf1Nql9qva+MedAzcU5/xpCy3a/lHvsn7Yr
        /7Wbn+LaD79nlW77uvpe4PQpZ1J13wbJ/pzSyNMfXF0zabc13+cQ8ys7v2if8zf7VbGjkoNz
        vsQf7eLljVd97fdZ7/9ovGuSme6Dg8qr1mSvNj577Keb+tEO7awzLmuXB3SdezNlq6573tk7
        PQpya8quZkS43eFYIO61TMJgz6p9OZ5XlyixFGckGmoxFxUnAgCy5k6hMgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJTtel3DfJ4MZvU4sH87axWVzer23R
        vHg9m8W7uTIW589vYLfY9Pgaq8XlXXPYLGac38dkcWZxL7sDp8emVZ1sHvvnrmH32Lyk3qNv
        yypGj8+b5AJYo7hsUlJzMstSi/TtErgyjq9Zx1gwmbui5/BKlgbGBxxdjJwcEgImEj1LPzN2
        MXJxCAnsZpS48vk2O0RCRmL5sz42CFtY4n7LEVaIomeMEl/vTGYESbAJ6Ers3PgKrEFEIEHi
        87ftTCBFzALzmCT2N/xlgujYxyTR9uwn2ChOATuJ9/OmgnUIC8RI3J54mqWLkYODRUBF4th3
        d5Awr4ClxP1Za5kgbEGJkzOfsIDYzALaEr0PWxkhbHmJ7W/nMENcpyDx8+kyVoi4iMTszjZm
        iIPCJM43fmGawCg8C8moWUhGzUIyahaS9gWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS
        83M3MYLjS0tzB+P2VR/0DjEycTAeYpTgYFYS4a3K9UkS4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        znuh62S8kEB6YklqdmpqQWoRTJaJg1OqgWn5pLjfyzfdTK2+GsxzseSH2YVs/UTvjKPbljd8
        VJPZG/wqoE/i5P5oxQWLjj5VP3F6m4i2nc227OjaV2d6X9pevaWhfvNX7sH//w9s2iTG9S3e
        aKHn/uRje/vPHQp9433kkttZNeYq1u/SHhWhgouLnqj+1dm/46OGuKldlAWvRtKyI+5cLJ5R
        9oZTJk2de7HR1c1apsusUG7Cy2UresWO+JpI74+5qmJ8QEp4xs5/a8/dTl369bZ+n9cMnagC
        o7vpJy86na3i9chtPxsbeW51zZGKS/OnL3h5/nDIrvk/XavW7v9yIC1l8+TTXCWSnYvOWE7x
        m6rdKFJx+kdmu+WPd6/F2V6fl9c4HzaN58ISJZbijERDLeai4kQAxTfjXB4DAAA=
X-CMS-MailID: 20220406111933epcas2p17492e6b45283591a238da6e74368866e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220406081823epcas2p2f7afa27e2402c4fc02c9bee5972bed4f
References: <20220406082216.11206-1-jaewon02.kim@samsung.com>
        <CGME20220406081823epcas2p2f7afa27e2402c4fc02c9bee5972bed4f@epcas2p2.samsung.com>
        <20220406082216.11206-2-jaewon02.kim@samsung.com>
        <Yk1NmTdUgMcSIq1O@kroah.com> <042701d84991$ca50d410$5ef27c30$@samsung.com>
        <98c359ba-9563-3da0-d968-ae40cee9d45f@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22. 4. 6. 18:48, Jiri Slaby wrote:> On 06. 04. 22, 10:39, Jaewon Kim wrote:
> > On 22. 4. 6. 17:21, Greg Kroah-Hartman wrote:
> >> On Wed, Apr 06, 2022 at 05:22:16PM +0900, Jaewon Kim wrote:
> >>> The console_write and IRQ handler can run concurrently.
> >>> Problems may occurs console_write is continuously executed while the
> >>> IRQ handler is running.
> >>>
> >>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> >>> ---
> >>>   drivers/tty/serial/samsung_tty.c | 12 ++++++++++++
> >>>   1 file changed, 12 insertions(+)
> >>>
> >>> diff --git a/drivers/tty/serial/samsung_tty.c
> >>> b/drivers/tty/serial/samsung_tty.c
> >>> index e1585fbae909..9db479d728b5 100644
> >>> --- a/drivers/tty/serial/samsung_tty.c
> >>> +++ b/drivers/tty/serial/samsung_tty.c
> >>> @@ -2480,12 +2480,24 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
> >>>   			     unsigned int count)
> >>>   {
> >>>   	unsigned int ucon = rd_regl(cons_uart, S3C2410_UCON);
> >>> +	unsigned long flags;
> >>> +	bool locked = 1;
> >>
> >> "1" is not a boolean :)
> >
> > return value of spin_trylock() is 1 or 0.
> > It seems better to keep it as an int than to change it to bool.
> > I will return it to int.
> 
> Hi, no, do not that. Simply use bool/true/false.
> 

Okay, Thanks to review.
I will fix 1 to bool in next v3 patch.

> thanks,
> --
> js
> suse labs

Thanks
Jaewon Kim

