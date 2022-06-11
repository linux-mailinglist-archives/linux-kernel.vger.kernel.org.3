Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4483B547592
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbiFKORT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 10:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiFKORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 10:17:18 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D985B10FF0;
        Sat, 11 Jun 2022 07:17:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 5B891100022;
        Sat, 11 Jun 2022 14:17:15 +0000 (UTC)
Date:   Sat, 11 Jun 2022 16:17:13 +0200
From:   Max Staudt <max@enpas.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220611161713.5303549d.max@enpas.org>
In-Reply-To: <20220611133608.3zdfb3nnl5445kr7@pengutronix.de>
References: <20220602213544.68273-1-max@enpas.org>
        <CAMZ6RqLLn3tE6kPd+yyHURsbBU_jVKN=u4=YvhZVyAf_NyRqCQ@mail.gmail.com>
        <20220611151551.5024f51e.max@enpas.org>
        <20220611133608.3zdfb3nnl5445kr7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2022 15:36:08 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> What about this change?
> 
> diff --git a/drivers/net/can/dev/netlink.c
> b/drivers/net/can/dev/netlink.c index 7633d98e3912..667ddd28fcdc
> 100644 --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -176,7 +176,8 @@ static int can_changelink(struct net_device *dev,
> struct nlattr *tb[],
>                  * directly via do_set_bitrate(). Bail out if neither
>                  * is given.
>                  */
> -               if (!priv->bittiming_const && !priv->do_set_bittiming)
> +               if (!priv->bittiming_const && !priv->do_set_bittiming
> &&
> +                   !priv->bitrate_const)
>                         return -EOPNOTSUPP;
>  
>                 memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]),
> sizeof(bt));
> 
> If it works I'll make a patch and apply it to net-next/master so that
> you can base your series on this.

Yes, it seems to work fine, since the dummy function is empty, and it's
only ever used in this same function, and the pointer is guarded as
Vincent mentioned. So if a no-op do_set_bittiming() is okay, then not
having it at all is also okay.

Yes, I'd appreciate you patching this, and I'll rebase upon it :)


Thanks for your quick decision!

Max
