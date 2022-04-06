Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB064F5E20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiDFMia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiDFMhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:37:42 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE6E44099C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:39:19 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220406083917epoutp0495958e598f2470045cc0ec855b997c16~jQej7dhA92115321153epoutp04X
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:39:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220406083917epoutp0495958e598f2470045cc0ec855b997c16~jQej7dhA92115321153epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649234357;
        bh=c54J3bp3plJLsFTEsC6S4PiShdQ+U2ETlWezGJ5k9AU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=GgTfNlu/DqsW/v+kbvyZhMvnMFBp5HWny63eXhyVnqMLhKd3js+qYF4bNEfrZ/8iS
         bEp+IuGhQD6P7HdWvt9cni8OkC7PMITCDWx3HPvQurjl7rFTAYp2vDxTP97PFBjN2O
         ldpuBFkdyWLlso/B45mIxtzs7n1gzItl8zjVeBzY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220406083916epcas2p30ee3bd4de04a7094344cb5b8d505cf97~jQejeaHxI1105711057epcas2p3L;
        Wed,  6 Apr 2022 08:39:16 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KYHxG5LbKz4x9QP; Wed,  6 Apr
        2022 08:39:14 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7D.73.25540.1B15D426; Wed,  6 Apr 2022 17:39:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220406083912epcas2p4aa5946cfaf84e6bac9c56dd25e1dedba~jQefHh_or1577715777epcas2p4a;
        Wed,  6 Apr 2022 08:39:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220406083912epsmtrp26b4cbfbb2728036861c67c2a23586fa8~jQefDrx8S0804408044epsmtrp2T;
        Wed,  6 Apr 2022 08:39:12 +0000 (GMT)
