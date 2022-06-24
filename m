Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EF4559EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiFXQlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiFXQlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43DCD52E5D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656088903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t/smxZEQF0rlrINP54p9ZMkprKgJw4xyF6tUA17beEk=;
        b=aVG7IHSNwRPL7RJUnsN4DYsoEuAYab5Tl+5Yq1kyj39CQYShl/uQVS9lOB20y8rT+6UIbW
        ebgwsmCKgLxa/sR9R935IAGiLE48H37LIYfHskGeleJaL0Pf8pBUslEBL48t4akEJvZwkA
        BlMArX+tVxLaIrHrpC8Z5q+b8pbRalY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-c-QTd3EePvCX0LvfgxgUbA-1; Fri, 24 Jun 2022 12:41:41 -0400
X-MC-Unique: c-QTd3EePvCX0LvfgxgUbA-1
Received: by mail-ed1-f70.google.com with SMTP id i9-20020a05640242c900b004373cd1c4d5so1440581edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=t/smxZEQF0rlrINP54p9ZMkprKgJw4xyF6tUA17beEk=;
        b=HT6TqF2KiCOsfl73cm+4g2klJ2lqUqVzi+VwaeqpEt++NjYIHTPnK0R3M9RJDUUg7D
         3yzwod/UUoCtLRlovwzqqVOpHvKnb20ifRSdtg+O1QyonuXKOG8Ceq5uD30Y5BzLUzBc
         K5bjNvL/PtXc7osqrGB6DuA4o4ZltX+mhOAFb3Acs8Q/WJamHJ6yJ8olidzARahZWlSZ
         plHJkV65YpDUZH9eOgtpGFuahMndNjWYbPY601jSixg5uM9EdMks4fNyc6B4OMiEVItT
         6WsS6gmaWknPqttrQVznhe5SPkj9V9n7xiA9ts/1Pufwx7H28ABRG/JaI89uTfIiP4w8
         ruzw==
X-Gm-Message-State: AJIora+FAfnGX/pce/2zkrgvcOwzHkDlQaebiFVjitPO8MNFWbGlFW4F
        0LdZ3FmfAiFh3mZXwLiTwnaNEgWIAHrprncyje2d+3qSFP/Afn6ZqCGgnnLULy9gRkS8K/v43aa
        qqLyHHPLMYTcO8d1Nv6CXuBUv
X-Received: by 2002:a05:6402:3707:b0:437:61f9:57a9 with SMTP id ek7-20020a056402370700b0043761f957a9mr2892427edb.1.1656088900708;
        Fri, 24 Jun 2022 09:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sAHyieuKfgfF7xh3Bu0JCOHWMglxujHSYQjWb6iC7JSljzlAJM8HrCC5MS9mk5P6odIu8b4g==
X-Received: by 2002:a05:6402:3707:b0:437:61f9:57a9 with SMTP id ek7-20020a056402370700b0043761f957a9mr2892407edb.1.1656088900517;
        Fri, 24 Jun 2022 09:41:40 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id bq15-20020a056402214f00b00435a742e350sm2451592edb.75.2022.06.24.09.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 09:41:39 -0700 (PDT)
Message-ID: <b8610296-6fb7-e110-900f-4616e1e39bb4@redhat.com>
Date:   Fri, 24 Jun 2022 18:41:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     mlevitsk@redhat.com, seanjc@google.com, joro@8bytes.org,
        jon.grimm@amd.com, wei.huang2@amd.com, terry.bowman@amd.com
References: <20220519102709.24125-1-suravee.suthikulpanit@amd.com>
 <20220519102709.24125-16-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 15/17] KVM: SVM: Use target APIC ID to complete x2AVIC
 IRQs when possible
In-Reply-To: <20220519102709.24125-16-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 12:27, Suravee Suthikulpanit wrote:
> +			 * If the x2APIC logical ID sub-field (i.e. icrh[15:0]) contains zero
> +			 * or more than 1 bits, we cannot match just one vcpu to kick for
> +			 * fast path.
> +			 */
> +			if (!first || (first != last))
> +				return -EINVAL;
> +
> +			apic = first - 1;
> +			if ((apic < 0) || (apic > 15) || (cluster >= 0xfffff))
> +				return -EINVAL;

Neither of these is possible: first == 0 has been cheked above, and
ffs(icrh & 0xffff) cannot exceed 15.  Likewise, cluster is actually
limited to 16 bits, not 20.

Plus, C is not Pascal so no parentheses. :)

Putting everything together, it can be simplified to this:

+                       int cluster = (icrh & 0xffff0000) >> 16;
+                       int apic = ffs(icrh & 0xffff) - 1;
+
+                       /*
+                        * If the x2APIC logical ID sub-field (i.e. icrh[15:0])
+                        * contains anything but a single bit, we cannot use the
+                        * fast path, because it is limited to a single vCPU.
+                        */
+                       if (apic < 0 || icrh != (1 << apic))
+                               return -EINVAL;
+
+                       l1_physical_id = (cluster << 4) + apic;


> +			apic_id = (cluster << 4) + apic;

