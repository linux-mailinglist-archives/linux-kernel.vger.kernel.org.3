Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B21A54AADA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352722AbiFNHpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiFNHpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 290EA26118
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655192705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dgyIXyBsOELAwe/LYhSIfeWs8SqQKOJEdzlYMa9u4pA=;
        b=YVdResl+eNTZ6sCAHvuGG9/55k9kUq7yDU9fTkDANCb53ivmFLts4PrV31IoE4kgadLyqZ
        ah4HHj9sU+evzd6SZSWImyYXEVSl8X1mmuGEFh8TSM6KBD2TimrWL80aJGaN7Tz+nCvaya
        ZqfI8QfJ4+51m4kSpIqLAPDabgIIU7o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-SfED0OPMNOGZdjIYjV3VaQ-1; Tue, 14 Jun 2022 03:45:03 -0400
X-MC-Unique: SfED0OPMNOGZdjIYjV3VaQ-1
Received: by mail-ed1-f69.google.com with SMTP id s15-20020a056402520f00b004327f126170so5643390edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dgyIXyBsOELAwe/LYhSIfeWs8SqQKOJEdzlYMa9u4pA=;
        b=biv1vABriYarGv62zvnVe60vJY0MMf7ZdsCWGeGaT3plF986sovozeOT7c02Mk7VZO
         sQ4mO99yBQdS/XAV6GSSrMODecchIxj69CtshMr2Q8Cmmgc1EWtKZJqfLt/827/ueluq
         V47DFIRqN+Jw0ZRNiOgjecZ3bEc66wUCNh12//TAqxRJoa3KvBoxQlH1sQ1oA3aGqd9/
         QNRYsqaz32Bnra2/8C12eOwKZg2bfkvkS4aiC4cP6OzAf73YgPRZPcPYvjV8yGGkGdhW
         H3kliYd2p8gsIr5nji0H2j3ZzpqE2gs/Mxr1i2ffS6E/k/y9TqhIP1+yES4JtsLdcbdm
         /f4w==
X-Gm-Message-State: AJIora+zTXpNp9jHkeiRvbCi5udNjW5c/qj+TrlFH1QtA58ar2MYJmOH
        gvFxMXkLR0UXijRWChdwvqz+/L4HWNUHx2BBhVSP/eyiyELsBZ9fvBQhVkxS8j7e++eFAm5Khvw
        NfFlD3b/+hd1awDy+uOC8v6IA
X-Received: by 2002:aa7:c84d:0:b0:431:4226:70c9 with SMTP id g13-20020aa7c84d000000b00431422670c9mr4271493edt.51.1655192702384;
        Tue, 14 Jun 2022 00:45:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJ5IlXxslNIf6I97hjXfT4GlolXDA60Ma8Z62WzRzPo1MZt3AJ8Xm7QzGo4XAnyp297JvrmA==
X-Received: by 2002:aa7:c84d:0:b0:431:4226:70c9 with SMTP id g13-20020aa7c84d000000b00431422670c9mr4271477edt.51.1655192702127;
        Tue, 14 Jun 2022 00:45:02 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z6-20020a056402274600b0042def6cd141sm6689297edd.30.2022.06.14.00.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 00:45:01 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <likexu@tencent.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/7] KVM: x86: Ignore benign host accesses to
 "unsupported" PEBS and BTS MSRs
In-Reply-To: <20220611005755.753273-7-seanjc@google.com>
References: <20220611005755.753273-1-seanjc@google.com>
 <20220611005755.753273-7-seanjc@google.com>
Date:   Tue, 14 Jun 2022 09:45:01 +0200
Message-ID: <875yl3k7sy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Ignore host userspace reads and writes of '0' to PEBS and BTS MSRs that
> KVM reports in the MSR-to-save list, but the MSRs are ultimately
> unsupported.  All MSRs in said list must be writable by userspace, e.g.
> if userspace sends the list back at KVM without filtering out the MSRs it
> doesn't need.
>
> 8183a538cd95 ("KVM: x86/pmu: Add IA32_DS_AREA MSR emulation to support guest DS")
> 902caeb6841a ("KVM: x86/pmu: Add PEBS_DATA_CFG MSR emulation to support adaptive PEBS")
> c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")

These are 'Fixes:' tags I suppose?

...

-- 
Vitaly

