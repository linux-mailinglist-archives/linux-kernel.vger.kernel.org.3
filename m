Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E772B5265E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381889AbiEMPUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381888AbiEMPUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:20:49 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735A466ADA;
        Fri, 13 May 2022 08:20:48 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2feb8eac315so15970627b3.3;
        Fri, 13 May 2022 08:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmZIoJGMrKtmX8tYXoWBlj/vP3BEUHY+bCqtu7SbDdQ=;
        b=eRYvIy7JEGU/KpzqugeeAqcLMcWuKZc37MPdyj/9ElGSMFt+6yTo9/NQjhbIySLtAt
         DtX4OytyLtMt9Q5ZXWhqVcYYvibTRbpCcf48beDpxKZ8wqCs1rtb5WCwRZyCZMosCrQ8
         W03jpy++9P/f+ar+eFEAPFQIDyXrz+56i9qffinJA6Qf4NwdF+6Hj4mIRUhynxYWcug2
         3uPilDkpbcWm4PomotAycbxGyZDVh/f4UN52vB0uPwP3tWreQtff0wnXqvtOdQy3+TNh
         sxrvC3YscRZjw5rW3jyIi1OqH01sQEVjWu3sr0nSjcfnvjI4ZBaG0o7mlPKEqkIg41IK
         ZnqA==
X-Gm-Message-State: AOAM5313Ehpt/L7AUPs2RlGaUh4/ls53mAo/miaU1Vq/lAvAqMwCMr0G
        cvQds8K5haGXSzhUHq6UiZssvipvkd5vhGK+Z+k=
X-Google-Smtp-Source: ABdhPJz3MzTrixY89GB+xcGxbpQzk0lpihBmY9JNmCwDA9pPezWUV0vmD6nvtcsExxO6VrQwpSnoqCTtu9K5hU35MA0=
X-Received: by 2002:a81:34f:0:b0:2f7:bbb1:1576 with SMTP id
 76-20020a81034f000000b002f7bbb11576mr6303681ywd.45.1652455247642; Fri, 13 May
 2022 08:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr> <20220513144230.upuirv4ufebxvfbq@pengutronix.de>
In-Reply-To: <20220513144230.upuirv4ufebxvfbq@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 14 May 2022 00:20:36 +0900
Message-ID: <CAMZ6RqKBLSVmPXsdKS0F1C+9JnDJKULO9dhY00A1bRU=nMmJ2A@mail.gmail.com>
Subject: Re: [PATCH 0/2] can: drop tx skb if the device is in listen only mode
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri. 13 May 2022 at 23:42, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 13.05.2022 23:23:53, Vincent Mailhol wrote:
> > In listen only mode, tx CAN frames can still reach the driver if
> > injected via the packet socket. This series add a check toward
> > CAN_CTRLMODE_LISTENONLY in can_dropped_invalid_skb() to discard such
> > skb. The first patch does some preparation work and migrates
> > can_dropped_invalid_skb() from skb.h to dev.h. The second and last
> > patch is the actual change.
>
> Thanks for your quick patch!
>
> What about moving the function to a .c file? The
> can_dropped_invalid_skb() grew a lot over the years, since it was added
> to the header as a static inline function.

OK. Will also migrate can_skb_headrom_valid() which is only used by
can_dropped_invalid_skb().

> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
