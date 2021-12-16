Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354F5476839
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhLPCm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:42:26 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:19589 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhLPCmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:42:25 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211216024224epoutp0445e31c9925db4a9eb3470db797a0e5ab~BHARmO5wu1221712217epoutp04J
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:42:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211216024224epoutp0445e31c9925db4a9eb3470db797a0e5ab~BHARmO5wu1221712217epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639622544;
        bh=SmTyq6gEJN733fwzI8uCUgNmA6mhE3+j/FGH5Vkfecw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=usi+QivCGx9bKT6tEC/TqtgMOTUGb1bQqMv68NDPuNRHnqCgZ82cr2OlX/+Xvhgqz
         aD0hNd9phaZYgFjFowY2CrM2DhK23/Dgj0e9ogIazPm0kEwDzuuPiKRtFZnYLzM30Q
         zDMVhh9NS5ajM9xlZwyur6ws1ct+5nlrRMy63XfE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211216024224epcas1p3da1f6d95efd156880a63d76044f4d480~BHARS428A3251532515epcas1p3N;
        Thu, 16 Dec 2021 02:42:24 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.235]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JDxGj4mg5z4x9QJ; Thu, 16 Dec
        2021 02:42:21 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.C9.09592.857AAB16; Thu, 16 Dec 2021 11:41:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211216024218epcas1p32fdd048b1922464a75281ae5087efa54~BHAMCoDUd3251532515epcas1p3o;
        Thu, 16 Dec 2021 02:42:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211216024218epsmtrp2ea4036e8257293b8274d115349aab70c~BHAMBPm7Q0341103411epsmtrp2M;
        Thu, 16 Dec 2021 02:42:18 +0000 (GMT)
X-AuditID: b6c32a37-2a5ff70000002578-26-61baa758f5b6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.43.08738.987AAB16; Thu, 16 Dec 2021 11:42:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211216024218epsmtip2257c289657d825dc98d338b773f77f13~BHAL3VTay1743317433epsmtip2Y;
        Thu, 16 Dec 2021 02:42:18 +0000 (GMT)
