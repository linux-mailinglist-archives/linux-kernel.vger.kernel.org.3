Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECC44E6CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 04:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356351AbiCYDHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 23:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354366AbiCYDHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10CCB393E9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648177530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1/M7/bmnByTWu65Mzim6SoRU2urxCvtovIoU38RgkU=;
        b=WpadKwdErklKri4AQp5ONhAUhJDJJYJC2GAVKhQLDgpa0K23NEeaKiXYVWwCcGdKqMCLuI
        u87Af/BEp7/SU4qfGhJKl9bhNuVHgozLd1L0DrTgHLNjP45azgbI51P/9Tb2hQ0ASw5dXt
        wcgxOAEx1ERl0iqU0pKBO8Nf+/BEvP8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-J3A3ZCkXNZOMeEUnvcZElQ-1; Thu, 24 Mar 2022 23:05:29 -0400
X-MC-Unique: J3A3ZCkXNZOMeEUnvcZElQ-1
Received: by mail-pl1-f198.google.com with SMTP id q11-20020a170902c9cb00b001546680ee18so3502889pld.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 20:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W1/M7/bmnByTWu65Mzim6SoRU2urxCvtovIoU38RgkU=;
        b=h03oIoxBMVL/qhjLAtOCF3DNMy7sI1D6jGx9rVgId4/gDIlPDJSq1YXNjledp+MjBl
         L9PZWSKfYDrtTV4snS9Gqe+WDjGlhQubTHYIqnVd5nwZQvNuGy4qVWnm3hVsVGK2MdCS
         ig3vQ/zBhhsTz7vSi9ZweYxLDnNv1I7z6X14TAElisPjgS8fWV82Asb7SL5mFRf+Lxun
         2DlbY+xVEMjIkr9BU6fBxmqoqAx5O+CpdMt/IZNn71BffZ+ia2Tk050rJHLA6rnLmoJh
         64PuM9coBv7a7rN1/QTF17NL+caRP8tp/+MLN1P310DcRw4TvH+sGFAB9Y2irUm/5uoF
         ib9g==
X-Gm-Message-State: AOAM533DLzZCMKCB8NH80YU8kTUpP/IQfl+rxYENJft65zqoZCtE7x83
        mme9tKbjS1CXEbW2PA6thbeC95aGW9yHfGPHafRF3RolQ1h81g5OB8suXwG238yvPvYbU+bG9Er
        8M+aMW4Zy6K5/KkCEYr77qtk/
X-Received: by 2002:a17:902:7797:b0:154:b6d:31f2 with SMTP id o23-20020a170902779700b001540b6d31f2mr9069821pll.39.1648177527693;
        Thu, 24 Mar 2022 20:05:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymmceXQlKogsbDkqxGa/+jhIE+qWfz707Sj9yP9hpf7xzOj6GOmmceC8wpdI7WERDceL9xUQ==
X-Received: by 2002:a17:902:7797:b0:154:b6d:31f2 with SMTP id o23-20020a170902779700b001540b6d31f2mr9069804pll.39.1648177527397;
        Thu, 24 Mar 2022 20:05:27 -0700 (PDT)
Received: from [10.72.13.249] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f14-20020a056a0022ce00b004fabe9fac23sm5163104pfj.151.2022.03.24.20.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 20:05:26 -0700 (PDT)
Message-ID: <81381018-9dcd-3fba-becf-183435a5bf6b@redhat.com>
Date:   Fri, 25 Mar 2022 11:05:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] virtio: use virtio_device_ready() in
 virtio_device_restore()
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, keirf@google.com
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-2-jasowang@redhat.com>
 <20220324064205-mutt-send-email-mst@kernel.org>
 <20220324110307.iizkdwuhc5c75noj@sgarzare-redhat>
 <20220324070612-mutt-send-email-mst@kernel.org>
 <20220324113126.f6f5hfabhqfyutix@sgarzare-redhat>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220324113126.f6f5hfabhqfyutix@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/3/24 下午7:31, Stefano Garzarella 写道:
> On Thu, Mar 24, 2022 at 07:07:09AM -0400, Michael S. Tsirkin wrote:
>> On Thu, Mar 24, 2022 at 12:03:07PM +0100, Stefano Garzarella wrote:
>>> On Thu, Mar 24, 2022 at 06:48:05AM -0400, Michael S. Tsirkin wrote:
>>> > On Thu, Mar 24, 2022 at 04:40:02PM +0800, Jason Wang wrote:
>>> > > From: Stefano Garzarella <sgarzare@redhat.com>
>>> > >
>>> > > This avoids setting DRIVER_OK twice for those drivers that call
>>> > > virtio_device_ready() in the .restore
>>> >
>>> > Is this trying to say it's faster?
>>>
>>> Nope, I mean, when I wrote the original version, I meant to do the same
>>> things that we do in virtio_dev_probe() where we called
>>> virtio_device_ready() which not only set the state, but also called
>>> .enable_cbs callback.
>>>
>>> Was this a side effect and maybe more compliant with the spec?
>>
>>
>> Sorry I don't understand the question. it says "avoids setting 
>> DRIVER_OK twice" -
>> why is that advantageous and worth calling out in the commit log?
>
> I just wanted to say that it seems strange to set DRIVER_OK twice if 
> we read the spec. I don't think it's wrong, but weird.
>
> Yes, maybe we should rewrite the commit message saying that we want to 
> use virtio_device_ready() everywhere to complete the setup before 
> setting DRIVER_OK so we can do all the necessary operations inside 
> (like in patch 3 or call enable_cbs).
>
> Jason rewrote the commit log, so I don't know if he agrees.
>
> Thanks,
> Stefano


I agree, I will tweak the log in V2.

Thanks


