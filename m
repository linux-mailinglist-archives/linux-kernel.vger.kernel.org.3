Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B2453355D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 04:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbiEYCd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 22:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiEYCd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:33:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D65454F9F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653446005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TUzlT5FItCjrnkA2ba6GnsAuieiG0tvhuEs/Sgn4WbA=;
        b=hrw14nzUdIs6S+bNFTz7IB4+0LfnpfvHYiJYz5p2tyAPyrFJlz0XpDaKd0XIqT3hP1Itcs
        YU0igMqa+xvYSQL86ixDnhjC2QwsV0T8c5IUTz9KW6SKwXy8M7/DlYQ+pWxR/3J8z1Jw9M
        D3pod14OKPmgmgRriYuKOnsPgFB38vY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-JSPfP9jUNveLpYtSjLd3Lw-1; Tue, 24 May 2022 22:33:24 -0400
X-MC-Unique: JSPfP9jUNveLpYtSjLd3Lw-1
Received: by mail-lf1-f72.google.com with SMTP id y12-20020a0565123f0c00b00477bab7c83aso9781261lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUzlT5FItCjrnkA2ba6GnsAuieiG0tvhuEs/Sgn4WbA=;
        b=bJEYCMKKZuC5NkuYMJV93AaLA4brOHg3yhXhmcPLMj9zSFs4UrnmWAzsacHlBgXmDP
         73EdBSSYijP3fwTqeCoxUz/fEFYM3PcospmVd5npnyDxKlm9xhfCw9FNgqgbWrtULp9j
         SVVCPl1DOsbF/gzLKGVqoAdsmvMybnV6jrWAsqDShfo4bxydal60iG5WFBP+pV2+Mt7L
         AqasE7VHzm/U6q0zNNmjtIxYSmtpj6kjbqiGBm/qkwbe8vsUX8ADzBZx79kMCG0lsY/6
         SGJioOq3A+mOQYzR+0nKQ+7+RgkVFKyrmb8F3G5w7K1YOLlZfvEuLMm1dpIYFgD5XjWm
         +65Q==
X-Gm-Message-State: AOAM53056agv9EAWGjn/R1zm1QvJnKJ9+O5RmAMUo+RInoBSbc+ATY+4
        Bbl7Tk6MG4yzLNpMQcRF6V8aUTEA5shxUQtMD3DFPz29tApzw8zHJuhFmmJwbBdKXfnVs2MG5hW
        EICJ+/DoKMKjwTN2AwUzUnrzzhXRmD3Vm/JM9yCWF
X-Received: by 2002:a2e:949:0:b0:253:ad20:7638 with SMTP id 70-20020a2e0949000000b00253ad207638mr18213290ljj.73.1653446002509;
        Tue, 24 May 2022 19:33:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaIb2y4xSBunj6Y0Pn0HegD61k8wMpUegglnU6deG7dwCx7EXFGAyqLks58kgg00PxIOV7BLaHbKWxgFww6js=
X-Received: by 2002:a2e:949:0:b0:253:ad20:7638 with SMTP id
 70-20020a2e0949000000b00253ad207638mr18213276ljj.73.1653446002298; Tue, 24
 May 2022 19:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220518035951.94220-1-jasowang@redhat.com> <20220523105323.58c28d75.pasic@linux.ibm.com>
 <20220524182751.1d4bf02f.pasic@linux.ibm.com>
In-Reply-To: <20220524182751.1d4bf02f.pasic@linux.ibm.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 25 May 2022 10:33:11 +0800
Message-ID: <CACGkMEuxdoXoasdAPzAik2Xge7vU5Fp4SMxiqk3eGZCwC8s9eA@mail.gmail.com>
Subject: Re: [PATCH V5 0/9] rework on the IRQ hardening of virtio
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 12:28 AM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Mon, 23 May 2022 10:53:23 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
>
> > On Wed, 18 May 2022 11:59:42 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >
> > > Hi All:
> >
> > Sorry for being slow on this one. I'm pretty much under water. Will try
> > to get some regression-testing done till tomorrow end of day.
> >
>
> Did some testing with the two stage indicators disabled. Didn't see any
> significant difference in performance, and with that also no performance
> regression. IMHO we are good to go ahead!

Great!

>
> Sorry it took so long.

No worries and thanks a lot for the help.

I will repost a version with some comments tweaked that is suggested
by Cornelia Huck.

Thanks

>
> Regards,
> Halil
>

