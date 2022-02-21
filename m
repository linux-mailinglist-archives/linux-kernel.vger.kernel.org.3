Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CE04BDD24
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359594AbiBUNpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:45:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359405AbiBUNpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:45:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3B20220EE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645451122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pMlwhYvM624uJ20Mr+cc5U9wDFcuKYpa33YOS3zX70=;
        b=an8LjZXxWvqdhzJdai2meVsDuB0Ay31BTIkkm8kOSufilQ5LiZ5KclaVbqQAUgGQZV5D3B
        Kp0vGTb+HEGTwXarCkyshYT/qwQRzC7/pyyP0XIO4BCr3tkTeafFboBAvNW7zLjZQ3EJnI
        26+9R/+XQavVR2ubyMSDnqi5cElGkNg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-wfD_ptQFOzOuwwBjCNQEeQ-1; Mon, 21 Feb 2022 08:45:20 -0500
X-MC-Unique: wfD_ptQFOzOuwwBjCNQEeQ-1
Received: by mail-wr1-f70.google.com with SMTP id e11-20020adf9bcb000000b001e316b01456so7412522wrc.21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2pMlwhYvM624uJ20Mr+cc5U9wDFcuKYpa33YOS3zX70=;
        b=YldGhAbWYpRFE0UtS1bivImpRIwrMofKzA9qYJwZVCUhmeoQ14Nwvv75rZSoxWZ/km
         zxgiI1xBzl4YGpdyN7G+ggOekwWHQGpoDsZLsm5PgvvJlrJQ3LnkYDWMGZ0hwiRkJgOh
         uGS0mRbVQOQSAKb7VniclBhFYPEX09vKNhM25HgM6+KUkoEuT/btgy2OPfzOCpLGnpJM
         k071NR0lQTjQDaxiC1e1F7UCzsv/jKHDlnhG1slEJrnBi5a+VIlnN3k99u9zVTWkevur
         w9g72ABuX9pWNVi6VMEJDyXvOcAWxuQzoQl7ck+TdQtgKuZ8u0ZI8YuMOHgz6IjAmcOI
         +8jg==
X-Gm-Message-State: AOAM531Z79pA3eEK8ztA0D/fBjfG1VU1kTr45Y+PhJIkNLvTcZvHO0Am
        PlwpQ9OkZmJ83OPcXIJy1ONLAptI3eQUY7eAN4ZZU6LDcvF1YqIMt4nM9QLePg/WBZaLh3TTK73
        +WC6YV5cvPiSkBvgybq2yEg7m
X-Received: by 2002:a5d:6d0e:0:b0:1e2:fa3d:7f22 with SMTP id e14-20020a5d6d0e000000b001e2fa3d7f22mr15933597wrq.142.1645451119648;
        Mon, 21 Feb 2022 05:45:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0IfRzmVb4Wy9QsJLZ9GJ2G0bDxQvk/jNwfQtAab6O9pmvi6VqnbcgyFjHPaps6ZqNl3PV3g==
X-Received: by 2002:a5d:6d0e:0:b0:1e2:fa3d:7f22 with SMTP id e14-20020a5d6d0e000000b001e2fa3d7f22mr15933584wrq.142.1645451119445;
        Mon, 21 Feb 2022 05:45:19 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it. [95.248.229.156])
        by smtp.gmail.com with ESMTPSA id x7sm43026500wro.21.2022.02.21.05.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:45:18 -0800 (PST)
Date:   Mon, 21 Feb 2022 14:45:16 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>,
        jasowang@redhat.com, linux-kernel@vger.kernel.org, mst@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
Message-ID: <20220221134516.gmm3a5bjdlnzile2@sgarzare-redhat>
References: <20220219125100.835-1-hdanton@sina.com>
 <000000000000e5720605d85e97d7@google.com>
 <20220221133646.1551-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220221133646.1551-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 09:36:46PM +0800, Hillf Danton wrote:
>Hey Stefano,
>
>On Mon, 21 Feb 2022 14:09:26 +0100 Stefano Garzarella wrote:
>> It seems that this patch [1] should fix also this issue. (syzbot seems
>> happy).
>
>What do you mean by happy?
>Why not feed it to syzbot if it is a good fix, given a test-by tag can
>speak for itself?

Because I sent the patch this morning for another report: 
https://syzkaller.appspot.com/bug?extid=1e3ea63db39f2b4440e0

Then I asked syzbot for this report to test my branch with that patch 
applied and the result is OK.

Is there any way to ask syzbot to test a patch already posted to the 
mailing list? (instead of sending it back to it again)

Stefano

