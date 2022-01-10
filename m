Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337F14897BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244973AbiAJLnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244923AbiAJLlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:41:45 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26C6C061748;
        Mon, 10 Jan 2022 03:41:40 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id l68so7933157vkh.4;
        Mon, 10 Jan 2022 03:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o514X0rKQeZG8KSvRY+nluj6/Uqn5RzfGG2pNIWGbz4=;
        b=RpCR4VRmypfzEIS8sdD+1MhtREHywwBRPMt1/4Vdazr0+FzTXAt38nFlsbttcS8Wvi
         TRYpoJG0BrtM7IohqSEz2/6nlqsWxxyQ9MliDTfrU3U3bdc3GkSnFtP2xqF/anNxLXx1
         h0XwTGzjpWFiPHTkLDRA5dZcApaQicti+hCmqjoLaA8UgAQBm+Q+Td/nICeoAMLQ6pdy
         v1x8txQ7cL3puqHqS9fVtaFUsuTYATEjkOzWmtKIbKvksqHXcrx8LOF9FVTVxbf7cAVv
         /4DShyncvzHu0mzERufmEgc5EB0z9saOD56LzfCy4StafwXbSug3q/3mR1CkZLjPGVH6
         MKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o514X0rKQeZG8KSvRY+nluj6/Uqn5RzfGG2pNIWGbz4=;
        b=XmLy2yZJeVGc+RkBEmximTRYsHJ70f96uTrYHpPUmIw55BgrBhaKEH+dj82SGENHL/
         9Ik6peIlrT2kzLjxp5YEoBpZp4f3QgTPIcxmscGBYBGba0aiCXywaK4CvPBnyCcW9sPm
         ezhKN3eyZ6SKEcA2LrsB3oYwPyYgE6C/6sXAoZ8FE35ObQ24wsJkWqzhfGjFMO+ZKPFF
         uqWkFP4HpN46xGDc2QPH/cLACN5UKkDgxbY4ew0LeOBYF81PbVrSLafUeiHHYyqiNkpb
         EjHw4V2yqVHyrvwPHYoUbICQtx9s/qVwVIqJ+O470ecHISS9aZcDVgWzkqiL7gFyuvaL
         PToQ==
X-Gm-Message-State: AOAM530222oUalvcpgdPMaUknLqzebwVbDQlo9ctBJJ44QcbhTW85HUn
        +/bUMGSWEwWH05jLKkA9W4or892ABmpt+DizMbc=
X-Google-Smtp-Source: ABdhPJwGvgloBmQRKWa/zPp77xHXFYqA0ZwE902jyWdNhXjMW3gmdy6XXREboy+aLz0EFPk6dJtdPde83fOIupvAaj0=
X-Received: by 2002:a05:6122:513:: with SMTP id x19mr15038756vko.19.1641814900003;
 Mon, 10 Jan 2022 03:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20220110111036.1380288-1-sergio.paracuellos@gmail.com>
 <20220110111036.1380288-4-sergio.paracuellos@gmail.com> <c88e81067826f04e2301b52eddb84ec84bbd1c9d.camel@pengutronix.de>
In-Reply-To: <c88e81067826f04e2301b52eddb84ec84bbd1c9d.camel@pengutronix.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 10 Jan 2022 12:41:28 +0100
Message-ID: <CAMhs-H9q=hP2GMU5QEU5791HfcCchrek6m9L4UdKzMyLg4nZBw@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] clk: ralink: make system controller node a reset provider
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:37 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Mon, 2022-01-10 at 12:10 +0100, Sergio Paracuellos wrote:
> [...]
> > +static int mt7621_rst_xlate(struct reset_controller_dev *rcdev,
> > +                         const struct of_phandle_args *reset_spec)
> > +{
> > +     unsigned long id = reset_spec->args[0];
> > +
> > +     if (id == MT7621_RST_SYS)
>
>         if (id == MT7621_RST_SYS || id >= rcdev->nr_resets)
>
> I forgot to mention that with .of_xlate set, the driver needs to check
> whether id < nr_resets on its own.

Oh, ok. I checked 'drivers/reset/reset-k210.c' as example and there
was only a similar check that I sent. Let me add this also and send
v8.

Best regards,
    Sergio Paracuellos
>
> regards
> Philipp
