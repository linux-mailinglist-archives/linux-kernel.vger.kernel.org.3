Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C592514D99
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377703AbiD2OnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377723AbiD2Om7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA66340A24
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651243066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AT1MEacTTcApPp8iHqUgp1S5RGZuSM7hNEU97RzSbaU=;
        b=QRCFKr6qL7zGM1fdXyx6xRkTfIqJJE0RQXBjM0ARc6FV6RneWn7LkB2o3MZNlJ49o02svM
        guYVCEnzqTH9rphdzJvg+PE320QjH2+vVAe345pAYDMJPhfb0bX6ZM+cKMyUXCGXLhyH1J
        Wkl1J021lLFLSoLdSSX74yOaRMvnU8w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-kGU7vq3hOHKfv3DeXNjPxA-1; Fri, 29 Apr 2022 10:37:45 -0400
X-MC-Unique: kGU7vq3hOHKfv3DeXNjPxA-1
Received: by mail-ed1-f69.google.com with SMTP id c23-20020a50d657000000b00425d5162a0dso4629932edj.16
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AT1MEacTTcApPp8iHqUgp1S5RGZuSM7hNEU97RzSbaU=;
        b=NuU2YlEuG84NYK1pGsPFJh5XanUlKF/QVnvaJOZ3GA5wKKcMo0z1WdEM8sJ8btSkhD
         jJ3YfVxYTH2mrjR5+u9fEYZ2MCr7qCoH6K5N8ES+mGDDMVoJ4WLgZmB7rX2os07/drh+
         rh3xuCMfOlunWhFurF9zmZ5vtuQSgA6+t+6Wp1QM49/2nDznKtA/uWhWhkc4js6NZGAH
         WHA8TN4+lOy7AOrJD83AfpSx0xvy6UBgCWXun+UFyUxVdrk9RTLrt5iAe1p2PfGQ32w3
         1xiCsO0JilDAUUGsAJqF9sZcboTueSXpG3biMJETBkyV/567AA6xZi/pYD8ktd+Kya12
         gzcQ==
X-Gm-Message-State: AOAM532UcTQdMLcaL6QFMfkztodbLrqzrBgkiyIDoQqW89kZjl+lFy5C
        UtrjJIVwjvXGavIE9q3/xnSqESA3aCsCa6gkCPAh1hopt29VPzxbdci2BoR2vU0mAHUEGY+HF5u
        gYpVWmz391hwXak5oFLZAcxB2
X-Received: by 2002:a05:6402:2741:b0:41f:69dc:9bcd with SMTP id z1-20020a056402274100b0041f69dc9bcdmr41715321edd.239.1651243063975;
        Fri, 29 Apr 2022 07:37:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfzw8QumCVk4MWDo2T3g06+wFXLjFwRTVrcN+UQEjLRi2Izb8gBKMMJuYOw8MLJK1HidU0zg==
X-Received: by 2002:a05:6402:2741:b0:41f:69dc:9bcd with SMTP id z1-20020a056402274100b0041f69dc9bcdmr41715307edd.239.1651243063789;
        Fri, 29 Apr 2022 07:37:43 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id jl13-20020a17090775cd00b006f3ef214e0csm709823ejc.114.2022.04.29.07.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 07:37:43 -0700 (PDT)
Message-ID: <20e1e7b1-ece7-e9e7-9085-999f7a916ac2@redhat.com>
Date:   Fri, 29 Apr 2022 16:37:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] KVM: x86/mmu: Do not create SPTEs for GFNs that exceed
 host.MAXPHYADDR
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>
References: <20220428233416.2446833-1-seanjc@google.com>
 <337332ca-835c-087c-c99b-92c35ea8dcd3@redhat.com>
 <Ymv1I5ixX1+k8Nst@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ymv1I5ixX1+k8Nst@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 16:24, Sean Christopherson wrote:
> I don't love the divergent memslot behavior, but it's technically correct, so I
> can't really argue.  Do we want to "officially" document the memslot behavior?
> 

I don't know what you mean by officially document, but at least I have 
relied on it to test KVM's MAXPHYADDR=52 cases before such hardware 
existed. :)

Paolo

