Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5214551308D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiD1KD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiD1KDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E847B53F8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651139384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jgkRF61wIuvSMOhgVZ5X8ahGDAKVGL68WuFaxWkhlhA=;
        b=aNxRLdrd9+jDWjLr/rJGsch86jZwaJO9CMSaHz81VQrSZTXCDLe1tLwhWsZ5SazyJeF7qT
        i2gpPkIprikyaTjJIB8A9SbO1ZFpz+zSdxuOZS5EwUmPKi0T/yDCD4rLSpPpXqGE4oHl0p
        U2V3xI70AGeFtD45raLda+qMDj6WsWo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-kkDnFZJJOKufPWGDTyOTbg-1; Thu, 28 Apr 2022 05:49:43 -0400
X-MC-Unique: kkDnFZJJOKufPWGDTyOTbg-1
Received: by mail-wm1-f69.google.com with SMTP id bh7-20020a05600c3d0700b003940829b48dso1673192wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=jgkRF61wIuvSMOhgVZ5X8ahGDAKVGL68WuFaxWkhlhA=;
        b=NSW96xVjIeOHHd5jOUnwk1SR9jHfkOO2zWCx+1tmGJ4oE/0A3bvzRzEe81//ul1LX0
         yeDlvFcrm189hvAPNMfnTXUnNNrD87J63FDZC1gUrEcTRd+AlFvcS1x/JxIK4mtYhHHb
         xvtk6MY25kPXftZaFeGhu/a1SVgek1Zdl6s03UXyXqiUzGsigNgf8d0vcJ9Ks25RJwpp
         bnT6srqivkFpTQJJ56/K5wXV5U45YKwP9qUdQvDuQVzB4Xed11ZtV15tYvJWkIofsAgF
         TQ4jD1mJv4S/j6ENVdP7GhKFmgeXRk3l6Rmnd7OTe+5HyyWCLZo1cdvwBivRSwHpiX4z
         gw4Q==
X-Gm-Message-State: AOAM533uQw3rOKKhymrZ0DbesARgja3toQZQ+HPyO6lJuP6kknfUH0f3
        rusXETaT+YuWcWLs1YopvXTziO6I1KjuOGPbZlqzWmFvFmfqzV4DBapCkIbv8jDI2SZ6aVeaXTq
        1Z33QGk1NYBKDalBCixI8VqnT
X-Received: by 2002:a05:600c:3785:b0:38e:bca8:f0c1 with SMTP id o5-20020a05600c378500b0038ebca8f0c1mr38370067wmr.56.1651139381487;
        Thu, 28 Apr 2022 02:49:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo3BJ8TK15hKBdUBzkju/9wd6KFXyCwXPgPHm9uxcSwg6sT+cbKtpZSGfx9bkszO1hbJcfYw==
X-Received: by 2002:a05:600c:3785:b0:38e:bca8:f0c1 with SMTP id o5-20020a05600c378500b0038ebca8f0c1mr38370050wmr.56.1651139381249;
        Thu, 28 Apr 2022 02:49:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:ef00:7443:a23c:26b8:b96? (p200300cbc708ef007443a23c26b80b96.dip0.t-ipconnect.de. [2003:cb:c708:ef00:7443:a23c:26b8:b96])
        by smtp.gmail.com with ESMTPSA id e30-20020adf9bde000000b0020aeafa418dsm4410144wrc.14.2022.04.28.02.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:49:40 -0700 (PDT)
Message-ID: <6369fd69-5b59-1aa4-461e-237b3f128925@redhat.com>
Date:   Thu, 28 Apr 2022 11:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v7 1/8] x86/crash: fix minor typo/bug in debug message
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-2-eric.devolder@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220413164237.20845-2-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.22 18:42, Eric DeVolder wrote:
> The pr_debug() intends to display the memsz member, but the
> parameter is actually the bufsz member (which is already
> displayed). Correct this to display memsz value.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