X-AuditID: b6c32a47-831ff700000063c4-3b-624d51b12991
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.2E.03370.0B15D426; Wed,  6 Apr 2022 17:39:12 +0900 (KST)
Received: from KORCO006858 (unknown [10.229.18.72]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220406083912epsmtip27e9c3fce16ef8727cfd6495a3dde8d86~jQee38F521809018090epsmtip2r;
        Wed,  6 Apr 2022 08:39:12 +0000 (GMT)
From:   "Jaewon Kim" <jaewon02.kim@samsung.com>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Jiri Slaby'" <jirislaby@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Chanho Park'" <chanho61.park@samsung.com>
In-Reply-To: <Yk1NmTdUgMcSIq1O@kroah.com>
Subject: RE: [PATCH 1/1] tty: serial: samsung: add spin_lock for interrupt
 and console_write
Date:   Wed, 6 Apr 2022 17:39:11 +0900
Message-ID: <042701d84991$ca50d410$5ef27c30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQKAReulhVQQuLhL7TJZSLDDSdoOSgMPy/dDAfNn9KQCezrJxqtWoyVQ
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmme7GQN8kg7l93BYP5m1js7i8X9ui
        efF6Not3c2Uszp/fwG6x6fE1VovLu+awWcw4v4/J4sziXnYHTo9NqzrZPPbPXcPusXlJvUff
        llWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
        6Lpl5gBdo6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2x
        MjQwMDIFKkzIzug895Gl4DFHxeTetywNjL/Yuhg5OSQETCQ2TvrH3sXIxSEksINRYsXXrUwQ
        zidGiXXfzkM5nxklpu/uZIVpOdY7ESqxi1Hi4aTDYLOEBF4wSuzbzA1iswnoSuzc+IodxBYR
        MJeY+/A4mM0scJBJ4lQvD4jNKaAp8XTeebBeYYE4iRm7toPZLAIqEtPebgar5xWwlNg+eRIr
        hC0ocXLmExaIOfIS29/OYYY4SEHi59NlrBBxEYnZnW3MEHvdJF49uMoIcqiEwFIOiU3bF0E9
        7SJxbu1xRghbWOLV8S3sELaUxOd3e6FqiiWO93xngmhuYJQ4e+cA1PvGErOetQM1cwBt05RY
        v0sfxJQQUJY4cgvqNj6JjsN/2SHCvBIdbUIQjWoS96eeg5ouIzHpyEqmCYxKs5B8NgvJZ7OQ
        fDMLYdcCRpZVjGKpBcW56anFRgXG8MhOzs/dxAhOqFruOxhnvP2gd4iRiYPxEKMEB7OSCG9V
        rk+SEG9KYmVValF+fFFpTmrxIUZTYFhPZJYSTc4HpvS8knhDE0sDEzMzQ3MjUwNzJXFer5QN
        iUIC6YklqdmpqQWpRTB9TBycUg1MG6/3WbELlrQV85xfxOKWnv94vU+bR8LiUx650ZL+pjvj
        hIIvCHT+ZNG+r2dsXZx2cGdZr3bh+atS6h1nVTdNkQsPizqlnKnCs+Lan/OM+7b8MLyxq84g
        0p3Fy42JU4TDdU3i9KIF6Zm8B/pe5xQ9+7PQi3fbg445l8w3/X3+V3Dq4n063HuMivrPXZd+
        uTQjTv3cCoN7Ob4TLGKMqzbcVP26Sch46gJviwtzVPY/fMYnnyTd4STLNenzQ5sZJ0UrEyc3
        6d49en7RpJ9L0nOPRFbsXhaY+/v28nnxtlVLhBX2JmZqPNLtEi/7FvzgKVs321QnwUPPdVW2
        zlr5wESh4Mo8Vruy9vyd63oaVvcqsRRnJBpqMRcVJwIAGb05bDEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXndDoG+SwcILHBYP5m1js7i8X9ui
        efF6Not3c2Uszp/fwG6x6fE1VovLu+awWcw4v4/J4sziXnYHTo9NqzrZPPbPXcPusXlJvUff
        llWMHp83yQWwRnHZpKTmZJalFunbJXBldJ77yFLwmKNicu9blgbGX2xdjJwcEgImEsd6JzJ1
        MXJxCAnsYJS4Nm0NO0RCRmL5sz6oImGJ+y1HWCGKnjFK3P6yiAUkwSagK7Fz4yuwBhEBc4m5
        D4+zgxQxCxxnklj2pgUsISRwj1FiRbc2iM0poCnxdN55sKnCAjEStyeeBhvEIqAiMe3tZrB6
        XgFLie2TJ7FC2IISJ2c+AarhABqqJ9G2kREkzCwgL7H97RxmiOMUJH4+XcYKEReRmN3Zxgxx
        j5vEqwdXGScwCs9CMmkWwqRZSCbNQtK9gJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+
        7iZGcGxpae1g3LPqg94hRiYOxkOMEhzMSiK8Vbk+SUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwMfiFy7peerY+xVShfG8K70KZ2xNEl+9OuRxYq+fL
        MkUrLPfLTJMpRfP2/rG2uCFxXzfw5AQuxcZrrhuYtq3dlhIoxXw4qCRx6y3HvN6ZgiaNTZss
        bp9bIX7o8RyZ9x5nj3luaj7/qOjcUl3f2mMaNtoJ4Vsn3Dt9+1nF4ll/yp/pBkl959qy/fw6
        oUdFjOL7+udMFNrW6dQTt+FS06ffa8rqE7s+PAmLWTB7adSEYoaTAQFnF1n9Mvu9d9vWzVz7
        Dzv5ZX+aM+sIV+6cDVLi3FovhWdo7lrT/U55xr7mtwwyYfPV+VksM87KSYV/eZ81VdBu4eEK
        ya+Hvgjq3bln0b9MZjeX6au6eVsTvaVOJymxFGckGmoxFxUnAgCFkTMMHAMAAA==
X-CMS-MailID: 20220406083912epcas2p4aa5946cfaf84e6bac9c56dd25e1dedba
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
        <Yk1NmTdUgMcSIq1O@kroah.com>
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

On 22. 4. 6. 17:21, Greg Kroah-Hartman wrote: 
> On Wed, Apr 06, 2022 at 05:22:16PM +0900, Jaewon Kim wrote:
> > The console_write and IRQ handler can run concurrently.
> > Problems may occurs console_write is continuously executed while the
> > IRQ handler is running.
> >
> > Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> > ---
> >  drivers/tty/serial/samsung_tty.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c
> > b/drivers/tty/serial/samsung_tty.c
> > index e1585fbae909..9db479d728b5 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -2480,12 +2480,24 @@ s3c24xx_serial_console_write(struct console *co, const char *s,
> >  			     unsigned int count)
> >  {
> >  	unsigned int ucon = rd_regl(cons_uart, S3C2410_UCON);
> > +	unsigned long flags;
> > +	bool locked = 1;
> 
> "1" is not a boolean :)

return value of spin_trylock() is 1 or 0.
It seems better to keep it as an int than to change it to bool.
I will return it to int.


Thanks
Jaewon Kim