Subject: Re: [PATCH 1/1] extcon: deduplicate code in extcon_set_state_sync()
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <09ea6f93-4aae-1f74-bb54-0453908a7102@samsung.com>
Date:   Thu, 16 Dec 2021 12:05:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211123145301.778629-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmrm7E8l2JBmu3SVi8nrKWyeLyrjls
        FrcbV7A5MHu8mPCPyaNvyypGj8+b5AKYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
        TAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM+5PsCq4xlvxcPcOtgbGdu4uRk4OCQETiTNXPzB2
        MXJxCAnsYJTYPesAlPOJUWLCnwesEM5nRom9b5cxwrXcW8UGkdjFKHFx+h0mCOc9o8S17XeZ
        QaqEBXwkev/vZQGxRQQSJF6cucQEYjMLKEj8ureJFcRmE9CS2P/iBhuIzS+gKHH1x2OwDbwC
        dhJtBw+A9bIIqEq0TrgI1isqECZxclsLVI2gxMmZT8BqOAXcJJaevcIKMV9c4taT+VC75CW2
        v53DDHKchMBHdomG9w/ZIF5wkbjZtpUVwhaWeHV8CzuELSXx+d1eNoiGZYwSvyZ3MkE46xkl
        Xs7qZIaoMpbYv3QyUIIDaIWmxPpd+hBhRYmdv+cyQmzmk3j3tYcVpERCgFeio00IokRZ4vKD
        u0wQtqTE4vZOtgmMSrOQ/DMLyQ+zkPwwC2HZAkaWVYxiqQXFuempxYYFxvDoTs7P3cQIToVa
        5jsYp739oHeIkYmD8RCjBAezkgjvk4hdiUK8KYmVValF+fFFpTmpxYcYTYEhPJFZSjQ5H5iM
        80riDU0sDUzMjIxNLAzNDJXEeV/4T08UEkhPLEnNTk0tSC2C6WPi4JRqYAqTm1HrGsoz7WvL
        LYmVHOfWROtl7gsO1BEVEuT1891cK9PBXHBXSeTb08qo/vaEh4dlHy+6tNKzcKe8tcCvBx7a
        XxgUdj16+GNhml4uq4/e/CV2hw8Y/sn7m8fwfJW25c6VbVt9pgaWPekJPPKsmLnD5GtzS2RT
        33QFpqg7mntnX7YNzvTL17rQKbqtt4mDadra6Mbgk4sKyiRvL5fRnMvaejLBXbB766xa/6CN
        mrOVXco0+HtF/3esDXvUfWQKr0Ccy8KZbbMOrXq4bYHJu/OXYlhUuHNSvj5Xu33BN1fC/Lrp
        wXc3OL7s11/m9VYj+wKnRrHyv9wOQ7aYdbGuFywDNk+Vf3pn+wPVmREGSizFGYmGWsxFxYkA
        5dGNsA4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvG7n8l2JBndmW1m8nrKWyeLyrjls
        FrcbV7A5MHu8mPCPyaNvyypGj8+b5AKYo7hsUlJzMstSi/TtErgy7k+wKrjGW/Fw9w62BsZ2
        7i5GTg4JAROJM/dWsXUxcnEICexglHi0bScrREJSYtrFo8xdjBxAtrDE4cPFIGEhgbeMEnff
        VIHYwgI+Er3/97KA2CICCRIn121gArGZBRQkft3bxAoxcyajxMFLb9hBEmwCWhL7X9xgA7H5
        BRQlrv54zAhi8wrYSbQdPAA2iEVAVaJ1wkWwQaICYRI7lzxmgqgRlDg58wlYDaeAm8TSs1dY
        IZapS/yZd4kZwhaXuPVkPtQR8hLb385hnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6x
        YYFRXmq5XnFibnFpXrpecn7uJkZwPGhp7WDcs+qD3iFGJg7GQ4wSHMxKIrxPInYlCvGmJFZW
        pRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cC0g1H2Y4uCgZjG31t5
        nKaON1KLF4fEOxZohZ0rf+Fr5hXi9Y8x6tqd3hU/9OJbNj7MNnPyu3DyvaTRvbnHbvwR+ZZl
        LtZ76g3jXkXm6+FTmlSO7c2pf+Qbnrhnv9K1OLdkh5DV5xOVA26ZqYml7th7rrrnzGXLjIsX
        /vR+XyG0xXpJ3H7nalm3xBtRItwzuB3+eT/QNj9cqvk6XMF/rzP7rsQJ9qvn7D70zyrtet+P
        e/JdGZ7/pp7g6flzIuT6/LzwxMfeFyeoePbflRRur+AyeRAzl4G/fAmTWf7tV8Ei52Y1nJkY
        cy3wG+e8rvWLF/08wW1p97hj5W7/PVblsRqeIgVf8zLrXnWvD90g90eJpTgj0VCLuag4EQCo
        j1Om9gIAAA==
X-CMS-MailID: 20211216024218epcas1p32fdd048b1922464a75281ae5087efa54
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211123145318epcas1p17f6567ed89ec7f8f3ab3c007c58b1fe0
References: <CGME20211123145318epcas1p17f6567ed89ec7f8f3ab3c007c58b1fe0@epcas1p1.samsung.com>
        <20211123145301.778629-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/21 11:53 PM, Alexander Stein wrote:
> Finding the cable index and checking for changed status is also done
> in extcon_set_state(). So calling extcon_set_state_sync() will do these
> checks twice. Remove them and use these checks from extcon_set_state().
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> I noticed this duplicated code while debugging an extcon related issue.
> I do not know if it is allowed in the kernel to assume some behavior in
> EXPORT_SYMBOL* functions, but as the two functions mentioned are in the
> same source file it should be ok.
> In the case it is not okay to assume some behaviour,
> extcon_set_state_sync() is missing a check for !edev, like
> extcon_set_state() does.
> 
>  drivers/extcon/extcon.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index e7a9561a826d..a09e704fd0fa 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -576,19 +576,7 @@ EXPORT_SYMBOL_GPL(extcon_set_state);
>   */
>  int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id, bool state)
>  {
> -	int ret, index;
> -	unsigned long flags;
> -
> -	index = find_cable_index_by_id(edev, id);
> -	if (index < 0)
> -		return index;
> -
> -	/* Check whether the external connector's state is changed. */
> -	spin_lock_irqsave(&edev->lock, flags);
> -	ret = is_extcon_changed(edev, index, state);
> -	spin_unlock_irqrestore(&edev->lock, flags);
> -	if (!ret)
> -		return 0;
> +	int ret;
>  
>  	ret = extcon_set_state(edev, id, state);
>  	if (ret < 0)
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
