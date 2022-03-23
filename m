Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DE14E5AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344939AbiCWVe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiCWVe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E4FE3EF0C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648071176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oh11iooAkmJrsdwWBjuA6GGBECOmBuX2cXQQcpcqSuY=;
        b=Xel+mS7/qETXRUFTspUtNzwhBThOliaN05yXgU6xkR1b13Vu6/Hax/fwcvOwPJVHioI7Bz
        iOZ9+mXNkzKmtnbgGOODqZ1tGgLXRfRJ9/hfmRAx20URM+wktWrkHzJ9XIkXNqJhvuF7SF
        HRQQ3M7T8204KUjGKiOR/qB0RcUVwho=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-SzvdApABO4eZ_ScqZERGgA-1; Wed, 23 Mar 2022 17:32:54 -0400
X-MC-Unique: SzvdApABO4eZ_ScqZERGgA-1
Received: by mail-ej1-f69.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso1440614eje.20
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oh11iooAkmJrsdwWBjuA6GGBECOmBuX2cXQQcpcqSuY=;
        b=cBb+jdL5lAHoYeSuiTHSLe0UmMZgr2VussWBgD7Ls6C/z3GX9l1Ca5vJMIlavOnGJl
         XkCVjcBEoclnzjEtKr+sk+bXcrc9Kine4k9nN2HsFH0trQKzEPOpeBQgTl+hXC0S25qQ
         TRP0o95os3UBfLSuaK3ECv4rRVH9+tYVD/8hIDQkGtqd5tOYCdVdKG4m6RmPBTkPa4km
         /4Nt1QqI2jHfkc/BPt6oUpPNY9Lq0xX+ji27Y9np/BtyTOqc1syNRaEiGjick6iQ9Iwp
         /xPLxeawnTsIqRPYqjk80o93Flc2dzxQe2yJyMpBxA9fkL8U0EeYo9pYWOcUZ4MvtBfn
         Pd/w==
X-Gm-Message-State: AOAM5331BJmmv4Kz3HIOwtLCc1dTYL+OAkW7h112CLLdouLczg3ftmHf
        ERP8D5+ubTPyVq4Z4z6q3Ms5GUq4zfHzY4uw4nCSh6OBfigsDiMkAxYqsbduTOEn0aAuvPzy+lp
        H4AuOGE91TasDWA62uzBcU66N
X-Received: by 2002:a05:6402:454:b0:416:2db7:685b with SMTP id p20-20020a056402045400b004162db7685bmr2783662edw.43.1648071173693;
        Wed, 23 Mar 2022 14:32:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHYr8na/zz+NGxL5TIMj/1NzKsoC6teN3liiWE+FHimqyjued/mO1iRCI2LxxCqk4X8SpvwA==
X-Received: by 2002:a05:6402:454:b0:416:2db7:685b with SMTP id p20-20020a056402045400b004162db7685bmr2783648edw.43.1648071173499;
        Wed, 23 Mar 2022 14:32:53 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id r16-20020a056402019000b00418ed60c332sm476712edv.65.2022.03.23.14.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 14:32:52 -0700 (PDT)
Message-ID: <a35f9408-9d54-654c-6639-64192f03ba3b@redhat.com>
Date:   Wed, 23 Mar 2022 22:32:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] Documentation: KVM: add API issues section
Content-Language: en-US
To:     Oliver Upton <oupton@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        mlevitsk@redhat.com, jmattson@google.com
References: <20220322110712.222449-1-pbonzini@redhat.com>
 <20220322110712.222449-4-pbonzini@redhat.com> <Yjtj8qESPWIL221r@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yjtj8qESPWIL221r@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 19:16, Oliver Upton wrote:
> Do you think we should vent about our mistakes inline with the
> descriptions of the corresponding UAPI? One example that comes to mind
> is ARM's CNTV_CVAL_EL0/CNTVCT_EL0 mixup, which is mentioned in 4.68
> 'KVM_SET_ONE_REG'. That, of course, doesn't cover the
> previously-undocumented bits of UAPI that are problematic:)

It depends.  My intention was to use this document more for hidden 
interdependencies, in this case between KVM_GET_SUPPORTED_CPUID and 
KVM_CREATE_IRQCHIP, KVM_ENABLE_CAP(KVM_CAP_IRQCHIP_SPLIT), 
KVM_CAP_TSC_DEADLINE_TIMER.

Paolo

