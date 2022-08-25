Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554545A0B7E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiHYIao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbiHYIae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:30:34 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB735D0D4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:30:34 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c20so14637928qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Pq928BHaI2Lv558Sf2rhLdejDvBSnbTYII4M2EKLKo0=;
        b=XeJAl7NFFtfm4MqSPj2sYa3Yw9LykJpck1nsRnO5rPBX1mXRaJ4ocjvi97ps1b666o
         S2YIg/XmigOeCA/5PuzldSnvUvg82BMkQ9+8LvQwPo2/qcipQs69xWSZW4o7fbiUlJVy
         /ja3+Go2NgoNMZ6xeVvcqLHiBM03LTbFnjUOBQ8Ql4MOjN4weMAbw5lEdXzpCdpDE/r6
         W5CgFgyaFKMoiOLJm4g6DDVw4WdhwzyEZzqfqwW5coo5eRQPOZ3h2ymxYCL9KOj1nmX6
         W7FCN/3Su8q4tOUPrBbMYmG9jeGX4qGfC8l6R5cIfvDRhAfKuPtEw1pcmqVR7WlDn7/o
         F4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Pq928BHaI2Lv558Sf2rhLdejDvBSnbTYII4M2EKLKo0=;
        b=keV6630qWT1UaJf9G55Iv/Lg707SE07Ad0nAzuVR5GSbLubsyE0+2in40CS1SzdVGY
         T2QIrRTGhRc6pjy44KW75Cte8/Xse9cJis0LYBkvKJ0GmMggKztzPaE81bYBzo7sUbew
         s1d79KD35bo8coch4CY677tJmnNQg+VW8OOZhLjeI7QSQ55OK8t3N9xsn0vv97iztEkX
         79X8iSEtLfsWCfi5RCBtwLjUcnBynJ30MMyVEKeHoJjWrdUWTXgp4gE8itcyN8at15Cd
         SHu+ubBvWmeosKdQUKweqImdtUQctpUa5di3eB8EP6ztCTTsiVYjivJ3LreYbmm1cIyv
         ZyGA==
X-Gm-Message-State: ACgBeo1dkiDlRvwtB+Zpd+26jEk6BGa4vP5sEvGxRVxXtjbuTJkW/bLq
        8hmCUDqb5Cu76CNc/D7fg8vTFvzavgXbo06UX4c=
X-Google-Smtp-Source: AA6agR7x+6IYP7LemVUdEvBK5q16ye49+klU/uo6Xb81QcQRwGf6RqqPG+sT8nMRyT7WJjn4HZLFvUfaOZoeUks/4uc=
X-Received: by 2002:ac8:7f92:0:b0:344:8cd8:59a1 with SMTP id
 z18-20020ac87f92000000b003448cd859a1mr2720141qtj.384.1661416233078; Thu, 25
 Aug 2022 01:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220825060819.74303-1-liaochang1@huawei.com> <20220825060819.74303-2-liaochang1@huawei.com>
In-Reply-To: <20220825060819.74303-2-liaochang1@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 11:29:57 +0300
Message-ID: <CAHp75VdZrcouWXor1DjdzzWEsUC87+CkD4ZqMd165H-QXMgvRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] irqchip/gic-v3-its: Release the allocated but
 unmapped bits in LPI maps
To:     Liao Chang <liaochang1@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michael Kelley <mikelley@microsoft.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Thu, Aug 25, 2022 at 9:11 AM Liao Chang <liaochang1@huawei.com> wrote:
>
> If one hwirq allocated in ITS domain followed by some unmapped bits, the
> number of unmapped bits will be recorded, so that this hwirq and
> following unmapped bits could be released both.

...

> +       /*
> +        * In order to free dangling hwirq bits, kernel uses the irq_data

the kernel

> +        * of hwirq which is followed by dangling bits to record dangling
> +        * number.
> +        */


-- 
With Best Regards,
Andy Shevchenko
