Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DB2481B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbhL3Kxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbhL3Kxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:53:34 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C136CC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 02:53:33 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o12so53776492lfk.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 02:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/uQ7mlPCwSiqEuD6zV7KjSAepcnZeDwAcxDuZ2+VvkY=;
        b=t6D7CgGki5jRd0hDoY8BbNIoQJRe49ikJBDA+l+2XBIlA7sGK7FRS8auHThctyI+Hy
         SNKJQ9SCOPAhRF3z0bq9drftCDCrEviSIbBpmQZ+UAfkCNUOeD7rY8LkYw59BD7pEjr2
         Wqp9hF90+W+TN4/QzQCrdU23Gti3Vvwp+6MlViWmtBTZa/at5dKwwzGoHzusLX6/GLD5
         uHmLJ7eq7ALLS3sBA98A3BG0gsUwNVrl6snNDsxjkLVVr7Ju40oaPJo+fFY/lmx5Whon
         DxRbTt1d/+3Ufg5zl03Q8uipxwG+MHpkzLpjs9KNkTSaSrblQdbAiIbtEJc2+tfPT1Jc
         xxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/uQ7mlPCwSiqEuD6zV7KjSAepcnZeDwAcxDuZ2+VvkY=;
        b=PrWyQqbjEkc0X9/9IU8jbIwOTKscLeYNGJKssgtmNISf0EVr8N5a9HKUXKe5525b5F
         L9LSC2ufhfu6KBf5LGDhyOQwSGmuL9tg70iJVrDirlz/YTCoHeTOQ3w2nGCMczaK9jKS
         hxiTFp0n5uMmbEsihW4ewLPuR4GnFxLfOF76K1QphGr2ke7u37V/0bBdtCcyNT7xKXK1
         iNeFtFcK/b1sRQMl7K2ONextaQbGyyd8Qiy4aBeYA7fCfK0G2qiaMtuLBbUsBEcrRoKj
         owq6VbKO7vEp3me3hf5l2QJMFZGbb1MNW+VhtkkW78rUPuhhQNR/4ehveljsM4WbU2xw
         4A7g==
X-Gm-Message-State: AOAM533j5NxhT0ceNF+YZhkb+sRhTis68tzANtT0dkjx9WbI72KDVfWE
        TjfSdQsIB4l32S4P0NN6yhI2JHzb4sMB3uk1EGA=
X-Google-Smtp-Source: ABdhPJw0Apz3JIJeEBDtMs9Y5vEAfNTei6l+6aip3zHthxK7kmyyRUU0T///hsuE2VcvxGW/yYgPXA==
X-Received: by 2002:a05:6512:39d1:: with SMTP id k17mr27672364lfu.303.1640861611772;
        Thu, 30 Dec 2021 02:53:31 -0800 (PST)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id l17sm2460981lfp.82.2021.12.30.02.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 02:53:31 -0800 (PST)
Subject: Re: [PATCH/RFC] drivers/irqchip: add irq-inverter
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211228165642.2514766-1-nikita.yoush@cogentembedded.com>
 <87h7aszj70.wl-maz@kernel.org>
 <b5e0ff57-885a-051b-4c4c-a02b005fa1f1@cogentembedded.com>
 <87fsqbznc2.wl-maz@kernel.org>
 <37db485e-b832-9ff1-4d21-606eeeba871c@cogentembedded.com>
 <87ee5uz8hk.wl-maz@kernel.org>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <9df5e85b-79e6-b796-e5ce-bc47d2cbed67@cogentembedded.com>
Date:   Thu, 30 Dec 2021 13:53:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87ee5uz8hk.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> The right way to do it is to use the existing API by exposing the
>>>>> inverter (there are existing examples in the tree, using the
>>>>> hierarchical model)...
>>>
>>> A much simpler version can be written in a few minutes, see below...
>>
>> Can something like that be used if the parent domain is not
>> hierarchical (i.e. does not provide alloc(), but provides map()
>> instead)?
> 
> No. This definitely relies on the parent being hierarchical, as that's
> exactly what it was designed for the first place.

Is supporting hierarchical API now mandatory for kernel irqchips?

If yes, then perhaps you can at least document it somewhere?
E.g. declare irq_domain.map() as deprecated?

If no, then I'd like to discuss a solution for irq_inverter that can work for non-hierarchical case.

Nikita
