Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228894E2630
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347274AbiCUMSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347266AbiCUMSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:18:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE6F1621A7;
        Mon, 21 Mar 2022 05:16:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k10so3848557edj.2;
        Mon, 21 Mar 2022 05:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FVmsk2siuOBeOD45Au0+vzJrkI7Itr+i7upwdVIByJQ=;
        b=WwQ1ogylZaigKDW4t6TbDN0rj4h4oWvvwMMsovz/1wATgsJFnpra/z/+U1LZ2byB6V
         siU8AqilmhxfxnPSHvlTRbwqEpqppTLedVa+xbXe4OUFhVmENi60UbKfuHZ+24oui/Qa
         QbY01zkOQDPM85bZnX5oy+orqmP2ziK+U7pmmy1AaKtqo1v0qjrVUJvfgPS7xAHZCYXG
         Xr0BT9LwNmCSHPQ1hv+hfW2PnQ8VHdyfZG8VUFnNEL3mwQteN0br/2AN4MMzYrzxTeHn
         3fE9M9nAJD1nd+hssGlnN2BSW+Lhd2Ddrpf01gR0s43zOg7tV88mi01ehrpXklpKqXi3
         KOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FVmsk2siuOBeOD45Au0+vzJrkI7Itr+i7upwdVIByJQ=;
        b=hHvnMup9K9o0VvlLm4HXeAteXtFnlOJrezq0btO0c/a8UAyiZZP2KwqCXHBO9I9Py2
         vwaMMiqcIecsqhrIipOxNuzPYxLpOl2CyVC+O7xGzcWb6b6qsXZy7vBJKuYKDnJT5CR7
         DheiaYBNLj6zU9A4/zSic8O48QCHVgACKy8ZBb2DhvbAAZ+PwYYGRHwQ3vk3acINxyR/
         xZ6UiRvdWMKauEm+9rGgxhDQ0BQXqDajyEGdZ0ftEEz4K503mPTym1AoSKHK95LU21E1
         2XJWkoCBnayp+oKPFrKGFcy8MCiui0hBAmIVS5VZG7VbCtimbEPAFMCnaieVHx3mvOas
         idpQ==
X-Gm-Message-State: AOAM530w6pBgpJ0/B8fB+j8ZCl4iygWdPtCJeG8X5uGFMFKdYM/9IMoY
        6RmzFRjGarJAMpNXJL5vCAc=
X-Google-Smtp-Source: ABdhPJzdMYVz2a4hQoNPr65/LccPzyWENQRCLL1oTZT1KgzUmbSQSl59isPNud3yV3OE3XHXmQhXXQ==
X-Received: by 2002:a50:d711:0:b0:410:a51a:77c5 with SMTP id t17-20020a50d711000000b00410a51a77c5mr22487737edi.154.1647865013691;
        Mon, 21 Mar 2022 05:16:53 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id j18-20020a170906535200b006e007fa9d0fsm1371849ejo.149.2022.03.21.05.16.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2022 05:16:53 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] s390/zcrypt: fix using the correct variable for sizeof()
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <63552021dab7bcf6385526c6dd715e4f@imap.linux.ibm.com>
Date:   Mon, 21 Mar 2022 13:16:52 +0100
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A255D0D-F9E4-4155-933E-574442F3652E@gmail.com>
References: <20220319203528.2552869-1-jakobkoschel@gmail.com>
 <63552021dab7bcf6385526c6dd715e4f@imap.linux.ibm.com>
To:     hfreude <hfreude@imap.linux.ibm.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 21. Mar 2022, at 10:26, hfreude <hfreude@imap.linux.ibm.com> wrote:
>=20
> On 2022-03-19 21:35, Jakob Koschel wrote:
>> While the original code is valid, it is not the obvious choice for =
the
>> sizeof() call and in preparation to limit the scope of the list =
iterator
>> variable the sizeof should be changed to the size of the variable
>> being allocated.
>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>> ---
>> drivers/s390/crypto/zcrypt_card.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/s390/crypto/zcrypt_card.c
>> b/drivers/s390/crypto/zcrypt_card.c
>> index 3e259befd30a..fcbd537530e8 100644
>> --- a/drivers/s390/crypto/zcrypt_card.c
>> +++ b/drivers/s390/crypto/zcrypt_card.c
>> @@ -90,7 +90,7 @@ static ssize_t online_store(struct device *dev,
>> 	list_for_each_entry(zq, &zc->zqueues, list)
>> 		maxzqs++;
>> 	if (maxzqs > 0)
>> -		zq_uelist =3D kcalloc(maxzqs + 1, sizeof(zq), =
GFP_ATOMIC);
>> +		zq_uelist =3D kcalloc(maxzqs + 1, sizeof(*zq_uelist), =
GFP_ATOMIC);
>> 	list_for_each_entry(zq, &zc->zqueues, list)
>> 		if (zcrypt_queue_force_online(zq, online))
>> 			if (zq_uelist) {
>> base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
>> --
>> 2.25.1
> Thanks Jakob, add my Reviewed-by: Harald Freudenberger =
<freude@linux.ibm.com>
> Which way is this patch going to be integrated into the kernel ?
> Usually I pick this and push it into s390 and on the next merge window =
it will
> get merged into Linus Torvalds kernel tree.
> However, sounds like you are about to clean up the kernel in =
preparation for the
> changes related to the double linked list api. So maybe you have a =
patch series
> which will go into the kernel by another way ?
> Waiting for an answer, Thanks
>=20

CC'd Greg KH (in case he has some input) but my assumption is that this =
just goes
the normal way through your s390 tree. Most of this cleanup is not in a =
hurry so
getting it into the next merge window should be fine.

	Jakob

