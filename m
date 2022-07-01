Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFD5562B07
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 07:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiGAFrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 01:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiGAFra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F91968A38
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 22:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656654448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kxaw70hoiHwUI/cqTZ5YO6DN+NgrafhvITSveXQq/1Y=;
        b=WHJujJlrxOI21lr68P/JTyf+ogssbOV66QbiKCGEYajzTLYcOyo//XkLMV/MmQD1APXZ0M
        UViBaYe4Bweq5qZeFqXRsq5ViyhvRvbRcU7/Mflm5Hyu47BN2uqsIFBZVthGcgD0aEYjg4
        kHW6T7qEbU/Hk3uZmNO35xSLOZDxHl4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-p6IuVGnDN2uM5XCAI_Xejg-1; Fri, 01 Jul 2022 01:47:26 -0400
X-MC-Unique: p6IuVGnDN2uM5XCAI_Xejg-1
Received: by mail-lj1-f200.google.com with SMTP id l5-20020a2e8345000000b0025bce6dcde0so148717ljh.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 22:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kxaw70hoiHwUI/cqTZ5YO6DN+NgrafhvITSveXQq/1Y=;
        b=qMtqcM9zeBsT47k+oyQXzV6HkGRSrDPcaiOSaG2xVwhXrvX8u+F+JQVYvVhgKloQaM
         DNkrye22WGoG6VAE2HetEfRqJucs+MejFXLBAPP/aICRhjMJAubL/cE01mo8oG2nYqbV
         uL89UDERzkXmBRriQKhLcc/HXrnozYIylhEI71Qg3Q7ICAQRey/7E5VDOQqLXvOvbogs
         d2W8YExpzvz6FU/SF2pNOsyz/8CAtsUvBjMSf0WpLXRF+2Qjtof8wovAXVdcl0/pgiW3
         wVVBq4/GKoCUWYEsGFwo/NmsLgLU1N4IQv6bSsjZZtr6byk5+gEE4tLIlMf7gFHWur02
         +sIA==
X-Gm-Message-State: AJIora/7WEdwdyxJavVKXDQvO+rTgQTOC0KRF8LyE0bXHwurGBps95aB
        n1ZVF35Xe0y29c2pZQybngLDg7EOArm7Cxw6vXi43c+MuPmDX5/Bfw+T/uOgE+HxPOcRjDzCTSy
        sJJm8plDCAxC1Ah0lIiSFn1HctVgUcEtsDPS7J4KG
X-Received: by 2002:a05:6512:ba1:b0:47f:c0bd:7105 with SMTP id b33-20020a0565120ba100b0047fc0bd7105mr8341300lfv.641.1656654445392;
        Thu, 30 Jun 2022 22:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v0se/FzcmxliJW6fuUGUSnkLWgJBUFrZl0mlLPLSRxp5AulWkBQuSlkKahwAKOQVa7v5Ii718oBi82YszhcQs=
X-Received: by 2002:a05:6512:ba1:b0:47f:c0bd:7105 with SMTP id
 b33-20020a0565120ba100b0047fc0bd7105mr8341293lfv.641.1656654445190; Thu, 30
 Jun 2022 22:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220701020655.86532-1-jasowang@redhat.com> <20220630210344.4ab805fe@kernel.org>
In-Reply-To: <20220630210344.4ab805fe@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 1 Jul 2022 13:47:14 +0800
Message-ID: <CACGkMEvMnxK-VhEQvf6itBiG=ZYuFjPuPCkpJJT=4VqWrDK32w@mail.gmail.com>
Subject: Re: [PATCH net V3] virtio-net: fix the race between refill work and close
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     mst <mst@redhat.com>, davem <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 1, 2022 at 12:03 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri,  1 Jul 2022 10:06:55 +0800 Jason Wang wrote:
> > We try using cancel_delayed_work_sync() to prevent the work from
> > enabling NAPI. This is insufficient since we don't disable the source
> > of the refill work scheduling. This means an NAPI poll callback after
> > cancel_delayed_work_sync() can schedule the refill work then can
> > re-enable the NAPI that leads to use-after-free [1].
> >
> > Since the work can enable NAPI, we can't simply disable NAPI before
> > calling cancel_delayed_work_sync(). So fix this by introducing a
> > dedicated boolean to control whether or not the work could be
> > scheduled from NAPI.
>
> Hm, does not apply cleanly to net or Linus's tree.

May bad, let me post a new version.

Thanks

>

