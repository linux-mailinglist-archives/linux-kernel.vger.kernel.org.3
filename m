Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46484F473D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350042AbiDEVEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392285AbiDEPgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2E3913D0A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649166515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZveUJKzsoCzkXjLEmVVwtjwhVIlnnTQ1b+zTECXTF/U=;
        b=G5kJ65kb7zw/NQQb13mDyCYU13+pExTyZZtoy9vkmSP5K8L/OTjkZ4erldv4N41khJHuNF
        TSZAPy1u+MdvM7PSuXJYLJWo9Yj5/XK5lY86PYVDk9E3okiCUmfr7Gf2ePb228/9poxHBU
        AgbVPNQHKqZtTx2/gdH9LZiKLFR7pfM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-_WSV99ANOFOfiwbtjLtvrw-1; Tue, 05 Apr 2022 09:48:33 -0400
X-MC-Unique: _WSV99ANOFOfiwbtjLtvrw-1
Received: by mail-wr1-f70.google.com with SMTP id x17-20020adfbb51000000b002060ff71a3bso1360320wrg.22
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZveUJKzsoCzkXjLEmVVwtjwhVIlnnTQ1b+zTECXTF/U=;
        b=XIXhNHanNx5LbGnB+W3HckA4/SI5gmfHyiM8eCIFqwGqCBikjOVPqLGtqY6AaFsaNu
         lSKrklKTK9CAARLaQ8nkHuchoE5z4SMDrEhIxOAoLcPQcVBtFK1HnKPJfBj5Wf1CGjE8
         UZcWda0BXl9WAP8k55bItMBiXzc1zxwcJuVmVPn62WyLJeF1V3H24JSWBVVpMkPFCHlT
         84jzpxmln3dWbFcZ9rSfqqtXG9dzfh+jAaMm6Ge0FNWSJ+3NhgwCvblNyRrxvqfBNWLb
         WuhI1UIakNgSomA5c1RshzUKzqnEjq9GK50g2zTbOsPjxY/q6InLQF4ublJwBrqwilgQ
         g14Q==
X-Gm-Message-State: AOAM530iaLoirSoNi7cUGNsdtDj8Hh5my0P9DgI9CbbJMX+oYzjJ9Av4
        +OiYtueTnzuOjxWbnVsrhpohF0D6C7cpVFFUyLQ1Eue6VOj24TQ99RBHiOPmwyVadlaZ6kzcsMz
        qle1oFU5pEsbZvmcglhCTKhfR
X-Received: by 2002:a7b:cd13:0:b0:38c:9a08:5c62 with SMTP id f19-20020a7bcd13000000b0038c9a085c62mr3234416wmj.154.1649166512157;
        Tue, 05 Apr 2022 06:48:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgxLrzuXmRgcHGSm9NougyOgwDnbf47hIlS2lc6czMniBzy/El5Zf8y2oTdwEa1oPyH4skoA==
X-Received: by 2002:a7b:cd13:0:b0:38c:9a08:5c62 with SMTP id f19-20020a7bcd13000000b0038c9a085c62mr3234400wmj.154.1649166511973;
        Tue, 05 Apr 2022 06:48:31 -0700 (PDT)
Received: from [10.32.181.87] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id o19-20020a05600c511300b0038d0d8f67e5sm2275912wms.16.2022.04.05.06.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 06:48:30 -0700 (PDT)
Message-ID: <5093bff2-bc85-57b9-5f8b-ecb81417409e@redhat.com>
Date:   Tue, 5 Apr 2022 15:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 032/104] KVM: x86/mmu: introduce config for PRIVATE
 KVM MMU
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <770235e7fed04229b81c334e2477374374cea901.1646422845.git.isaku.yamahata@intel.com>
 <55fa888b31bae80bf72cbdbdf6f27401ea4ccc5c.camel@intel.com>
 <20220401015130.GE2084469@ls.amr.corp.intel.com>
 <9e01bc014df60e215ba17432c06b6854f6dae3f8.camel@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <9e01bc014df60e215ba17432c06b6854f6dae3f8.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 04:13, Kai Huang wrote:
>> I don't want to use CONFIG_INTEL_TDX_HOST in KVM MMU code.  I think the change
>> to KVM MMU should be a sort of independent from TDX.  But it seems failed based
>> on your feedback.
> 
> Why do you need to use any config?  As I said majority of your changes to MMU
> are not under any config.  But I'll leave this to maintainer/reviewers.

There are few uses, but the effect should be pretty large, because the 
config symbol replaces variable accesses with constants:

+static inline gfn_t kvm_gfn_stolen_mask(struct kvm *kvm)
+{
+#ifdef CONFIG_KVM_MMU_PRIVATE
+	return kvm->arch.gfn_shared_mask;
+#else
+	return 0;
+#endif
+}

Please keep it.

Paolo

