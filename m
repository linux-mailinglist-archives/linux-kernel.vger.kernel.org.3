Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9E95A6593
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiH3NwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiH3Nvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7DB21E27
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661867401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xSYsGT+JuRUnE0x8Uu6rvpfH2JA8fm0UMDh7oy78WJU=;
        b=DRL+OAj8aY+7F4QlHoEuT79wRC2wCLyduuOJ8auHG2FFfMC9s4bKcNuReXbUcv8iBlu30C
        rxnmcuv+k1FnW2fTAJ04Lc3F4umG003FBh4HGT7VScC228lCSVNbAGyP3bAeOCelkypKyk
        Ci6hypV6IxZyFEraqtEPbXsQjjJ7/8Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-329-r6d0XWkBMuKppy4fUdOKJg-1; Tue, 30 Aug 2022 09:43:44 -0400
X-MC-Unique: r6d0XWkBMuKppy4fUdOKJg-1
Received: by mail-wr1-f72.google.com with SMTP id r7-20020adfbb07000000b00225b9579132so1757170wrg.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=xSYsGT+JuRUnE0x8Uu6rvpfH2JA8fm0UMDh7oy78WJU=;
        b=fagMvdTCa78PTT9chyXm0XuONp9JrPG96Mvp4PskNVujG/2uqZJi3nWq2cI3av/qv3
         QqeNUkhzcQ1rY7afiz8QB9ds3D1gJWydo9AB121WiWVz+LoZ3a5ANBsmG6BDeh/CU6LD
         GNwqrPpg1xTr8DjuKQPrtUG+HdOFUA5Yc+S0lzp1FsVtljpbFfI+THcNwSPKRYQ3AnOd
         lwBtTzlk4bBqItaLcd28kbUBtzz+b7DeMGZAUs13/hWwI7O8okfiH4V1lIDoHJ0Udo7B
         6tECKi/SAVMbdLbrCWxPKc4eu/aeU1pEfz4DipmjcSWyDhLJEDBUg1xKziZ8P/cvBT5S
         se7g==
X-Gm-Message-State: ACgBeo3AB81LnyvmrqXs/uy7g2VSwhH2Z2Y7Pguurc1QRJRMN0vYrv9H
        uYLZZsry1jTrYFm9musWHQuqGiPrCu2P25DlK97e4iLF0rUY/MvD0NjZ/qZndxCweYsTjkxI0h/
        nbLhUZiWJVh2MWJlCZumCJY4X
X-Received: by 2002:a05:600c:418a:b0:3a5:168e:a918 with SMTP id p10-20020a05600c418a00b003a5168ea918mr9782000wmh.31.1661867023751;
        Tue, 30 Aug 2022 06:43:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7J7amscRJ3WfZNYVzhrBCLo4tjoSRLTzgx5nbx4QzFf31AtfhlXNT2cljEHY97bXhWh+p3lQ==
X-Received: by 2002:a05:600c:418a:b0:3a5:168e:a918 with SMTP id p10-20020a05600c418a00b003a5168ea918mr9781989wmh.31.1661867023521;
        Tue, 30 Aug 2022 06:43:43 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c2d9400b003a604a29a34sm11680851wmg.35.2022.08.30.06.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:43:42 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v9 00/40] KVM: x86: hyper-v: Fine-grained TLB flush + L2
 TLB flush features
In-Reply-To: <20220803134110.397885-1-vkuznets@redhat.com>
References: <20220803134110.397885-1-vkuznets@redhat.com>
Date:   Tue, 30 Aug 2022 15:43:41 +0200
Message-ID: <8735ddvoc2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Changes since v8:
> - Rebase to the current kvm/queue (93472b797153)
> - selftests: move Hyper-V test pages to a dedicated struct untangling from 
>  vendor-specific (VMX/SVM) pages allocation [Sean].

Sean, Paolo,

I've jsut checked and this series applies cleanly on top of the latest
kvm/queue [372d07084593]. I also don't seem to have any feedback to
address.

Any chance this can be queued?

-- 
Vitaly

