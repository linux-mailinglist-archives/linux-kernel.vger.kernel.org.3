Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B25507A72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356049AbiDSTrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356257AbiDSTrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54D34558A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650397495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5vCwuSK/712FB8g0Zizwg2pJoMPCopbwmLWH0e6BsO4=;
        b=cmHsWLuZ0aPURHI7DNAq9XRA13+1gCEM7qz9HCLl73rejjcMbCnr6mWlpAuu9KbEkP0aB3
        zMxQFVV+6Y+veAHDVrK1SeI6pXQQBU7qlprFk8mnOkf/y+VHA1Dt2Aa0D3605JRlGwED2t
        SfxA06clc4sIM0J4qrcKw4y+hJ4JnqA=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-Wn9R-qWiPMq4MnPHbBDOcQ-1; Tue, 19 Apr 2022 15:44:54 -0400
X-MC-Unique: Wn9R-qWiPMq4MnPHbBDOcQ-1
Received: by mail-il1-f198.google.com with SMTP id j4-20020a92c204000000b002caad37af3fso10135079ilo.22
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5vCwuSK/712FB8g0Zizwg2pJoMPCopbwmLWH0e6BsO4=;
        b=O5ZjFnPABas3bTOQvmNJHe3sqH69R2M3t1NeLT9sAJZIAnVkwBg0SXVw6XTgsOKaiL
         q134Muq6uCzHCbdMC6wRWkFNI+saqOk0axo1z9HNVwtx0zxqFaHN7FkPEyyxYDQIOvTQ
         HqE6HifAbMVUl5bH+iExjoZVCK1CrVDh6w2OU2WU/EghwopqZJebNA9b8JUVSW3WOt4m
         5h7KgB/R5vS41utHa+MoEJeFQRGu862znsLEWtzn2qCL6H4uuIdn2w1GQZ98xFK+kHC2
         C2YNUykpXU0kCrfRNn+AcHCJnrGMSxM7KmQBlrFPMw3tbxoWDSzP4TefcNAXmPUxuZ+T
         dlNw==
X-Gm-Message-State: AOAM532fhCFydVuGxFj/Cm/36cqjIEqzNyYo91RKaLBW+aE8JJkUnobI
        V+vdT0IEsZ3Hzq0EWqHoVh7CLw52sJLhSm2+/ASCP8Nl4o5bSRsQSxAhTVs1dk61OqE/X6K3bqf
        nHkFYfzvL9KSve3ZJU1KtkCnI
X-Received: by 2002:a5d:85d2:0:b0:5ed:a17c:a25c with SMTP id e18-20020a5d85d2000000b005eda17ca25cmr7435269ios.85.1650397493141;
        Tue, 19 Apr 2022 12:44:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBLdhTL+ZNpa9L5wyZ5vSYwDFzzRA9HFCZfgMNAwtPqtegu+snbmrfU3mWAijR65esmn175w==
X-Received: by 2002:a5d:85d2:0:b0:5ed:a17c:a25c with SMTP id e18-20020a5d85d2000000b005eda17ca25cmr7435248ios.85.1650397492575;
        Tue, 19 Apr 2022 12:44:52 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id q13-20020a056e020c2d00b002caa365b43bsm9585490ilg.76.2022.04.19.12.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 12:44:52 -0700 (PDT)
Date:   Tue, 19 Apr 2022 15:44:50 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 01/23] mm: Introduce PTE_MARKER swap entry
Message-ID: <Yl8RMjgIoW0r2TFM@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014646.13522-2-peterx@redhat.com>
 <87o80xjwvd.fsf@nvdebian.thelocal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o80xjwvd.fsf@nvdebian.thelocal>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 06:25:31PM +1000, Alistair Popple wrote:
> Hi Peter,

Hi, Alistair,

> 
> Is there something I have missed that means PTE markers can only be used with
> file-backed memory? Obviously that's all you care about for this patch series,
> but if we needed to mark some anonymous PTE for special processing is there
> anything that would prevent us using a PTE marker? Specifically I was thinking
> about it in relation to this series:
> <https://lore.kernel.org/linux-mm/87pmldjxiq.fsf@nvdebian.thelocal/>

It's not necessarily to be restricted to file-backed.  All the file-backed
check here in this series was just for safety purpose and nothing else.

I think it's a very good example of that swap-read-error case that pte
marker does sound like a great fit, but let's see whether people would
still like to stick with hwpoison which makes some sense too.  Then let's
keep the discussion in that thread.

Thanks for the pointer!

-- 
Peter Xu

