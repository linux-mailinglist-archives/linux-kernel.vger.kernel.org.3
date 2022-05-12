Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5E8524E23
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354318AbiELNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354183AbiELNWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AC8D3ED02
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652361741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGoOIUCJGa4SaOfudTG7yQQEUS0BOq99bUpZYAujLo0=;
        b=WOjP8MdPqu3LOsfahT82zc8xugEfFIT7nCLCVDa+gNXt75X+itV3ea4MPbXhUbiGFqNn1R
        gopb+V303EGReu1GRKgJA866a/gKyvlz3Iaduty4afXgHptcI2kUeRUl/c+y6typ1h2tzH
        ac7lB01acVU5UNs6HuDLMrlR6EY+rR8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-WekY_2JtPQqXmPlTwEXIhw-1; Thu, 12 May 2022 09:22:20 -0400
X-MC-Unique: WekY_2JtPQqXmPlTwEXIhw-1
Received: by mail-wm1-f70.google.com with SMTP id s14-20020a05600c29ce00b00394611a8059so4389483wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=iGoOIUCJGa4SaOfudTG7yQQEUS0BOq99bUpZYAujLo0=;
        b=XpjGJ53Q4ANMpLi4ysQPkYpinj2UvyMbmLZ2tIkE9cl3l9LcRCWJYSjNBqtfg8M/9E
         QwxLDE2RKIM4z2LnP7Die9SSTdfPOsKahaVOUoXZlKa8B0KVm47z5udAta9FhUK1Uu0p
         u5C6gpk30ugWF1oaBpEo3ijCOqdYx7wJ/pOkQoknzk7IE6LWiydlw17YPCGfVZ2pqEVb
         5+0TTYiHoXRW7+N8viWvwix37EvmOxTyrFN7UCmTaNV+YZ++JKB70HtNXnUUNGf89Vq0
         q9Wyrn/MihHTiMpUL5pypnnyvIOcxIs38rWeNc3+Wcw9CAAM6yg6guFJ4azLFT6Lki/q
         2Ksg==
X-Gm-Message-State: AOAM532AIFPiCzwXtcYkFRvJnpU1kvRo1V4UTAY4AsQDTSuZIgA0jVae
        1wbrBEsSIEQqCN1hgM9RBHYsCVvKLWVAVY2fI5B0dsLtq0hjZqkfJBmcjgWH80f3gC8Ytvvueyb
        kcIIi+edO3m8XAru2TFUEC4kh
X-Received: by 2002:a5d:5746:0:b0:20c:dbc2:397d with SMTP id q6-20020a5d5746000000b0020cdbc2397dmr7981055wrw.658.1652361739079;
        Thu, 12 May 2022 06:22:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+hXYu6vzpLOJq39B+H7C8rDVvQP/gQANCQfbt9DiMWxcg2qD5+fl3H5Fdy+4EFw8qj6gfWw==
X-Received: by 2002:a5d:5746:0:b0:20c:dbc2:397d with SMTP id q6-20020a5d5746000000b0020cdbc2397dmr7981034wrw.658.1652361738823;
        Thu, 12 May 2022 06:22:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id o11-20020a5d408b000000b0020c9520a940sm4946313wrp.54.2022.05.12.06.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:22:18 -0700 (PDT)
Message-ID: <77f6f5e7-5945-c478-0e41-affed62252eb@redhat.com>
Date:   Thu, 12 May 2022 15:22:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20220512131019.2594948-1-scgl@linux.ibm.com>
 <20220512131019.2594948-2-scgl@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 1/2] KVM: s390: Don't indicate suppression on dirtying,
 failing memop
In-Reply-To: <20220512131019.2594948-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.05.22 15:10, Janis Schoetterl-Glausch wrote:
> If user space uses a memop to emulate an instruction and that
> memop fails, the execution of the instruction ends.
> Instruction execution can end in different ways, one of which is
> suppression, which requires that the instruction execute like a no-op.
> A writing memop that spans multiple pages and fails due to key
> protection may have modified guest memory, as a result, the likely
> correct ending is termination. Therefore, do not indicate a
> suppressing instruction ending in this case.

I think that is possibly problematic handling.

In TCG we stumbled in similar issues in the past for MVC when crossing
page boundaries. Failing after modifying the first page already
seriously broke some user space, because the guest would retry the
instruction after fixing up the fault reason on the second page: if
source and destination operands overlap, you'll be in trouble because
the input parameters already changed.

For this reason, in TCG we make sure that all accesses are valid before
starting modifications.

See target/s390x/tcg/mem_helper.c:do_helper_mvc with access_prepare()
and friends as an example.

Now, I don't know how to tackle that for KVM, I just wanted to raise
awareness that injecting an interrupt after modifying page content is
possible dodgy and dangerous.

-- 
Thanks,

David / dhildenb

