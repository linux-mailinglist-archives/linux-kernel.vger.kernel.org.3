Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B83520AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 03:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbiEJBzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 21:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiEJBzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 21:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 081A6BB3
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652147470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=teQJ5KLbxBAQsQDucoumVqAHigNqlNVTlH1Kv1gzM2M=;
        b=jOc3cRgwIZa6O0nTVqskbjXV5DT/c8a095FXeKujFaIJG8hLgueuNU7FpnDzHz6QrTo9ZI
        YihBjrPgtYB8BazAK8DAQrQWMj/1o5pwSU1RNUSXl2NQYSXzd46fwpV9oClBRnO6zwd9Rt
        2sXrigPZq1L4kLh126tSKFAikfDi7OI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-qlT099GeOM6Zf9p8NoG80Q-1; Mon, 09 May 2022 21:51:08 -0400
X-MC-Unique: qlT099GeOM6Zf9p8NoG80Q-1
Received: by mail-lf1-f70.google.com with SMTP id k17-20020a195611000000b00473e7438bb8so4711423lfb.17
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 18:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teQJ5KLbxBAQsQDucoumVqAHigNqlNVTlH1Kv1gzM2M=;
        b=a5rylwGqlhhp/MTJ38V2BAGgQuYWHYCkoKXl3sNHyUzqEgPabWtNfSuZa6SsWeH9O2
         6vpCVP/Yc1Okewj55NUcnIZhhDUnvhutuSnk1G2E2qinLzCH/HZ4jImU5ttBv1GAaPAI
         7o8a7bDcetniRdqqjTtulDIMT7cFIcKbjub3EqGfFSA4Uud7oXDQF3Pg3cj33mb2U2Hr
         8r4IbhVsdGEERYzMZ/qn0mcsctKHDeq5QImdzTkD41GxNdPWC7DUSIfrdJ1SZiAUXc7t
         4yKXaW0xny0THHxF5VPJWyLervq0u45f8XCy3kHskg37SdnmzEBGtoG5/V34ppkLEB48
         IGcA==
X-Gm-Message-State: AOAM533azi7CsKV8LRC6/0lWXgdX+dFjsMOcuL20Kmp3wvI1knKWlnpV
        WMmZDOqksQlRD7l255PBtXHII9zpaV3dFOxIcd9HNAsQSHkn984v9DLktRRMiWYm2CbiIAuCIYu
        MwxRosFcJfLpd0CsIlZbAYWVyOjYiYqGPRwTaQXZx
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id h16-20020a19ca50000000b00471f556092bmr14646496lfj.587.1652147467368;
        Mon, 09 May 2022 18:51:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAD9vhgUsXPjEZITjdjVacUMMb+5bP4mBi9Gsh9amo66y0gdv+kqwYajul4yOnm15JVd7SjPCmReZLg0X9J8A=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr14646483lfj.587.1652147467196; Mon, 09
 May 2022 18:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com> <20220507071954.14455-2-jasowang@redhat.com>
 <87bkw64tol.fsf@redhat.com>
In-Reply-To: <87bkw64tol.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 10 May 2022 09:50:56 +0800
Message-ID: <CACGkMEu=oG5KtouSGEBfaa1R0ivDBQRFqew1nttZKYFn9jQAHg@mail.gmail.com>
Subject: Re: [PATCH V4 1/9] virtio: use virtio_device_ready() in virtio_device_restore()
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 11:22 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Sat, May 07 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > From: Stefano Garzarella <sgarzare@redhat.com>
> >
> > It will allow us to do extension on virtio_device_ready() without
> > duplicating code.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
>
> I think you forgot my R-b on this and the following patch...

Sorry, I will add them in the next version (or I will repost if
everyone thinks this version is fine).

Thanks

>

