Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0671E4EEBD5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345230AbiDAKwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345224AbiDAKwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 435564D603
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648810218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDDO4Z8byxB+Vv3MwlS6NmtsWgbDQ/bQgZ8uPefW6us=;
        b=Jn2SzCBX/0v9WQqVkVd/yh4Nz65Z0vPFYAZg8M3/krRW/F0Ohw8Nn9APol2+K9xpZd09DA
        zIJZCEKvhbPiy75XvPDhnYzieTQ0fKUj6isD18gixlbLnefVRpfDzIbFPiUfNEjZOh2Wjt
        6cVrRi9CTif9oB3kmQLB888HHI81j4Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-HccHol7lPk6TCB7ho3FKjQ-1; Fri, 01 Apr 2022 06:50:17 -0400
X-MC-Unique: HccHol7lPk6TCB7ho3FKjQ-1
Received: by mail-ed1-f71.google.com with SMTP id b24-20020a50e798000000b0041631767675so1287171edn.23
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 03:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gDDO4Z8byxB+Vv3MwlS6NmtsWgbDQ/bQgZ8uPefW6us=;
        b=SSPnS2P4cWECP4a67//DXBorNgqDYVfZYvegZMWHBSA3+Bj7ywXOf8rUhYdS6fDKve
         BmFftKkQsl5Qycr7kTb3bBNAP6TrV8Eb3lVbdnxpw+o8Vpm8CT41qR8ZLGmZjn2l65y8
         PIOfnWYdFdUQ6ABEPXWRDKm4B97oeBlvo8yMg/IOBdUwwQTHk8M2Pd8IcaByhIEIWaU1
         QnyMYQje88umaXUnZDg/ByDPLXmZSj0i296HQMlBkZtsAkMmwop3xg5fFjd7Cp5xyQJP
         lJwfQl8VM8gNOIpjGL7KWMkVBRQrjkIBOIHz4qlyIZBPXRNqPYppsIKVlnbHRnJ95gOU
         H5rQ==
X-Gm-Message-State: AOAM532ps1BUlwfKy2T/YyA/0lHPxNe+hdXxdjkhFP//0yRXmLTKkUeT
        paRbmbGAG+oO1zeLnZfagUppzHG62X1ioJ0pG4Ghh98zzuyVwWnbXxl3RB8GYBo9V+SKNE+cz5F
        Hr6D/ZsnNeFyJSV2ydTIbyt06
X-Received: by 2002:a50:9d49:0:b0:418:681b:f6d with SMTP id j9-20020a509d49000000b00418681b0f6dmr20467286edk.160.1648810216110;
        Fri, 01 Apr 2022 03:50:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhFlFkORi2fxrVhw0AlbjXBnfVihiFBGuQKhRIJf9d7DtE4HzdXknBigLBfoR6nADd+SUniw==
X-Received: by 2002:a50:9d49:0:b0:418:681b:f6d with SMTP id j9-20020a509d49000000b00418681b0f6dmr20467276edk.160.1648810215971;
        Fri, 01 Apr 2022 03:50:15 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id gb29-20020a170907961d00b006e00c7b0f5asm888182ejc.0.2022.04.01.03.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 03:50:15 -0700 (PDT)
Message-ID: <b4462338-7c38-032f-bcd2-2a50cffb15d5@redhat.com>
Date:   Fri, 1 Apr 2022 12:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/2] staging: rtl8723bs: remove some 5 GHz code
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220331214146.15161-1-straube.linux@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220331214146.15161-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/31/22 23:41, Michael Straube wrote:
> This two patches remove 5 GHz channels from the ch_freq_map array in
> rtw_rf.c and simplify the rtw_ch2freq() function.

Thanks, both patches look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans



> 
> Michael Straube (2):
>   staging: rtl8723bs: remove 5 GHz channels from ch_freq_map
>   staging: rtl8723bs: refactor rtw_ch2freq()
> 
>  drivers/staging/rtl8723bs/core/rtw_rf.c | 56 ++++++++-----------------
>  1 file changed, 18 insertions(+), 38 deletions(-)
> 

