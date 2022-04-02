Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241084F00C6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354472AbiDBKtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354470AbiDBKtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 757EB124C0D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648896467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G63buSfDCPc5qndai6dQxFulpyAndQa2gEdrpbrlGnA=;
        b=Davj8w5YhH8A6T6WE0pCFo4HdOS8C7u1YwTBtynZBj8tQAugCIg8BzQF4fxUHCn9wnbVCi
        GtHcQghjPxe3yyjEv5RyNYwtDcZ56psOd4Tuz44ORWhCdvjwftpmq8uB7NkhcednbeHbnZ
        v16o8ecPnMcKmXpjggfxWMxQ/conb3w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-D6-0_Y5_MV2us5llFNHEHw-1; Sat, 02 Apr 2022 06:47:46 -0400
X-MC-Unique: D6-0_Y5_MV2us5llFNHEHw-1
Received: by mail-ej1-f69.google.com with SMTP id de52-20020a1709069bf400b006dffb966922so2714452ejc.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G63buSfDCPc5qndai6dQxFulpyAndQa2gEdrpbrlGnA=;
        b=Icr8DtU6EIZtuBz1rtcH4PDWrB/AwQqaF7u63mV1td369266kwO77Lh/1wkvP1cWfy
         H/03ZQtuaeAMzcAfzVMWZaMqMweTQr7oS+tKVu3WfLK/omRF3E4zEsAd1wXaHyV1ZVw6
         O5Oc6p1u0iKvbL/bpGpS7yRYo8E4jiYiFogrn86SRoDRCPbnZsLxn3Y00C33D2Eaa/V9
         SUK0wZR6Y9tj0sOs5qg3NnwSoUQ0oLUUdT1z86peeW22er2e8ovbyOkzVDwkFhfa9+J9
         RI5LMLWeV3idQwab4vj4/MjoW5xvEPxygdtDK2CV4XoTmLPkfEAgqh2B6H9+uevtP534
         +vVQ==
X-Gm-Message-State: AOAM532vKU8wNRMAVpyzeJP6mbvz9gzMgZmZ42pgz25UhaHmMvXS2+U6
        W7Rv0iYOR9MT4aJTaCu3SpPpJYdnez0/J54RE7u7P0Wnc/9gG3xZK/HdU71qSsSQoUoPeId3vKJ
        LuBWlkTP2ytaNpgjma4USufC2
X-Received: by 2002:a17:907:971c:b0:6e0:d0ef:393e with SMTP id jg28-20020a170907971c00b006e0d0ef393emr3349743ejc.562.1648896465101;
        Sat, 02 Apr 2022 03:47:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrP2K/IEgYHF4LgPlaIoXpl60puqxMAxjpSVRK7WgDbLyj1jOc6xFdNlRwY96jfmdVm1C3IQ==
X-Received: by 2002:a17:907:971c:b0:6e0:d0ef:393e with SMTP id jg28-20020a170907971c00b006e0d0ef393emr3349734ejc.562.1648896464862;
        Sat, 02 Apr 2022 03:47:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id qk32-20020a1709077fa000b006df6bb30b28sm1966976ejc.171.2022.04.02.03.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 03:47:44 -0700 (PDT)
Message-ID: <8a430ab7-024f-51a9-d785-07e03f163261@redhat.com>
Date:   Sat, 2 Apr 2022 12:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5] input/i8042: Rework quirk tables
Content-Language: en-US
To:     Werner Sembach <wse@tuxedocomputers.com>,
        dmitry.torokhov@gmail.com, tiwai@suse.de, mpdesouza@suse.com,
        arnd@arndb.de, samuel@cavoj.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220329143622.31394-1-wse@tuxedocomputers.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220329143622.31394-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/29/22 16:36, Werner Sembach wrote:
> Revision 5 with some fixes based on feedback by Hans de Goede.
> 
> The 1st patch is minor housekeeping.
> 
> The 2nd patch merges the tables together. Minor fixes in 5th revision and
> no more duplication of ASUS devices
> 
> The 3rd patch add optional debug output to see which quirks get applied. In
> 5th revision this no longer breaks compilation on non x86 platforms.
> 
> The 4th patch adds a list of Clevo devices that need multiple quirks.
> With the reworked table they don't need to be inserted multiple times now,
> which was required in v1 and v2 of this patch.
> 
> I also included the extra quirk for the Clevo NS7xMU, which was a separate
> patch before.
> 
> The added Clevo devices are now only identified by their board name as this
> is the only somewhat reliable string that might not be changed by resellers.

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans



p.s.

In the future if you get a Reviewed-by to a previous version of a patch
and the patch does not change (or does not change much, e.g. only
small code-style / comment typo tweaks) you can keep that Reviewed-by
for next versions of the patch, just copy it over to your commit
msg and put it directly above your own S-o-b line.


