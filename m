Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036E05477BE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 23:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiFKVoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 17:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiFKVoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 17:44:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1AE57B3C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 14:43:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c4so3476572lfj.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 14:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfPbQWxVdTCOJ0ARtfuxn4tIfyfSZbkVjOIz2CyS9yM=;
        b=XUz9K1yVXlY0DRBDL7zr/EEftWakgFSk5edf9xSmnaFRtK8w9R41V9cED2gfDsxEy5
         +ghpvR7TdhpG17i3HH6k/VZMJtPeqY1wECzCPja2oejHzdpgpCOW1Eb9esT/j76u2Ix7
         8ES6QIHr1rMCVQL33PdI6tJCgOqKOBLQtjeOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfPbQWxVdTCOJ0ARtfuxn4tIfyfSZbkVjOIz2CyS9yM=;
        b=L/ggXcWbdhaSCnY84kTXdKnuy1OyVxvgoYcGAsngCj0YNKNrGIAVqcJvNVw0pmErvj
         2ZyU8o76R/pL9UuFf95lFc8pq2Ql3MfdrY0t4TvLP/4jwOWLCg9pMY+Vg3vNF1rJiNf7
         Ogp1UYYDRIokL7P2LEUMrjrAVpxRobeJH1s0K9z4j2p/sq39svDRWEdStmBgcMeXovOI
         I4Zp1CbpNeq2M78TgkfYjYRjUfNK2zLbx7+A3QCiL56ZPyg3iulVp1dnVwGEkmtKQZI0
         GglIhpq4EnWgeBEUpseak68wTISHnp/BXj9YZVKBNz5CnmX4Rjkr5o70vs7izjH7GwAB
         X+sA==
X-Gm-Message-State: AOAM530gIm4pa7J4usF421R9StD2BcgKspTcIFmEYFNYMNkLQCBrna/W
        3saDp9ZOCvidnlgR9bvYAFH9bYhu8ga1/GokIHQ6Fg==
X-Google-Smtp-Source: ABdhPJyyzlstOLJKa7Sv0E2yREoSKkKVxNfagzqdjNKZ4h9exDcco/HgBxeywj+hla4Pw8YrJxCcqUytnhupMLzQo6Q=
X-Received: by 2002:a19:431c:0:b0:479:2053:178e with SMTP id
 q28-20020a19431c000000b004792053178emr25009561lfa.117.1654983838112; Sat, 11
 Jun 2022 14:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
 <20220607094752.1029295-7-dario.binacchi@amarulasolutions.com> <20220609071636.6tbspftu3yclip55@pengutronix.de>
In-Reply-To: <20220609071636.6tbspftu3yclip55@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Sat, 11 Jun 2022 23:43:47 +0200
Message-ID: <CABGWkvp1=DF1uok4ZoCRt1EqpdrgdcytG==Ex6zuWgT5mrvdwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/13] can: slcan: allow to send commands to the adapter
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, Jun 9, 2022 at 9:16 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 07.06.2022 11:47:45, Dario Binacchi wrote:
> > This is a preparation patch for the upcoming support to change the
> > bitrate via ip tool, reset the adapter error states via the ethtool API
> > and, more generally, send commands to the adapter.
> >
> > Since some commands (e. g. setting the bitrate) will be sent before
> > calling the open_candev(), the netif_running() will return false and so
> > a new flag bit (i. e. SLF_XCMD) for serial transmission has to be added.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> I think this patch can be dropped, let me explain:
>
> You don't have to implement the do_set_bittiming callback. It's
> perfectly OK to set the bitrate during the ndo_open callback after
> open_candev().

I developed what you suggested (i. e. remove the SLF_XCMD bit and set the
bitrate, as well as send the "F\r" and "O\r" commands, after calling
the open_candev(),
but now I can't send the close command ("C\r") during the ndo_stop() since
netif_running() returns false. The CAN framework clears netif_running() before
calling the ndo_stop(). IMHO the SLF_XCMD bit then becomes necessary to
transmit the commands to the adapter from the ndo_open() and
ndo_stop() routines.
Any suggestions ?

Thanks and regards,
Dario
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
