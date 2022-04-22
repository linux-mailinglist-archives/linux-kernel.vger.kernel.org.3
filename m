Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F8950BBBD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449469AbiDVPfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385481AbiDVPff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91A3E5D1B4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650641561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+o3QI2qLDiKgmdGnQtt8Rgfs8/7qkV8vtGRNkkMknPA=;
        b=MFz6kixn944XwDDgqIqNHIlF64t0EDflp+ANaHBLMQatNv2rHjwUw98IKSfcqx8cnDNcU3
        +SDJKFvl0I77cMntjb5j/43uqAtnKoVdn3aR25hVzR6r1GxSBRPIlhBjvyOpD8f/eF7uc9
        oBzVBKBeESurfv7TkptZNv9fUOpoILQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-29MUbUyqOYOEB2-K-fcdJg-1; Fri, 22 Apr 2022 11:32:39 -0400
X-MC-Unique: 29MUbUyqOYOEB2-K-fcdJg-1
Received: by mail-qt1-f198.google.com with SMTP id w18-20020ac857d2000000b002f1fa23a40eso5230468qta.14
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+o3QI2qLDiKgmdGnQtt8Rgfs8/7qkV8vtGRNkkMknPA=;
        b=mBTaRMfyAq/Jbf87/6GepRrl8t9PWcXEx/yWOpGvKP6m4N7EqOyzSN7vW9Z8CiP+lM
         rXj+DoVW1YcDl7Z3Hm7mzXW81H5Vjmznz2OWfYdD8h/V7TttR7EpFtNk+SaN4fFJ2wPU
         7J7Jy1kht1CjWxq0shnkYxWDNPhtU2Z9myYFTn2G/DEqBNaSxIkA+xHW03UyCyo6cJCf
         hOwNJRAUO1LMJMdLVenpfnW4+gPoDfmNN7B3glOUEk5tmGjxPmaHV6dMIb/PEgksGeNq
         5tPX8COm7KnSwX0JIKumFwuU1OKiIbubbQAHOFcOc5YGahitKzM6gLOROI/GO9wtwFD/
         RgqA==
X-Gm-Message-State: AOAM530jvX7gNGN45HLXxSLOlbGsYePJW/EtAlZ548dcWRkfpR3A3GNu
        bK0jD9koSvh/7JYWZOx4ZhxFdms8Cm/vgykfDw4JvaQDaNIuVTX3e7EXaY8C6ddjtIimmveCpVx
        deduHXGnA5hQPL1s/oUEczTVImCdqm3r+sc4psMQ1x+Ji5zWX0iSFnTeOpOKRChOSONw4U44=
X-Received: by 2002:a37:8d44:0:b0:69a:224a:dc27 with SMTP id p65-20020a378d44000000b0069a224adc27mr2989685qkd.563.1650641559145;
        Fri, 22 Apr 2022 08:32:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyw3Fqo3Nt15GFg/eHVhsKryB84/WiPdXDZP8hr3iO7fiPjDzNqt+7pAsJpGw+YTIzbAezHA==
X-Received: by 2002:a37:8d44:0:b0:69a:224a:dc27 with SMTP id p65-20020a378d44000000b0069a224adc27mr2989647qkd.563.1650641558767;
        Fri, 22 Apr 2022 08:32:38 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a188300b002f201623acasm1364883qtc.50.2022.04.22.08.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 08:32:38 -0700 (PDT)
Subject: Re: [PATCH] staging: vchiq_arm: change vchiq_platform_init from
 global to static
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        gregkh@linuxfoundation.org, stefan.wahren@i2se.com,
        gascoar@gmail.com, ojaswin98@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220418164356.3532969-1-trix@redhat.com>
 <20220422144423.GI2462@kadam>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4594e273-caae-686c-4a4e-875a7bd70e0c@redhat.com>
Date:   Fri, 22 Apr 2022 08:32:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220422144423.GI2462@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/22/22 7:44 AM, Dan Carpenter wrote:
> On Mon, Apr 18, 2022 at 12:43:56PM -0400, Tom Rix wrote:
>> Smatch reports this issue
>> vchiq_arm.c:466:5: warning: symbol 'vchiq_platform_init'
>>    was not declared. Should it be static?
> This is a Sparse warning, not Smatch.

Yes, this is correct.

Though I am using

make CC=cgcc

And forgot which one I had installed last.

Tom

>
> Use this command for Smatch
> ~/smatch/smatch_scripts/kchecker drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>
> And this command for Sparse
> ~/smatch/smatch_scripts/kchecker --sparse drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>
> regards,
> dan carpenter
>

