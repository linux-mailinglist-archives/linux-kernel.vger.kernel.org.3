Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884075719FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiGLMak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiGLMag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C4B22E6A5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657629034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ozgUhvIWKASvsf5a+WUmynagIG9hnmSOEkRHQEhJ0I=;
        b=PWFn4lTdzz3jW2FJ7ylmabNyNr6rmAG6nXvDRHOXYie1XziDK0KjJrb+jrwyCbpIG4Mtpw
        Ro0+cYIzqUfiIfD7HZv3jitZNLZaxATk0gOEX0r2cT/iqe8IFFPzJEgyE33O9+dUyzC5R4
        mqNpvTyYA9QL+ADvw8DfCN2qwFQUwvE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-oSLTrZLvMt-_wvCVmOi4Og-1; Tue, 12 Jul 2022 08:30:33 -0400
X-MC-Unique: oSLTrZLvMt-_wvCVmOi4Og-1
Received: by mail-wr1-f70.google.com with SMTP id q12-20020adfab0c000000b0021d6dcb51e8so1364459wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8ozgUhvIWKASvsf5a+WUmynagIG9hnmSOEkRHQEhJ0I=;
        b=BmeC43rru6yynW6bCGh0a5hplXa9AJPVl1ue0NG7v/GI73nTmzMAxpddtyZXCR2sci
         4kO1ivUxff4jV1tL2qzUbB1FQiRxRHHJ4x6zCc4zPtWdQEgTmBVbUkItgdNRofN9gmQT
         ylekWXeT8sJVFNr9pl8G509J5ClHRNoWLaG/6I3Qf8wcm++NE71MXwViSm7EyrcUPuWz
         g5Pbx5U59tGKFNj4yNgM0kMBk8H8vq7cYmdH7WDPm1zPWSGeBY9QAleRgoY+M23KAsEN
         m0TTIWom+FvpDmW5ftNiW6tFDmb5GW2PltvIssmNHQ48kp8nqzVNNchz35seNW04Purt
         SJ0w==
X-Gm-Message-State: AJIora/0zU74XIfOeMGe6M9t8x9cYdVyTBMinlzlIS/cqEAUyKiBmLUo
        D0mHJsh2KsS2yBrD6WRc8Jr1gO9usv1GI1ynQXCLMcMzvLCZmXnS2U96Nm4ZDBWy30d3H5vAEtC
        l9tCI0y8hV5dLzj5fJcXZaCcE
X-Received: by 2002:adf:c6c1:0:b0:21d:976e:6e87 with SMTP id c1-20020adfc6c1000000b0021d976e6e87mr15888245wrh.140.1657629031445;
        Tue, 12 Jul 2022 05:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tWGX4QWbrSslFM8amOOZY3A7QRzMxODKWapi8+CUV0gLy4qUHfsp5AT5HZp7ImMobcuttpmA==
X-Received: by 2002:adf:c6c1:0:b0:21d:976e:6e87 with SMTP id c1-20020adfc6c1000000b0021d976e6e87mr15888222wrh.140.1657629031178;
        Tue, 12 Jul 2022 05:30:31 -0700 (PDT)
Received: from redhat.com ([2.52.24.42])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b003a2d45472b6sm12627225wmr.28.2022.07.12.05.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 05:30:30 -0700 (PDT)
Date:   Tue, 12 Jul 2022 08:30:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: drop phys_addr_t typedef
Message-ID: <20220712083021-mutt-send-email-mst@kernel.org>
References: <20220411014039.3368218-1-peng.fan@oss.nxp.com>
 <CACGkMEtnXPBvv1W8SdT0Hv4riShQP3Du+EMv0XNgOGNmmfS6ng@mail.gmail.com>
 <DU0PR04MB94176F8C95FB297B4FCAD4D988869@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB94176F8C95FB297B4FCAD4D988869@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will do.

On Tue, Jul 12, 2022 at 04:59:44AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] tools/virtio: drop phys_addr_t typedef
> 
> Would anyone pick up this patch? Or any comments?
> 
> Thanks,
> Peng.
> 
> > 
> > On Mon, Apr 11, 2022 at 9:39 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > With commit 884ee1e585ca ("tools/include: Add phys_addr_t to
> > > types.h"),
> > >
> > > When building virtio tools, there is a type conficting error:
> > >
> > > "
> > > ./linux/kernel.h:32:28: error: conflicting types for ‘phys_addr_t’
> > >    32 | typedef unsigned long long phys_addr_t;
> > >       |                            ^~~~~~~~~~~
> > > In file included from /usr/include/linux/virtio_blk.h:28,
> > >                  from virtio-ivshmem-block.c:29:
> > > ../include/linux/types.h:69:13: note: previous declaration of ‘phys_addr_t’
> > was here
> > >    69 | typedef u32 phys_addr_t;
> > >       |             ^~~~~~~~~~~
> > > "
> > >
> > > Let's drop the typedef in tools/virtio/linux/kernel.h
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> > > ---
> > >  tools/virtio/linux/kernel.h | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> > > index 0b493542e61a..1d3248e3f270 100644
> > > --- a/tools/virtio/linux/kernel.h
> > > +++ b/tools/virtio/linux/kernel.h
> > > @@ -29,7 +29,6 @@
> > >  #define READ                    0
> > >  #define WRITE                   1
> > >
> > > -typedef unsigned long long phys_addr_t;  typedef unsigned long long
> > > dma_addr_t;  typedef size_t __kernel_size_t;  typedef unsigned int
> > > __wsum;
> > > --
> > > 2.25.1
> > >
> 

