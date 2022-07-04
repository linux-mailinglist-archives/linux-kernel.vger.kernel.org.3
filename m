Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114A35659F8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiGDPgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbiGDPgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:36:06 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23AF11169;
        Mon,  4 Jul 2022 08:36:01 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id l14so10304531qtx.2;
        Mon, 04 Jul 2022 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LwA/Kv+kT4lvUviRoyI/dEAegOAMYJu1KKy1Tr4jNk4=;
        b=G7P2JWpgnPgLDYkyVc6cKWp/RIvKG6NfOAiMR3Zow56KA7/xE5pgiCIjOSxgwftys1
         HWmnjKnKLI0q2wmim7r797r9QCB28CHlV1nurOOcLuI2UK0IO1iYnZnCr/itiqTs3kqw
         0wi4SsupmhUbfBvt5antJv7+TyAh+WO+yFZSb5uMtR4rIA2Etob2HOjduHx8yY6tUsEU
         a/53BSE5zsCJUg2AwmL+XTdXKRfpvWobyfAQ/0rWN6i3U2TtNt91q3we60WmEtLqcJD/
         kILqZZ0vDJJGrY/Fh8bYHQczsRMvBMTK+yemVw/H7cJtrBbo2yQyFNPZwo3bLR4JT74v
         l2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LwA/Kv+kT4lvUviRoyI/dEAegOAMYJu1KKy1Tr4jNk4=;
        b=USgpJvEh0RQ+oMPHfMYRJDODSC0pJr1rW38g7/tYj/n+drjA7KEVopagmhAFU1Dsvt
         v7iRo8cRTQyiTDDwIloR31ZzFY/OqUIC9S/DDAwAEwpZ8FlrqSPsF9tMN3vvZDk4ye2s
         4WA4x+CAv/UGUNHmkA9to5K3r0NGb+4A7teEqZPwY5CRsAxF/3RIinl1zpcxc8iutIwL
         EFSiaXDG1jsVTMnkUD/cOU2Cn/OCCjQmFlgMrbybdvNPlDTzZqbSDRHd1Ex546C/5z2e
         j8cKe54aGZAFLc+p6Yftm7teLm928BU28X8NyWdFsZOPOknsCVihyREXZ1jfHa7TJqmM
         nzfQ==
X-Gm-Message-State: AJIora+peohl/bdURAunUGIxib1cC1zsuq8Y8UCfWwlSB6qsJZXO7kCV
        mKuobxdk4UbK4c1EJhEBaD4=
X-Google-Smtp-Source: AGRyM1tAypJU/RXFU+t69Of4A/pPH6JorVuxukQtXuaMnDHUm3maocfQWXmPBUwBYZqS2VS8ernx4A==
X-Received: by 2002:a05:6214:20a4:b0:470:51fd:d455 with SMTP id 4-20020a05621420a400b0047051fdd455mr28450647qvd.26.1656948960758;
        Mon, 04 Jul 2022 08:36:00 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id r8-20020a05620a298800b006b4689e3425sm2270630qkp.129.2022.07.04.08.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 08:36:00 -0700 (PDT)
Message-ID: <f422b4f7-75ca-8337-e099-fea9cf879b4c@gmail.com>
Date:   Mon, 4 Jul 2022 08:35:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v2] serial: 8250_bcm7271: Save/restore RTS in
 suspend/resume
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220629160208.3167955-1-f.fainelli@gmail.com>
 <a7104148-2c11-8235-9282-5731639316f5@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <a7104148-2c11-8235-9282-5731639316f5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/2022 11:40 PM, Jiri Slaby wrote:
> On 29. 06. 22, 18:02, Florian Fainelli wrote:
>> From: Doug Berger <opendmb@gmail.com>
>>
>> Commit 9cabe26e65a8 ("serial: 8250_bcm7271: UART errors after resuming
>> from S2") prevented an early enabling of RTS during resume, but it did
>> not actively restore the RTS state after resume.
>>
>> Fixes: 9cabe26e65a8 ("serial: 8250_bcm7271: UART errors after resuming 
>> from S2")
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   drivers/tty/serial/8250/8250_bcm7271.c | 24 ++++++++++++++++++------
>>   1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c 
>> b/drivers/tty/serial/8250/8250_bcm7271.c
>> index 9b878d023dac..b9cea38c8aff 100644
>> --- a/drivers/tty/serial/8250/8250_bcm7271.c
>> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> ...
>> @@ -1180,7 +1184,15 @@ static int __maybe_unused 
>> brcmuart_resume(struct device *dev)
>>           start_rx_dma(serial8250_get_port(priv->line));
>>       }
>>       serial8250_resume_port(priv->line);
>> -    port->mctrl = priv->saved_mctrl;
>> +
>> +    if (priv->saved_mctrl & TIOCM_RTS) {
>> +        /* Restore RTS */
>> +        spin_lock_irqsave(&port->lock, flags);
>> +        port->mctrl |= TIOCM_RTS;
>> +        spin_unlock_irqrestore(&port->lock, flags);
>> +        port->ops->set_mctrl(port, port->mctrl);
> 
> Calling ->set_mctrl w/o port->lock doesn't look really safe.

Good point, I will check with Doug whether this was intentional and if 
so, why, and if not why should we move it up under the spinlock.

Thanks!
-- 
Florian
