Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD057DB18
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbiGVHSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiGVHSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 397BB30F4F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658474286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PEPMG/npQMivjV0T9Q//xsOIeoNgprxx4pTJ3pO1hI=;
        b=AncBmsee85gjifsgAfm4QAZ2RcxRE6Drp7/sKQxZ9L5XhBWIqApMKOZQWGgadVt5e7jtcl
        4SiyAmKvIptLUTwUnUFW9crePbz/j6It1VBJNrHiN/rj5Wk0SA2q4H0GvJibFfy5gYaIwD
        RsStJtLPO4SALrxdrJSsk5qxBVlppQo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-RH0oD06jNJyTrAWNc4MGEQ-1; Fri, 22 Jul 2022 03:18:04 -0400
X-MC-Unique: RH0oD06jNJyTrAWNc4MGEQ-1
Received: by mail-wm1-f72.google.com with SMTP id c126-20020a1c3584000000b003a02fa133ceso2113696wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7PEPMG/npQMivjV0T9Q//xsOIeoNgprxx4pTJ3pO1hI=;
        b=BntU3NLhEPry4e56VreMfv3MYx4iIczXTzsEdh0dW9ALKmX7vcn+7jmEbuWzUnnHeG
         jWPeXAYhGWBbuWF876eXhvObpPjszdJY1ODbYG/2bF6ZHEfBD05ZffopBxOVBWsq6E7o
         p+2m43ZIX4CPyUZX0Dti7/MyDrpTFtxw18FmZrNny1c5xknaNYl2TNfiLzNLlT6TcTpQ
         7QKLIYp2xrr2E5revqLbDBp9zaCQOWCrZLO1hER1YK0Ki5FcPdmyITHuIEkixLBOJjPI
         ZvpwB8m1AaVZxfZeQFstzOasVnpdTSMJj9IKcLWrKDno4FLOomzwXXPEgNvq9zSZjTSa
         u8mA==
X-Gm-Message-State: AJIora/tqYKB8Uuh/HWxHl4zo7WvwkMKPuZBfzunoJhPS2JfPxucIWp8
        U83+syJblYsvHoRvvQkbUHbeUTixMv+uiE4rZsz6WxBxPMmrg25RRbhA0h32+UUDMgcFhgllREQ
        OEayxhidMrBXMYutxuaFMInSD
X-Received: by 2002:a05:6000:186:b0:21e:5874:2bfb with SMTP id p6-20020a056000018600b0021e58742bfbmr1488658wrx.510.1658474283249;
        Fri, 22 Jul 2022 00:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vX0w2NIOUAj/gte8sQkJ9cuc1lccA/yNy+9enje5QT0Cp7tZ8RSTzWgS0Ceq+Bu+z/9OXPUQ==
X-Received: by 2002:a05:6000:186:b0:21e:5874:2bfb with SMTP id p6-20020a056000018600b0021e58742bfbmr1488622wrx.510.1658474282682;
        Fri, 22 Jul 2022 00:18:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6? (p200300cbc707cb00cd6b7964cc7db0e6.dip0.t-ipconnect.de. [2003:cb:c707:cb00:cd6b:7964:cc7d:b0e6])
        by smtp.gmail.com with ESMTPSA id q6-20020a1cf306000000b0039c5ab7167dsm7590904wmq.48.2022.07.22.00.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 00:18:02 -0700 (PDT)
Message-ID: <8bd436af-7f9a-5dc0-1e16-d07fc653942e@redhat.com>
Date:   Fri, 22 Jul 2022 09:18:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/3] selftests: Add soft-dirty into run_vmtests.sh
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20220721183338.27871-1-peterx@redhat.com>
 <20220721183338.27871-4-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220721183338.27871-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.22 20:33, Peter Xu wrote:
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/vm/run_vmtests.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
> index 2af563a9652e..de86983b8a0f 100755
> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -190,4 +190,6 @@ then
>  	run_test ./protection_keys_64
>  fi
>  
> +run_test ./soft-dirty
> +
>  exit $exitcode

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

