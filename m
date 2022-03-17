Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD9C4DC0AC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiCQILM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiCQILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EC7BFD3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647504588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bnLdr4HwqrI6g2eVldupmYABxQ1B7HkrLHxzrYkWZNY=;
        b=R52wsbPEc66AQ5tRKrAUD/+lw7I6L/vZfKwMKvasI0DRT8Gux66nZuFKonbVyIzbLhDz7w
        zEDhEs6MG4iDIvvjniWtb4m3rpVvl53Ihl6L+/Ro3ZS9+Bq2GrgDx7XND1mD0amNt97Hx9
        zQxXIoc2sHYWBEPy3P49uKYTJl4Dodg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-LYdvDARFNiiIm2bSjMLutw-1; Thu, 17 Mar 2022 04:09:45 -0400
X-MC-Unique: LYdvDARFNiiIm2bSjMLutw-1
Received: by mail-qv1-f71.google.com with SMTP id 33-20020a0c8024000000b0043d17ffb0bdso3426507qva.18
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bnLdr4HwqrI6g2eVldupmYABxQ1B7HkrLHxzrYkWZNY=;
        b=0nMQSZjzhqV/PjIBHiAQQ3WPcSYGVPuvL9QxCIv3pkNOvQyhNq1QWbGHYRYZLm8Uvk
         hjtfcZ7WvMfM5H//u/RF4zAUDAMuR4bq7MwPRYJjG78sC8YQLZ4c4E1MTLRv/7ZqPpHw
         rRza9rv3q0FsIJs96OeDE4JSOf/EPf0Fav92luBuGMfTX6+WeE8L69l9fkiU6qB4hkg4
         wvlk87zLb5CtMovCp3TCHQ17J8EbMg8ke4pDGpuoDExlf/9d6QoDL1lLpsTDxcsHWnJ+
         X7nIoub2AEdPPmTYGoRJbUl3hWxqod0lWVpBndL06/aBzECt7JVGb8TeAT80VF7xKDOq
         wsjA==
X-Gm-Message-State: AOAM531IPWG3089McPBWc7ceSEU+NalgE+v7QUqGbx90HwMU+PSl3Ke4
        P2cfNiaQIY891N59JC8Rc7sTpkCBhe+NWArGQ9IFRl5M1PO1RWbsk25/3N4nNqYqrOF7BsZuHY/
        BWgvdwB0HD6bQ+AoFW01rdZf7
X-Received: by 2002:ac8:5ccc:0:b0:2e1:b355:5c36 with SMTP id s12-20020ac85ccc000000b002e1b3555c36mr2733610qta.402.1647504584993;
        Thu, 17 Mar 2022 01:09:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxnAp8LRv0pGr4caYh2PYRswaZ3blc4m+lTKdGlnP5IFQMb25svYg88Zli7hmhO5GnMJsu3Q==
X-Received: by 2002:ac8:5ccc:0:b0:2e1:b355:5c36 with SMTP id s12-20020ac85ccc000000b002e1b3555c36mr2733597qta.402.1647504584792;
        Thu, 17 Mar 2022 01:09:44 -0700 (PDT)
Received: from sgarzare-redhat (host-79-42-202-12.retail.telecomitalia.it. [79.42.202.12])
        by smtp.gmail.com with ESMTPSA id a6-20020ae9e806000000b0067ba5a8a2a7sm2003975qkg.134.2022.03.17.01.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 01:09:44 -0700 (PDT)
Date:   Thu, 17 Mar 2022 09:09:38 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Cc:     Krasnov Arseniy <oxffffaa@gmail.com>,
        Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] af_vsock: SOCK_SEQPACKET broken buffer
 test
Message-ID: <20220317080938.pyngcehb3lmags7k@sgarzare-redhat>
References: <4ecfa306-a374-93f6-4e66-be62895ae4f7@sberdevices.ru>
 <c3ce3c67-1bbd-8172-0c98-e0c3cd5a80b6@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c3ce3c67-1bbd-8172-0c98-e0c3cd5a80b6@sberdevices.ru>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 05:28:21AM +0000, Krasnov Arseniy Vladimirovich wrote:
>Add test where sender sends two message, each with own
>data pattern. Reader tries to read first to broken buffer:
>it has three pages size, but middle page is unmapped. Then,
>reader tries to read second message to valid buffer. Test
>checks, that uncopied part of first message was dropped
>and thus not copied as part of second message.
>
>Signed-off-by: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
>---
> v2 -> v3:
> 1) "got X, expected Y" -> "expected X, got Y".
> 2) Some checkpatch.pl fixes.
>
> tools/testing/vsock/vsock_test.c | 131 +++++++++++++++++++++++++++++++
> 1 file changed, 131 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

