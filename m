Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7F459EDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiHWU5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiHWU5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BA36F24D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661288228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ye9Fi4oA+sgS1EZvFu2xD8Gq2Q7V2mGd9cMXbr5HfE=;
        b=Ifx1k0ZtlXwfgczXIiHwZHNAtwGkqCthJqf96zrQwjqZmvj/Gkpitc+ong4iyL5pg1zmJF
        24Rs2BEkNymvWSmlx+KLhIpUFnWuyTQnVsEKvyW+VU1G34Le1xM60ncfRTDGlDsLHkymL9
        pwZHbpBw5g8RapqR4ZAoG0LIrAWUfLg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-184-GbqfEXPjMImwHXEOWu3f8w-1; Tue, 23 Aug 2022 16:57:05 -0400
X-MC-Unique: GbqfEXPjMImwHXEOWu3f8w-1
Received: by mail-wm1-f69.google.com with SMTP id j3-20020a05600c1c0300b003a5e72421c2so991363wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=3Ye9Fi4oA+sgS1EZvFu2xD8Gq2Q7V2mGd9cMXbr5HfE=;
        b=Mo16VuhBTB48YWp57Sf0EIzPhE1rcJXAbrijBk3HJlxESdUty6CXG8HbWlDcN7rptt
         uujwOXu+vT4qQHojFwKTZ0uJTi/NRrojQLNbcyAgMwxL0XmYelnGTrhhpY2SI1c8ZRGH
         ka4clREmxl/SrtN1Zszl4fbIfYoiRilGPE5/JDL0xN+VZ8HbB54OMnYg/+ZuDP7+2IUE
         lmSWhjUzJ7OdI9IuEoAIOJT4ZiDYYuo6oBSNcQnxRres3m9gWZgKJ7F3JrTxT01Ot7Or
         bWwkTcJjDqAh5sym0i4yHg5Asru+6YM/tmKrNbu5Jf6pId7jYgQWUv+xQ+YtoSufDBtE
         Ylrg==
X-Gm-Message-State: ACgBeo0u7x4dfLWHfFVbIQQ4tPdj+wWsdmquYF9UjX9hg0OzB1fCwghH
        6w62hJE4edEkxukGK/bqpf9Z6bZKzDUyoM48UdUZpyd5vZ8kZRXsFOd3zvdAlG34yp1scBPvEUF
        IgIejMUB32OkzeLBzhiHZVRQR
X-Received: by 2002:a5d:6d8c:0:b0:225:57a2:9564 with SMTP id l12-20020a5d6d8c000000b0022557a29564mr7076789wrs.139.1661288223798;
        Tue, 23 Aug 2022 13:57:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR54Q25oOQQy6ncWsx6VrUpN/F0yvxwJjNCy88FJ6OQgWy/SD0qe1rcQwPjDrsdsaDlIGDXXRg==
X-Received: by 2002:a5d:6d8c:0:b0:225:57a2:9564 with SMTP id l12-20020a5d6d8c000000b0022557a29564mr7076778wrs.139.1661288223584;
        Tue, 23 Aug 2022 13:57:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it. [146.241.97.176])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c029900b003a62bc1735asm280179wmk.9.2022.08.23.13.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 13:57:03 -0700 (PDT)
Message-ID: <5174d4ef7fe3928472d5a575c87ee627bfb4c129.camel@redhat.com>
Subject: Re: [PATCH net-next v4 0/9] vsock: updates for SO_RCVLOWAT handling
From:   Paolo Abeni <pabeni@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Date:   Tue, 23 Aug 2022 22:57:01 +0200
In-Reply-To: <YwU443jzc/N4fV3A@fedora>
References: <de41de4c-0345-34d7-7c36-4345258b7ba8@sberdevices.ru>
         <YwUnAhWauSFSJX+g@fedora> <20220823121852.1fde7917@kernel.org>
         <YwU443jzc/N4fV3A@fedora>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-23 at 16:30 -0400, Stefan Hajnoczi wrote:
> On Tue, Aug 23, 2022 at 12:18:52PM -0700, Jakub Kicinski wrote:
> > On Tue, 23 Aug 2022 15:14:10 -0400 Stefan Hajnoczi wrote:
> > > Stefano will be online again on Monday. I suggest we wait for him to
> > > review this series. If it's urgent, please let me know and I'll take a
> > > look.
> > 
> > It was already applied, sorry about that. But please continue with
> > review as if it wasn't. We'll just revert based on Stefano's feedback
> > as needed.
> 
> Okay, no problem.

For the records, I applied the series since it looked to me Arseniy
addressed all the feedback from Stefano on the first patch (the only
one still lacking an acked-by/reviewed-by tag) and I thought it would
be better avoiding such delay.

We are still early in this net-next cycle, I think it can be improved
incrementally as needed.

Paolo

