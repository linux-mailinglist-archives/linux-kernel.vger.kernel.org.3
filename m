Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B273553B53E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiFBIkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiFBIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B68129A631
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654159210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J9X9eKlzEclLa6MvLNYAdFd2zQQAwQquxfSZzdJAnY0=;
        b=RUmaX5lD5WwiRr3nbzne5QfAPJMv35kZH49maozEvIUk8IAQaISjvteKVHd4mfLBs4yHH2
        sNu+Zz99KkXkv4BcPJvcFtj30JScw4a0VuX9OIU7YCnfmO9DAgQVlVyDZLzqLNqfPjAqM7
        Vahw4cWjeV1uaxVtKrmCsW3VdHCMDk8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-iWA2hJLzNumbCbJDaXikfg-1; Thu, 02 Jun 2022 04:40:04 -0400
X-MC-Unique: iWA2hJLzNumbCbJDaXikfg-1
Received: by mail-wm1-f69.google.com with SMTP id c125-20020a1c3583000000b003978decffedso4804997wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 01:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=J9X9eKlzEclLa6MvLNYAdFd2zQQAwQquxfSZzdJAnY0=;
        b=q9RMa9NPyAQH+S/Gl2sv8rP193YNUOjf/1LXim70nEsZFpkN6FnFB9XDuQ/XMtDMle
         U2RdxPm2QefVHUUbtR3DpNgkcvE06wJ+RYYoj9twWwGyNBH6+UmwXHVaPWJZe2G6vjp5
         LZZaPdfLCAwl5xbTce+OgqW8uVrWG5fqIiL3yCgI6k89cG2XfNqfv6RaLs8GF93WCdwe
         qCHMLfBpfB+RhBIwuqbcYtBo6hwUl45sPf7BDKBQzdZ9Mo4gvRLfN9JjBNQYVv+HRCQJ
         0HfQrNI98d5eTTzdQ8wQKpn4M1AfwpbIwU+P2xU2cpXiD7oyiLhPMpC3ZqdDOknwrmX8
         LyRQ==
X-Gm-Message-State: AOAM530Pz+dtCnguyYC4R2wLNUoggc39fQimc2U+khVYJj6WKTo+JGUx
        KMCS/gosptGIwYBa8GvDLk//ZeCSORJ+VZOmLQg/gY5sYbHtwEm7gTCQ1Wu0SKO4/Gi+3vr0ynE
        Zq/szpdfxZSQbZMBTILg/FVvF
X-Received: by 2002:adf:f6d2:0:b0:211:f0bf:3d14 with SMTP id y18-20020adff6d2000000b00211f0bf3d14mr2763527wrp.264.1654159203387;
        Thu, 02 Jun 2022 01:40:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfIfFeYpd+hweqJ+/V1YU5ayupuojpWaT3H2UqQkV92iVE0trL+kBR715ZoiwRRgjTHCszLw==
X-Received: by 2002:adf:f6d2:0:b0:211:f0bf:3d14 with SMTP id y18-20020adff6d2000000b00211f0bf3d14mr2763500wrp.264.1654159203090;
        Thu, 02 Jun 2022 01:40:03 -0700 (PDT)
Received: from [192.168.178.20] (p57a1a7d6.dip0.t-ipconnect.de. [87.161.167.214])
        by smtp.gmail.com with ESMTPSA id h5-20020a5d5045000000b0020d07d90b71sm3675589wrt.66.2022.06.02.01.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 01:40:02 -0700 (PDT)
Message-ID: <a678504c-3468-12e5-b51d-5670bdf165e5@redhat.com>
Date:   Thu, 2 Jun 2022 10:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv6 10/15] x86/mm: Report unaccepted memory in /proc/meminfo
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-11-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220517153444.11195-11-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.22 17:34, Kirill A. Shutemov wrote:
> Track amount of unaccepted memory and report it in /proc/meminfo.

I feel like instead of doing this arch specific tracking here, we should
simply report the total number of unaccepted (base) pages in the buddy.

When the system boots up, the number will rise as unaccepted memory gets
exposed to the buddy. But especially once user space is up and running,
that number should only go down.

Once it hits zero, there is no unaccepted memory left in the buddy and
there won't be any performance surprises anymote -- and AFAIKT, that's
what we really care about.

-- 
Thanks,

David / dhildenb

