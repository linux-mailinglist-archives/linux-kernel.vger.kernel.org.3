Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7215512AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242963AbiD1F2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiD1F2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8655523178
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651123494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E2WT+5Dj/uF92md4vRvJ45vZd5NBiJcHUWg+Un6DF70=;
        b=bAf3BZ6QaqgK//q2caMT5ah594EnZT2Jb2yx0WlQz5kZGIMdilaS/65RHmJzhG5/Noqc4A
        BgvmKO0KGnOf9qIu9QNPXMYN1kQyHayLWGuqdfBrobKlSkbAFkIqbBfl66V4WCjkMflBwc
        1KLO2CQjWFUENHPxY3IEp6XCiF+9TNE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-k7XNWM5_NSeq4MgQ2Mo-MA-1; Thu, 28 Apr 2022 01:24:52 -0400
X-MC-Unique: k7XNWM5_NSeq4MgQ2Mo-MA-1
Received: by mail-wm1-f71.google.com with SMTP id d13-20020a05600c3acd00b0038ff865c043so3854444wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E2WT+5Dj/uF92md4vRvJ45vZd5NBiJcHUWg+Un6DF70=;
        b=Vz5ohx+e6zDNy7rP7qPR54oTSdYwzbzSHj53Vq84syy4437Cxk1Tirec54sUIfLxL0
         +0984vguOJmX0XUnmJkcsirOIjeFd7HSuA6TZN8hD87r7ltuK8DNadJZwKEy8pfwAZ+e
         7FylZUNH+p5ea0OZPis6k4F/Vgh5chzYYL0z+93VI7iBCa4WqbU/PH6Jyr7b5MPi1owb
         UlDbeGwXtXHmMeA3h1stPZTHbZTky2Vb5POY272Ev+tKp9Gd/o0QzcYDFM1qYdwZ/gjK
         VX+fReFFP3t0EbtCJ6ilc7PU+lHJYPeSlFzEo09gWMb1myG2+AxVx29OEXtE1VU2OtgP
         3CoQ==
X-Gm-Message-State: AOAM532BepJaJh/WOe5lSG3HPuK5HhULvWTxQL6R1bgkM8K9AHt9wAgC
        7ktljEi0Yi916c7g+mVrHEwNBKJmedwgWYS0CIDSPle7Lw2Q2Bbu8fei2SExpxWmXT66HZ11h7N
        hamciLC1/JuykER62O94W2Hj5
X-Received: by 2002:adf:dd0e:0:b0:20a:d00a:fcf0 with SMTP id a14-20020adfdd0e000000b0020ad00afcf0mr20082710wrm.239.1651123491569;
        Wed, 27 Apr 2022 22:24:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1Dc+Z1n8cfxiweI/O1wRWrqc7b8BNVYC1ZGuXlRWcoYm4SDgXmSVs64meStwS7OhANEavmw==
X-Received: by 2002:adf:dd0e:0:b0:20a:d00a:fcf0 with SMTP id a14-20020adfdd0e000000b0020ad00afcf0mr20082687wrm.239.1651123491114;
        Wed, 27 Apr 2022 22:24:51 -0700 (PDT)
Received: from redhat.com ([2.53.18.16])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm3674279wmq.35.2022.04.27.22.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 22:24:49 -0700 (PDT)
Date:   Thu, 28 Apr 2022 01:24:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220428012156-mutt-send-email-mst@kernel.org>
References: <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com>
 <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com>
 <20220428044315.3945e660.pasic@linux.ibm.com>
 <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
> > But my guess is that rwlock + some testing for the legacy indicator case
> > just to double check if there is a heavy regression despite of our
> > expectations to see none should do the trick.
> 
> I suggest this, rwlock (for not airq) seems better than spinlock, but
> at worst case it will cause cache line bouncing. But I wonder if it's
> noticeable (anyhow it has been used for airq).
> 
> Thanks

Which existing rwlock does airq use right now? Can we take it to sync?

-- 
MST

