Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5274AAACB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380779AbiBESKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiBESKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:10:33 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79FEC061348;
        Sat,  5 Feb 2022 10:10:31 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n17so11528873iod.4;
        Sat, 05 Feb 2022 10:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBUOGUtzFJgNcdHixV9vTG4G40xfXefboQtWrkyvtx0=;
        b=KD9cxccgiKp+iFkPrvsUEFuq61jxFcdUmYsdhsuqFeH8OAS4u7rG6F+8xSYm+p/ps6
         SQtc0nVo7qeZUIBo3WPtY2NZuzh4vU2jzj2auAOGW0Er0WhN83kbKnzwi1p93tTv688i
         6dcvHCE5zXvq4nuasJ9A3XGwuyQHC0x0dCAZUmaC9wEBIEAeRstCa21gDlEGq4r/CAom
         nKw9SMX3yzgb6JgQfyZAEXuHqb/hUGatDXdUIJVvERMJRAvaBObIikVhLnlU1gjz7mdC
         stXGzePynI3XNpq+ZSaPTs2+9HZK7H4rf1f5pwxtQ1sdIJbydeN1oud4MgaNdJujhh92
         DklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBUOGUtzFJgNcdHixV9vTG4G40xfXefboQtWrkyvtx0=;
        b=fqmZZzOozexeg6xQf1yBEKBHkyhB4pGGEnhOEQGnupt6HDQquz/oP4QzmKbeOnbUoR
         Yc08o0AcsjHyVzlx7uwGT2AuXpaRLhbQlTqu00bl1hqk64rm4FaC8ITOnjIwC7B7Zyvb
         /js5iMpcd5moWhrkd8ppo94XLI2ubSyAgmJJoEpRzH3oX+AMXUFacL3U8VbXxub9H6mT
         7Xa8dM5t2wdP5CUuUxm70jNht80j9uFHSFSctF1cfZMjYaFiEsXj03WleOZYz8Y24Y8G
         uUNAYjcxEaNFVcodUz4o04wd8jkAJYSHcDQImWa1QP1lVfZoDCeZMTF4UKhYldiyXBLl
         hCLg==
X-Gm-Message-State: AOAM531XqWgwMzIuDUgD8Km2m4rLy3kX243D38DkQ3V60rmi4QSPz28M
        ZhQIXdsTpouquK0d5Ts8tD3D+d926+e8EHT9mSc=
X-Google-Smtp-Source: ABdhPJyr5BNNJzgRb+65S2TLXeweHzTcMpqrZ02axruGmnpWlg1CBUVwDkfDUTF0wZ0gxd64jpcZp0RElfuLpvNAu9s=
X-Received: by 2002:a5e:9916:: with SMTP id t22mr2041800ioj.146.1644084631113;
 Sat, 05 Feb 2022 10:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20220204163045.576903-1-eugene.shalygin@gmail.com> <20220205180120.GA3076528@roeck-us.net>
In-Reply-To: <20220205180120.GA3076528@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Sat, 5 Feb 2022 19:10:20 +0100
Message-ID: <CAB95QARG9ZUNOcE=vcsZ7qV=eRXKxEfh+aqRBbWcWTreN7jDUg@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) read sensors as signed ints
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, I hope we won't get a situation where an unsigned is reported
> and needed, but I guess we can deal with that if/when it happens.

There is still one byte left in the sensor address structure, which I
planned to put data format flags into, and the signees can be one of
those. I know that interpreting the reading for the VRM temperature
misses something, because while the reported value matches the one
reported by the ASUS software when the system thermal state is close
to a thermal equilibrium, right after booting its value (at least with
my board) is lower than the ambient temperature.

Eugene
