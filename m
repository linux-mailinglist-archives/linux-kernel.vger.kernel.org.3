Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A319C5750C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbiGNO2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbiGNO1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2989E60535
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657808865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cz78mnFjzIkSh4ecW8yoUSs4S/2YW/7nJ4PcfLl3hvM=;
        b=BEDpV1z6KFW8/vajqnCQ10t1zn3eK5l90MkL+SMBDgom0p7NQTJo85oOudVt0Tz8ApfXLx
        oNDEZRi6F4IaDpk/TZHSf01EOpcivCPtgBOr8XewZip/2Jieyq4iKuGLjzwJ8vrEpMuEKo
        nHXxspQpBuEB0y8SWUCqssYfakw0p9w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-PnZMtEVFPCyHaey62Ed63Q-1; Thu, 14 Jul 2022 10:27:44 -0400
X-MC-Unique: PnZMtEVFPCyHaey62Ed63Q-1
Received: by mail-ed1-f71.google.com with SMTP id w13-20020a05640234cd00b0043a991fb3f3so1627509edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Cz78mnFjzIkSh4ecW8yoUSs4S/2YW/7nJ4PcfLl3hvM=;
        b=2bN8HsQK2T7OPSX/E7laj0WvsbKobmLXNz8gkJ7/IvnrQUuEiLX5tp8UbQf/cEbyLR
         GqnRINeGp/EayWG6KhIfBo9dUouqFiACRdabIlVdRDM0qUo9ixsH/oPJLsHnlFbrUfTx
         PkEzqNcmCvy9ypjXTpnpZJmTm76GAn0JQ4NZh02chEK+8xiDRT54lWtbxsyJ4CF69Hrr
         FAlcwhEBTfmKHZ6IlJWakPv62htLRRBBgTaihvlRP0CBEHhl78XQMBzqJ6GmqVFRYxBZ
         6tVJz3aZFI+IriZJcAX5KsRBtq6NeF3+opab3Kon+L3JoNMOpGsxvldbh4CvtfkzSBKo
         i5xg==
X-Gm-Message-State: AJIora8+CTCPayZ4ucQVMDgwKzxOcIBweblLE51073aOVFSvg820q9d1
        4NkYmUUaXA+BR8lva1ztWVJ4FhfR0JmyGYsQEOQvSB04PVURvK0c/5F7MHL78/RpyZLvH+x+RBx
        +zPs2Rta7521msgbg7us4yNB8
X-Received: by 2002:a17:907:2cf3:b0:72b:8ac1:a21f with SMTP id hz19-20020a1709072cf300b0072b8ac1a21fmr9109476ejc.291.1657808862482;
        Thu, 14 Jul 2022 07:27:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ty1LxlwMQaUDqd/kUFFh9O52BvtcEFAZw91orw4ZJDpuPzqfnnK+7eTtgC1obuOdRb2F/3KQ==
X-Received: by 2002:a17:907:2cf3:b0:72b:8ac1:a21f with SMTP id hz19-20020a1709072cf300b0072b8ac1a21fmr9109462ejc.291.1657808862329;
        Thu, 14 Jul 2022 07:27:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b40:2ee8:642:1aff:fe31:a15c? ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id e2-20020a50fb82000000b0042bdb6a3602sm1084721edq.69.2022.07.14.07.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 07:27:41 -0700 (PDT)
Message-ID: <dda65c68-cea4-4323-b061-8fc2048bd604@redhat.com>
Date:   Thu, 14 Jul 2022 16:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] drm/vc4: use drm managed resources
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org, emma@anholt.net,
        linux-kernel@vger.kernel.org
References: <20220713085500.1970589-1-dakr@redhat.com>
 <20220713091049.qy4t3j3hh5jgtqum@houat>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20220713091049.qy4t3j3hh5jgtqum@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 7/13/22 11:10, Maxime Ripard wrote:
> Hi Danilo,
> 
> On Wed, Jul 13, 2022 at 10:54:57AM +0200, Danilo Krummrich wrote:
>> This patch series converts DRM modeset object allocations from devm_*()
>> to drmm_*() memory allocators, or their corresponding convenience
>> wrappers, respectively, in order to tie the release action to the
>> underlaying struct drm_device.
>>
>> This can prevent potential use-after free issues on driver unload or
>> EPROBE_DEFERRED backoff.
> 
> Yeah, the driver had a lot of this kind of issues.
> 
> As it turns out, at the moment you sent it, I was applying a larger
> series (hopefully) addressing all of them:
> https://lore.kernel.org/all/20220711173939.1132294-1-maxime@cerno.tech/
Ah, great! That's covering even more than the series I sent.
> 
> Maxime

- Danilo

