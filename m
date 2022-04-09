Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F74FA969
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 18:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242556AbiDIQFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 12:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiDIQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 12:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E61062C1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649520225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtkyBcEIcgGitzE6/jMR0BHvrVCs5FpvV9wdXJQk7lw=;
        b=ZMW9WlxGWd4k7ey9jSAoBlvshyUGNQvSRCLhalxJdXUcuSwdZoh9zXyyjJCIvF/o2oZ1NA
        rwmcicg/LoG+EXit133fpNFIbkc7I5c6ZP6FFWt87VIXrj30dHtX3NJvuvwKt9pnQsNsNy
        f2CpLQAsjREqOujo/jgEQSx1fyff1VE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-9sYKpmZzPX-xoez5MAYKEA-1; Sat, 09 Apr 2022 12:03:44 -0400
X-MC-Unique: 9sYKpmZzPX-xoez5MAYKEA-1
Received: by mail-qt1-f198.google.com with SMTP id v14-20020ac8748e000000b002ed0d38283aso2698296qtq.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 09:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qtkyBcEIcgGitzE6/jMR0BHvrVCs5FpvV9wdXJQk7lw=;
        b=ELZbiPw+GBf4Kixppvjll+Mrzg9yIQm0q0Ln/QXl+GwX3nhrOA/0I0gSCF8aZ2zmUO
         IwWsczMoJVlJ9/HxVQ9viA1bNrVsHfBNvpenxtF7s/7qFKp/IaJ/0JXn9xXMhWYZVqEr
         NKSDMsD5EOwcPiuxEQvfkw6QDy/NZM+7n7lc1BIiWkBmH+k8asS3Xbs8/Jo1i6rJnUqj
         J9Sim7kcuLBu7ti9VQbpMDQQ23tByKCTvQoRWQtGx3emhjQHRU+Sy942oibakA8XD8D2
         Q3fWtTFoPIco79DpLU3YldTz94fsrUwtUOmxady7/zujOtOxAvNMXlGvhAm5j9qkhDNi
         p+Mg==
X-Gm-Message-State: AOAM530KoeOP/EofNDmznQ8/FbneI/NKUrIRmvDytYZ+03qyuKvTu+Da
        OUUwFmpte4F+o4COJLOLwFZjAPicgJqL4ar59HRn1VgaRRGdKqM+DQs7Xy8yYSsVfRYXwFtcRkE
        DKdoD3K9aao0ukSzjUpuNimVF
X-Received: by 2002:a05:620a:4694:b0:67e:ca07:4d46 with SMTP id bq20-20020a05620a469400b0067eca074d46mr16310332qkb.624.1649520223783;
        Sat, 09 Apr 2022 09:03:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9gLy9N+EtbprXxWppsB8/pZMfaSy4i+GT0eKsrmpJpPW6wWHSwAV/TaLkqZlqoRiGySXFDw==
X-Received: by 2002:a05:620a:4694:b0:67e:ca07:4d46 with SMTP id bq20-20020a05620a469400b0067eca074d46mr16310304qkb.624.1649520223470;
        Sat, 09 Apr 2022 09:03:43 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id o6-20020a05620a22c600b0067d247816eesm15150840qki.85.2022.04.09.09.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 09:03:43 -0700 (PDT)
Subject: Re: [PATCH] block: Remove redundant assignments
To:     Michal Orzel <michalorzel.eng@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, llvm@lists.linux.dev
References: <20220409101933.207157-1-michalorzel.eng@gmail.com>
 <20220409101933.207157-2-michalorzel.eng@gmail.com>
 <a56d1184-d399-d5f8-765f-5a4f35dacd5e@redhat.com>
 <446a3e88-4c14-300d-862a-1279274c3760@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c2c40f00-777c-f19a-eb5f-6e978ddd6bcf@redhat.com>
Date:   Sat, 9 Apr 2022 09:03:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <446a3e88-4c14-300d-862a-1279274c3760@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/9/22 6:20 AM, Michal Orzel wrote:
> Hi Tom,
>
>> On 4/9/22 3:19 AM, Michal Orzel wrote:
>>> Get rid of redundant assignments which end up in values not being
>>> read either because they are overwritten or the function ends.
>> This log is the same as your last patch.
>>
>> Instead of a general statement on deadstores, a more specific
>>
>> analysis of the setting being removed would be helpful.
>>
>> This will mean splitting the patch to match the analysis.
>>
>> Tom
>>
> I think that this explanation in a commit is enough for such a trivial patch.
> It informs that we are fixing clang-tidy findings related to deadstores
> in a block subsystem. What analysis would you want to see?
> Something like "Remove deadstore assignment ret = -EINVAL  in a function bio_map_user_iov" ?
> I think that it will create too much of not needed overhead.

The compiler should remove these already.  All of the static analyzers 
produce false positives, if you do not provide analysis the reviewer has 
to assume you have not done any and has to do the false positive 
analysis themselves. This burdens the reviewer for something of small 
value that can be dismissed as churn.

Tom

>
> Cheers,
> Michal
>

