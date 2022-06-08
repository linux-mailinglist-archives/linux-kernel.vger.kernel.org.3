Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517475427B4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbiFHHLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354215AbiFHGT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30D8820F68
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654668448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=btPsJ5x7niNmjEjOGerzCn59AIO0rvNFat3C8BRTa+c=;
        b=Jdv8rNRlTKBr0MaXadd0o5skfwRQf4sB9q2uHc2AKE4wm0ouj9qKJHPP7Hd0pfdIiX9Vz7
        F4WXm+4ZFfbIKV5mjeD7UbJWlMc2yNiz2EClCUOCRrsJX3mtduNUMRZxUcl/kiYRUcV5Ww
        H3Wh+LLmoexQzxlUHvVtbxYuAUesu7Y=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-53RUrQVOOBWNcLAzhBBF7A-1; Wed, 08 Jun 2022 02:07:19 -0400
X-MC-Unique: 53RUrQVOOBWNcLAzhBBF7A-1
Received: by mail-lf1-f69.google.com with SMTP id b2-20020a0565120b8200b00477a4532448so9797755lfv.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 23:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btPsJ5x7niNmjEjOGerzCn59AIO0rvNFat3C8BRTa+c=;
        b=b2Grx5xevGYZxV10+vxFRcLOcbtrv3XY5nNar09aLW8ukmdO5dv1eDGjF3rd3wDw7Q
         nkIc7i8Vs/fjOnTIxAR37r6R6FNPANTe15PKza0q9xg0Yh8UUD0+jIXpnOnBKUhOCC8N
         7W+mTNnM3ZXDeEnLa/Q0FHEPvaetSXQiYDX6qCaXITEM5Rxm0bHoKMyt1luIsV1T0T0h
         TximX4TbvF1mbWPdAp6Zr6AKN3WP8BU8YhT/c8c2nB1XI4DglMbox+YCiANHE2ODfwf6
         iz+I0GOBGhIfTOOi4tDLE1rOr8WDaHaQe+R45D1uUKGR7KRBlOwRmKgIIbV7kOlzVKah
         uOoQ==
X-Gm-Message-State: AOAM531oE6oCidrGWBM7r0WfFF/T8mCK47y3mtf+ToHQV7etWeU8QRBA
        jt1Wfxl8PX7Fy04Xzq4ZSfMliEPWrrLnAHJprLO+d+KEhcKPPIvLQfEFw1M5JG7LfYYIiMvut4H
        sxvHU74lUi/UUb9MWH825/IUeBrg+KTqpSKnGgnvb
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id b5-20020a2ebc05000000b0024b212d7521mr54409479ljf.243.1654668437625;
        Tue, 07 Jun 2022 23:07:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4UR8Bopi8bBvbC6iJ/qjLlWKuBEd8b7c2mUsEsz3iehoCWZh44Tb08CL360aRmFvrNFEl9Zn9DxVhXaP5YUE=
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id
 b5-20020a2ebc05000000b0024b212d7521mr54409469ljf.243.1654668437408; Tue, 07
 Jun 2022 23:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEus=RMMcDk+sM8X14=AtFjK+-3p_Lo=O6tfv9H=0wXENw@mail.gmail.com>
 <000000000000d5113205e0e71c8f@google.com>
In-Reply-To: <000000000000d5113205e0e71c8f@google.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 8 Jun 2022 14:07:06 +0800
Message-ID: <CACGkMEtQPxaEbZmEYj9vtUbCAaW+X4_nZW0tyC4RDG1OJKJooQ@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in add_early_randomness (2)
To:     syzbot <syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux@dominikbrodowski.net, mpm@selenic.com, mst <mst@redhat.com>,
        syzkaller-bugs@googlegroups.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 11:15 AM syzbot
<syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-and-tested-by: syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         bd8bb9ae vdpa: ifcvf: set pci driver data in probe
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8d4cbb773055caee
> dashboard link: https://syzkaller.appspot.com/bug?extid=5b59d6d459306a556f54
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1731eaf7f00000
>
> Note: testing is done by a robot and is best-effort only.
>

Cool, let me post a formal patch.

Thanks

