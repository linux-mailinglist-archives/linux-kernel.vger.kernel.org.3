Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EC4507C89
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358183AbiDSWck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358182AbiDSWch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:32:37 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0232D642A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:29:54 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id h8so33621645ybj.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQv4N2Tnm8oWMiODXD/PDbzuuiQcK7iithu9y/xHS/k=;
        b=l1zRidnLzbrPyaF9/UwdKtwiILAQGOym7YHdcJ/rN4H8CZDpcCJk2QWun/x1T5THjP
         ltDTXd3BBkpKWx7sOTTjKyvUD/KGgiF7FUVg9k/awqYCu0IlR220ZyKULrbl21ueX+VM
         7R2DoJGtAsmbqcfgfXbM7qNRrBykhVLyM2vW84TZRn9d52dRb/HK39SdMIVkIA5UK7qZ
         hxZZc56FcqsAbzu4XqjpwTBX6HyQse+dXRoQyYVIGPYNqY75UqqI/L4z78s4P5Q0c5pS
         Y3hgUZ0vAkErdnyU2ELiJF8cOnjjwLG1eowrVxKrVbYA6cMmhbfy2tZK+lGuZycuGOll
         JpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQv4N2Tnm8oWMiODXD/PDbzuuiQcK7iithu9y/xHS/k=;
        b=y5vtG480FWlc4ntu+aVpDhGZ0bRKvhv0Iq5a5W2fRgn6dOBYyBqiBHqr21h+WeTrIt
         kgk023KEjMjn+DBcIM5tbE3j9i7aoP4KWgAr0pdvf1PucAFX/yQm6fF9oS53UW2JR3jE
         ldV8xGcYsQ96pRVaFCM9snpFRrv0af0AB7/ZsnN4FW2uwMOD73VoL0VJjxkUhrWvePOP
         zctHUFtyW9p0d4lmNkoHDP+P4GS4RVQQD4KWe+flf8h6j0HYIqiF2IgaLRn+grPY/lTE
         eXS8onCxpyXeOxPhzZKUPqU3y/uhFWMQczlODonIHKVBOBLlfcaNSe6WuQe2WkOuNEo5
         o40A==
X-Gm-Message-State: AOAM531pl5ALa3qfsfkDE5X04OeU+Q2mfRh902TQgL/9bnJ/rBtARvyr
        CYDMO8HZk7BAZhjZX5uS3qi6xySEolwVMjQgmrTso7wg5ng=
X-Google-Smtp-Source: ABdhPJxHny+R+bChDEsDA4pj7hKzDQP8GXNpdc4vk6kKi7pUgOgnlGFEJu7EjUSiG2/dMIrsgVV912HOlARa7LlxyiA=
X-Received: by 2002:a25:a12a:0:b0:644:e94e:5844 with SMTP id
 z39-20020a25a12a000000b00644e94e5844mr12625679ybh.492.1650407393156; Tue, 19
 Apr 2022 15:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220326192848.2944519-1-michael@walle.cc> <20220326192848.2944519-2-michael@walle.cc>
In-Reply-To: <20220326192848.2944519-2-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Apr 2022 00:29:42 +0200
Message-ID: <CACRpkda0zA3By+TyQLBDZW6vQUMfwUu1_EvNq8rO_cB30tMcbQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pinctrl: ocelot: add clock monitor option for LAN966x
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 8:29 PM Michael Walle <michael@walle.cc> wrote:

> The SoC supports a debug clock output of its internal clocks. Depending
> on the clk_sel input (GPIO_31) clk_mon (GPIO_30) will output either
> cpu_clk/64 or sys_clk/64. This is very useful for debugging and is
> missing in the pinmux table. Add it.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Patch applied!

Yours,
Linus Walleij
