Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D675012B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346490AbiDNN5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244763AbiDNN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:28:06 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39B3A5E95;
        Thu, 14 Apr 2022 06:20:52 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id t67so9385826ybi.2;
        Thu, 14 Apr 2022 06:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q/gbAEREb62A8JevuFxQMwwR0Kq1AX0d797Hsd3s/CI=;
        b=h+0BbF6sL4P9IeOcFTP3fUX4pLFM2G+jWWL7otAPjya+NOFgkW/ui40SHY/sZAhHS4
         qmoS/HCiMFZ4xJbootTmWiqv5CVvquVUizsFTmMAXk6R9UMr+wniH/k+IO1f54So0cBk
         hKGJe6FmDckivfj3yze2asz/Dp13VnroJOR7SM/s/a28Ejtw/dK5n6cQLTSmQuBb6F9G
         1jN+nNtyU2+tHCYV8Zyq0uptEJkrXSBpLVvthDv6On6WtT49dlHByS2f/X/sWnODoKrc
         C1QQuvIS2R2U9J4wfIj+juph9RscMlH9ugpiNc70/1F2gfgO8AibxxY9/lZgIHHdnCM8
         LKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q/gbAEREb62A8JevuFxQMwwR0Kq1AX0d797Hsd3s/CI=;
        b=7kRkR3LXLvwsMY4kfT462LGssc46rn3d+KPvRN6HN9CikvnaHk++5o9pmRkkhQX+jt
         d8UFZGTUEmvn1mFsqKrSDEJPBxjc48TMZxOmZloN7JVt02fuBC/JRNpzhRtrj8ujP7NL
         A/41t+y/vAMSioS6rTedU31gJG+QK7Q/EKm64HHThjgV4XcOff5v8ULtRzJsX0wo7VgO
         ENh+iuucop/3zKT8LHZwVW+CpGnLFVvkiBTDwtYjqJwQGBEkp+EGqO81I1Z/DXSiXRB4
         s4fcp4hd5vv2ep6/kr7l9UjUxAJjVGHmVqcr8uRFbCv9FDAAOV7gFhjN0SdwczsFG7vS
         vGDA==
X-Gm-Message-State: AOAM530TMKM0bgjPOolEFPdQyInm/+DxODjpojtnY61etFzqjfo7DNUn
        6XPqY+G4kziEwvyBgEiNOytF8L2/XJDc8nGakP0=
X-Google-Smtp-Source: ABdhPJzA/6wH5wYipanebt4UPB8IhFL/56DXJMDetAOQZrPeoPqghdPu3W8hC1001/DfVHUEum/cKtygewIJYc7kpes=
X-Received: by 2002:a25:cf11:0:b0:641:bfc8:4fc7 with SMTP id
 f17-20020a25cf11000000b00641bfc84fc7mr1733774ybg.366.1649942451985; Thu, 14
 Apr 2022 06:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <9e12d806c5554b4ed18c644f71f6662fcf0d0516.1649813822.git.lhjeff911@gmail.com>
 <Yla01C6MJbaieIwR@sirena.org.uk>
In-Reply-To: <Yla01C6MJbaieIwR@sirena.org.uk>
From:   =?UTF-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>
Date:   Thu, 14 Apr 2022 21:18:34 +0800
Message-ID: <CAGcXWkx6fZZ3kMnGuXtAA+WatJMf1dq_vd6fiFAocH9b03CWcg@mail.gmail.com>
Subject: Re: [PATCH] spi: remove spin_lock_irq in the irq procress
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?5ZGC6Iqz6aiwTHVXZWxscw==?= <wells.lu@sunplus.com>,
        "lh.kuo" <lh.kuo@sunplus.com>, nathan@kernel.org,
        Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mr.Mark :

I will remove the variable "psim->lock" in the next patch

Li-hao Kuo

Mark Brown <broonie@kernel.org> =E6=96=BC 2022=E5=B9=B44=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Apr 13, 2022 at 09:38:00AM +0800, Li-hao Kuo wrote:
> > - remove spin_lock_irq and spin_unlock_irq in the irq funciton
>
> It looks like this is the only use of the lock so the variable can be
> removed as well?
