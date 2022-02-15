Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F624B75C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbiBOR0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:26:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiBOR0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:26:53 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCF9140FD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:26:43 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d187so35976755pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LivC78KXDmCeBXJxJsH/goPuWXuSn9BnrpWMwbtednQ=;
        b=ZZ1NeVjRHkne81llSgnehU+Oly7EGCd8n2UfEjNW4RbULk/bt5g8voHGiQed0jj+mn
         hEl82AhzVEcnTv40D4gjTiSeymrkFFLQBtQoEjw1hXGkmpcWNnEZPxc2ui49Oxdqxpyz
         WBtDY4J3UVxZzANq6JUMWW+9PlbmpsAXHIh+vYn6sP9jQAXkrxs8PuPpOZSECtx4GcuV
         2sXUMosIEAY9Y1f9Myt6udtgtXaFjoK8bgo1UNXlrvQ3SrYLXK9gQwxiL7SadEvKow4r
         AN73bMDKbGXkiH4HsMI7hch/9XYB1gzlcioZSX3OsDXafQWSFZ1efVlr5drlXajird4W
         4pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LivC78KXDmCeBXJxJsH/goPuWXuSn9BnrpWMwbtednQ=;
        b=pZHUIHSkLDwipsko9U9SHSiPMMmnzOc//mYC7QYMHJLSVKK4U3hQeU1qqncZzHgMHg
         DWLwwJhkmdzSNS3StkJieV/0iCwCzfAFVeeRTHlNEy92usZ6nWPJpbIdV5dy7D1VQl1H
         dqDtdkY9becsjUmzOI7/O+fxyKUQtln5iz7mVCTBmyQf0sKZOpOenDOPb7wZ6+a7h64G
         o7ok0KOoYBTgfw+h9OgWTIrGaVlNJN1Ld/Zy/bipdOQACnnG7RhOgJKJRz5Qca30a0Eu
         KaIUWJrdxkTBksGSLJbnRYHgC4GPdSPf6gMy+HOCkWcXe/ThVFA1HK/KRWkmineen37z
         JSsg==
X-Gm-Message-State: AOAM5317dD0qfgQCk1ICKl4ylieVcTYVfJZdITPnzjXbGDOT9uYg6gU2
        b6kRGsCMCZRY8nXpsdf87TyzACmL1aJVxm38Z6ShZw==
X-Google-Smtp-Source: ABdhPJzf97Fv+GmhmthjM7cQZ+yiNvj/uOi69amBBwTr/Gv6s6j9trUhmKnj0GqfEgE0yQ0sylShhp6pIXxc6ja8LLg=
X-Received: by 2002:a63:5b62:: with SMTP id l34mr4397652pgm.440.1644946003281;
 Tue, 15 Feb 2022 09:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20220214213020.685-1-tharvey@gateworks.com> <9d5cff18-5493-f6dd-4bd6-9bafa2a503a7@camlingroup.com>
In-Reply-To: <9d5cff18-5493-f6dd-4bd6-9bafa2a503a7@camlingroup.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 15 Feb 2022 09:26:32 -0800
Message-ID: <CAJ+vNU0sWGsQa=YwLE9Ng34-DhJF=YR3oTV+q--KcgTMCjBa2w@mail.gmail.com>
Subject: Re: [PATCH] serial: imx: leave IRTS disabled if using modem-control CTS
To:     =?UTF-8?Q?Tomasz_Mo=C5=84?= <tomasz.mon@camlingroup.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:03 PM Tomasz Mo=C5=84 <tomasz.mon@camlingroup.co=
m> wrote:
>
> On 14.02.2022 22:30, Tim Harvey wrote:
> > If using modem-control gpios for CTS we must leave IRTS disabled
> > as otherwise the hardware will only transmit based on the internal RTS
> > pin routed to it.
> >
> > This allows hardware flow control to be used with cts-gpios.
>
> This hardware flow control sounds quite limited. Once CTS becomes
> inactive, the transmitter will still output all characters from TxFIFO.
> Transmitting whole TxFIFO already sounds quite bad, but that's the best
> case scenario where gpio interrupt is handled right away without any
> delay (so more than TxFIFO characters can actually be transmitted).
>
> Does the internal RTS default to inactive when it's not pinmuxed to the
> actual pin? If so, then controlling UCR2_IRTS based on CTS gpio could
> halt the transmission when the TxFIFO is not empty.
>

Tomasz,

I agree that the increased latency makes using a GPIO for CTS
(software controlled) not as good as one pinmuxed into the UART block
directly (hardware controlled) but without this patch GPIO for CTS
does not work at all because the internal RTS defaults to inactive
when its not pinmuxed. For many applications the latency is not an
issue.

Best Regards,

Tim
