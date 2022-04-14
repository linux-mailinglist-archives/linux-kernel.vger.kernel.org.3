Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FBA501752
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347583AbiDNP2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346624AbiDNN5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:57:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6402657F;
        Thu, 14 Apr 2022 06:47:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lc2so10108650ejb.12;
        Thu, 14 Apr 2022 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9hYB17biMvNqrX89B5MdlYJL0E69SsfsfXeh7dFOiA=;
        b=FYXH//pkag+vPVt/fhiJZaiDlY3kGR88wCFPSmrTgqb5ZNtAdDLHDD3Y/gF5WauOYG
         KEzUHL7hY9V5KaWZOwCXfsKpjazg1rcwbrWb4fTLz+L72C8iMnQXb+mclvHFbknOOLoN
         /oCAOJD8U0YQ4ecNyBm/Dx6KGBcDF12GK8UgGTaPnRGBrXc4oGI4Orfn7mosBnj/ApJO
         UGlDI98IJzCBFma+xiBUwav3kKgDlTNc+U4ZCF1dIPr/p3A1bj4YOw8zVvyBW8p8UAc+
         bFFQDTgQfQ1kWC+i2LDoBBEfIiv8k+XCpH7qbnBmWGt5a/40cb63hX9PZDdoRkk46hKv
         Vj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9hYB17biMvNqrX89B5MdlYJL0E69SsfsfXeh7dFOiA=;
        b=QXRwWF1ZXSlw9bVE7GS2EVNiO+MrCydzVSRUZgic4eFZwJ8NdFEflaYjbfCQTIAnjp
         hcYr9MFwYXmVK2qor+DMnVnyUkmLOVmJdlhYPvWuwRZNHDlXBHCt4gZhdJmRfdBx9enJ
         d+aCORxe/Vc1JG6cnxEQWYCrqD3zZiUo6e3NBquoi2cy3Fiq3uWErto0dqrsC+GlZwnp
         z8ixk1Zj3Q/donkSgCCLf+jVLWJCLAv7wpQeaeK4JkK0H9RFSqSueFVsyPT8vES7A8qD
         zLP6UFYfBsa/hnyLY0w3PhaIfIb/ufRUUaCBUtY9sSMTmGheA2LXwYuwE9vIHMFBMX/q
         23CQ==
X-Gm-Message-State: AOAM531xdpvl7HZJ+ZJzorgRh/UxYqFtB+ebsoBqkimlMt9iSgaoMCFt
        V0XmH/IzOuyz/BdsOPdxR1jvankqnItUviZFuQogDvbHfRCbvg==
X-Google-Smtp-Source: ABdhPJzH4bczk+yp+HYwqIc2+zd8sOLX6Q+Bgy0HhVY4Jv5RyQnR9MAwOtrB48Qb7K5VsnR4UsRCEOw6UtYXI6oiJ6I=
X-Received: by 2002:a17:906:3799:b0:6ec:d25:3afe with SMTP id
 n25-20020a170906379900b006ec0d253afemr1060600ejc.44.1649944068719; Thu, 14
 Apr 2022 06:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <1649933135-14236-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1649933135-14236-1-git-send-email-baihaowen@meizu.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Apr 2022 16:47:12 +0300
Message-ID: <CAHp75VfbZhMvs7dHwadvNs6maPsBVOY3Mk5wkKSwZ1RANQQHDA@mail.gmail.com>
Subject: Re: [PATCH] iio: gp2ap020a00f: Fix signedness bug
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Thu, Apr 14, 2022 at 2:19 PM Haowen Bai <baihaowen@meizu.com> wrote:
>
> function gp2ap020a00f_get_thresh_reg() is unsigned but returning -EINVAL
> errcode, and thresh_reg_l is unsigned but receiving -EINVAL errcode. so
> we have to change u8 -> s8.

s8 is not enough to hold an (arbitrary) error code. To be on the safe
side you need to use int.

-- 
With Best Regards,
Andy Shevchenko
