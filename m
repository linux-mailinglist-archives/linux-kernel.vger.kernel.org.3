Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C2456322D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiGALGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGALGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:06:41 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E1F804A2;
        Fri,  1 Jul 2022 04:06:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p136so3444872ybg.4;
        Fri, 01 Jul 2022 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6ehmD31s5XqazdmAhzHt8WVaW1urTmfq0xOfL+Tyh4=;
        b=KQdvj0sRugDXfuSbe2iY7uuQuBuczxfKfTnHZ3Vpr39um8lUz7CjRQgLjPbf7/a3gO
         Z/BoEa64EXYI1hnY+xmN8LjBUmvAqjW6GDxpXZXFa1DTzXWCQ8n+wgpyRYRNJqfYF7WD
         g/xvR4mtRG5wzLFSu125FoXw9GoVGCCyPE1CNbKJqjeZ7YdVKYwO21i9AT5+DbBZ7PAI
         XICMfJJ4IHISVS12UKHtP9/G6HzcSFdssGWVuPZ6bVB+satzjs5HkC0TifbhzyjUMNkD
         +g83Knjt462Y3amsiKSOmW/HVovVD2jwsstakwDlA1AzviwYuVRZZ1QsUFkIJHH4ltJH
         1PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6ehmD31s5XqazdmAhzHt8WVaW1urTmfq0xOfL+Tyh4=;
        b=o4lsHbH2MO5CYWSeskQ3g2xsnw1VvRpdS0erXzB0hpuMf7duDOXN2dehYuAy+G8CdM
         UEhDL07RIgrpKSUmr+/GWWsJiZ3cxpsUJ8Av433qjYMz14FQb/j4rqocSHk7tptBeAwE
         EV79akSUX8K0fmPMtB30Tfw3cVz/MAFR2fOvjsX/pCHb67VGFifoOhVrOhTkAxcc+9jc
         h0KfpR5P30F43S/qC7fuEDsiB+6ukBVHb5gpo9CBBnjeX3JYz1iCER/GTtTHKYdIBb9B
         f7eZPdE3fLEtMEASrLaThCiHqGKobt49ed6cHqqk0MEG+QTpuBLJDPWA2C07BK+Kmljr
         V59g==
X-Gm-Message-State: AJIora/xu/5mH1F0Vc5RP4MYnxuUPhb909CzQRtSizGCD5ZOLSObW/bU
        GW2rTMMzRL+asDxBI1+nfvKMaA4URFr87QxoHGY=
X-Google-Smtp-Source: AGRyM1vfqcTy1yFpIwhXaPNZKrnxvSlHFrMyVY82IaofOWaVnzlzIWvcLgN+UBnE9Cw+6p7oOQRFpygiQb/f+n4mouM=
X-Received: by 2002:a05:6902:c4:b0:64b:4677:331b with SMTP id
 i4-20020a05690200c400b0064b4677331bmr14561281ybs.93.1656673599985; Fri, 01
 Jul 2022 04:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <12026357.O9o76ZdvQC@kreacher> <2657553.mvXUDI8C0e@kreacher>
 <5606189.DvuYhMxLoT@kreacher> <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
In-Reply-To: <e9666883-3285-36a6-6278-ace219b88f3c@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 Jul 2022 13:06:03 +0200
Message-ID: <CAHp75Ve-Cm43HhqqxxfmKTbC_Gkx=0aAcj0jJmA=-Nr-NT1FqQ@mail.gmail.com>
Subject: Re: [PATCH v3] hisi_lpc: Use acpi_dev_for_each_child()
To:     John Garry <john.garry@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>
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

On Fri, Jul 1, 2022 at 1:04 PM John Garry <john.garry@huawei.com> wrote:
> On 30/06/2022 19:13, Rafael J. Wysocki wrote:

...

> However Yang Yingliang spotted a pre-existing bug in the ACPI probe and
> sent a fix today (coincidence?):
>
> https://lore.kernel.org/lkml/20220701094352.2104998-1-yangyingliang@huawei.com/T/#u
>
> And they conflict. This code has been this way for years, so I just
> suggest Yang Yingliang resends the fix on top off Rafael's change.

Wondering if Yang can actually switch that to use
platform_device_register_full().

-- 
With Best Regards,
Andy Shevchenko
