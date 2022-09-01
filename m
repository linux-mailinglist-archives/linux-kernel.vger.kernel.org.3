Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5975A9E68
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiIARpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiIARpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:45:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBF95C97C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662054246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQOn0UueP4f1CSvnyezbvyIBmYegvrdiesOa5q4EoyU=;
        b=e1GnV13wXBMlZlgO7uuVSOcU/+5wbNy3WSRrdsNd6Rl2RljUUHqub6pwPS/XHbaYu4POoK
        Aa9dzqsHymPvrz84guDpwUJpQ+NSHOE55aYz3+cw1Z3U6us7OU1i21b0MJ6fX5A7mhOnet
        1VcGwu4ZGE2LwAGIByKObzdcil1h/4U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-462-bIaAbxaDPjO_6FjCE6IHmQ-1; Thu, 01 Sep 2022 13:44:05 -0400
X-MC-Unique: bIaAbxaDPjO_6FjCE6IHmQ-1
Received: by mail-wm1-f72.google.com with SMTP id h82-20020a1c2155000000b003a64d0510d9so10149226wmh.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=FQOn0UueP4f1CSvnyezbvyIBmYegvrdiesOa5q4EoyU=;
        b=qH2JfvS0VbNxi3ZjzrN8gDAgisEage5mzY/UFABb6xx/0NEnryqUONFgwZQvU8e2aV
         DUgvQhQD0CUZmwb5hQBTLvtoxRdxfzMddBUTrtyFf/HjKFEkzJOUCBWpuA3yoNAVufK0
         tR+XuGe3OnsfY4JV3mk9qu+rwiq1uN4sEZ+vCx3HGTKhYDXpYMz5POlR0V8z89/O7mNx
         HOnFzmHCrdc+0mCDCWlL1WmsJ1BV1nolrTz8JodnlI0y05rhkphQR9yU9SyQYLBqbxVh
         1UzGw3y0ENi62/MuyOjDXR7dqsu4Z6IkU8rUHroolzl8wPFJB3cYRp9Qivs2tGLnr8Oe
         ZnoA==
X-Gm-Message-State: ACgBeo2FHEdEPEx5lwUwfS5paDD7yz3ya2gTIh53GgOWVMaFHOPsip4h
        nXVcp21+TXPs6ivvR7ATZ2H5CTCFSQt8AgrhxFxBpsrnyJBFvz2DLzauVO6eMcjH0A357qeXo/t
        IPSx5J990+ws871Cmr63dJrsy
X-Received: by 2002:a1c:7c0d:0:b0:3a6:673a:395e with SMTP id x13-20020a1c7c0d000000b003a6673a395emr169622wmc.67.1662054244061;
        Thu, 01 Sep 2022 10:44:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4RzluDc/Wv+Wtio+db/BCrCcybF1ARP21JtBC1oqfw+IAEf7B2nGKiBSs5+C9mOhjB/UwFRw==
X-Received: by 2002:a1c:7c0d:0:b0:3a6:673a:395e with SMTP id x13-20020a1c7c0d000000b003a6673a395emr169606wmc.67.1662054243823;
        Thu, 01 Sep 2022 10:44:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9e00:fec0:7e96:15cb:742? (p200300cbc7079e00fec07e9615cb0742.dip0.t-ipconnect.de. [2003:cb:c707:9e00:fec0:7e96:15cb:742])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d428e000000b00225232154d7sm9124954wrq.110.2022.09.01.10.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 10:44:03 -0700 (PDT)
Message-ID: <c6990d62-a456-b7c5-f128-311ee758c161@redhat.com>
Date:   Thu, 1 Sep 2022 19:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
References: <20220901072119.37588-1-david@redhat.com>
 <YxDdycTur733hMgt@xz-m1.local>
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
 <YxDghv54uHYMGCfG@xz-m1.local>
 <c9dc3f22-4a72-9b9d-7a74-ad77fe4f3b6e@redhat.com>
 <YxDu51TQTz8lhIPP@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YxDu51TQTz8lhIPP@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> It can be dropped later if you want to rework the thp collapse side and
>>> finally remove IPI dependency on fast-gup, but so far it seems to me it's
>>> still needed.  Or just drop this patch until that rework happens?
>>
>> The doc as is is obviously stale, why drop this patch?
>>
>> We should see a fix for the THP collapse issue very soon I guess. Most
>> probably this patch will go upstream after that fix.
> 
> No objection to have this patch alone as the removal statement is only
> about "thp split".  But IMHO this patch alone didn't really help a great
> lot, especially if you plan to have more to come that is very relevant to
> this, so it'll be clearer to put them together.  Your call.

I can hold off the resend until the the fix is in place. Then I can add
to the description that we are not aware of remaining IPI dependencies,
and one undocumented case was broken and got fixed without the need for
IPIs.

Thanks!


-- 
Thanks,

David / dhildenb

