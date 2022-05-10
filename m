Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3C9521504
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbiEJMSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241612AbiEJMSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:18:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E655B2498BF;
        Tue, 10 May 2022 05:14:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g20so19749561edw.6;
        Tue, 10 May 2022 05:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/br5lVoJr5JONPYw1u2TkkXlTjPZRXlvdDqOy09iwI=;
        b=FjagvNXwCbQMkr00LSuq5wEwkPbbZaJXOlTX3CESKiHhORbnsjJpqJdCQKfImkBgoW
         THSuME8zouCe9kcMvi/fOKDuhiBzdtoIrfvQ9HdUo+iAXIc9J8Zbsqme+oqWRx/vxMom
         aPp7kYBEkZ4kd6rVxaQ/xY+puVba/kL3CRalqh0YJ3xqS2PXw2Lxl38cdwMHwPREkAOf
         BSYOYzS7BM+5YVgMxAysX479oT0kdnV+s34Tcsnsr2/O7m+PUH3ilTwd4nxP+Djl49HW
         feTXM8W/yStz0TnUIZuzZJ5X0V/hK4FBTr2AFudpHSLmeoP3hD836jGPi9Uk/RE8Ywuj
         oiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/br5lVoJr5JONPYw1u2TkkXlTjPZRXlvdDqOy09iwI=;
        b=BR3PU5pJFlTwd9Wfj+BSaVC+hno1t6fS1h4NVU6hscM/QfHNPI1zm6FUcdkGFEfxNn
         qEWkKu+r0lyCTGZowBXLwBO/ZN4P7cVSadlBVdkIuRBFmNvnVZ2sC4dCw069x4ixhoJB
         uo/nJs+vYU5ovIH7Wrr6P5XlRlxMIh34Ox4gTrkXwYKySQ6oCbMzgd2nA4Qk3p99aJz0
         2veoeZ/hYF1I1m9dto0oyeSoqWFm5Nj4PF/tmVGxfVREsyZJ2JSdtWfHHYr++apCfbuH
         KHS1vIxW1g55Y+ARQnDSJ7GIijA2LKokEG7nuMAg/LgmjmtSphP7t4utHDn0Rz7PUwIb
         gb3g==
X-Gm-Message-State: AOAM533zt0ByogtdLFvYVG3F6qcKVWsObGKaOxttlA8A3uu4KYR4XMQ0
        VKQjRqHz48Op84Yml7yJH+CuMZcvzC0nvcDfAD+A6izU82f71A==
X-Google-Smtp-Source: ABdhPJzmmtgyTQaBfS7rRY2Ew1pDYRTrRHGjAEEWeZnbUpnkC4lag67F/yWbMmdN7dUiDkJ7FiLSj5qxLld/7cITLos=
X-Received: by 2002:a05:6402:2999:b0:428:bb4d:6cea with SMTP id
 eq25-20020a056402299900b00428bb4d6ceamr958123edb.29.1652184885345; Tue, 10
 May 2022 05:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220510105222.1352180-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220510105222.1352180-1-chi.minghao@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 May 2022 14:14:08 +0200
Message-ID: <CAHp75VfzbWAS6phV3eB7ehe50NrXitkuS54sYjdVK-OqqYVieA@mail.gmail.com>
Subject: Re: [PATCH] toshiba_acpi: use kobj_to_dev()
To:     cgel.zte@gmail.com
Cc:     Azael Avalos <coproscefalo@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
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

On Tue, May 10, 2022 at 1:58 PM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Use kobj_to_dev() instead of open-coding it.

> Reported-by: Zeal Robot <zealci@zte.com.cn>

Same comment as per your other patch.

-- 
With Best Regards,
Andy Shevchenko
