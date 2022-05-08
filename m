Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2121B51ED77
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 14:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiEHMV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 08:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiEHMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09C15DFE
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652012282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ViPu7C63pGsgCXqS/hC6gxwkjSv/UDhqQYN0XBn3F4U=;
        b=QsttS4TnH0QrNp9lBToEUyvEcnu5DKlFULvNpdJl/S2Q2Em5/5D+E0scgaFfqakb6TCs2h
        +5gW/dE3UDYKn1kLXAQebq2efMK8Dvdeqify3yQlnvxKMRv9s691qr/E1yqBncgPlfXVYc
        wN8nwzqC2fpXGvA2k+896mv+Ya7MbSg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-zeDjObsKPHiAYyGwj5p9sg-1; Sun, 08 May 2022 08:18:01 -0400
X-MC-Unique: zeDjObsKPHiAYyGwj5p9sg-1
Received: by mail-qv1-f72.google.com with SMTP id fw9-20020a056214238900b0043522aa5b81so9674808qvb.21
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 05:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ViPu7C63pGsgCXqS/hC6gxwkjSv/UDhqQYN0XBn3F4U=;
        b=2focewBoqdLLDqlktFdAy49g/EIKb5TmdEQn8gI8GNWM9GZeKuk2Klt1f0SpCbcpiw
         CYYD9QYsTYesT/utnA2kWA8D79r7OGLmCehRBlRCWHzS5Umi1WwUPv/uHlx4GMj6nYLL
         oJ2gpGOTNxgRw+ultD/X/YzsExDdWjGPryrq0dhLqyTkC8VFjOOKOFir8JDs/A/8S+em
         ZhRTPtc7oreDD6lox8gfd/K6vwrING2dLXhlBaGUryAEdV7M4kzbw2pwCQMnMCsyeu13
         vGrJ47EOrnJlqWKXK6CXAP4/CqeMPWUHue1/JlpXaI1AL/5BtnZp4qQwa6AWv1cnmz2u
         TmqQ==
X-Gm-Message-State: AOAM530apvbcJjWfmfrBeCLkU6RuO+vnA2dN7Tu8rUCK1Ca0DTYSa16e
        20SnWlA4PY7CvCQahx3d22YBIBLx+AH6RlBR1z6tecotBOwsy+Zemc31uZCke3uCKwJdT7GTUfv
        ENh54aU036kA2tJ9T/DRU3VQY
X-Received: by 2002:a05:620a:4403:b0:6a0:5093:1742 with SMTP id v3-20020a05620a440300b006a050931742mr6090357qkp.691.1652012280975;
        Sun, 08 May 2022 05:18:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrSXVGMAErTCjyQ6DWWAm4LmtZ/sYouQE9alkl/0ZG+uocKKlzjN9i5/phkR2fAZmCw3HoQg==
X-Received: by 2002:a05:620a:4403:b0:6a0:5093:1742 with SMTP id v3-20020a05620a440300b006a050931742mr6090344qkp.691.1652012280768;
        Sun, 08 May 2022 05:18:00 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87148000000b002f39b99f68csm5981079qtp.38.2022.05.08.05.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 05:18:00 -0700 (PDT)
Subject: Re: uninitialized variables bugs
To:     Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, kbuild@lists.01.org, lkp@intel.com,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
References: <20220506091338.GE4031@kadam>
 <YnWYHzQC4Y55sOsT@dev-arch.thelio-3990X>
From:   Tom Rix <trix@redhat.com>
Message-ID: <53237fa6-3d32-4f92-c7ea-9dd8bc12e028@redhat.com>
Date:   Sun, 8 May 2022 05:17:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YnWYHzQC4Y55sOsT@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/6/22 2:50 PM, Nathan Chancellor wrote:
> Hi Dan,
>
> On Fri, May 06, 2022 at 12:13:38PM +0300, Dan Carpenter wrote:
>> Ever since commit 78a5255ffb6a ("Stop the ad-hoc games with
>> -Wno-maybe-initialized"), GCC's uninitialized variable warnings have
>> been disabled by default.  Now, you have to turn on W=1 or W=2 to see
>> the warnings which nobody except Arnd does.
...
> Clang's static analyzer, which Tom regularly runs, will check variables
> across function boundaries. I am not sure what the false positive rate
> on that check is but it does turn up issues like smatch does.

Clang's static analyzer is pretty go wrt uninitialized variables.

But the issues do not turn up in the report, the show up as errors and 
is why

I post a fix for a build break every couple of weeks.

Tom


