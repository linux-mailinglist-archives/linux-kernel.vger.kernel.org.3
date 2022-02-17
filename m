Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414224B9A22
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiBQHvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:51:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiBQHva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:51:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B97172A39DC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645084275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6avVhvuh+LQ6yXDGvdg58X8YQ+KJW2Yn+eyoEh3r/+I=;
        b=PhNlYT1zWdMeG8B9iUA4prJCotMBRiDd5wMZFssgvEM/EJJdG17NWkaND+CKoy2Tm3GxSq
        YeUX+neH0XSpYe5nk5LucvrqRSDFBXX4lUmdGdSAMBU2nKdC6cKuSi0Q7fUSQW0Zr0hqcX
        GiuEEAMddTQHW0vJwkGDkv5HDlE/pfk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-h9fK78wSM8GogHcAuVlYXg-1; Thu, 17 Feb 2022 02:51:14 -0500
X-MC-Unique: h9fK78wSM8GogHcAuVlYXg-1
Received: by mail-wm1-f69.google.com with SMTP id g22-20020a1c4e16000000b0037bc7a977b3so936454wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 23:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=6avVhvuh+LQ6yXDGvdg58X8YQ+KJW2Yn+eyoEh3r/+I=;
        b=wcRLNId7sUxBbhzu0aRsRPJlKAlLX0dIAH2lqUDmFO6zDN2bhhxPiMSzOsnBuKn7wv
         V7y49N7UKtJh5FNluPCz2b3TLXwLoRhzDkCiLORZIKceg8Dt3r9BSoW/dexH0+4F6fVW
         XTuxDEcUWxx45ooIt71ISXDJK5RcdO2op2aSY4KJRVwHZXymKtw+WQQfd+RkDWuRLFNo
         U06waW4tmBPHhka16pqCcP3isvE2cHTdI4gyIg3LrEJrB/+MiMi89xwGMajGEQhodl3d
         7IzS9/XpwBEubdSf2OEyCNmcmbLO+Ukkhe3lmxXCwDWg6KGVCnR7tXaW+gPXICm0Qu1J
         /qdQ==
X-Gm-Message-State: AOAM530z2bbLPVzZzy9Fj6sR2RaVDeiN1wmvT25gru6CEyablW67AcGX
        LDmXkTtnufxU9jo34QQxkzlVUueuHS8+dOhgaCQ+3OMRN3DSPF3uhG9jn7DUukMlr9KH0z3O0lg
        laT2MWpfAOOfnhnqjKKGIQV/z
X-Received: by 2002:a05:600c:4f90:b0:350:d962:8944 with SMTP id n16-20020a05600c4f9000b00350d9628944mr1471214wmq.48.1645084272931;
        Wed, 16 Feb 2022 23:51:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy93ucXgz+LliTZpttm5E4CBWy4N18iehcOCxu0y01PmNrQ++eENYAkFnLkfJQ2n6ufX2ApsA==
X-Received: by 2002:a05:600c:4f90:b0:350:d962:8944 with SMTP id n16-20020a05600c4f9000b00350d9628944mr1471192wmq.48.1645084272677;
        Wed, 16 Feb 2022 23:51:12 -0800 (PST)
Received: from ?IPV6:2003:cb:c711:b800:254c:2d22:aab2:20a? (p200300cbc711b800254c2d22aab2020a.dip0.t-ipconnect.de. [2003:cb:c711:b800:254c:2d22:aab2:20a])
        by smtp.gmail.com with ESMTPSA id h11sm20171914wrr.64.2022.02.16.23.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 23:51:12 -0800 (PST)
Message-ID: <d29fd91b-2043-0880-17ab-0ef7ec14bf62@redhat.com>
Date:   Thu, 17 Feb 2022 08:51:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm: fix dereference a null pointer in
 migrate[_huge]_page_move_mapping()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        liqiong <liqiong@nfschina.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20220217063808.42018-1-liqiong@nfschina.com>
 <Yg35UXjB7RpqVCOI@kroah.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Yg35UXjB7RpqVCOI@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.22 08:29, Greg KH wrote:
> On Thu, Feb 17, 2022 at 02:38:08PM +0800, liqiong wrote:
>> Upstream has no this bug.
> 
> What do you mean by this?
> 
> confused,

Dito. If this is fixed upstream and broken in stable kernels, we'd want
either a backport of the relevant upstream fix, or if too complicated, a
stable-only fix.


-- 
Thanks,

David / dhildenb

