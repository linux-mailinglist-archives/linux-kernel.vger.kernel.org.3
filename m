Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5885A43B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiH2HXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH2HX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:23:28 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49354DB7C;
        Mon, 29 Aug 2022 00:23:27 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id nc14so9014704ejc.4;
        Mon, 29 Aug 2022 00:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Rtt2y/T0FmKk18/Gg97piT4mN8veRCiqvd6/yN8Atd0=;
        b=M23d/kCqmCKSd/G1DXvPYA6GefaFWsIbsbMC2zXzG98eHiH+WoLrX0S14pAK6uF9z5
         Y4spcL4hEut46Xu9jrKd0qyypKi1z3uDZT8m1c+2wGTl7d1Y7eX/Ymj5AN3gx6HGe5pz
         SOAgc9Ed/Rwop4LvaFo5ECu53zTComwsZZhjA62EzhpVpUL2kkP8P6ro4j6kNJ9xFwB3
         dQ+OxhJb10B/RxYGXoVocXUwxM/m+EeSMi1WZ2EgMc8k26W7ZsANUIplO8Vpst4DrPwi
         /Y1EN10xHo2BScNWnYsN4RNvHzMjlr01AjqJCB09jwDWO5YkXW2Q5XPDW/9n5ujEJ8t7
         1QGg==
X-Gm-Message-State: ACgBeo0JVyojHZBD9a96hV2cOIgolrV0up2vkZ1EMFL28aCVnCg3fYyQ
        M4bwy0k0Szlw5vJMNhzffbo=
X-Google-Smtp-Source: AA6agR5d0olylVvB5BFwzH64hGODpDTvWwMREyWRUHrBK4/kYB5QIMMqxHWa3pY+fbv692mQaGM9Sw==
X-Received: by 2002:a17:907:1b1f:b0:72f:56db:cce9 with SMTP id mp31-20020a1709071b1f00b0072f56dbcce9mr12351068ejc.605.1661757806409;
        Mon, 29 Aug 2022 00:23:26 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906210100b0073d61238ae1sm4085451ejt.83.2022.08.29.00.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 00:23:25 -0700 (PDT)
Message-ID: <ac383256-65f2-e4ee-0142-65bdb9dd9dae@kernel.org>
Date:   Mon, 29 Aug 2022 09:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/3] serial: Add uart_xmit_advance() + fixes part (of a
 larger patch series)
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 08. 22, 11:17, Ilpo Järvinen wrote:
> Add uart_xmit_advance() helper to handle circular xmit buffer
> advancement + accounting of Tx'ed bytes. Use it to fix a few drivers
> that previously lacked to accounting for DMA Tx.
> 
> Greg,
> I've a another series on top this which is tty-next material making the
> rest of the drivers to use uart_xmit_advance(). That series obviously
> depends on the patch 1/3 of this series so if you end up putting these
> 3 patches into tty-linus, I'll need it to be merged into tty-next at
> some point (I'm not in a big hurry with this so if you choose to delay
> the merge, it's not a big deal).

Hi,
could you hold off with the latter series? I'll send a v2 of TX path 
cleanup shortly. You'd then need to update much less places (if my 
series is accepted):
https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?h=devel&id=2d9ade0412f7e5edacc7f791ebbf773d6481b453
https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?h=devel&id=fd55062d74a8c137d30388c6e25ebd5c06a04517
https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?h=devel&id=a1df5129cc0cf174a8cd03e187c6a5e890d313e4

v1 was here (but was doing a call for every character):
https://lore.kernel.org/all/20220411105405.9519-1-jslaby@suse.cz/

> Ilpo Järvinen (3):
>    serial: Create uart_xmit_advance()
>    serial: tegra: Use uart_xmit_advance(), fixes icount.tx accounting
>    serial: tegra-tcu: Use uart_xmit_advance(), fixes icount.tx accounting
> 
>   drivers/tty/serial/serial-tegra.c |  5 ++---
>   drivers/tty/serial/tegra-tcu.c    |  2 +-
>   include/linux/serial_core.h       | 17 +++++++++++++++++
>   3 files changed, 20 insertions(+), 4 deletions(-)
> 

thanks,
-- 
js
suse labs

