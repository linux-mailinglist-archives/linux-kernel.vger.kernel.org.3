Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76B8547253
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 08:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiFKGRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 02:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiFKGRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 02:17:43 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0859234
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 23:17:42 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-fb6b4da1dfso1872018fac.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 23:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=za02L3YGkMaQDDqUxwbazqy5dmLqsmTNruFmOVnXHLs=;
        b=ZhUYo+ec7/hRaGq7h5hPPUEOc8eNxo/1WQo+0mOKo2xGedoXSmfYbZXJUkz/QAf2y0
         SOKzhXharIFEs6ZHKTsX8zADjjUXfSGIWOBLzcpDzmFYryj0jOnQvGMnTMIg7YkWDH99
         gvu6xhUppNiQ9j1FX8G+hmOtzD/DekoTETyTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=za02L3YGkMaQDDqUxwbazqy5dmLqsmTNruFmOVnXHLs=;
        b=fWld/sZAvG6k0LdByXETtLbtkeuss8Kh1hO0OPntnAua8Jb+Tm5Ue3wv5jzBwIjhF0
         knGoY8UdLucvLk82e8FywSClRTtGapy17AX5LxpxoCBEzZtXoCtLUHwMCCHTIcgPanSJ
         +CG/Y1x28j1daNlXTWpHIpZ/q0NxAYH3xFU6DobpeobEOJsUDAf9f3NxX3tkWRSMJkYG
         0pYZWmHzMCm4L0XWVjPlBX3GEud0cNS/s7GgNteCmnk4MKdcgrDkxnlCCb84gytPAN0A
         yWZ0ZCSKo8RsTjPjIZdk35G2oZJWsteqoLId3t0nMc+Kegy+OdWJhAXZ+aTCf52pDyz6
         r7Ng==
X-Gm-Message-State: AOAM533OJS+eHu07HnhPWCzUWS/PNguUOOW4NAeMIWDwV4TMq97sL3iQ
        RexRJcShZe/0OPP/epzQrUzUdaoBtXziuCzBS+z+Qg==
X-Google-Smtp-Source: ABdhPJwP+GegoajQ2DsSTYfMWKmwk/n7FeyvsXDY8wjEV6aAE58scWTyKz/7+YfwZzIqWA8nVvUVOaFqHBibIaaaBHA=
X-Received: by 2002:a05:6870:b381:b0:fe:2004:b3b5 with SMTP id
 w1-20020a056870b38100b000fe2004b3b5mr1885317oap.63.1654928262086; Fri, 10 Jun
 2022 23:17:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Jun 2022 23:17:41 -0700
MIME-Version: 1.0
In-Reply-To: <CABXOdTfvuHLf=ahN4+iOewyLCNnOZMXS-S+4a_RUtLCC=9t_HA@mail.gmail.com>
References: <20220610223703.3387691-1-swboyd@chromium.org> <CABXOdTfvuHLf=ahN4+iOewyLCNnOZMXS-S+4a_RUtLCC=9t_HA@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 10 Jun 2022 23:17:41 -0700
Message-ID: <CAE-0n53HdS+tQJXQ303kofKBeCbj1K8hf9RTSnguLJbPY7FtxA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: Always expose last resume result
To:     Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, Evan Green <evgreen@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guenter Roeck (2022-06-10 18:40:33)
> On Fri, Jun 10, 2022 at 3:37 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> > index b3e94cdf7d1a..881d3ad09be0 100644
> > --- a/drivers/platform/chrome/cros_ec.c
> > +++ b/drivers/platform/chrome/cros_ec.c
> > @@ -135,10 +135,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
> >         buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
> >
> >         ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> > -
> > -       /* For now, report failure to transition to S0ix with a warning. */
> > +       /* Report failure to transition to system wide suspend with a warning. */
> >         if (ret >= 0 && ec_dev->host_sleep_v1 &&
> > -           (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
> > +           (sleep_event == HOST_SLEEP_EVENT_S0IX_SUSPEND ||
> > +            sleep_event == HOST_SLEEP_EVENT_S3_RESUME)) {
>
> I am sure I am missing something, but the description doesn't explain
> (to me) the switch from HOST_SLEEP_EVENT_S0IX_RESUME to
> HOST_SLEEP_EVENT_S0IX_SUSPEND.

You didn't miss anything.
