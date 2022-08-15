Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5D4594E31
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiHPBrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245017AbiHPBqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39307356D4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660599555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e2Hg6grA0aMUmuL4rEa0v8OvN+G77+vUxp19mNa37p4=;
        b=fvmPEoZ0xguwgALAx/MiAnwtYl5sdCPxOjewrbA3ynNj+eD67NhFjJBqCy7SBkQWV7C8S7
        0chWHoAAa09Zcl98CTCzUF4marqx5npdmIQ55Zs2Am1A97nljGRRyplA57n2Yntt7wJ3Vt
        X79TITi/cCtSuq7Po/PxcIH68gn5eUw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-91-3Rp__2yUO3-t7gWk7tF5gA-1; Mon, 15 Aug 2022 17:39:14 -0400
X-MC-Unique: 3Rp__2yUO3-t7gWk7tF5gA-1
Received: by mail-wm1-f72.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so1583221wmp.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=e2Hg6grA0aMUmuL4rEa0v8OvN+G77+vUxp19mNa37p4=;
        b=5CBGgfkVvR8f/14sUQir7MBWnSUnJRCfXpZ2M+eQNxF3uasaTdDSFPXDEqEo7pMl2I
         AEyt3vhr/LN3goZTHJ1BW6AJDpYUQHDGI4QLQFuFPtVJRYRRO2Zq1F3lrlYmpddSMbE/
         wzl5Eog8y/fZT4Cg98/aoylPaQbU9cgnABeXo0COzcktD7JtybgG+QAv0Tmfi5TU8B+e
         wOeMMVITnZIt2cMiPcA67CiF5zYu/Fu5IRkyFuW1nK+efRtZPm8V0GeYJaxjs4uJmPp8
         P1PoyzeX7e1mirl66s9PltOl2V0f6r2vR4CH8jTM9nj6r1AHsj6LVToUlZjMUfasFxKu
         vOqA==
X-Gm-Message-State: ACgBeo3m4acfWjjBMEkWJI2Ho0qUB+lTQWNs+/XQuCBbFxs5hxyLQDe+
        5WcbOUkiz4NihmiRyoZI94k6PLG/NpFfodXxgE42idMuwIV4+qRJkn8cde0yQSPzI3mhCpLfFgu
        2WWZlUh1HLss2gVtiiSTvuKHx
X-Received: by 2002:a05:600c:1e8d:b0:3a5:e37f:6fd2 with SMTP id be13-20020a05600c1e8d00b003a5e37f6fd2mr6889427wmb.33.1660599553674;
        Mon, 15 Aug 2022 14:39:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5OPTU7ZmWCtVBzowlE4TRPIvtXzHuep1+lrOGeKpN4aAF6Aj1ToJOY72dVoYDK4Ke/fClJcg==
X-Received: by 2002:a05:600c:1e8d:b0:3a5:e37f:6fd2 with SMTP id be13-20020a05600c1e8d00b003a5e37f6fd2mr6889413wmb.33.1660599553427;
        Mon, 15 Aug 2022 14:39:13 -0700 (PDT)
Received: from redhat.com ([2.55.4.37])
        by smtp.gmail.com with ESMTPSA id e14-20020a05600c4e4e00b003a31ca9dfb6sm13814387wmq.32.2022.08.15.14.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:39:12 -0700 (PDT)
Date:   Mon, 15 Aug 2022 17:39:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>, c@redhat.com
Subject: Re: [PATCH] virtio_net: Revert "virtio_net: set the default max ring
 size by find_vqs()"
Message-ID: <20220815173256-mutt-send-email-mst@kernel.org>
References: <20220815090521.127607-1-mst@redhat.com>
 <20220815203426.GA509309@roeck-us.net>
 <20220815164013-mutt-send-email-mst@kernel.org>
 <20220815205053.GD509309@roeck-us.net>
 <20220815165608-mutt-send-email-mst@kernel.org>
 <20220815212839.aop6wwx4fkngihbf@awork3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815212839.aop6wwx4fkngihbf@awork3.anarazel.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 02:28:39PM -0700, Andres Freund wrote:
> Hi,
> 
> On 2022-08-15 17:04:10 -0400, Michael S. Tsirkin wrote:
> > So virtio has a queue_size register. When read, it will give you
> > originally the maximum queue size. Normally we just read it and
> > use it as queue size.
> > 
> > However, when queue memory allocation fails, and unconditionally with a
> > network device with the problematic patch, driver is asking the
> > hypervisor to make the ring smaller by writing a smaller value into this
> > register.
> > 
> > I suspect that what happens is hypervisor still uses the original value
> > somewhere.
> 
> It looks more like the host is never told about the changed size for legacy
> devices...
> 
> Indeed, adding a vp_legacy_set_queue_size() & call to it to setup_vq(), makes
> 5.19 + restricting queue sizes to 1024 boot again.

Interesting, the register is RO in the legacy interface.
And to be frank I can't find where is vp_legacy_set_queue_size
even implemented. It's midnight here too ...

>  I'd bet that it also would
> fix 6.0rc1, but I'm running out of time to test that.
> 
> Greetings,
> 
> Andres Freund

Yes I figured this out too. And I was able to reproduce on qemu now.

Andres thanks a lot for the help!

I'm posting a new patchset reverting all the handing of resize
restrictions, I think we should rethink it for the next release.

Thanks everyone for the help!

-- 
MST

