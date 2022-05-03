Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBDA5187D4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbiECPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbiECPIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FDCD3A1BD
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651590282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q8KRyeOIJowwgq1LjuL92i0OyzQpFO6OlQ5jrqBwiaQ=;
        b=GsN2aHEwmnBSqzAAnCWcw7/CJDPv9Fb4L16x/+QNOcdLl9DQOTNve0c9FT4xDsQVSfgIwr
        aM9cVdd3W5HKV1WkonLjRzAHci+BYJSoVIYTI+HQpiEHA8hy//YAeUNr+HrZ7XRw03fE8e
        jrjEEt+cw4VBBg8OqyKWAeg+XDx+JJ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-El3JyjaEMFiFqjRBhvUOMQ-1; Tue, 03 May 2022 11:01:22 -0400
X-MC-Unique: El3JyjaEMFiFqjRBhvUOMQ-1
Received: by mail-wm1-f71.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso1475155wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=q8KRyeOIJowwgq1LjuL92i0OyzQpFO6OlQ5jrqBwiaQ=;
        b=MPxtVmU9TXCzlfICfpo5fW0/37rd+l5l7O/mDsoAC6Jv9Y3Z/5PVgn9urVFa0yc2Al
         NOKAvLBXd2EVVGM/khMdDa4B4vmQDLfKlCc6an41shsbTvD0CPk6lj5bs4ImE7FnAr7/
         w3uvh64g22XbA0nWegFks4D07rEZ5dc31AdLno7I1ewC7SC40/xLh1KxZ1b6oumijOMk
         O+BykDk1yN0G8aQi+O6acyHqEACdMcz0MR2/hwYDM6H41YKaUgu4DfOhdMctvLYmtgWR
         /PFMZNZF5FCtbZ2QqP8SQPifJGAR8x+wQ2UxoxnSvzsXe+YMZEFKlorD5tLpK6Gqo3bp
         A8uQ==
X-Gm-Message-State: AOAM533I3K+67H9wyFL6p5QXHn6R43su/g9wAowd9U7xhDLTaXnQBTl2
        PD52IVmtG6BIGQ7EsFwyiLiDXXYYLXvU6qJXmWzbtjpHLwXPuKYg86hWNkXR09t5+2h/mbwzWCk
        bNjN9BSMHKGA2ioPnnTwJRha5ugZ61nOrQYnRwcex3Z9AyH5Xwfntde0V7Vs8npnBeDqQVdcJIv
        j4
X-Received: by 2002:a5d:64c1:0:b0:20c:6ff9:3a61 with SMTP id f1-20020a5d64c1000000b0020c6ff93a61mr4770689wri.709.1651590080963;
        Tue, 03 May 2022 08:01:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFddadb0RhMqbED3cKhIrdL1UAliMUxLFrwK6VNOQYuEXW0q5ELPbxKJShs+8DVKmBmOBFgQ==
X-Received: by 2002:a5d:64c1:0:b0:20c:6ff9:3a61 with SMTP id f1-20020a5d64c1000000b0020c6ff93a61mr4770661wri.709.1651590080743;
        Tue, 03 May 2022 08:01:20 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t1-20020adfba41000000b0020c6fa5a797sm3344358wrg.91.2022.05.03.08.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:01:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/34] KVM: x86: hyper-v: Fine-grained TLB flush + L2
 TLB flush feature
In-Reply-To: <20220414132013.1588929-1-vkuznets@redhat.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
Date:   Tue, 03 May 2022 17:01:19 +0200
Message-ID: <87bkwe3bk0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Changes since v1:

This should've beed 'since v2', obviously.

...

>
> Currently, KVM handles HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} requests
> by flushing the whole VPID and this is sub-optimal. This series introduces
> the required mechanism to make handling of these requests more 
> fine-grained by flushing individual GVAs only (when requested). On this
> foundation, "Direct Virtual Flush" Hyper-V feature is implemented. The 
> feature allows L0 to handle Hyper-V TLB flush hypercalls directly at
> L0 without the need to reflect the exit to L1. This has at least two
> benefits: reflecting vmexit and the consequent vmenter are avoided + L0
> has precise information whether the target vCPU is actually running (and
> thus requires a kick).

FWIW, patches still apply cleanly to kvm/queue so probably there's no
need to resend.

-- 
Vitaly

