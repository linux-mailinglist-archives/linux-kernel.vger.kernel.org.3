Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41872599543
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbiHSGPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346625AbiHSGPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:15:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED3165242
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:15:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a7so7044972ejp.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=L+LdEo6DxniZvENxD3pg9Te7LR/ECsAOhxUIBcJUFf0=;
        b=fIXqL1CT8+GNgis/iuUHw8pOJas5JWWmrITfmGVNUqzgt3TCUblUzp794B7e3HDXB5
         RRh2L64t9vvMypH/wXPsiI5VIo+J8ESjnGpdCwtVlgvXS/AcSoYEHmahvPgOFmwcAv3P
         +vGHOxFH1is6RaTHBe5DYXvc8Ao3mHWr602Xewnj/9kaX4v1cuv/PUgXWLcLNp5ehf0h
         3qf/YrASHd5REBSiRE+zZjKxVegRQivAzPmJzQtpkn95SG+0eQE6p1cQrfTspIbXX499
         ZRYP1Bvnr5DYrCwMtWF1mB4qPKqFG6JyUOYihWbjyIszysLHJ3TK+a5jR8EedGJ0MfYS
         eDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=L+LdEo6DxniZvENxD3pg9Te7LR/ECsAOhxUIBcJUFf0=;
        b=J+qN6mmkFU0eH6ma8lq0dXcj6idP6xbrEDciKdPV0KqMpV8G9Ulz95EJNvWieLU5gl
         ituTvtZaesR9z7/PG/7Ok0TGgN+iPUd0/nJWdJI6n/I23x1iJHFcLt4U5fFN11x62BhS
         dkq7HhBfPP2HOf5z9G+Bw6FVSdyqfh/QPoAUcvbxOfruWnRQzqnyHYAAxx85NpYk4uop
         sTsCN7ZrifRQ08Ujt6I/N1csxxLMDa87e8w10OdIjNAdI1zYmiIKJpcIuW0YMAB/MXD+
         Ezqcltt6k1qB7LevENjNsDJzaE5cemZPrTdQ6JT52/XMZ1ouFJEFnrC4xyGkVv82ugP4
         CLvw==
X-Gm-Message-State: ACgBeo2m51ieuDV7UK1EGuUSAAf+IhPktwOayGfKQ2joQhNMtuDn6jT1
        fx0z0N3mGbixqk9cnLOZ7apPGMyGmuDrVUH5PLU5
X-Google-Smtp-Source: AA6agR5YHPiuhM1jujmBCfCIOFcrMvUvyAuoi4NBksjUYojlv2zVrvMenYaPp2XoGb/+XLTZUw5taQ2rEshFR7n3Osc=
X-Received: by 2002:a17:906:8463:b0:73d:53e4:1aa3 with SMTP id
 hx3-20020a170906846300b0073d53e41aa3mr211131ejc.646.1660889705372; Thu, 18
 Aug 2022 23:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220803045523.23851-1-xieyongji@bytedance.com>
 <20220803045523.23851-4-xieyongji@bytedance.com> <f75cb32b7c262fe852c53544034f5b6047d29b65.camel@gmx.de>
In-Reply-To: <f75cb32b7c262fe852c53544034f5b6047d29b65.camel@gmx.de>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 19 Aug 2022 14:14:54 +0800
Message-ID: <CACycT3tXWYwE4x-_N-pezV5SVXcZeT0OPsbDkyyreK_ayOYzXw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] vduse: Support using userspace pages as bounce buffer
To:     Mike Galbraith <efault@gmx.de>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Fri, Aug 19, 2022 at 2:01 PM Mike Galbraith <efault@gmx.de> wrote:
>
> Greetings,
>
> On Wed, 2022-08-03 at 12:55 +0800, Xie Yongji wrote:
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
> > index 2722d9b8e21a..4e0e50e7ac15 100644
> > --- a/drivers/vdpa/vdpa_user/iova_domain.h
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/iova.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/vhost_iotlb.h>
> > +#include <linux/rwlock.h>
>                    ^^^^^^^^
>
> Erm, that should be spinlock.h.
>
> #ifndef __LINUX_RWLOCK_H
> #define __LINUX_RWLOCK_H
>
> #ifndef __LINUX_SPINLOCK_H
> # error "please don't include this file directly"
> #endif
>
> This belated comment inspired by PREEMPT_RT build meeting the above :)
>

Thank you for pointing it out! I think Sebastian had sent a patch [1] to fix it.

[1] https://www.spinics.net/lists/linux-virtualization/msg58136.html

Thanks,
Yongji
