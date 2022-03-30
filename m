Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB454EBA16
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiC3FYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 01:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240660AbiC3FYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 084E715AAFC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648617743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=73+ha/vkBm7xxOmMxZvMhcq9V/8gU/hzN5hUEp6SUC0=;
        b=VoLB9ziFvKUdp417MWWO2iPYNiBHo6d8/fYmpP1B8YlX9+sGPcxsoRVG/yQqkT6i0HWGSg
        WL5ohowaFo15vQrfLYn+b08h+obSfX7N717LKeCIgZbCgDwg1AVL5vVtF/fW1aycqIvwMJ
        wP0I1/5T5nDPo3zCocYSTiu1ldBF2n8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-kbb-X98yMzGY0u1yyNNUZA-1; Wed, 30 Mar 2022 01:22:21 -0400
X-MC-Unique: kbb-X98yMzGY0u1yyNNUZA-1
Received: by mail-wr1-f71.google.com with SMTP id e10-20020adf9bca000000b002059b6ffa18so4173704wrc.14
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 22:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=73+ha/vkBm7xxOmMxZvMhcq9V/8gU/hzN5hUEp6SUC0=;
        b=YB4ouBU1b/HfFOZReV0wHOwfu7uuEWUjkNygZXvTNko4oSvvi3jgk5xOjBRTFHhswX
         c5vZkogPd6vi42hBrTWx99VcEF19oTD+fB7gYKWpH1q6N1izf38M++O8cpSGMNBk1FrH
         3fCHmOoSqzt5Fn6io315VXdn0+J9w3egY2CLvqrqL+N3tMhjTJvlzV2pWBTd9NnwQfNf
         zsYAaiZm+ro8w/wJqdd62Jy0eeclXgE4vZTvVgPMi9dP8KJ9cx76DlBHrnzVzp8Zv1BF
         vZNoeaMKNqs/BilVIiVnNwUa7eJ2oAx/C74cezj34IiCt7yze3lOWBS5zPS4RBWbLVIh
         7MuA==
X-Gm-Message-State: AOAM532Xt6DLfv1xqCP0CP2o59H9lRCqX0NqdRvswmtO3btasVdH2J9D
        hwzNRP9gQyrtt9kcYtTnWcc6YXRcCMvVUJhlyqHj4UWA3WEHy245dqzd6mlkKU7OigKG21laYTm
        vEJwNSeEDleA+E5dACyxbSyLx
X-Received: by 2002:a05:600c:4ec9:b0:38b:f1fd:b6b9 with SMTP id g9-20020a05600c4ec900b0038bf1fdb6b9mr2613644wmq.7.1648617740386;
        Tue, 29 Mar 2022 22:22:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhZNA71rh4p3gznLJEzepRF8Cf0lFbyruap5Iy8lNQ71ai2JE9ehQlS8ISFWRukJV+gCHPgQ==
X-Received: by 2002:a05:600c:4ec9:b0:38b:f1fd:b6b9 with SMTP id g9-20020a05600c4ec900b0038bf1fdb6b9mr2613631wmq.7.1648617740126;
        Tue, 29 Mar 2022 22:22:20 -0700 (PDT)
Received: from redhat.com ([2.52.9.207])
        by smtp.gmail.com with ESMTPSA id m2-20020a1c2602000000b0038ca9ffac53sm3730095wmm.11.2022.03.29.22.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:22:19 -0700 (PDT)
Date:   Wed, 30 Mar 2022 01:22:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, keirf@google.com
Subject: Re: [PATCH 1/3] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220330012204-mutt-send-email-mst@kernel.org>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-2-jasowang@redhat.com>
 <20220324064205-mutt-send-email-mst@kernel.org>
 <20220324110307.iizkdwuhc5c75noj@sgarzare-redhat>
 <20220324070612-mutt-send-email-mst@kernel.org>
 <20220324113126.f6f5hfabhqfyutix@sgarzare-redhat>
 <81381018-9dcd-3fba-becf-183435a5bf6b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81381018-9dcd-3fba-becf-183435a5bf6b@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 11:05:22AM +0800, Jason Wang wrote:
> 
> 在 2022/3/24 下午7:31, Stefano Garzarella 写道:
> > On Thu, Mar 24, 2022 at 07:07:09AM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Mar 24, 2022 at 12:03:07PM +0100, Stefano Garzarella wrote:
> > > > On Thu, Mar 24, 2022 at 06:48:05AM -0400, Michael S. Tsirkin wrote:
> > > > > On Thu, Mar 24, 2022 at 04:40:02PM +0800, Jason Wang wrote:
> > > > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > > >
> > > > > > This avoids setting DRIVER_OK twice for those drivers that call
> > > > > > virtio_device_ready() in the .restore
> > > > >
> > > > > Is this trying to say it's faster?
> > > > 
> > > > Nope, I mean, when I wrote the original version, I meant to do the same
> > > > things that we do in virtio_dev_probe() where we called
> > > > virtio_device_ready() which not only set the state, but also called
> > > > .enable_cbs callback.
> > > > 
> > > > Was this a side effect and maybe more compliant with the spec?
> > > 
> > > 
> > > Sorry I don't understand the question. it says "avoids setting
> > > DRIVER_OK twice" -
> > > why is that advantageous and worth calling out in the commit log?
> > 
> > I just wanted to say that it seems strange to set DRIVER_OK twice if we
> > read the spec. I don't think it's wrong, but weird.
> > 
> > Yes, maybe we should rewrite the commit message saying that we want to
> > use virtio_device_ready() everywhere to complete the setup before
> > setting DRIVER_OK so we can do all the necessary operations inside (like
> > in patch 3 or call enable_cbs).
> > 
> > Jason rewrote the commit log, so I don't know if he agrees.
> > 
> > Thanks,
> > Stefano
> 
> 
> I agree, I will tweak the log in V2.
> 
> Thanks

Still waiting for that v2.

