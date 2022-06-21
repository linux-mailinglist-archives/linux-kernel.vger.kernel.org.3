Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE126552C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347784AbiFUHzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345973AbiFUHzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:55:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3900E240BD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:55:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s1so17669740wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u1L7nd9RWy6bnH2I84AvftyR0eYfq9iIPGW4WLNh4fc=;
        b=giPyOWITw9taw4PaNQ0JGlbTMOUNhJwyE4M53GOoMqGDpIF+IKrbVQxeckOf1V53Yx
         LdiUXJgflNcwjcuD4jMqXEuc5hlkzV5w/Qkoo25ZOv2tILXOS93Ru4DFGWOx/dkt/PDc
         53fo6hW+pNez7BjrVXBNkqXRnEO2BXrGPypOyhQaUmy/rCACBk5DIj/k3JG80MmFw6IE
         dgXmlEWCFiHkVNiwxRewVvCBuanEzxBInZ8nvPb62dbSIlDgHjbPL3Six75dQsnInvw6
         m9th3TpLto75NFlInQpJa0MsuByDqaDyi28TZ10ClXPa4S0UCzFY3p0bqFOUBT2kGUWa
         J5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u1L7nd9RWy6bnH2I84AvftyR0eYfq9iIPGW4WLNh4fc=;
        b=47vMGOPlYijd1IJPFBOQuNhCxVXRVyO9h5UUCIFysbjA1FdC7HwsgBPLosWvyvNhFF
         1AMgc17kehuOy0Va1sQqnbaUdb6A2acY8cVM/BTkOzfm8SddkH0/BIACiAN9xSapOd9Y
         0tilo+ZDyHuNNEQiKwQJ2YZN9rnHbtFnC7t0yfae5aRDeRft+HPZpQNvrZAUimmgSAG5
         gnfkBgiom5omHbU2uRABzU1Plr+C3zspp8ysvAbTKQ2bVEbdxlG3rtoGQzNsPfUhixgt
         tfYoEmN2dPNkLNghX6i6H/iKnHNquAsXDFxV7VgAUvpoXc8N/NI7HIZe3823XYl8SOUf
         aepQ==
X-Gm-Message-State: AJIora9xZDnBtiB5Edst543SHNaW8BeoSGP6V0Ukos3HAVewtWfInFB1
        sIbnYJIGOYx2SU7bZjmDqYmeb0vHtzbgJtP3AqZ1fp804RA=
X-Google-Smtp-Source: AGRyM1tqRuIcQxhftk2xat7q2KjLeDqf4WLTaKZ42Rx/0qBDAhBIjp4VO/TVO9DuRg2px8UBFx8TKB1DmOWWiqmowuQ=
X-Received: by 2002:a05:6000:2a4:b0:219:2aad:51ce with SMTP id
 l4-20020a05600002a400b002192aad51cemr26241317wry.719.1655798137558; Tue, 21
 Jun 2022 00:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <CALt099+y4-kJ0OqVeKaAjAbs4inOkR-WE0FmyiJRDc1-Ev9UKw@mail.gmail.com>
 <20220603124956.GA18365@lst.de> <CALt099JqRXwsGnq_DmHmnwPyB0K9Y+-BZUG_YoGxOg7G7ZZh9w@mail.gmail.com>
 <20220609042736.GA31823@lst.de> <CALt099+_EoSmigM5LizV8g7KFY=n0dcfPv4Ycw=YrCDvhJELMg@mail.gmail.com>
In-Reply-To: <CALt099+_EoSmigM5LizV8g7KFY=n0dcfPv4Ycw=YrCDvhJELMg@mail.gmail.com>
From:   Michael Schaller <misch@google.com>
Date:   Tue, 21 Jun 2022 09:55:00 +0200
Message-ID: <CALt099L=D58sMB4176nfmFFN5H_Bh7rvB3Qf5mWJ8MwtuSExmw@mail.gmail.com>
Subject: Re: New partition on loop device doesn't appear in /dev anymore with
 kernel 5.17.0 and newer (repro script included)
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Done: https://github.com/osandov/blktests/commit/e067296aa2c5ba89d8140113af=
1e8e50241275b3

On Thu, Jun 9, 2022 at 9:10 AM Michael Schaller <misch@google.com> wrote:
>
> On Thu, Jun 9, 2022 at 6:27 AM Christoph Hellwig <hch@lst.de> wrote:
> > Any chance I could trick you into submitting your reproducer to blktest=
s:
> >
> >    https://github.com/osandov/blktests
> >
> > ?
>
> No need to trick me. ;-)
> https://github.com/osandov/blktests/pull/93
>
>
> Michael Schaller
> Site Reliability Engineer - Software Engineer
> misch@google.com
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg
