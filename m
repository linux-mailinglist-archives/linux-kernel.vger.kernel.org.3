Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAFF577C18
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiGRHCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbiGRHCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:02:13 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138A41706D;
        Mon, 18 Jul 2022 00:02:13 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id b26so15663505wrc.2;
        Mon, 18 Jul 2022 00:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mBaCn+yOtwwme9flF0xPrDTgDsQW7uNWw9wOEtCnhK4=;
        b=TxPYWCpnbe999RTMQbJmHOshS9DrDRFDdYeJwCnZX0xutYYGnR3102WyksgRMV/Dz6
         bd53Ng6jWR5tpNH3TA0FFEcQnLfu22APattrzKiFTn10yOTB7A2C8WzrMTXpJe4HwKaN
         uYqpj0sdf80RGGbytvF70vKEeiW58AwisZU8Fj7d1ggdm1Xf2ES+Ko+guMgJjNYeUZ2h
         hcyPmZi9VrNSKuZOfYAV5j28RPRa4BcWAsLmxlQ5Z0rwet7GMZr6t1lHf3n8HWjuR70e
         u/LX48XrHxs2QR4h11+h+UBTnK+aMxTrZXBwjy4mnlKGt5wSbq/AJNHb8Ey2y53w7Zz+
         iABg==
X-Gm-Message-State: AJIora962fYRr8KRW8oPuAfI/ZkpxfITjinGS63OVkMM7ZS+EBWG9Raf
        qtcFWuObhqQ/ftTQmHTKhelvzhYhJk8=
X-Google-Smtp-Source: AGRyM1vY2mD3JpdNb/SNzvjPGkQe4nn8SXRSvzuNUEmKzaUnA+s4GFDYX2/U024C758KBtyCxc93MA==
X-Received: by 2002:adf:f245:0:b0:21d:a39a:bed5 with SMTP id b5-20020adff245000000b0021da39abed5mr20980909wrp.508.1658127731543;
        Mon, 18 Jul 2022 00:02:11 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id r10-20020a056000014a00b0021d68a504cbsm10078557wrx.94.2022.07.18.00.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 00:02:10 -0700 (PDT)
Message-ID: <d75d1339-4539-330a-680b-2d940e603a72@kernel.org>
Date:   Mon, 18 Jul 2022 09:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: writing a 1 and then a 0 to
 trigger a break character
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>
References: <20220715025944.11076-1-sherry.sun@nxp.com>
 <20220715025944.11076-3-sherry.sun@nxp.com>
 <509669b26b5899088e9b77ed94d103ee@walle.cc>
 <AS8PR04MB840448675E64E4FCDEEF91A1928B9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <e2560f01fd1731ea2422d82c97efcc6f@walle.cc>
 <AS8PR04MB8404B8E3EB0FFCEE8ADDA283928B9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <61c525fc87d6586c024cd6e42fcf876d@walle.cc>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <61c525fc87d6586c024cd6e42fcf876d@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15. 07. 22, 13:52, Michael Walle wrote:
>> Seems we have the different understanding of the break_ctl(port,ctl)
>> callback. The original break_ctl(tty,-1) in lpuart will not send the
>> break signal until we call break_ctl(tty,0).
> 
> That is not correct. The TX linue goes low as soon as the SBK bit
> is set. See below.

In that case…

>> Per my understanding of
>> "If ctl is nonzero, the break signal should be transmitted", call
>> break_ctl(tty,-1) is enough the send one break signal, now my patch
>> makes the behavior align with my understanding.
> 
> As I said, Greg should clarify here.
> 
> In any case, I've checked the hardware (LS1028A) and as soon as you
> set the SBK bit, the TX line goes low (TTL levels) as expected. It
> will go to high again as soon as you clear the bit again.
> 
> So to me it seems there is nothing wrong here. Also have a look
> at man ioctl_tty:
> 
>         TIOCSBRK
>                Turn break on, that is, start sending zero bits.
> 
>         TIOCCBRK
>                Turn break off, that is, stop sending zero bits.
> 
> So to send one break "character", you need to do ioctl(TIOCSBRK)
> followed by an ioctl(TIOCCBRK).

… you're right.

regards,
-- 
js
