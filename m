Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416D358BE22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 01:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiHGXBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 19:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiHGXBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 19:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77153EA2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659913261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wk/43vXNo+gPgeJbUofxRngA+x+b00pdU9F/OSmIEJg=;
        b=d4Haw93S6P+Ob9vovI0K6YtUK1YMS9QUndcebBQFJuXycWL4zFfmnmZ5m8I6RT0bag5vZQ
        SnI/ujRH5rTCulYGcc7eXwvBo9hZjkm4q1ytuL05Xn444tD5aS5CEPl0AjMfI1fHoY9Gc8
        sEMiIhQ5I+isPuw1QKQUui1aC7JxJkM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-234xcwE8Nde2N2twiLK1gA-1; Sun, 07 Aug 2022 19:00:59 -0400
X-MC-Unique: 234xcwE8Nde2N2twiLK1gA-1
Received: by mail-wm1-f71.google.com with SMTP id y3-20020a1c4b03000000b003a537ef75c7so168359wma.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 16:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Wk/43vXNo+gPgeJbUofxRngA+x+b00pdU9F/OSmIEJg=;
        b=AM03/xhdEXlTYFqrTq3tKmvdKYJCfAewdlp1iEZSy+rpxUkMyeg3MRb/6DK/lN0I4W
         4RdHkfA5Xq5/YZfhAVVLC0m5T+ZPi+pEFgQoE7TTV7CyFwrSIbnM4e46MgqrJu06IG04
         DwcLUgrNoZBZof5r4EoM23Ba5kGyg+HQR0O1ZPAyEaKTxkXQugUWtwvqUzj0Z12rZUhL
         4CYn21bK0QdVAGFx2UrJQCcSbmnsWNwBpgrEsRKAqcaut6D2Uc77vt40YJrIBbV//4c4
         05gryxHfzbZD/IeV9HbFaKhZFYexqEPB5pwAh1saDj20HBpjBDlTrpXgIto0Xzp8t5QN
         NTIw==
X-Gm-Message-State: ACgBeo2A4VFGyk3MDcKtn5BhWuaI7NwxJQHaCvAQGgRfr6TgnO5j8kDB
        FqFzzsiMjGbAKTKP+KMzdSv/E7Wr52X+PuCWxMwIvp7ykSGfWYs4J+qNDlvEa0Bwa4Ied4Opcjo
        YCXDRt/zA3dC5NjuDpGIjJo/w
X-Received: by 2002:adf:e111:0:b0:21d:665e:2fa5 with SMTP id t17-20020adfe111000000b0021d665e2fa5mr10319212wrz.652.1659913258513;
        Sun, 07 Aug 2022 16:00:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR77jXqn3s6KfigLdRwFaDgPm/WuGZ/eUbqehSUKychxT4mkfEwdiEmUEE/nolidYa5kAcIEuw==
X-Received: by 2002:adf:e111:0:b0:21d:665e:2fa5 with SMTP id t17-20020adfe111000000b0021d665e2fa5mr10319205wrz.652.1659913258316;
        Sun, 07 Aug 2022 16:00:58 -0700 (PDT)
Received: from redhat.com ([2.52.21.123])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c210700b003a3561d4f3fsm916915wml.43.2022.08.07.16.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 16:00:57 -0700 (PDT)
Date:   Sun, 7 Aug 2022 19:00:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Igor Skalkin <Igor.Skalkin@opensynergy.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20220807185846-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> According to specification [1], "For the device-specific configuration
> space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> 16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> and aligned accesses for 32 and 64 bit wide fields.".
> 
> Current version of the configuration structure:
> 
>     struct virtio_bt_config {
>         __u8  type;
>         __u16 vendor;
>         __u16 msft_opcode;
>     } __attribute__((packed));
> 
> has both 16bit fields non-aligned.
> 
> This commit fixes it.
> 
> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf
> 
> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>

This is all true enough, but the problem is
1. changing uapi like this can't be done, will break userspace
2. the driver has more issues and no one seems to want to
   maintain it. 
I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
to merge it for this release.


> ---
>  include/uapi/linux/virtio_bt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
> index a7bd48daa9a9..adc03709cc4f 100644
> --- a/include/uapi/linux/virtio_bt.h
> +++ b/include/uapi/linux/virtio_bt.h
> @@ -23,9 +23,9 @@ enum virtio_bt_config_vendor {
>  };
>  
>  struct virtio_bt_config {
> -	__u8  type;
>  	__u16 vendor;
>  	__u16 msft_opcode;
> +	__u8  type;
>  } __attribute__((packed));
>  
>  #endif /* _UAPI_LINUX_VIRTIO_BT_H */
> -- 
> 2.34.1

