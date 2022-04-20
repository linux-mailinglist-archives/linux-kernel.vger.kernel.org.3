Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA98508ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379594AbiDTO23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351242AbiDTO21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4555927B06
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650464740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8DSx54ImoIrDcTZ0ltEH183UWHNgTANiSB/5rc9D3JE=;
        b=E3O+mx+IzmnUhzamyu1/pwbCMznXze385BFv/A5DjrQP183x7P85UomUu7NVfiEq+Z6D41
        vIqq00k31rX0qFr/K+3psqTxDbpOcGxRxSy7DanwTvf1wQUWNhCR7jnezqpezlAIyG+yY3
        iswvWBV2wLITzwJ0rNoVygybUiI1Klo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-sut2He30OsSCkWS-EwLmZA-1; Wed, 20 Apr 2022 10:25:39 -0400
X-MC-Unique: sut2He30OsSCkWS-EwLmZA-1
Received: by mail-il1-f200.google.com with SMTP id m3-20020a056e02158300b002b6e3d1f97cso986372ilu.19
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8DSx54ImoIrDcTZ0ltEH183UWHNgTANiSB/5rc9D3JE=;
        b=BtIcz07C0GE8S4FEabFripwprLNUze3YfsuX1di63f8DG7xBoSIlYcIiVxuqMmrwQZ
         WTQbF1JKiPSSuIc8OjZxwD+LBKvGIxE9b29ZWDDpwREtpqMNUyJJhPden9yOsa9KrxPW
         +73gULZoThLbcEtMsnQh1zvjsESl0G+FI0DE7aiYQXC66pOmAPucuFU/UDFB6oJLqGri
         zYmAHkaAIFq2RdM8qXSYDOpaQPemMzWK522W9wBevfPROT1DvvcPgOuddLG3FjjESJzE
         F4LNdFHoQbW7I8iqTF6qIUBdE2gP/AuCOofQ89Zv4dfD/jvW0jx0Yw/Ovhg+1G4TdACp
         jdAg==
X-Gm-Message-State: AOAM532qIPvkrDJ+gi+UuEFlFxPrv3D9KJp1kNL17fHr3Diz9nJy5qwk
        0JhjX8Vzdo0pESS4tC+ZM0xwguFXE+VhrmxwMNlb0jAaCZXSnvAFFpgtLBGdYm7t53kN0YlFjbI
        PN9PQohSWuGyapnem5KIpd7rW
X-Received: by 2002:a05:6e02:194e:b0:2cc:4e4c:fc9a with SMTP id x14-20020a056e02194e00b002cc4e4cfc9amr3237222ilu.178.1650464738515;
        Wed, 20 Apr 2022 07:25:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi8FH0j2gA8lyKO+QYNzf/oX37oN05YYk2uSAyOY7pC5pV0T5sVp835XJOoARGa9P9Xd6aOQ==
X-Received: by 2002:a05:6e02:194e:b0:2cc:4e4c:fc9a with SMTP id x14-20020a056e02194e00b002cc4e4cfc9amr3237212ilu.178.1650464738323;
        Wed, 20 Apr 2022 07:25:38 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id r9-20020a6b6009000000b006412abddbbbsm11320909iog.24.2022.04.20.07.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:25:37 -0700 (PDT)
Date:   Wed, 20 Apr 2022 10:25:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v8 22/23] mm: Enable PTE markers by default
Message-ID: <YmAX4IGu128Kinte@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014929.15158-1-peterx@redhat.com>
 <Yl7RrKV5mXtNAAzi@cmpxchg.org>
 <Yl8UmWQodLX+JkZ7@xz-m1.local>
 <Yl8YE+w+OWz5RNOL@cmpxchg.org>
 <Yl8bYKOJGW2py7Q0@xz-m1.local>
 <Yl8ojDwxsD/wqWM4@cmpxchg.org>
 <Yl8xKh9Dc+nPr30a@xz-m1.local>
 <YmAOn75O7zOOioXQ@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmAOn75O7zOOioXQ@cmpxchg.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 09:46:07AM -0400, Johannes Weiner wrote:
> My point was simply that for the user it might be easiest and most
> intuitive if userfaultfd and its related suboptions are 1) grouped
> together and 2) in the MM submenu.

Very reasonable request.

> Yeah it looks like there is a healthy mix ;) To add to the list:
> 
> - mm/Kconfig has CONFIG_SWAP for the swapon/swapoff syscalls.
> - fs/Kconfig has CONFIG_FILE_LOCKING, which adds the flock() syscall.
> - Interestingly, fs/Kconfig has CONFIG_MEMFD_CREATE for memfd_create()
>   which is implemented in mm/memfd.c.
> 
> It seems reasonable to me to move the userfaultfd stuff to mm as well,
> especially when it's becoming more than just a single binary question
> on whether you want a syscall or not, and has MM-specific suboptions.

Thanks for the extra information!

Obviously as you said it's growing a little bit.  I'll give it a shot later
today.

-- 
Peter Xu

