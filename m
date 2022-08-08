Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3161F58C83A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242527AbiHHMQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbiHHMQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E391DDE88
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659960978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KQglINn5qIliFhQxdXnssuNFpnHg6itQvnE5dnSG+xE=;
        b=Ld91eO6hhiVCO1YpORz6OjDOUwIpgE6CA+hlVTZNkVzLNTIhJ7+juIp8GP2zGrMnb1mZC/
        ryZOKTh4ZuepIkZdQG3jPVxClXOqJ+iO9n8ru9ZZkL3b1CxCuuDe5ZJSRS/znB1HhBqyod
        xMAWzVp9tI7GZDhGyHCyM3EVRLltHj0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-7Ms93gYXN26DJ2tvK92UUw-1; Mon, 08 Aug 2022 08:16:12 -0400
X-MC-Unique: 7Ms93gYXN26DJ2tvK92UUw-1
Received: by mail-wm1-f70.google.com with SMTP id bh18-20020a05600c3d1200b003a32044cc9fso4680169wmb.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KQglINn5qIliFhQxdXnssuNFpnHg6itQvnE5dnSG+xE=;
        b=XY7xawCMQjCfRiHxiuE6k4L8S2704rD9BrYhewGorsQANqvKob+oRMmRZtHFao3r5O
         FgDQyy8FR5FL4GYUF+OGEe9qPx2fBbPqlFQKbCDUOn7QUBC+6bXevibN6ImiCHSQFlLa
         vrgclNKadlbkT43TWRJsjDL66IvHTOTsp7hHVKmPTjMCJGvJVpOylXrVXcLgBwgVQzSV
         OzdwOs5tnicu2OAzuyo8f2NnoptjtTn5IqwCUeXWCZe4UyORf9KE6Esw0n4i41UDVe85
         fmVihl0sg0HnfeM8WMCzSJOH6GfyaUGmJXl8Yp3V2hIkeCnQ5IwQVUZKOwxVkGM+r3R5
         hOGQ==
X-Gm-Message-State: ACgBeo1ETHe60mJgkdSnBe3A42tRoz7nnjSKHT6R/1QC/uBGYP7R25Kw
        2BIHuUhDNAifUOMyo8X+T7OHz8zYqUbGM6edRuUpei2ty1VzF0hg+LT35EcQaOInOLQzm84+OBZ
        a/vBbKPWQrYNdXZUF7EODPorJ
X-Received: by 2002:adf:ecc7:0:b0:220:5fef:6d40 with SMTP id s7-20020adfecc7000000b002205fef6d40mr11346426wro.5.1659960971202;
        Mon, 08 Aug 2022 05:16:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zU6VHrKnAMD/aDkLqilJynNkwCVR51Kx58+rPxKSAaPZ1EV8m5UjTlEMZZCTPAQylrfDvzg==
X-Received: by 2002:adf:ecc7:0:b0:220:5fef:6d40 with SMTP id s7-20020adfecc7000000b002205fef6d40mr11346410wro.5.1659960970977;
        Mon, 08 Aug 2022 05:16:10 -0700 (PDT)
Received: from redhat.com ([2.52.21.123])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc018000000b003a53731f273sm5898667wmb.31.2022.08.08.05.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:16:10 -0700 (PDT)
Date:   Mon, 8 Aug 2022 08:16:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Igor Skalkin <igor.skalkin@opensynergy.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, mgo@opensynergy.com
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20220808081054-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org>
 <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> On 8/8/22 01:00, Michael S. Tsirkin wrote:
> 
>     On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> 
>         According to specification [1], "For the device-specific configuration
>         space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
>         16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
>         and aligned accesses for 32 and 64 bit wide fields.".
> 
>         Current version of the configuration structure:
> 
>             struct virtio_bt_config {
>                 __u8  type;
>                 __u16 vendor;
>                 __u16 msft_opcode;
>             } __attribute__((packed));
> 
>         has both 16bit fields non-aligned.
> 
>         This commit fixes it.
> 
>         [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&umid=d1786ace-e8ea-40e8-9665-96c0949174e5&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a470
> 
>         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> 
>     This is all true enough, but the problem is
>     1. changing uapi like this can't be done, will break userspace
>     2. the driver has more issues and no one seems to want to
>        maintain it.
>     I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
>     to merge it for this release.
> 
> This is very sad. We already use this driver in our projects.

Really?  Can you step up to maintain it? Then we can fix the issues
and it won't be broken.

> Our virtio bluetooth device has two backends - HCI_USER socket backend for one
> platform and uart backend for the other, and works well (after applying your
> "[PATCH] Bluetooth: virtio_bt: fix device remove") patch, so this "device
> removal" problem can probably be considered solved .

Can you post a Tested-by tag for that?

I need to go back and review it, I think I saw some issues but must be
fixable.

> We could help with the rest of the problems you listed that can be solved
> (specification, QEMU support).
> And the only problem that is difficult to solve (because of the need to change
> UAPI header files) is just this one with unaligned configuration fields.
> At the moment, it does not reproduce, because without VIRTIO_BT_F_VND_HCI
> (Indicates vendor command support) feature negotiated, the driver does not
> read the non-aligned configuration fields.


Hmm. So how about this:
- add a new feature flag
- add new aligned format
- mark the old memory reserved in the spec


> So, what would you advise us to do? Continuing to use the "marked broken"
> driver, start writing a specification for a new from scratch, better one?
> Or is there any way to bring this one back to life?

If someone is prepared to work on this we can bring it back.



> 
> 
>         ---
>          include/uapi/linux/virtio_bt.h | 2 +-
>          1 file changed, 1 insertion(+), 1 deletion(-)
> 
>         diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
>         index a7bd48daa9a9..adc03709cc4f 100644
>         --- a/include/uapi/linux/virtio_bt.h
>         +++ b/include/uapi/linux/virtio_bt.h
>         @@ -23,9 +23,9 @@ enum virtio_bt_config_vendor {
>          };
> 
>          struct virtio_bt_config {
>         -       __u8  type;
>                 __u16 vendor;
>                 __u16 msft_opcode;
>         +       __u8  type;
>          } __attribute__((packed));
> 
>          #endif /* _UAPI_LINUX_VIRTIO_BT_H */
>         --
>         2.34.1
> 
> --
> 
> Best regards,
> 
> Igor Skalkin
> Software Engineer
> 
> OpenSynergy GmbH
> Rotherstr. 20, 10245 Berlin
> 
> igor.skalkin@opensynergy.com
> www.opensynergy.com
> 
> registered: Amtsgericht Charlottenburg, HRB 108616B
> General Management: Rolf Morich, Stefaan Sonck Thiebaut
> 
> 
> Please mind our privacy notice pursuant to Art. 13 GDPR. // Unsere Hinweise zum
> Datenschutz gem. Art. 13 DSGVO finden Sie hier.

