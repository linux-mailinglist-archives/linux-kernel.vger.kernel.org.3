Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0764BB938
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiBRMdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:33:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiBRMdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:33:45 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51735D661;
        Fri, 18 Feb 2022 04:33:28 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a8so14698761ejc.8;
        Fri, 18 Feb 2022 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEy6Z8EAbV5361p6MIEKJMCYWBt8BwhZlCaFc7v7dJ0=;
        b=EY53GzDstlUrQqfq0IJUTKoSLZ0X+wpYwSkb9TPU6qppBt/xI8FGeb1/vz6zXK1TPB
         ApwUkrKeecJjhDrb2Nxzg41nHOQ/O9CSTad5f7F/LYDJhzMftcjUwXuomYVCfNZ2ug0k
         8pGR3MMjoeaKaTStIsqx+0n9e4VrIa6TMySCcxf4TyVzZacwk5zu6IIw3qxnWpGa1BDB
         3+TSQoXzI564PzdQWakqVYj7sfhAgryG9ucrxtxVWAbE+w/Osmw9BWSw00T4IokfuLH0
         VmrHMVifUVzX1QjalV9+Wp9EwpDfw80da7Ua2/MoDYk8Vi4cS6UbwK2lrEuTgFac6a8z
         PRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEy6Z8EAbV5361p6MIEKJMCYWBt8BwhZlCaFc7v7dJ0=;
        b=Amvum2CUaXNQC1Vd7WmP6Mv5kQIW6T3bWU/Wrt4mmMD8DZtevfesol/2IGe0fTIliI
         KXYaQPvdhjEZJ37s7JM09izGcjB5d+YvdlzEDWsDK/rELl/q6VoaNcj+nOImJhO46X0t
         tQB+c0ntadfQHDyt9DgQpheJpfWP18HDzkfMhGj/XCv7nK+QieZ4ZdAEHJfzYHd8IjtM
         YNVFiYlV/qwFtFUwoLqJLfvdjYIMh33WZ3CKt0a9gZN/U4t0wF8EWeInGg/q+nNUtLCJ
         PtsxpvPINdPU8rSDzZjKKA2FzUBa4Yh9qdjRQBJQCKxP81FhQE+UcOFIuVhfp2XZUuHr
         2FIg==
X-Gm-Message-State: AOAM531ZQAxBG6o6F+FtXN80NN52tAKEaJGyhlgt6mRGtoueKL7Q8baq
        xdRx2no6qnzKeFl9v32lulalAyNuKyEajzhWJBU=
X-Google-Smtp-Source: ABdhPJwyBTLReGA2ZCNBhyVd8TOu9qYH3PS5SDskly/tXAzsEFsykZKrrxaR6WAQDaaxgGKXPzRwd8YsgPY7OPdz97w=
X-Received: by 2002:a17:906:5786:b0:6cf:7206:98d5 with SMTP id
 k6-20020a170906578600b006cf720698d5mr6341552ejq.77.1645187607135; Fri, 18 Feb
 2022 04:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn> <20220217062705.2867149-4-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220217062705.2867149-4-Qing-wu.Li@leica-geosystems.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Feb 2022 13:32:51 +0100
Message-ID: <CAHp75VdTiMSgZKk+LQJQ=DTUD_5Zivj9O4UCQtc34T2OuUFqdA@mail.gmail.com>
Subject: Re: [PATCH V2 3/5] iio: accel: sca3300: modified to support multi chips
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        bsp-development.geo@leica-geosystems.com,
        kernel test robot <lkp@intel.com>
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

On Thu, Feb 17, 2022 at 7:27 AM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> The drive support sca3300 only,there are some other similar chips,
> for instance, SCL3300.
> modified the driver to read the device id,
> add the tables for the corresponding id to support multiple chips.

> Reported-by: kernel test robot <lkp@intel.com>

New features may not be reported. What does the above mean?

-- 
With Best Regards,
Andy Shevchenko
