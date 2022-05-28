Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716C3536C08
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 11:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiE1Jly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiE1Jlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 05:41:51 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350C61C111;
        Sat, 28 May 2022 02:41:46 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 8C7BB5FD04;
        Sat, 28 May 2022 12:41:42 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653730902;
        bh=Ex77ge4+cVuN9VwweqWv0CsC0vVpo2OdRP2djs/jzgg=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=KoOHTF7M9/JlRuF2m+QKeCoDpTcLM/8r2P6SOgZVim4uUOODb0JFQ73lS6dNiRxT+
         KqPiay2xPpfJr4KmiARud8MhGikuSvnEDIRssIPiap8ExLF/0nOwp9v15zSu7QDkp9
         lRtzvIvyZOBwMZecyLCZDQLmLrqy6ukthfqZ/b9QjJ++KV/gMGa7zyDYqF864AJobI
         IUyXdRO/eCAMVIkGdwwtq7tun3B8beh1AfwUJo53FyZbfR6m8mCVV+R+QCZV6FaE5c
         CqXBwPn2oNeeg0/zJSjp75RZ8AwImWdvvsdZEJCGH2VwgDqnkK9lpLQG8dbc5XDYDU
         +4yQ+nLQUGw5w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Sat, 28 May 2022 12:41:32 +0300 (MSK)
From:   Aleksey Romanov <AVRomanov@sberdevices.ru>
To:     "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@chromium.org" <axboe@chromium.org>
CC:     kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mnitenko@gmail.com" <mnitenko@gmail.com>
Subject: Re: [RFC PATCH v1] zram: experimental patch with entropy calculation
Thread-Topic: [RFC PATCH v1] zram: experimental patch with entropy calculation
Thread-Index: AQHYbGz3WSsk9a8KK0ibVrkSkBx6g60z4D2A
Date:   Sat, 28 May 2022 09:30:53 +0000
Message-ID: <20220528093121.zqejxapd7xxrbu5c@cab-wsm-0029881>
References: <20220520171309.26768-1-avromanov@sberdevices.ru>
In-Reply-To: <20220520171309.26768-1-avromanov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62DE108081885948A39634B3871D0FB7@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/28 05:16:00 #19603934
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I also try this for /lib and /bin direcories. See results below.

/lib folder as .tar (not compressed):
+-----+-------------+------------+--------+--------------+-------------+
| ent |  orig_size  | compr_size |  time  | instructions | branches    |
+-----+-------------+------------+--------+--------------+-------------+
|  Y  | 16527126528 | 5921855963 | 16.46s | 71366805304  | 11693084550 |
+-----+-------------+------------+--------+--------------+-------------+
|  N  | 16527126528 | 5594516871 | 21.87s | 112664002524 | 16184998761 |
+-----+-------------+------------+--------+--------------+-------------+

/bin folder as .tar (not compressed):
+-----+------------+------------+--------+--------------+------------+
| ent | orig_size  | compr_size |  time  | instructions | branches   |
+-----+------------+------------+--------+--------------+------------+
|  Y  | 5594516871 | 387226648  | 4.772s | 35688596793  | 4486177586 |
+-----+------------+------------+--------+--------------+------------+
|  N  | 5594516871 | 326629907  | 5.811s | 43886087430  | 5161907045 |
+-----+------------+------------+--------+--------------+------------+=
