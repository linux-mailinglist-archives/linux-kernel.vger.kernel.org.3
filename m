Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4604A57463A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiGNHzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiGNHzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E22665E0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657785347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SE9eAN5X+ShMxtdmF41zDz1yLtEpxxR36zmsks8hPS0=;
        b=e3hSQtDdEYakwMVeshl1oq7u9c1+YeseSHqIq2SQ9IAS+jvbRXAdO9SehU7I9K1uwcKb+a
        5bVxT0mfqx1fyfjSsRGnovb9VBmSm52mep0GTGj8G+nvMSQ76/7NW8ywbHRA25iy9FojrC
        FOHkTqtuBuODkAIKOS1/X8Uu92OZlWw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-l0eVmmN9N9qwUv2KQp5aGA-1; Thu, 14 Jul 2022 03:55:45 -0400
X-MC-Unique: l0eVmmN9N9qwUv2KQp5aGA-1
Received: by mail-ed1-f72.google.com with SMTP id b15-20020a056402278f00b0043acaf76f8dso974327ede.21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SE9eAN5X+ShMxtdmF41zDz1yLtEpxxR36zmsks8hPS0=;
        b=Q5AB1zkR04mf6La8s3l6cdiu2nh/bJ0DZDHSAZlVay/yaPGKDrMgJti0B+QVE4Y55b
         P+KnFh2gvqEBikV7pZQsMVoxgEbqdhOJcOy9/wEfFoZvxmeCSsfLDNOCG30TdhT/+D3L
         p8GHT+JSUNXyIHIa0XHoFY8MDYS0Y8QSibcJjCFTV8lrqqjIxBjKAOLeGNp3/zRAkfZY
         /8S5UFq9GKIg1f2K08RavWQml3Hds4rOjU90+3IBhPbC9JOj36WzHYCOBSXE5JNJWMzi
         9dmBvShFGadDEz3966w771ngoIIkoPyRcsCa094nBkC0blCRobCNMwqzDdf3TKOZDw/L
         yAMQ==
X-Gm-Message-State: AJIora/tLfIaj8EmlKtMyhO06gFP8XakjBcxWE34X3hPPluAhWWplXkv
        60JAff9RE6wmmeK89maQlLsMKACrwcXFy3kEdxgcp2EFM/NJnYQ/FGJuLrsbhA/ugHS9V16176W
        ZwYOWDfNb4kn/0hWsAzShKk2T
X-Received: by 2002:a05:6402:34c1:b0:43a:bd7a:898a with SMTP id w1-20020a05640234c100b0043abd7a898amr10764883edc.426.1657785344691;
        Thu, 14 Jul 2022 00:55:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1um/IMU8CKiTuPcepZAnSTRYoRBRZ2ZH0kI9/eLTdxlSioknmf1mGAkVR3V+y/TA4I2nzD2xg==
X-Received: by 2002:a05:6402:34c1:b0:43a:bd7a:898a with SMTP id w1-20020a05640234c100b0043abd7a898amr10764856edc.426.1657785344487;
        Thu, 14 Jul 2022 00:55:44 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id kv10-20020a17090778ca00b0072eddc468absm385354ejc.134.2022.07.14.00.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 00:55:43 -0700 (PDT)
Message-ID: <52ef13d4-068d-bd2c-11aa-c7053798aee9@redhat.com>
Date:   Thu, 14 Jul 2022 09:55:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/9] KVM: x86/MMU: Optimize disabling dirty logging
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
References: <20220321224358.1305530-1-bgardon@google.com>
 <dba0ecc8-90ae-975f-7a27-3049d6951ba0@redhat.com>
 <YszQcBy1RwGmkkht@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YszQcBy1RwGmkkht@google.com>
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

On 7/12/22 03:37, Sean Christopherson wrote:
> This fell through the cracks.  Ben is on a long vacation, I'll find my copy of
> the Necronomicon and do a bit of resurrection, and address the feedback from v2
> along the way.

This was superseded by the simple patch to zap only the leaves I think?

Paolo

