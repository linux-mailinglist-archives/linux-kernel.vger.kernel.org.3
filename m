Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938C554B761
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243674AbiFNRJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243075AbiFNRJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DC90201A4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655226545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtO7y3+ijZ6YgcAc4PQtJVzw8h5/IO41lJW3F/O5h8o=;
        b=MExBRNUrDgO3Q+J734Mscv2T2qASZLzHE4c8el9HZi4lUBQWptJZY+ONvKd8Y6oXwuv7uE
        /ufobr/ex6e07iXpTO4d2IvHFhWqnVY54c6O9vb6obt4kK3C5MGbgQqNzmPab29/h4jUiv
        y1ANlS0px2g3htt6lFW/B2sNQxgCp58=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-6xSVKKK3NnSJSB7V_cxkqw-1; Tue, 14 Jun 2022 13:09:04 -0400
X-MC-Unique: 6xSVKKK3NnSJSB7V_cxkqw-1
Received: by mail-wm1-f72.google.com with SMTP id k32-20020a05600c1ca000b0039c4cf75023so7861064wms.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TtO7y3+ijZ6YgcAc4PQtJVzw8h5/IO41lJW3F/O5h8o=;
        b=z0k0PORCtVK5nH//0tMHCKLc1pg2t3A/EhpbHMpeNluf1qkryq72Hg45uLOPkgpCxE
         dI5zK+hXuDsu8C5TGExc37DaxPGkM4ZvTmIVMjOAT6/PZUXMafBDTOVsqRljjNs/D+wb
         jhLPbadwwD8cVzm3gzLazi849l4ObhDUqKDdOyeVAqjSTK/QlDzyddIQxVK6UtloQLXT
         WiXfz0g0Uupwwjwx04zbg3kM14Tlijf3murzwUJ24xON/yRy4Cvh53wvyCBa2C/En0xG
         pD9GuKyu/OiKEpnK+p5rd8Go3QQ6ndJAhzt22T6EISMZGyjtJZDRDTuSW8PzdQ2QQ/Zo
         PwCA==
X-Gm-Message-State: AOAM5328vB48e36QBaqIJwwTcNYwWoVIX9lnKtR+3Fv2/af92k2imXSX
        ue0SHAMfhZTr2i+BDQ1gqJX9bFaL+tbJ39rY8puxhxvaFz2Wt2defgxojEpbUxm2hTqBk79Sw3P
        ZBDB9i67ROFLfkRK71jQmaEYa
X-Received: by 2002:a1c:f213:0:b0:39b:ad32:5e51 with SMTP id s19-20020a1cf213000000b0039bad325e51mr5215048wmc.72.1655226543169;
        Tue, 14 Jun 2022 10:09:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEH0VwSnOcNDbF6N4JmvvUE3uFVg/Be8POxZzNI8KiXy7aOZbLTS8Lt1QSrzLFl377ZtNdew==
X-Received: by 2002:a1c:f213:0:b0:39b:ad32:5e51 with SMTP id s19-20020a1cf213000000b0039bad325e51mr5215014wmc.72.1655226542875;
        Tue, 14 Jun 2022 10:09:02 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id v1-20020adfebc1000000b0020d07d90b71sm12236421wrn.66.2022.06.14.10.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 10:09:01 -0700 (PDT)
Message-ID: <6dca9fc3-d50a-2920-b22e-73f0bd2c93f9@redhat.com>
Date:   Tue, 14 Jun 2022 19:09:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] KVM: s390: selftests: Fix memop extension capability
 check
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>, thuth@redhat.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     david@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org, shuah@kernel.org
References: <36d83871-343d-e8a0-1aed-05bf386f9b1b@redhat.com>
 <20220614162635.3445019-1-scgl@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220614162635.3445019-1-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 18:26, Janis Schoetterl-Glausch wrote:
> Fix the inverted logic of the memop extension capability check.
> 
> Fixes: 97da92c0ff92 ("KVM: s390: selftests: Use TAP interface in the memop test")
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
> 
> 
> Here you go.
> Hope it doesn't get lost as a reply, but I can always resend
> and it's not super critical after all.
> 
> 
>   tools/testing/selftests/kvm/s390x/memop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index e704c6fa5758..e1056f20dfa1 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -769,7 +769,7 @@ int main(int argc, char *argv[])
>   	ksft_set_plan(ARRAY_SIZE(testlist));
>   
>   	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
> -		if (testlist[idx].extension >= extension_cap) {
> +		if (extension_cap >= testlist[idx].extension) {
>   			testlist[idx].test();
>   			ksft_test_result_pass("%s\n", testlist[idx].name);
>   		} else {

Done, thanks!

Paolo

