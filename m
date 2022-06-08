Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3C95427AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiFHHHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353326AbiFHGRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 783A8A7773
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 23:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654668062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4EmZpbnZG2iGxtLA1wEpmaCgsZIV0Qp3tq0M8QVlG4=;
        b=DihhrCFO6AdlIwEntGZL6BB+Be0eBj45gPwGJhDjF5lPaNml1xLYQjry6LjkX9UtoqrCOj
        QkfK/1/wnFw0ptVszLhrjxU7Vur6OlHsWxljaJlv+tv/V27rdYI9HiYqnvfUJzfIiagOrX
        1zT0sphgMDOvccv0LMzYNYPedvurwKY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-jCCVW_x6MwO_8T-Pz9_zeA-1; Wed, 08 Jun 2022 02:00:53 -0400
X-MC-Unique: jCCVW_x6MwO_8T-Pz9_zeA-1
Received: by mail-wr1-f72.google.com with SMTP id c7-20020adfa707000000b002184d715e69so1368772wrd.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 23:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=K4EmZpbnZG2iGxtLA1wEpmaCgsZIV0Qp3tq0M8QVlG4=;
        b=fzqxINEEoK5yxikv9Zr56o6xPMTUE/z606V9SoLCM7mHxSd661aQ3eTaWP3OC5D49t
         XSjzx6bq4NWAHS4LsbarJofvXgOb5WEWw/8ta+oo5S6IbVRUCUeZGEx42BzDKHH9ymaY
         TkPIy1Wr2UofJkSXMFELbaPThjH9v9QatfL0t9ZiYfB+f3uTPE2TS+HnduWjq1W0StmG
         VOtbbTNfhBnt3w3k9P5RW/imLutiem9MB7/I4GyK4GOLFx7REXZNAxbdrWXFdk9T5IgA
         C+6Wfni1f2Mi0Ao/+xQ57Z6F8mu+QykVRiF+DJ8QnL7ijBsZHHsXqzk+l0a3MyScLkFn
         ai3Q==
X-Gm-Message-State: AOAM531nN3OyIyhks/zDFtc/QqIght3KuTMWmFPHoUD6HSL1T7DkNH3I
        EGgnCSdULbYaDgv8us3dHkiS1JIzg7o7Mc5oeTC0Sl4QuW6Ix2JWNsrQiHU607IjHyh36LOIuM/
        xZTiw3WsL/PGqaJsCTkNqOoTn
X-Received: by 2002:adf:9cc2:0:b0:20f:e59a:ec41 with SMTP id h2-20020adf9cc2000000b0020fe59aec41mr31401240wre.124.1654668052538;
        Tue, 07 Jun 2022 23:00:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHQplGnELB+79hF5tZieuRC/jNvYpvm+mt9Ta1KGoefr17nHK6bc6qds9St+Vp2bqRhwe1fg==
X-Received: by 2002:adf:9cc2:0:b0:20f:e59a:ec41 with SMTP id h2-20020adf9cc2000000b0020fe59aec41mr31401201wre.124.1654668052305;
        Tue, 07 Jun 2022 23:00:52 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-42-114-66.web.vodafone.de. [109.42.114.66])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c2cac00b0039749256d74sm27609665wmc.2.2022.06.07.23.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 23:00:51 -0700 (PDT)
Message-ID: <7350ca00-2dbe-f92c-ee28-9b0438051171@redhat.com>
Date:   Wed, 8 Jun 2022 08:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, pasic@linux.ibm.com,
        pbonzini@redhat.com, corbet@lwn.net, jgg@nvidia.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220606203325.110625-1-mjrosato@linux.ibm.com>
 <20220606203325.110625-21-mjrosato@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v9 20/21] KVM: s390: add KVM_S390_ZPCI_OP to manage guest
 zPCI devices
In-Reply-To: <20220606203325.110625-21-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2022 22.33, Matthew Rosato wrote:
> The KVM_S390_ZPCI_OP ioctl provides a mechanism for managing
> hardware-assisted virtualization features for s390x zPCI passthrough.
> Add the first 2 operations, which can be used to enable/disable
> the specified device for Adapter Event Notification interpretation.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   Documentation/virt/kvm/api.rst | 47 +++++++++++++++++++
>   arch/s390/kvm/kvm-s390.c       | 16 +++++++
>   arch/s390/kvm/pci.c            | 85 ++++++++++++++++++++++++++++++++++
>   arch/s390/kvm/pci.h            |  2 +
>   include/uapi/linux/kvm.h       | 31 +++++++++++++
>   5 files changed, 181 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>

