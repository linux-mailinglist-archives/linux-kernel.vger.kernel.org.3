Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D2F51FBAC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiEILvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiEILvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:51:21 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268D9187D9D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:47:28 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so24500416ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LnDm42XAjcK8nDEN/NXuMD8bqA9EbCRNmEicH0GdWc=;
        b=VAdstAUP43Up/jD0RDAMS3ideC1ln27PV/yin1CnKnJoQdjgUr5RBybEz5k1zYCrUf
         /XX1+kyc0WX7faMi7gMg2cb1evuHgfGQYTv2bWiw/ZoL20k5M0vuTG8aK/uSpBQlISkI
         DPcv4ONb5N2/fr0trNGML6sGmBOekVdXj+ps7wRYdBn/2Vnh+Zuy1HY+ZWRpko97oO2b
         AT/c11G0T1nuPirq97brndpEGIq4hGvmA5kEIfhY3f1cnQTygx2lRzbQ7EjVJeEe7ClY
         JJOB+pU1lG7rZFXweRsWTlJamrCFfichkyxt2vYy3lyrvCTs+vSaWsq+1sICmQeDMiiQ
         B1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LnDm42XAjcK8nDEN/NXuMD8bqA9EbCRNmEicH0GdWc=;
        b=R9xUYgZbt8vc1O30susg4ZiCUf0t7is0tgcfPCql/79lTxSCRN3laNfsbj1zhUm26y
         SG6oSlnjdPvfaJtuj7ZBbA7UOhWIk52ju85YJu/Y5XSW4tGTH7byMikICy0879gByQ+L
         vtABKUt8iEJbEAG0S/N6R0lZ113DJj1KOb2hMM/+py4oecoOSstsRrejbvLPBXIcY0r8
         UJVGnAGm/iqX0E0dPFl6WZrnfz+LyrCO8PWEeCd1EtY0P/733PIDsopz8GAq3LTb9Q6t
         64DOotmx3+TkE61wOsRb+G5PbAc5a9f5w7i1hKbkbRq9JjQ5nj1lVepnwwiahCY3UM4H
         HOig==
X-Gm-Message-State: AOAM5324aHiLov7tK9ZGX2hhY9l1hVKRs9QiM0i0pyrs4NKedn0Yln1p
        ZI0JffCIGYxjCjy4NnivdiTZMIs1f48tGgRXYoB0wA71XLg=
X-Google-Smtp-Source: ABdhPJwTJGQrHFFNChN09m0mf2VXZ34V205CWTzTBrXCLu804Op96doJDQ6HuN1C76VSotbuh6qiSkhoMMXJtlfMRCc=
X-Received: by 2002:a25:aa94:0:b0:648:62f2:ef4e with SMTP id
 t20-20020a25aa94000000b0064862f2ef4emr12359018ybi.626.1652096847403; Mon, 09
 May 2022 04:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220503151321.58800-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220503151321.58800-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 May 2022 13:47:16 +0200
Message-ID: <CACRpkda7WoFKxV1p6vmcg9GmDuRPsednoZV5_hMov=OJ3EE2Vg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: equilibrium: Switch to use fwnode instead
 of of_node
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, May 3, 2022 at 5:13 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied.

Yours,
Linus Walleij
