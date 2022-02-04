Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98294AA0E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbiBDUHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbiBDUGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:06:31 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9C8C061778
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:05:21 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so5880984oot.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 12:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RksNAMhH5Jdhvi6mfS4+KhrwPyqm2XJrsjLWqJJDp+8=;
        b=P64uR2ltLhXlRC+DXILM0XeyWEQeWtVSx1Xg9l59OShSIYknxCX/QTaxdi3pLbvykJ
         4oBNmHZtjy/nzGas90yNMeal2Lg5X+BpJnCILWLeM249X4fkioyYLnuqA1IgcMS++IdY
         Uu2S8sgKYMs1Y6vztwK/WsiRPp53FfaObPkEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RksNAMhH5Jdhvi6mfS4+KhrwPyqm2XJrsjLWqJJDp+8=;
        b=lVCDItfXysoMT2Z8vaamfzhAzckMw1GaSQFAp6uf3XA6oZ81NwKkjVBuNl30py+F7m
         zlyb7K1XRUafHeMtgMQLB+uyr0GZUlb0JJDUM2jOOchLQUot6ItuYL9YXElFPKzuyFQe
         /4+4pSeNZakbE8UaeUzvBYjxiA8US0P0mE9bC5e48u5QKRVnsGI8uHJ4QY8KqEbloAdW
         AjFjQOzigW9H+oacc0lmaJeVv9AKyvMhO5Ll1v0UqZYaic7hCH+lAoyBfBgsPQPZgIbE
         LBYsMIllJPIWX0kzwAnj0uFjVf9QcGIj42cVTAf3tGyHC2jUYlBiQ0gPvaYJtIZcsnas
         grDw==
X-Gm-Message-State: AOAM530c5cBwkEsj9FkJBLEXtwlReHnDYz4lveebLlrooSDA61lylNtF
        jYE4y8jRC5YX/aS37JAvk1e61HpabovMKg==
X-Google-Smtp-Source: ABdhPJyT2obvrgkqY5hRQjzDQ6lghptRPBt+Y/qJ3R/QFWRe7Lkei9QOglkSiq+6OYNtMBpY2M0VdQ==
X-Received: by 2002:a05:6870:b283:: with SMTP id c3mr1089453oao.196.1644005120700;
        Fri, 04 Feb 2022 12:05:20 -0800 (PST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id h203sm1224304oif.27.2022.02.04.12.05.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 12:05:20 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id t199so9729269oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 12:05:19 -0800 (PST)
X-Received: by 2002:a05:6808:2026:: with SMTP id q38mr2128798oiw.243.1644005119281;
 Fri, 04 Feb 2022 12:05:19 -0800 (PST)
MIME-Version: 1.0
References: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
 <20200423104000.GD4808@sirena.org.uk> <DB6PR0402MB27600084E4A040609EF620A088D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200423112244.GH4808@sirena.org.uk> <DB6PR0402MB2760FBCA05C1BADB27F0356488D00@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200424103004.GB5850@sirena.org.uk> <Ye87P19+JOjPEGTY@google.com>
 <Yf14RJbM10O3RdA+@sirena.org.uk> <CA+ASDXP+KeiRKASFakDjJ=cZPD_rGmV4=JgRH26zQi-uZDdiAQ@mail.gmail.com>
In-Reply-To: <CA+ASDXP+KeiRKASFakDjJ=cZPD_rGmV4=JgRH26zQi-uZDdiAQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 4 Feb 2022 12:05:07 -0800
X-Gmail-Original-Message-ID: <CA+ASDXO-61=D0DM+d4dNCbEYV3omroFbbFao3YrUPOYy+7AJUg@mail.gmail.com>
Message-ID: <CA+ASDXO-61=D0DM+d4dNCbEYV3omroFbbFao3YrUPOYy+7AJUg@mail.gmail.com>
Subject: Re: regmap: mmio: lack of runtime_pm support for debugfs
To:     Mark Brown <broonie@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a bit more thinking:

On Fri, Feb 4, 2022 at 11:21 AM Brian Norris <briannorris@chromium.org> wrote:
> Anyway, I'll probably just go with precious_reg() as suggested above.

Unfortunately, precious_reg() wouldn't be quite safe either -- we
could do a single check for pm_runtime_active(), but we have no way of
knowing (guaranteeing) that it will remain active throughout the
remainder of the debugfs operation. For all we know, some other actor
could be *just* finishing with (and PM-suspending) our domain
immediately after the check. And we can't grab a reference, because we
don't have a callback for balancing that back out.

If I really want to solve this, I might have to go with adding a
debugfs-specific runtime_pm flag, and (to avoid too many side effects)
use that with pm_runtime_get_if_active() in regmap-debugfs.c.

Brian
