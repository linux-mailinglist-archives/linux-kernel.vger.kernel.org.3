Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5EB48FDF1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 17:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiAPQuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 11:50:24 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49428
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232585AbiAPQuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 11:50:23 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2291E3F1E3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642351816;
        bh=uu9EwQyUbuYOtlXdv8X6YvDBdNAXZT2Hiy2y1K9OCsE=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Ah6xF7eC0TWXBsxmFjXPvU/9YqyLg9qkw/JSvMksPcoP/cYbJzPpp5jwtVWtLc3lO
         ok+ELGEZbh1r+cd3JC+SsBQHUiSYvViwGmSVgKu0RwmC83eoK6LW6uU6NV7A7mrCcj
         LflY1FAMO2o7ZBIej/P8VK+KAEm54Y9SlMirn/fu0MZBoRRYnsh8wuirF/XLWuoMY/
         t3dEfBNQuLTgyzQtdunvgQpUdzQxfrOR6+iaNEPPZhVyZfi/J7gIO7dddnI7XWbxPG
         OGMZ8oLqRK9//k38WNFqJhEfVDHIf0e2cR2ReHZUNjtntLGDscXZ+fnf/aOmXFdgRr
         sVLE7l7fCQrqQ==
Received: by mail-ed1-f70.google.com with SMTP id a8-20020a056402168800b004022fcdeb25so1432360edv.21
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 08:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uu9EwQyUbuYOtlXdv8X6YvDBdNAXZT2Hiy2y1K9OCsE=;
        b=Y7b1HRfMmy5b1HzdAIz1my2tTZs404jk52ApPLSPWsn2MFFhpfvRbjWBEqSXi9Gowq
         146nJs+OTtCrt72tVHY2P+obAd5dx2l7NyGvZc8MfKk/T7XaTPISJ+eqcFnitQnp7BhK
         UjPvHv3DSuvpxQtxtcKQGRo2xqPAKjtBz4y5VfLWwQu37mGI8ODiAtZr4HdXQczawmj4
         ODu98lhzjxzVtQkm+x1GVqKwH8+56HVmb1M0WpfHaspDwzKMrLYE2aS5ZYvxJCgYsgIf
         GMsNvknQx4+nSA/mB0o6TPrm1o0NZzFYckngUoN0KJaFV1Mp+i9JCVBo5J+rXUlSPk++
         CYAg==
X-Gm-Message-State: AOAM533AjjHIYxcLwlDHdtG+xXutdnpqbIjMjpZWLTPmcPfJTcqSoDLw
        4vexExFumdCI/33YwPZiezwXKuq1SxqLYM8XmUn1tkgp0ML6kFk43nKutzVqDfjmcxHXauJHlKH
        XtYpwr1J+t3jhGJ7CJU5eWDZV0tmDIwGKQvxhuMsQ2A==
X-Received: by 2002:a17:906:3e8a:: with SMTP id a10mr13816078ejj.612.1642351815015;
        Sun, 16 Jan 2022 08:50:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTDkNNzbNUZrdQVQnZWdz82SY8ieh3/fjQzLtq01B7PHYFbyE/eHBt0M1wSkD8sdfYhWEPVA==
X-Received: by 2002:a17:906:3e8a:: with SMTP id a10mr13816070ejj.612.1642351814769;
        Sun, 16 Jan 2022 08:50:14 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id 7sm3585082ejh.161.2022.01.16.08.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 08:50:14 -0800 (PST)
Message-ID: <ddce0e77-2fba-716f-6a69-eeb148fe91ca@canonical.com>
Date:   Sun, 16 Jan 2022 17:50:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/7] nfc: llcp: fix NULL error pointer dereference on
 sendmsg() after failed bind()
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+7f23bcddf626e0593a39@syzkaller.appspotmail.com
References: <20220115122650.128182-1-krzysztof.kozlowski@canonical.com>
 <20220116134122.2197-1-hdanton@sina.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220116134122.2197-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2022 14:41, Hillf Danton wrote:
> Hey Krzysztof 
> 
> On Sat, 15 Jan 2022 13:26:44 +0100 Krzysztof Kozlowski wrote:
>> +++ b/net/nfc/llcp_sock.c
>> @@ -789,6 +789,11 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>>  
>>  	lock_sock(sk);
>>  
>> +	if (!llcp_sock->local) {
>> +		release_sock(sk);
>> +		return -ENODEV;
>> +	}
>> +
>>  	if (sk->sk_type == SOCK_DGRAM) {
>>  		DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
>>  				 msg->msg_name);
>> -- 
>> 2.32.0
> 
> Given the same check for llcp local in nfc_llcp_send_ui_frame(), adding
> another check does not help.

Helps, because other is not protected with lock. The other could be
removed, because it is simply wrong, but I did not check it.

The patch fixes the report and reproducible race, but maybe does not
necessarily fix entirely the race (which maybe this is what you meant by
"does not help"?).


Best regards,
Krzysztof
