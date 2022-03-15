Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CFC4D95EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbiCOIJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbiCOIJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A64971261D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647331699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vBxdygrDGnIdQovqZjnOBUiE0fFV5TKmJtEmU95vBEM=;
        b=UaDEf5iXYXl2xgIyf2JFZVzihSrcOyXxLViKJctWbox8rw/kB2cjRDq6qpK+msVOeodC10
        c1afdy+JDq7uv2BBMleLzKvu2Ay1pc3B/TAuFjh7KXJitnWcAGmLGX/nLMIIsaTuEIENUD
        SAX1GDe0Cf3zw0HaK+QOmiwpi/Qqvfw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-6b817DeGPQyyAwWY5mDNkg-1; Tue, 15 Mar 2022 04:08:18 -0400
X-MC-Unique: 6b817DeGPQyyAwWY5mDNkg-1
Received: by mail-wr1-f69.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so5014461wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vBxdygrDGnIdQovqZjnOBUiE0fFV5TKmJtEmU95vBEM=;
        b=7gR5RGYF0AGfFXvNOMxik3iMFYUCObR/MivrwFdK1FAc+5aLSA/jCjzQqYLS7mGnBo
         z8Qp2iEe9nsmnzpJFvaK38VYZbfo3sYZsOSOtEyxwEhU3/gW8NBRwXpLLO+OZBsStKTc
         QD1W4A2VKT5NO4NkX4QnY7Txx+RSoQOqyaUNh8tu7A/gp0ioXjd8f+mLMM0AuIeerhQb
         lR+VUPQwQvxbgcb2J54lysabz0t+VAm/2zeVzH7V5HsiE8jnrQF+06xYPQKVPKOzdusi
         tCMgg6yNAizCLx5YHJei7XXwgbhEX9cPFVQdz2kheZhINZI01SvNpMY7Sb7rJiVQzFjg
         x50Q==
X-Gm-Message-State: AOAM531kG/Ze2HtV+oU5FhMa7LLMpRHbIGGN8WruCGwvQ/nyvaiem24c
        Ru663mlnbOYvyqW6UvUOH3pd9PgnpS8YN+6fLasafdgbkYgMJM5CvdhTl3IITfb0emgI0iUBhgT
        j9Hf2zV78I+ToZ40D17x75FXY
X-Received: by 2002:adf:dc86:0:b0:1f0:250a:265 with SMTP id r6-20020adfdc86000000b001f0250a0265mr19331376wrj.85.1647331697396;
        Tue, 15 Mar 2022 01:08:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycN8k8k30GqvbuzPk3qK11Jv29vfX/EQcOg+NXt/NpyhDzihkbEOBexiZimm3rtZNSjRc4pA==
X-Received: by 2002:adf:dc86:0:b0:1f0:250a:265 with SMTP id r6-20020adfdc86000000b001f0250a0265mr19331361wrj.85.1647331697232;
        Tue, 15 Mar 2022 01:08:17 -0700 (PDT)
Received: from gator (cst2-173-70.cust.vodafone.cz. [31.30.173.70])
        by smtp.gmail.com with ESMTPSA id f7-20020a0560001a8700b00203c23e55e0sm3467969wry.78.2022.03.15.01.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:08:16 -0700 (PDT)
Date:   Tue, 15 Mar 2022 09:08:14 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Oliver Upton <oupton@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [RFC PATCH 000/105] KVM: selftests: Overhaul APIs, purge VCPU_ID
Message-ID: <20220315080814.sqfhamts5tekhxlj@gator>
References: <20220311055056.57265-1-seanjc@google.com>
 <20220314110653.a46vy5hqegt75wpb@gator>
 <Yi+B5bZ1LpaNCUJT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi+B5bZ1LpaNCUJT@google.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 05:56:53PM +0000, Oliver Upton wrote:
> 
> I think it may make more sense to only define optional functions as
> weak and let the compiler do the screaming for the required ones. Only
> discovering that functions are missing at runtime could be annoying if
> you're cross-compiling and running on a separate host with a different
> architecture.
>

Ah, indeed, no reason to push the lack of required arch functions to
runtime detection, compile time is much better. And, in those cases,
the _arch_ naming will also provide a nice hint that one must implement
it in arch specific code.

Thanks,
drew

