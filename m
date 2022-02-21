Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C135D4BEAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiBUSU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:20:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiBUSSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:18:41 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76731175;
        Mon, 21 Feb 2022 10:10:47 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id v5so15396515qkj.4;
        Mon, 21 Feb 2022 10:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=mbIldg0iF9VjD3Ozzo0Wwc3h0+c5pHLpFRfUlyikWD4=;
        b=SQpgVeknETm3lRds0h8fPFBRjuKgDeVGe06ljjy5wKCPljPOA7MqeVpck/bg0csbR1
         UAO+ruRNU8ddhRbpew5DiEEGCk6rOw6Su+03sK65CLqQpzi/ZjF7qyA5g7audHAFztL5
         WkSkn7YB1qni8heM2nQn0fZnxcKy6djTP3qUkE7OvL1VM+G9spFe1cCeE+lBAjwsP/Gj
         1bJBNyWJX1LuJihDid+PreN37nev/tcMqcx5OUf4ALfVJ6KejgsjskBv9J/m/XyJUvPc
         azge9p4hvpIs8aO6QtJwrm5C8iYbtXQYbGrGfS5Iqz2UaAW6co9/Su8uDg3Hga5eHArL
         hNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=mbIldg0iF9VjD3Ozzo0Wwc3h0+c5pHLpFRfUlyikWD4=;
        b=mlsLmgOWIVVijzmrxK0+IAbPDisB3oiH7R0oe6phKLRPfiqeEJMWLmCtKZZxiTMnGX
         n5eF1h86CI2Tm10B01M/hDN/ud02XJKnSrJ9KHN89CR03JdBjMwpJutpUKe06qJEDBZm
         Gz7whO26uD/zowrfRt/yJbF7AjbVV6SBD+dFzhGUYmLPXSiOzgHAV44cEdDvPW9K9UDR
         +UItwDZUQCf+Kpvy48XsPnGLQ69xOYkqmlNVzH35nw8f9ImukEWPTHXuqbwxUjUEcYnr
         eMvoMx8rofJ2mdZX2DJ2EjKjSLeHEGcJCRmyhQerR9yH8t3rwpx4Q9zqFS2IQYgKyopl
         443A==
X-Gm-Message-State: AOAM532UThDls6gCkflpM6rl1caEDaDamB0LCDmYFzkTLzPnKIp/eC24
        FAYmt2q6VFH5MWApu3jQ4FQ=
X-Google-Smtp-Source: ABdhPJxiPfnOca6vCD4UTzyG1YC6EYVSfPpA7lakd+x2ogE1JO2/bWacWek6BJYIuzhu0DvmO25RtA==
X-Received: by 2002:a05:620a:288f:b0:47e:afd0:3f88 with SMTP id j15-20020a05620a288f00b0047eafd03f88mr12752484qkp.393.1645467047029;
        Mon, 21 Feb 2022 10:10:47 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o19sm30418708qta.19.2022.02.21.10.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 10:10:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1778a683-30fa-9119-c3ce-2dddb5939809@roeck-us.net>
Date:   Mon, 21 Feb 2022 10:10:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <CAHk-=wiWZ=3dTuRq46KvQVpx-e7xqrnMAVB73dzj7g4Pbwc1zg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.17-rc5
In-Reply-To: <CAHk-=wiWZ=3dTuRq46KvQVpx-e7xqrnMAVB73dzj7g4Pbwc1zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 09:44, Linus Torvalds wrote:
> [ Fixed the subject line - you answered the wrong email.]
> 
> On Sun, Feb 20, 2022 at 6:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Build results:
>>          total: 155 pass: 152 fail: 3
> 
> Grr. Things are going in the wrong direction here.
> 
> At least the two new cases look trivial, and that ppc fix is finally
> in linux-next.
> 
>> Qemu test results:
>>          total: 488 pass: 427 fail: 61
>> Failed tests:
>>          arm:orangepi-pc:multi_v7_defconfig:usb1:net,nic:sun8i-h3-orangepi-pc:rootfs
> 
> Adding some devicetree and otherwise involved people to the cc, can we
> *finally* get this fixed? It's been around for all of this release,
> and Guenter has done a fair amount of bisecting and testing, chasing
> down lockdep reports etc.
> 
> I've been ignoring this on the assumption that it will just get fixed,
> but it's starting to be pretty late in the game now..
> 
>>          <almost all mips tests>
> 
> Gaah. And what happened here? There aren't even any MIPS changes in
> rc5, so clearly something went sideways that just must have happened
> to affect your mips qemu tests. Added Thomas Bogendoerfer despite the
> lack of commits.
> 

Oh, that is "just" the result of the netfilter build problem.

Building mips:malta_defconfig ... failed
--------------
Error log:
net/netfilter/xt_socket.c: In function 'socket_mt_destroy':
net/netfilter/xt_socket.c:224:17: error: implicit declaration of function 'nf_defrag_ipv6_disable'; did you mean 'nf_defrag_ipv4_disable'?

This was introduced with commit 75063c9294fb ("netfilter: xt_socket:
fix a typo in socket_mt_destroy()"). The build error is seen whenever
NETFILTER_XT_MATCH_SOCKET is enabled and IPV6 is disabled, and mips
builds are the unfortunate victim. The patch introducing the problem
now proliferated into the 5.15 and 5.16 stable release candidates
as well, causing the same build and test failures there.

The real question is why to patch introducing the problem made it
upstream even though the problem was reported several days before
the push request was sent.

Guenter
