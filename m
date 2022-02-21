Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A163F4BDD91
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377194AbiBUOAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:00:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbiBUOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:00:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4C721A3A8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645452008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zc9B59zUSZzLgXt5nKph0V8CweIsTnYFHSszcLLLuo=;
        b=OJhNhcI6/bxC0A4Gs2mYSUvQrg8EEC2cRGaexSd5u0fyC2KSgAtxtUys63WnOPUjNwRPPp
        4LDGZHGsKqjDxw2yZJ/3WOkgFywToKTLT7VxrVqV5/PbYLLvyQRpqTqVUzMCS8Byh2b/qe
        FA1s6+PE0I68KDYH75Rb0OavqW4ZjCo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-XsB0vo8TNsmyOQMg43-d8w-1; Mon, 21 Feb 2022 09:00:02 -0500
X-MC-Unique: XsB0vo8TNsmyOQMg43-d8w-1
Received: by mail-ej1-f69.google.com with SMTP id qa30-20020a170907869e00b006cee5e080easo4650323ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3zc9B59zUSZzLgXt5nKph0V8CweIsTnYFHSszcLLLuo=;
        b=SJKJ/7VW7TMB+Y2gubHBRBnbCEG5qojpMfDhuYwCZ2//HUSdSqlicPy5kQPA6j2Oi1
         mV7WSByj5LdroVNoW6mPiTr3v0GXtsCwVGkruCe/hG/fP0dsncqgyFbFz7NkULZR2sW0
         wXJ+7aR3O2+JABhbNLeTmzGc10kel5NqZsNIu33Pe2dIOYz4gBWIq6eWN9J6dRbplC4w
         cuokRDb1gdwXU/M0Sf1iCR6QVY3KP5QG5ALOtoqCAyyZi9v5gVqxsPm935aK4XfoMBko
         pgHa/HUV54ZI3SGkzGO/NNz2MH6WSYoaRLqE5U6b8VnpG6IB5dMh1meWH7pYJEaXbUW/
         ccaA==
X-Gm-Message-State: AOAM530BUttw6Mqk9xjLMlu8b1+JUfPkqITnnJz2zVYf7TB3OCtnY382
        CGVV944Sf8aZdgvUyfiVbaN1L6LLMiNdtsr3d3G8mozHeeSuLJzGGG+cH80i2b+BwBz0u31lfS6
        DFKAqNr8JdiGeGe5aGu/71Z63
X-Received: by 2002:a17:906:1613:b0:6cf:1161:eab6 with SMTP id m19-20020a170906161300b006cf1161eab6mr15738152ejd.315.1645452001234;
        Mon, 21 Feb 2022 06:00:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJrstq/OZL+VZEPOpOO/5yxAWyiEKzV4F9bja1q5e3eKwiADph4FHsU4qpmCMGkC08j34q2w==
X-Received: by 2002:a17:906:1613:b0:6cf:1161:eab6 with SMTP id m19-20020a170906161300b006cf1161eab6mr15738136ejd.315.1645452001073;
        Mon, 21 Feb 2022 06:00:01 -0800 (PST)
Received: from redhat.com ([2.55.129.240])
        by smtp.gmail.com with ESMTPSA id eq19sm8133190edb.36.2022.02.21.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:59:59 -0800 (PST)
Date:   Mon, 21 Feb 2022 08:59:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
Message-ID: <20220221085926-mutt-send-email-mst@kernel.org>
References: <20220219125100.835-1-hdanton@sina.com>
 <000000000000e5720605d85e97d7@google.com>
 <20220221133646.1551-1-hdanton@sina.com>
 <20220221134516.gmm3a5bjdlnzile2@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221134516.gmm3a5bjdlnzile2@sgarzare-redhat>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 02:45:16PM +0100, Stefano Garzarella wrote:
> On Mon, Feb 21, 2022 at 09:36:46PM +0800, Hillf Danton wrote:
> > Hey Stefano,
> > 
> > On Mon, 21 Feb 2022 14:09:26 +0100 Stefano Garzarella wrote:
> > > It seems that this patch [1] should fix also this issue. (syzbot seems
> > > happy).
> > 
> > What do you mean by happy?
> > Why not feed it to syzbot if it is a good fix, given a test-by tag can
> > speak for itself?
> 
> Because I sent the patch this morning for another report:
> https://syzkaller.appspot.com/bug?extid=1e3ea63db39f2b4440e0
> 
> Then I asked syzbot for this report to test my branch with that patch
> applied and the result is OK.
> 
> Is there any way to ask syzbot to test a patch already posted to the mailing
> list? (instead of sending it back to it again)
> 
> Stefano

I don't know of a way, but hey, sending it back isn't too bad,
just mention this in the mail text.

