Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B34AB0FC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 18:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344545AbiBFRiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 12:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbiBFRh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:37:58 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F020C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 09:37:56 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id x193so14841378oix.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 09:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vVKrnJDOHGbjSSHfQuuoJvy2XKJCbAbDk+4hsVzeVT4=;
        b=Ln+BqGQJLxlgnNo5qJrWQ484qT5n+OrgHozO1ECWRT6VesEsOCQGUxAqUAuXqRl9+f
         62peCmdXsolXfdoG3ahcsdefJHJr0E30TJhOT4ppj0ikpsPx4hg2w439xU/jHm5DyODY
         MeYiWTDPqniBoPPIc/45nQQezO+EgSKTsK2vtCABjmgdupcdAx7JI9g2Pzgp4O3MTCxw
         SQpz4imBoWlUZZXJ6u3Ckt5gBgRgZf7ESvDsdt8m72ApII2XsYqZs5Dm/TSM/AaNuQuR
         Toq2y54FPNW/Fe06+o+P4TvDlh8i8xhTNmSrMmnFsxDMx1ypzby7swYQaLLqilpO3K7q
         Xrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vVKrnJDOHGbjSSHfQuuoJvy2XKJCbAbDk+4hsVzeVT4=;
        b=5/3X2tWzeLrgTrrf89Xzv0nybsXyXtmNV5m1UFklMryBF5HzgDPzld9OB7QNj2MW4+
         jcpah1hFelQBw3loS1wIwQV6sF3ituh8viuYUu8EKkuUz+yBpdPC0WrlBAa5Pi/oUAMh
         0R6it1L/lfvAcNDXsmApyvL3I8FauaMwrzEkGtYr7eKOhEC+7Ku7IjFqRRxg+jBS/zSi
         7bIvKLbrGLzQoduvCeKY1mde6Zda4gdah5/H40vkpo2q+N5OrP1S9RACUdHWmUg95fxm
         GhT35JIO4zfkAyeFb1z/W0PMm8wYSXCqkfGxbCUzfKq3YH8AhsiioYW4uuYl4BsS06Ns
         +hZg==
X-Gm-Message-State: AOAM532vhuk/TKBS6xOb+L8Y6gUceGU8yUPtdUzvqvtDdkRRPdEuxQgY
        y864YOAVkzFJ4gIcHwBc23A=
X-Google-Smtp-Source: ABdhPJyyFr6qcAXR6PgZJnvpWbJqzU/tbg3jVON7HGuwyjCsJAF4UUEw/HHlVPaiIG5yBA6d+MPidw==
X-Received: by 2002:a05:6808:14c1:: with SMTP id f1mr3636989oiw.12.1644169075892;
        Sun, 06 Feb 2022 09:37:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o19sm3148725oae.36.2022.02.06.09.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 09:37:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 6 Feb 2022 09:37:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: [PATCH v2] isoc: mediatek: Check for error clk pointer
Message-ID: <20220206173754.GA2014863@roeck-us.net>
References: <20211222015157.1025853-1-jiasheng@iscas.ac.cn>
 <trinity-2a727d96-0335-4d03-8f30-e22a0e10112d-1643363480085@3c-app-gmx-bap33>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-2a727d96-0335-4d03-8f30-e22a0e10112d-1643363480085@3c-app-gmx-bap33>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 10:51:20AM +0100, Frank Wunderlich wrote:
> Hi,
> 
> this commit is merged in 5.17-rc1 and breaks scpsys on mt7622/bananapi R64
> 
> mtk-scpsys: probe of 10006000.power-controller failed with error -2
> 
> at least ethernet is affected (i guess usb,sata,btif,... too, but not checked), as gmacs do not get probed as depency of it
> 
> after reverting this commit it is working again.
> 
> have not yet digged deeper into it why it is failing, but maybe author has an idea
> 

I created a revert of the problematic patch with some explanation.

https://lore.kernel.org/lkml/20220205014755.699603-1-linux@roeck-us.net/

Sorry that I didn't reference this discussion; I only noticed it after
I wrote the revert. The revert and my analysis is based on the impact
of this patch on affected Chromebooks.

The revert is queued for v4.19.y and later stable releases because
the patch discussed here made it into all those releases and breaks
pretty much all Mediatek based systems using the affected driver.

Guenter
