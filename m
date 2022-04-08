Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1A44F95E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiDHMgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiDHMgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:36:38 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4297D34419D;
        Fri,  8 Apr 2022 05:34:35 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2389pBUC030712;
        Fri, 8 Apr 2022 14:34:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=bp+advT6TM4LuIU9sLQaID0/TZyMgJN3G2xJZz8o1AU=;
 b=eABha4MSL/xg7cgiJru/aiX8yjGl3v7qG+TgqX0x9EsmjR7fprmru21plFCCWv0iUtD/
 Pc3sf5vj+xJXhbfr6Hgye9ZtH2MTzJu4XZMx2e+hrZyMKtTftOHiKjUhSIu3HQXPrDeN
 ZwvNLsljApLl40aI69xulJOMayBQbX/6xwqKLoO7Q+MWnRiTwcpjngYQNDjSgkwrdvGr
 H/KlWHLk60AXq2cTkQMx6LIMZYkIvdgax71qLWkIwMNS57yHVMbH/aAhRxAINsjmY7q8
 6sZJLd7wy9k1zskvea3CbUUDVk9wpr+xddm3XTF9d35ul0mBw10+phSsYU8cB3R7UA/j ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f6du1c173-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Apr 2022 14:34:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0FC3C10002A;
        Fri,  8 Apr 2022 14:34:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 08C2E21A233;
        Fri,  8 Apr 2022 14:34:17 +0200 (CEST)
Received: from [10.201.20.168] (10.75.127.50) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 8 Apr
 2022 14:34:16 +0200
Message-ID: <01e5e489-024c-89c1-4df0-21a12557401b@foss.st.com>
Date:   Fri, 8 Apr 2022 14:34:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/3] serial: stm32: add earlycon and polling mode
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        <linux-serial@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20220407123109.132035-1-valentin.caron@foss.st.com>
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <20220407123109.132035-1-valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_04,2022-04-08_01,2022-02-23_01
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 14:31, Valentin Caron wrote:
> - Add support of early console and polling mode in stm32-usart driver.
> - Avoid a possible infinite loop in putchar function.
>
> Valentin Caron (3):
>    serial: stm32: remove infinite loop possibility in putchar function
>    serial: stm32: add KGDB support
>    serial: stm32: add earlycon support
>
>   .../admin-guide/kernel-parameters.txt         |   6 ++
>   drivers/tty/serial/Kconfig                    |   1 +
>   drivers/tty/serial/stm32-usart.c              | 101 +++++++++++++++++-
>   drivers/tty/serial/stm32-usart.h              |   2 +
>   4 files changed, 105 insertions(+), 5 deletions(-)
>
Hi,

Please drop this series, I sent a V2

Thanks,
Valentin
