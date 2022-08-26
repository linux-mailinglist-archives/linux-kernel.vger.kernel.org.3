Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D85A2BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344478AbiHZPvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344497AbiHZPvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:51:32 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27739CEB36;
        Fri, 26 Aug 2022 08:51:31 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r6so1543307qtx.6;
        Fri, 26 Aug 2022 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=FesPnI2XuGI2A/F80YHcfjcFtoY5eMqDAbWBbAutgu0=;
        b=Tb1NPOfLTTuZPV2OEeyPMKLrpCOa8GCeaT0SfZHEK1oPlezyF0I58nu8WzeKr9AW0y
         Om0g2tQUPpuHWClziyqnLqltAWbr+sjQ1oCYMCnTOchwtO9/Uyq8eW7wrYQlC4G60rjS
         5KHcMSODDfgszM9scFQhvPE25sO7yDB7vGPEFX1LcFRNNvb/Staxrf8f7pFmIdWmHigQ
         Dl70sf7T82JxR8xYxTVeRZZE2cNtazPkTwd/SqUGJZLCfIkosqtgwuwuyfBD5pdk18Jy
         3mYVORFJwlPkuayJ6qdEFEnoariQUKPkvTd0ZlGr3ugh7PGZREdBasFgOQfurMS6fg6e
         jP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=FesPnI2XuGI2A/F80YHcfjcFtoY5eMqDAbWBbAutgu0=;
        b=BhEHOPWbDbLGZy8JumzHRvcG5SF/p9cXZqKhVv2HcKRkTAKACQKRS9Ksn5FMXNKrLu
         vXWx5Hb8f5LDhE/ieIai9XTPD5vMKR4m7uRailHX9yk/u+UAqxpGxa+wWrzf8RjMdPT4
         LfpKVFzAfeeyyKd2TjDvOnvr0mgmQiAryyhhjcShKyHFzOq+Eh28wwCLBkZpKTB66QPl
         n646bBbf5vrtsOH0VkW4rc5LeWwcdqg1E0CqpTy4pEDX6BYNeMGEO+tAD+cf0NC3D9tN
         nDNXlFLAc8SWkjCIFlPP3BrRv8VPstpCBYzBC/rWU/teymoYbWmkd8oMpyqhjRVNeVqr
         SB4Q==
X-Gm-Message-State: ACgBeo1oCvvA9domtZh6pjzjtyhWkiPpN1xn5Pt3viTIRivl5ET97kqn
        YQHHQUixFccvkueVy9kSxgXOae2bA92fV2LSb+4=
X-Google-Smtp-Source: AA6agR4VGlk6KoIe8nbYogc4V3QKG0ZzM46cFZPVa7XoeVTCBC/6A5ViPmzidBFCq+bvi9tj/xF7S/yx8QEsIIGspxY=
X-Received: by 2002:ac8:7dd0:0:b0:344:afc1:b11d with SMTP id
 c16-20020ac87dd0000000b00344afc1b11dmr277022qte.195.1661529090174; Fri, 26
 Aug 2022 08:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220826144629.11507-1-ilpo.jarvinen@linux.intel.com> <20220826144629.11507-4-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220826144629.11507-4-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Aug 2022 18:50:54 +0300
Message-ID: <CAHp75Vc4NfZE6DxFnfeAS9fxnZHpxMjacHy1TsG8ib+FiCqFLQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] serial: Add kserial_rs485 to avoid wasted space due
 to .padding
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 5:51 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Struct serial_rs485 has a .padding field to make uapi updates easier.

The struct

> It wastes space, however. Create struct kserial_rs485 which is a kerner
> counterpart w/o padding.
>
> kernel_serial_rs485_to_user_rs485()'s rs485 can now become const as
> padding is dealt within the local variable.

...

> -static int user_rs485_to_kernel_serial_rs485(struct serial_rs485 *rs485,
> +static int user_rs485_to_kernel_serial_rs485(struct kserial_rs485 *rs485=
,
>                                              const struct serial_rs485 __=
user *rs485_user)
>  {
> -       if (copy_from_user(rs485, rs485_user, sizeof(*rs485)))
> +       struct serial_rs485 rs485_uapi;
> +
> +       if (copy_from_user(&rs485_uapi, rs485_user, sizeof(*rs485)))
>                 return -EFAULT;

> +       *rs485 =3D *((struct kserial_rs485 *)&rs485_uapi);

So with all assets we have we can be sure that on BE64 / BE32 machines
this will be flawless. Is this assumption correct?

>         return 0;
>  }

...

>  static int kernel_serial_rs485_to_user_rs485(struct serial_rs485 __user =
*rs485_user,
> -                                            struct serial_rs485 *rs485)
> +                                            const struct kserial_rs485 *=
rs485)
>  {
> +       struct serial_rs485 rs485_uapi;

> +       *((struct kserial_rs485 *)&rs485_uapi) =3D *rs485;

Ditto.

+ Blank line?

>         /* Return clean padding area to userspace */
> -       memset(rs485->padding0, 0, sizeof(rs485->padding0));
> -       memset(rs485->padding1, 0, sizeof(rs485->padding1));
> +       memset(rs485_uapi.padding0, 0, sizeof(rs485_uapi.padding0));
> +       memset(rs485_uapi.padding1, 0, sizeof(rs485_uapi.padding1));
>
> -       if (copy_to_user(rs485_user, rs485, sizeof(*rs485)))
> +       if (copy_to_user(rs485_user, &rs485_uapi, sizeof(rs485_uapi)))
>                 return -EFAULT;
>
>         return 0;

...

> +/* Compile-time asserts for kserial_rs485 and serial_rs485 equality (exc=
ept padding) */

struct kserial_rs485
struct serial_rs485

(rationale: standard representation in text / comments and be a link
in case if this is converted to kernel doc)

...

> +/*
> + * Must match with serial_rs485 in include/uapi/linux/serial.h excluding=
 the

Ditto.

> + * padding.
> + */
> +struct kserial_rs485 {
> +       __u32   flags;                  /* RS485 feature flags */
> +       __u32   delay_rts_before_send;  /* Delay before send (millisecond=
s) */
> +       __u32   delay_rts_after_send;   /* Delay after send (milliseconds=
) */
> +       struct {
> +               __u8    addr_recv;
> +               __u8    addr_dest;
> +       };

Btw, can't we convert them to kernel doc?

> +};

...

> + * There's kernel counterpart kserial_rs485 of this struct without paddi=
ng.

struct kserial_rs485

--=20
With Best Regards,
Andy Shevchenko
