Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A955B1EC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 14:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiFZMhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 08:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiFZMhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 08:37:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BC5CE12;
        Sun, 26 Jun 2022 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656247014;
        bh=Hbtbw9jJgitYi4Z1i1+4yr+MTM8CnSIbUaYa7C0VFDY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kswUMhETBFK56Q0XxSikt3etbjm1mDVeRvzvFtdSeO5Napul4RZfuHgWZ6GI/Djse
         3eo9t0eDmH7IHUIjjEBOxhbfvW0jkhyUYreAvD2NVL2H19IcnqDAEAGgoFbxs6fEyr
         FNwQX9bQ9mM04EkHSDDw61NgYSeTmIKRz6nycvTE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.248]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhlKy-1nRxtW386K-00dkI7; Sun, 26
 Jun 2022 14:36:54 +0200
Subject: Re: [PATCH 01/36] serial: Add uart_rs485_config()
To:     Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
 <20220606100433.13793-2-ilpo.jarvinen@linux.intel.com>
 <20220625201912.GA29720@wunner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <918ab6d2-c0f8-fd74-8e80-36d86ba82255@gmx.de>
Date:   Sun, 26 Jun 2022 14:36:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220625201912.GA29720@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K5Dksg2RaK0LqBDn1SNu1Z+t7gV3IiwFu9erKwyTmoohPcUepHY
 Y/qgDB1NZpObVLEXvW+Kj7dyurIZHwEkMZW4eLhf0di4a8xFCe5aF5tl2+ISKKUFDmx8epA
 N/x0SfOoBHgEosaDdjMkQiZorISW1sf1Kcf1cmwSWsAmksETKXZ5lGczgfN+DOYAStxIN6t
 Dl+RULIgSGU0M6WIM8LUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ss1557fiKFY=:hTT7UI5/V4QTt6XUM8QXCc
 dCSwXJc1GSfJuAc7BvpGQ65AhulAWoQff++G5+UqBmx8FjA+jec0y99hIFUwSYVAg+LMHGxtQ
 SQ6qP4y/72i3FSa5SmjTr95cgZWU36xXh7jFz9GI+JHdC9iZdgSdvo4USkYPea0EWc1Tn21IO
 QFUnR1yeVWDfeLOwYXMUT26WKyKNoxS4IySLpIv06BDUsmZ/d0BNFAFw3tTmlF58YWCRchNpN
 dXTe6xljzqunV0OoOQ7NQiEPw6czb38I0Qm5Jx+0GaxvM/LJjKLBVgAWevX0FLOp1iSGTJCt2
 iGn1y75nI3k5FtgagOKoGiit4ct3jVGt4go2jqQz5RA7g6yH4jKpaqBR/heFAbB4Vq4HK5n/N
 qxlFmVhTa47e816ZKp5ThJcPmgSRY2ysxUyIvhv9G8/ogmLKBodZdcWj1u2LioQQkQ/f4KiAg
 5aEUup0q/wYsFU9T9AF3WFez4HoS4OdcHnEfJrPEzU7oWiLzAKtr67cQVF87JtEf41WGWao6B
 dx2jZmMYifo7IKXIZcT6dGy6skXRXhCoxSOIFtcQ92ctOVu5eM9nDmmtTRIhspDH5LVfGP+jR
 SNdxZvf8mITs3ARhRqWGxgFb/8rj1RsDkd/iKhxCx57ihpKWkoTlJEJh/qFSAATsFBHPUQQW3
 0kWOvEnEe9HiXOzr7oAfojX85hrLNe28axaVNO5kUhKSxdL79DwYpaqP5blXnG+K14xZqzO7W
 7bnNGV3Nn/CE20XwGHeOHlyMGfnas3sAgv9wN2oxEV/iTu2ZN9G7eMrIPKEXDTkAlkTSDdtuL
 ueKuILNWr0uCQa8RM7KsoqUxfkHiVUz3fL6cQ1JE8dkBE25OydK6gzlMa2PGab3Clvg/fHLDG
 MMN36/7bh6KQfR1ojE/f1ae8i9Bz1ri4Fox0pP0M6hJSRBTNbDbcLhXuHfkYaK0IAn911s0TQ
 F9JtpD5rE4qTYIOabZX6FHMj47POmFoR+iZ4fzahZGxuQjbmwCUq3oVniSh44bBSb1lk8ZfGa
 YnympI5ZnG/jeTF28YaRFxMV2u3fDXUzpDQhj1t48OKrlLWbt8U6fshBXKl1fRyTmiYeQjNjf
 8EP1bnW/dURpdvUGDd1/o46VFjHc9oRgsqz1qhtEO1QOwhuJvjtOY4y7A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.22 at 22:19, Lukas Wunner wrote:

>
> Why doesn't this helper acquire the port spinlock, unlike
> uart_set_rs485_config()?  Is this safe?  Do all callers hold the lock?
> Do we need an assertion to verify the lock is held?
>

AFAIU the callers are using this only during initialization, so there is n=
othing else
at this time that accesses the serial_rs485 struct and thus no need for lo=
cking.

Regards,
Lino
