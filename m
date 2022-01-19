Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D58F4939F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354364AbiASLxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:53:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354362AbiASLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642593183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9Mk8x6h3+3pv2pI2IYU/SKL9nrxKC/9/vUTNplQZ3o=;
        b=H1ff2Q8x3eJKRfsW7cLCwPjgLenuFrFsgXf1bbGZS+BB18o9znPW/XqAaIlHD1dLjIumEM
        7GFdj5PBlXfU67kNnZ3n0XFczLWlH8Fj5rbfkV/tWHDaJv6HhYJYpLGHv/f9shkoteX20n
        F7DemMhGOut4CdMVCsK0W2m1Y5LZ33s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-A326b2DpPFSjLq6WDxSYRw-1; Wed, 19 Jan 2022 06:53:02 -0500
X-MC-Unique: A326b2DpPFSjLq6WDxSYRw-1
Received: by mail-wm1-f72.google.com with SMTP id 14-20020a05600c024e00b0034a83f7391aso1744702wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 03:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J9Mk8x6h3+3pv2pI2IYU/SKL9nrxKC/9/vUTNplQZ3o=;
        b=uMYyq3KG55A9CA2df+fVMIpGo4QfnZuhF18wiFKkZ7D8zpmQCdCGdjaxOGknHumcUL
         lcvPBsCRvJq/p3DzAc1AxAf/3hGJeEj6IJSSgxMDNwUvXHVckQBgG00z4QSdpmRhcF0P
         7nKVJ74mhbxtVG8DZT5IQGuAspEreX4z8x72eT3KOW4+5zkQoRVunUfcS1udxrfPPval
         PQQsysPNl14Njety9XzoliiUfMS7yrw8KxXrZefleZLJifOJeYUfpqdw0FwjP+NXVzUE
         fnm5uHSyAkgfdFfsCePBRLQYmVJIqAdGQovctwiTWLwe4et1xwakyps+yh8FmGunkAH6
         6nKQ==
X-Gm-Message-State: AOAM531EhYqlEENsjlmm6q5WdwmTzYi9IYSgiP0fSx7OaYYI8cjeWpU/
        A7rZ0RN2MNhedPNvgNRgvuRyClMTO7yk/Cg3ZoCCFkGFhey7qSoeUrDPtjs7rDmJSWwBH4WbHdI
        +OIoOdXW4rDxLl9wCAuLCic9S
X-Received: by 2002:a5d:690c:: with SMTP id t12mr29073772wru.536.1642593180966;
        Wed, 19 Jan 2022 03:53:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+coOAxfk7/pEhrWiTHo6300RiSHyo2Xld6RFO2DMG3eym1SZ8ER4ToceMXeLTZvGpp1oxBA==
X-Received: by 2002:a5d:690c:: with SMTP id t12mr29073761wru.536.1642593180763;
        Wed, 19 Jan 2022 03:53:00 -0800 (PST)
Received: from [192.168.8.100] (tmo-096-151.customers.d1-online.com. [80.187.96.151])
        by smtp.gmail.com with ESMTPSA id l13sm5267757wmq.22.2022.01.19.03.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 03:53:00 -0800 (PST)
Message-ID: <a3a143f8-8fd5-49bf-9b2b-2f7cb04732de@redhat.com>
Date:   Wed, 19 Jan 2022 12:52:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v1 06/10] KVM: s390: Add vm IOCTL for key checked
 guest absolute memory access
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
 <20220118095210.1651483-7-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220118095210.1651483-7-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 10.52, Janis Schoetterl-Glausch wrote:
> Channel I/O honors storage keys and is performed on absolute memory.
> For I/O emulation user space therefore needs to be able to do key
> checked accesses.

Can't we do the checking in userspace? We already have functions for 
handling the storage keys there (see hw/s390x/s390-skeys-kvm.c), so why 
can't we do the checking in QEMU?

  Thomas

