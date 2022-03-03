Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935214CB851
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiCCIIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiCCIII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:08:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DE401704C1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646294842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2mAGXBlKqRnW4B+OtLFqzxW5wMoYCTA1YJLFQ1QSJY=;
        b=TJGx2UTPuaZo61R0ubx4RutgL4LHt68eS4+velb5jOei+QXry5JvoUff/nx9FChHXz6DJs
        XmtgSMYTGUoCJsV6oH+K0gyCgyluvG2W3pNKwGjbd+AYAoenzDqsVgIa4iWajZV+Adj9Q9
        wTzoj4vwxb8iUqwA0biLnE2YkLzTTB8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-44_FQlFhNFaSZD1cGeUOBA-1; Thu, 03 Mar 2022 03:07:21 -0500
X-MC-Unique: 44_FQlFhNFaSZD1cGeUOBA-1
Received: by mail-wm1-f70.google.com with SMTP id n31-20020a05600c3b9f00b003812242973aso1406751wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 00:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=m2mAGXBlKqRnW4B+OtLFqzxW5wMoYCTA1YJLFQ1QSJY=;
        b=p2RuwS+9MD76pcnBOQFINQgEI7m7ZVPoolY1/HkXoLxEtZ4rGkUYzCSftpBfbdmAhj
         VX6q/uHx21c26elrAbHNnh/eBokOiZL86FkAjkchgeXKy1998Ao1/4D12w5Wdp+eDdgD
         qzIy/bY1vwVY2jfyJQwsCyZufzSxGvPaip6xEeZD+4e5bJ7Gqv3wn38wL6vK8elfD28x
         WLCvHxCoN9XuWH38pNPonNAbTPLP1sz06Ho38KguGEnAFTUruyk4QkjgFwTUBXBYLq7r
         D/2dsWZ16h+AfaoMQyO9zYEYOFhk2UUoGcw91UC7FQTor4EXd4in6yxWq4OtOSu8MR+9
         qyxA==
X-Gm-Message-State: AOAM531W4Lsrs14eaw6EpzG0qSJUb2Ff8kiSB2sCPQcP77ZR3gxdwexU
        AgMud2cer6+Tvmx2Vv1Al9b21U0lbAgQQYCimDID+2Xl1QUWH/ytoKJZRrBMk1wCVserz3pfeyE
        lBhLgAwg5rSLilNKEKaT6D/5a
X-Received: by 2002:adf:c188:0:b0:1e6:8ecb:ea5a with SMTP id x8-20020adfc188000000b001e68ecbea5amr24933479wre.711.1646294840362;
        Thu, 03 Mar 2022 00:07:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBVB6X+a+hnU5+DdOikbkM+SKCXiLBZpaVoc2emm4prXEv/lI7eCVSxUk0aFkP1LgEn5rVOA==
X-Received: by 2002:adf:c188:0:b0:1e6:8ecb:ea5a with SMTP id x8-20020adfc188000000b001e68ecbea5amr24933446wre.711.1646294840096;
        Thu, 03 Mar 2022 00:07:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:3600:f39a:d830:baab:42f0? (p200300cbc7063600f39ad830baab42f0.dip0.t-ipconnect.de. [2003:cb:c706:3600:f39a:d830:baab:42f0])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c4f4e00b0038181486018sm1393216wmq.40.2022.03.03.00.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 00:07:19 -0800 (PST)
Message-ID: <dcfda12a-58c0-caa0-f4b0-ec2b615540d4@redhat.com>
Date:   Thu, 3 Mar 2022 09:07:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RFC 12/13] mm/gup: trigger FAULT_FLAG_UNSHARE when
 R/O-pinning a possibly shared anonymous page
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220224122614.94921-1-david@redhat.com>
 <20220224122614.94921-13-david@redhat.com>
 <20220302165559.GU219866@nvidia.com>
 <fb895ba3-9d7e-7421-d5c6-f5e7a2d1231a@redhat.com>
 <20220302205934.GV219866@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220302205934.GV219866@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.22 21:59, Jason Gunthorpe wrote:
> On Wed, Mar 02, 2022 at 09:38:09PM +0100, David Hildenbrand wrote:
> 
>> (a) I want a R/O pin to observe file modifications.
>> (b) I want the R/O pin to *not* observe file modifications but observe
>>     my (eventual? if any) private modifications,
> 
> A scenario I know that motivated this is fairly straightfoward:
> 
>    static char data[] = {};
> 
>    ibv_reg_mr(data, READ_ONLY)
>    data[0] = 1
>    .. go touch data via DMA ..
> 
> We want to reliably observe the '1'
> 
> What is happening under the covers is that 'data' is placed in the
> .data segment and becomes a file backed MAP_PRIVATE page. The write
> COWs that page
> 
> It would work OK if it was in .bss instead
> 
> I think the FOLL_FORCE is there because otherwise the trick doesn't
> work on true RO pages and the API becomes broken.

Thanks for the nice example, it matches what John brought up in respect
to MAP_PRIVATE semantics.

-- 
Thanks,

David / dhildenb

