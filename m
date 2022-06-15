Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCE554C8BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345336AbiFOMlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiFOMlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:41:18 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC7B3ED10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:41:17 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c30so13093301ljr.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=w6mEqtJ4r74TnNlMvfbdu8cIIS/gk/ZwzqlOU40cLcI=;
        b=Ns/Yffi5uouREXNrVzUrM90jbm7q7a2tY0STxq349YuYuatUrOEBk8sVaJgw4JgFzo
         m3glrH2cCTIhO6ZUxBDytyLucbRmwnxuO9OF73Okk2xJIwVPmcuL4eRsWi8GAG+rOt+X
         wYsB+HoBLOQDXKB2n00M6RF/44SSgpydn90oAe70A3HAMQgn8YQJyddKkRRXY0yCwRms
         Y/f7AztfyYwWlnyGBi1qNE7Vv6QWj60WshXfVFpzAP86iowhQknaTsfhLH+7k+OEiFHQ
         HIDbzY4fr3FB5pNomH/QMszBG8vOl9G0YIULNPbZseUJicWUZkfH45XPqhCC5mrS411f
         e+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=w6mEqtJ4r74TnNlMvfbdu8cIIS/gk/ZwzqlOU40cLcI=;
        b=i3l1i6nQ3llaMuvcezI0+LU4lofeVGeCgKmLC5ZfZ2PBqozH3BJAaM5kqfqHu28YBq
         yPOitMwdYr97l/7jB+dKdv9su6ANnu9E0V3TfRUAjDfmnRy43irpi4UFvBtNqpXnJ+3U
         LYxI3G4gcls/lB/lYEQHvXBwSz1K1N3AxnCUv04FdUjkx8MIil5veQbc5u623sl5sz6V
         y7iDiSS/gE/NKCoZHWuY1PVn2a4J50BwWa7A5XLtd6joSKCq3hemFlMBjt/RXSsP5B34
         vOgeCdkNAbC302m8ybqnCi/UYgp8whQlOf1egTst4521DINaCHTkXg4ZVvtiyyRXWjSs
         buPw==
X-Gm-Message-State: AJIora+vGgGux5zZu8PkVnSMOg1tc+Ro8kwROLtigfUtyuHBPtonIbt8
        c+jqhythsWEURzC3cukea6M=
X-Google-Smtp-Source: AGRyM1vMQ3DAgxFkhCIcxZL1gvzuqNwRkvB4KnPM+GPQG7YK1lhJpUD9P+MxaOzfLYZ1FVgmhRljvw==
X-Received: by 2002:a05:651c:981:b0:253:b87e:ba6c with SMTP id b1-20020a05651c098100b00253b87eba6cmr5354225ljq.530.1655296875504;
        Wed, 15 Jun 2022 05:41:15 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id z7-20020a056512370700b00478ee6a58c1sm1792986lfr.172.2022.06.15.05.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 05:41:15 -0700 (PDT)
Subject: Re: [PATCH V4 0/8] virtio: Solution to restrict memory access under
 Xen using xen-grant DMA-mapping layer
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     xen-devel@lists.xenproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <1654197833-25362-1-git-send-email-olekstysh@gmail.com>
 <CAOh2x=kxpdisV+tqcYOoZGSKA8YjPMej+7u19Jpa1jmVcZCaxA@mail.gmail.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <52b1389b-348d-2433-f80c-fab22194dac2@gmail.com>
Date:   Wed, 15 Jun 2022 15:41:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOh2x=kxpdisV+tqcYOoZGSKA8YjPMej+7u19Jpa1jmVcZCaxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.06.22 09:23, Viresh Kumar wrote:
> Hi Oleksandr,


Hello Viresh


>
> On Mon, Jun 6, 2022 at 10:16 AM Oleksandr Tyshchenko
> <olekstysh@gmail.com> wrote:
>> The high level idea is to create new Xen’s grant table based DMA-mapping layer for the guest Linux whose main
>> purpose is to provide a special 64-bit DMA address which is formed by using the grant reference (for a page
>> to be shared with the backend) with offset and setting the highest address bit (this is for the backend to
>> be able to distinguish grant ref based DMA address from normal GPA). For this to work we need the ability
>> to allocate contiguous (consecutive) grant references for multi-page allocations. And the backend then needs
>> to offer VIRTIO_F_ACCESS_PLATFORM and VIRTIO_F_VERSION_1 feature bits (it must support virtio-mmio modern
>> transport for 64-bit addresses in the virtqueue).
> I was trying your series, from Linus's tree now and started seeing
> boot failures,
> failed to mount rootfs. And the reason probably is these messages:
>
> [ 1.222498] virtio_scsi virtio1: device must provide VIRTIO_F_ACCESS_PLATFORM
> [ 1.316334] virtio_net virtio0: device must provide VIRTIO_F_ACCESS_PLATFORM
>
> I understand from your email that the backends need to offer
> VIRTIO_F_ACCESS_PLATFORM flag now, but should this requirement be a
> bit soft ? I mean shouldn't we allow both types of backends to run with the same
> kernel, ones that offer this feature and others that don't ? The ones that don't
> offer the feature, should continue to work like they used to, i.e.
> without the restricted
> memory access feature.
> I am testing Xen currently with help of Qemu  over my x86 desktop and
> these backends
> (scsi and net) are part of QEMU itself I think, and I don't really
> want to go and make the
> change there.


Thank you for testing on x86.


I assume your guest type in HVM. Within current series the 
PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS is set for *all* type of Xen 
guests if CONFIG_XEN_VIRTIO is enabled.

I have to admit that from the very beginning it could be possible to 
configure for PV and HVM guests separately [1] because the usage of 
grant mappings for virtio is mandatory for paravirtualized guest, but 
not strictly necessary for the fully virtualized guests (if the backends 
are in Dom0). But it was decided to drop these extra options (including 
XEN_HVM_VIRTIO_GRANT) and leave only single one CONFIG_XEN_VIRTIO.

I see that Juergen has already pushed a fix.

Sorry for the inconvenience.



[1] 
https://lore.kernel.org/xen-devel/1649963973-22879-3-git-send-email-olekstysh@gmail.com/


>
> Thanks.
>
> --
> Viresh

-- 
Regards,

Oleksandr Tyshchenko

