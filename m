Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953665003CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbiDNBsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239500AbiDNBr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C26C252B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649900733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaUH/uBDt0Khh1i/AkQAQeFZf7ctY3a5V5SG+bAPmQY=;
        b=RC+9QE2ZbCehRQxP+3Hmg1epOJc5yvNrh/2NIKUFwV1K7zy6qEzVwQF4/DwRDVRgIxfLdW
        +cv0zxxi+HigCZPDSYQFOKw6JtirVdZZegvb7v9ORSOnAHg40iiqc5wmhNQNOWtCcYc6XQ
        QsYYW5h0KMc5vU8ZRffOtR9oVyJmv7I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-iL0NJb2RP-eSttnPK0eorQ-1; Wed, 13 Apr 2022 21:45:32 -0400
X-MC-Unique: iL0NJb2RP-eSttnPK0eorQ-1
Received: by mail-pj1-f70.google.com with SMTP id r15-20020a17090a4dcf00b001cb7ea0b0bdso2257046pjl.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UaUH/uBDt0Khh1i/AkQAQeFZf7ctY3a5V5SG+bAPmQY=;
        b=l/TscxO1ZMAe6cl/hEFPr772dcAimhX1EbVRBNjyQzPejscT15hql5W+kja7UtnB1p
         3gLMSz6d8opLLD0qCgpkR5UDLeVpXxu1lnkPz8r4WYRsEUB3z0gcb+h8SFLgC+Yuh624
         MQk7FT3fiwOq14Hx8fgD1pE4ZmzkvRWFzSSNMIOlP7t7neX27ja/e1SzwcKQZyXiW/5B
         06E17n4IRNiusCzxWlY8ycVKqfQ2xHVX8bEq1RDbp2OfApiqBaDBJ9zB63q89VCpI9dL
         OJUp+INUhL0lEKd1uTB/mkW7vCe3nuCPwoZpCpcV6NeWLJOUalU99Za2eDvBGdPXCOeH
         vD6Q==
X-Gm-Message-State: AOAM532NBe84bKVvzA5vacYlOUzSbHM52KFRrGL3b0GsyuzjcuaehyUC
        p6Az0qJaNqF+dVb2VawesWQ9G87PpmW0Lhl6j6uAGrIw1tzw+mj6HZHQz8rK1bM0ERAe9cqAT6U
        eQpF+z4WPQQ/Qx41dUf60k5bt
X-Received: by 2002:a17:90b:3b4d:b0:1cd:3ce7:aaec with SMTP id ot13-20020a17090b3b4d00b001cd3ce7aaecmr1137071pjb.32.1649900731303;
        Wed, 13 Apr 2022 18:45:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhkFSPwz69To4M7mJ3fKFULldZWpqa3OVP1lY/uMySD5zgHHwlIcM9BKs0THLjUvA8cwG07Q==
X-Received: by 2002:a17:90b:3b4d:b0:1cd:3ce7:aaec with SMTP id ot13-20020a17090b3b4d00b001cd3ce7aaecmr1137051pjb.32.1649900731059;
        Wed, 13 Apr 2022 18:45:31 -0700 (PDT)
Received: from localhost ([240e:3a1:31c:360:52fc:c968:cb41:efbc])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b004faef351ebcsm335950pfk.45.2022.04.13.18.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:45:30 -0700 (PDT)
Date:   Thu, 14 Apr 2022 09:44:46 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] arm64: kexec_file: use more system keyrings to
 verify kernel image signature
Message-ID: <20220414014446.tqopgaz2n3srwc6p@Rk>
References: <20220401013118.348084-1-coxu@redhat.com>
 <20220401013118.348084-4-coxu@redhat.com>
 <20220411085938.GA163591@kunlun.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411085938.GA163591@kunlun.suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 10:59:38AM +0200, Michal Suchánek wrote:
>On Fri, Apr 01, 2022 at 09:31:18AM +0800, Coiby Xu wrote:
>> Currently, a problem faced by arm64 is if a kernel image is signed by a
>> MOK key, loading it via the kexec_file_load() system call would be
>> rejected with the error "Lockdown: kexec: kexec of unsigned images is
>> restricted; see man kernel_lockdown.7".
>
>This is because image_verify_sig uses only the primary keyring that
>contains only kernel built-in keys to verify the kexec image.
>
>> This patch allows to verify arm64 kernel image signature using not only
>> .builtin_trusted_keys but also .platform and .secondary_trusted_key
>> keyring.
>>
>> Acked-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/arm64/kernel/kexec_image.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
>> index 9ec34690e255..51af1c22d6da 100644
>> --- a/arch/arm64/kernel/kexec_image.c
>> +++ b/arch/arm64/kernel/kexec_image.c
>> @@ -14,7 +14,6 @@
>>  #include <linux/kexec.h>
>>  #include <linux/pe.h>
>>  #include <linux/string.h>
>> -#include <linux/verification.h>
>>  #include <asm/byteorder.h>
>>  #include <asm/cpufeature.h>
>>  #include <asm/image.h>
>> @@ -133,8 +132,7 @@ static void *image_load(struct kimage *image,
>>  #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
>>  static int image_verify_sig(const char *kernel, unsigned long kernel_len)
>>  {
>> -	return verify_pefile_signature(kernel, kernel_len, NULL,
>> -				       VERIFYING_KEXEC_PE_SIGNATURE);
>> +	return kexec_kernel_verify_pe_sig(kernel, kernel_len);
>>  }
>>  #endif
>
>You can eliminate image_verify_sig here aswell and directly assign
>kexec_kernel_verify_pe_sig to fops.

Good suggestions, thanks!

>
>Thanks
>
>Michal
>

-- 
Best regards,
Coiby

