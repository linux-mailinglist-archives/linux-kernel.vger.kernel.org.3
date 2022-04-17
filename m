Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BED9504993
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 23:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiDQVIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiDQVIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 17:08:12 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A81E0D9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 14:05:12 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a8so14739200ljq.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3+nbTY+84mWqEaxVh9si/y236NGTkkPaVHQEn9FFNrQ=;
        b=SqsQaN3fYS853QyFaqhKfWVcI1U/A4Juzvi+EN0SFJi1ZQ2FiQxlnlVvOkN8wT92pg
         gYeEGqE2PFZCSAUQjDQ8XlgcTPj/J2mPfqkKTxv9+bvDqHwu4L+OrW2E048B79hejG7J
         YGS5pVsV5N+uPco8nKvkzcIXjk8rBoBeWtXYgbHek3YWtvLnCgvIMLLeFD1jBuQmmrJf
         ZQgFJnXSrmh9mMXyBlk6yc2g6dV6Eq6VoeNeRcFrMFJVpIdAoMg92fyYoEGZ/Al0blfo
         epqj6ufkNBRCTbF7UfmPszNHZrkig+Ad6MAtecdlZJnWfmFOMAluLmNo7zX3yOPkSVAx
         9dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3+nbTY+84mWqEaxVh9si/y236NGTkkPaVHQEn9FFNrQ=;
        b=hWjtxUTKQS6XQsvUZBo3jOQKI1Bid09upOqNZq7zUmey41xgs15UOLfYBptrK5l26e
         3Q5Ka7FhPEEPT46gyUEBQ+86vgbwATAH/I/2upcLmPN4nLTfGReoOKPMnReEx/baMMGx
         JoXgiWg40mbiuC1funneOqaou3rPR5Vf5kVBPyqkdjs7TBEXwyYueBpRvZfsqM/MAQNZ
         T0uFJneDKqrp74gDauze8HoP/l/Nff7SQ6wZWwvmYSC7zv80N+keb16BSwpcQxClD//z
         Is32vCi/aoSi1td9SKz666kLIp5+C18iia9wfdiwJhf9YdPBANqfpuYO5Ndcha/dg5Ty
         MPMg==
X-Gm-Message-State: AOAM533XlKag6DQHQ0YPeg43gy7htbicdvcEMyCouTopr/A8YO6sy36/
        El2ZhEON/hrl5EGnLlwjU+Q=
X-Google-Smtp-Source: ABdhPJwA45/8xaDYUsCh46Vd5PLnnCYBZYvMyLLmDl7WHF9eI0ftD1WkdGwRVKQNKCGBZhzlQf9Pyg==
X-Received: by 2002:a2e:b8c7:0:b0:24d:a697:cbf3 with SMTP id s7-20020a2eb8c7000000b0024da697cbf3mr5387864ljp.448.1650229510204;
        Sun, 17 Apr 2022 14:05:10 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id p9-20020a2e93c9000000b0024b3c2ecc18sm979821ljh.115.2022.04.17.14.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 14:05:09 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] arm/xen: Assign xen-virtio DMA ops for virtio
 devices in Xen guests
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
 <1649963973-22879-7-git-send-email-olekstysh@gmail.com>
 <alpine.DEB.2.22.394.2204151305050.915916@ubuntu-linux-20-04-desktop>
 <YlpdBHKT1bYzZe2e@infradead.org>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <f879622e-5656-deb1-1930-f0cd180a4ab1@gmail.com>
Date:   Mon, 18 Apr 2022 00:05:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YlpdBHKT1bYzZe2e@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16.04.22 09:07, Christoph Hellwig wrote:

Hello Christoph

> On Fri, Apr 15, 2022 at 03:02:45PM -0700, Stefano Stabellini wrote:
>> This makes sense overall. Considering that the swiotlb-xen case and the
>> virtio case are mutually exclusive, I would write it like this:
> Curious question:  Why can't the same grant scheme also be used for
> non-virtio devices?  I really hate having virtio hooks in the arch
> dma code.  Why can't Xen just say in DT/ACPI that grants can be used
> for a given device?


In Xen system:
- the grants are not used for "non-virtualized" devices at all (platform 
devices for the passthrough).
- the grants are widely used for "virtualized, but non-virtio" devices 
(traditional Xen PV devices), but grants for these Xen PV devices
are used in a different way and *not* at the DMA ops level like in 
current approach

Or I misunderstood your question?

This patch series tries to make things work with "virtio" devices in Xen 
system without introducing any modifications to code under drivers/virtio.
We could avoid having virtio hooks in the arch DMA code, but we need to 
trigger setting xen-virtio DMA ops for the virtio device from some other 
place.
For example, the following code would also work, but requires altering 
virtio_mmio_probe():

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9..8f48491 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -615,6 +615,9 @@ static int virtio_mmio_probe(struct platform_device 
*pdev)
                                               DMA_BIT_MASK(32 + 
PAGE_SHIFT));
         } else {
                 rc = dma_set_mask_and_coherent(&pdev->dev, 
DMA_BIT_MASK(64));
+
+               if (arch_has_restricted_virtio_memory_access())
+ xen_virtio_setup_dma_ops(&pdev->dev);
         }
         if (rc)
                 rc = dma_set_mask_and_coherent(&pdev->dev, 
DMA_BIT_MASK(32));


Another possible option could be to introduce local init function in 
drivers/xen/xen-virtio.c to scan the device tree and set xen-virtio DMA 
ops for all devices with the
"xen,dev-domid" property.


What do you think?

-- 
Regards,

Oleksandr Tyshchenko

