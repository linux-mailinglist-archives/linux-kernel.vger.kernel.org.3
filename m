Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9EE598A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbiHRR0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344942AbiHRR0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21794D24F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660843564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kaf0MkKhKvnMfHmWNydWqWYsE73+Hvoylc8uSsXc2Yc=;
        b=h3jQhyaogZb2rJuIjO3QDjWtGvwOOna2nCWbfYtnzf2Dz7lqAIjryUZGzJnTIxPwPq/gno
        4XQ2av4dNHYLNGxH84xNET51rbX1LgqZ10wrf91W9tzeBcdwzU/T+imyA3EwvCYmvXVF9C
        c95Qn8N9lL1MmtMw/U7v5Z5ZBT9cMn4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-XclQCTj0PZWc4MQYsvfxyQ-1; Thu, 18 Aug 2022 13:26:00 -0400
X-MC-Unique: XclQCTj0PZWc4MQYsvfxyQ-1
Received: by mail-ej1-f69.google.com with SMTP id gs35-20020a1709072d2300b00730e14fd76eso909148ejc.15
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Kaf0MkKhKvnMfHmWNydWqWYsE73+Hvoylc8uSsXc2Yc=;
        b=nW5ucL9q9HbbKZLIyJFqCsV5ZNKkGxjpGMQuHyYnsuP6XKiRVmEnP/kzydzNTVDwUi
         syLBpzSU5+zBzQq7N1cCR+FQqkEr1rFgUPQg55GjB87VcxS4qGKOqXyAqhpqufOtOoH/
         DARBdF833gdUh711R0Xb/YzxknMtmYwNO+tAUYcHl+9gjgnQao35p57ZcLXdh4ScSmXT
         8VSpNWoljxFGF6IL0FsU2qE2Jz5xQJlHHffXpbYOzx6wktedsBblf3z7mWnLq1fTu20q
         YNochekHy3zQonEnGd05aG4OjY4R3cVYgd93+Yx7U6eRj4HHlM47iEK2wR3Q9BhHC6KN
         8gRg==
X-Gm-Message-State: ACgBeo1gcbExe3eMaS8psZmRL50d19Ut9xnLIetv8ZvD/CroUbBkeLlE
        tXNakeaLNtbeQQ59pFcoul2ZDis2BxAR8eBJkFFK5m1yDVABfIPzXWYFLYP5sP1EYD5jvKEKvJk
        7KVUmXL9wDLMwvycOYJ16T/xl
X-Received: by 2002:a05:6402:1294:b0:445:eb35:1af3 with SMTP id w20-20020a056402129400b00445eb351af3mr2958951edv.392.1660843559109;
        Thu, 18 Aug 2022 10:25:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4+hQY/Uhq0AS9HRrx7LJQnY88Hi3zEbNhJMMPdUiDld7WQHe7G2JdILyjpMqvKN/cboEN/lw==
X-Received: by 2002:a05:6402:1294:b0:445:eb35:1af3 with SMTP id w20-20020a056402129400b00445eb351af3mr2958937edv.392.1660843558908;
        Thu, 18 Aug 2022 10:25:58 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id m5-20020a50cc05000000b0043cf2e0ce1csm1459332edi.48.2022.08.18.10.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 10:25:58 -0700 (PDT)
Message-ID: <64365019-57dc-b449-8178-30428e09adf8@redhat.com>
Date:   Thu, 18 Aug 2022 19:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/3] x86/kvm, objtool: Fix KVM "missing ENDBR" bug
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Pengfei Xu <pengfei.xu@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Su, Heng" <heng.su@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1660837839.git.jpoimboe@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <cover.1660837839.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/22 17:53, Josh Poimboeuf wrote:
> Fix the "missing ENDBR" KVM bug, along with a couple of preparatory
> patches.
> 
> Josh Poimboeuf (3):
>    x86/ibt, objtool: Add IBT_NOSEAL()
>    x86/kvm: Simplify FOP_SETCC()
>    x86/kvm: Fix "missing ENDBR" BUG for fastop functions
> 
>   arch/x86/include/asm/ibt.h | 10 ++++++++++
>   arch/x86/kvm/emulate.c     | 26 ++++++--------------------
>   tools/objtool/check.c      |  3 ++-
>   3 files changed, 18 insertions(+), 21 deletions(-)
> 

Queued, thanks!

Paolo

