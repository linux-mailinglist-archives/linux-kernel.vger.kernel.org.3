Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75CA51C60A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382319AbiEER3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349464AbiEER3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:29:38 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EE5B5C86D
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651771557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tT2BrC5wtpY98Xyl4U1QZDUp/OCUTw1Ys8ss+GOAfFE=;
        b=IqXg+5hND66iCJuST0xzf5R+cyJ5uwKG9x2NpB8eCb1GCNi/7E2ZGPwCGJvfIV6l5NsXvT
        znNyWixF6X1IWMjbENb5WbD57v1yVcX17Cr8iXqesv9miT0RG2gOYUxgi5b76+W0JhY2E8
        qBeZ/TVt5a6JmPOmsC8YXoJWCkeKkXE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-R3UbHB9_NfmkjO8UPxzoAw-1; Thu, 05 May 2022 13:25:56 -0400
X-MC-Unique: R3UbHB9_NfmkjO8UPxzoAw-1
Received: by mail-io1-f71.google.com with SMTP id k2-20020a0566022a4200b00654c0f121a9so3356046iov.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 10:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tT2BrC5wtpY98Xyl4U1QZDUp/OCUTw1Ys8ss+GOAfFE=;
        b=8Jnu2usKG/SuNADQ6mLKsUpK7zMkDZX33rX2deAukwinqRVTpXcCQNg2/37HAfo5pi
         6/enKRJpLq79vOtjZRiHItVdEQDikdGlebwKz6145Ckq1pEipX0AYtr3fB3W3DVz6+04
         7CKm4CHkfjmJgZfyBD+EmxuY4fomfap50zQ2Wet5MjaE1YjwIOfZkYAXCGztvsbl6IdH
         FG/CkZzPbSQet7jCudDSA9HQ5JzfUC1+opQH2JUZW9NTxME4cTfj2faOOwzG7jELc5jZ
         YuXIZ2juxs+VO3ZaDlwNrcuZTIwKGQX4Sc2yJ4m9tMYakGB+gjQwuym8yFrFOKlSODPp
         xSvA==
X-Gm-Message-State: AOAM531oTxdpRfAOuVYFYMQcM88WHUTWlAULr4Poz16w9eCdyiCpLseh
        HZcyWnad+b3tgYAD5ID0+cMdLrbFoSvElNlPZIMBUEb4+cN7vufLZWlw1THO2uMyZNbjCTPGtfm
        h+cd6jl2inGiBaDcLe8F16C8v
X-Received: by 2002:a05:6638:40ac:b0:328:6b81:f9e8 with SMTP id m44-20020a05663840ac00b003286b81f9e8mr11353107jam.153.1651771555622;
        Thu, 05 May 2022 10:25:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC+oM9RGzodl9hkJpceUHdPlHK9Zhnz05l6pq0+J+sejC41muNngNg+JonwkN9XxNJwtUZnA==
X-Received: by 2002:a05:6638:40ac:b0:328:6b81:f9e8 with SMTP id m44-20020a05663840ac00b003286b81f9e8mr11353103jam.153.1651771555414;
        Thu, 05 May 2022 10:25:55 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id m2-20020a056e020de200b002cde6e352d4sm589943ilj.30.2022.05.05.10.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 10:25:54 -0700 (PDT)
Date:   Thu, 5 May 2022 13:25:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Message-ID: <YnQIoVqXZQGILt6F@xz-m1.local>
References: <20220502173558.2510641-1-minchan@kernel.org>
 <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
 <YnAhaRNjmIhtGUjk@google.com>
 <08e9855c-395d-f40c-de3d-1ec8b644bfe8@redhat.com>
 <YnFJss0doXGCmq3w@google.com>
 <da07530d-92ad-7aef-2f2b-d115f878ef76@redhat.com>
 <YnMC1jFoPvNLWqnG@google.com>
 <YnNzPlehofB57XXU@google.com>
 <dd4588a4-c1ca-481c-ac33-06abef6cf70a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd4588a4-c1ca-481c-ac33-06abef6cf70a@oracle.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 10:00:07AM -0700, Mike Kravetz wrote:
> Gigantic pages can only be migrated IF there is another (already allocated)
> gigantic page available.  The routine to try and allocate a page 'on the fly'
> for migration will fail if passed a gigantic size.  There 'might' be a free
> pre-allocated gigantic page.  However, if the user set up CMA reserves for
> gigantic page allocations it is likely the free gigantic page is also in CMA.
> Therefore, it can not be used for this migration.  So, unless my reasoning
> is wrong, FOLL_LONGTERM would almost always fail for gigantic pages in CMA.

I'm probably not familiar enough with CMA, but.. I just noticed that if CMA
is destined to not be able to be pinned then maybe it'll lose quite a few
scenarios where pinning is a possible use case.  It doesn't even need to be
the major use case, but as long as it's possible (e.g. hypervisors hosting
virtual machines with device assignment) it'll be a hard no to CMA, which
seems to be a pity.

-- 
Peter Xu

