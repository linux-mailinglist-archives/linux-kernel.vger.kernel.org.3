Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118784B97EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiBQEzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:55:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiBQEzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:55:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 361891F227D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645073706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RMv0nYd6lGK+0myXiREIWX1spcR5nFtehllxBFTPu1Y=;
        b=ffx0aL2DMQ/sOBmuC+mhThf6r7EOAbvnIwvZ+J4rAyjPZ2Vg6mBXoAra+KxHtbFLctvYh1
        popFGxhi/W/lri+LoKXG3VEzOax+J5qa3oAxcTpieGWkUDgJy97z8TIUsr56ageP5z70qh
        1ek5lNLO0InrhPtIXizLE8RNo/3MTeI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-a5CmAR7wPKaaK16uHKXlEg-1; Wed, 16 Feb 2022 23:55:04 -0500
X-MC-Unique: a5CmAR7wPKaaK16uHKXlEg-1
Received: by mail-pj1-f69.google.com with SMTP id jf17-20020a17090b175100b001b90cf26a4eso2701489pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RMv0nYd6lGK+0myXiREIWX1spcR5nFtehllxBFTPu1Y=;
        b=MULFo6cfSXUqdwOvTKsWcXuMIfGEhWVLYPCbceFV168uOmaLDU4C6mJvKsZOu+uGYU
         r9bTowEALeC4JXoYd3OSidA8e8+zvI5kRGevi7C54SzbtTYoKMnYNZXdNn7PGsEC/YvI
         J1tz7+D5N0mydTp+eHqEtkb+ZzoMCk7NMML/DthVLQF1nKWIWWQ7NJnndbghZbaXjMyW
         RsepPG/TriFZcdioM23AtLIbrU+r9/HpD564m0QZo4jVEZy7Pam6x2yFywOd9Z1xAePm
         EuohHpvd5put+Ry2osevEnnFc3nsQMkhZPy7gj85d4eBBbjG7AUR0sDg8aiiYKBBeRoW
         Yu2g==
X-Gm-Message-State: AOAM5301sLmBuTGl6cK+XRADBJXFTc7UNALfCSIOxuvSSvB6grl6otAn
        VjkYtJol9iIfsY8X2hT5rKkKJ7iIjUiQH6GIUtYxNerDq66tiSZOAip+LFOY276xwHceALukLvb
        OQRB9O7WkWR4Lji61Zs/vfQO6
X-Received: by 2002:a63:64c5:0:b0:34d:3d6c:31d2 with SMTP id y188-20020a6364c5000000b0034d3d6c31d2mr1058953pgb.499.1645073703666;
        Wed, 16 Feb 2022 20:55:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWkBcDi1skevakW2rDEWyLhv5w6//N3woI9hMgQrmqsdqWPUoZgA2KY0t4hPceD8oDm7tX7Q==
X-Received: by 2002:a63:64c5:0:b0:34d:3d6c:31d2 with SMTP id y188-20020a6364c5000000b0034d3d6c31d2mr1058930pgb.499.1645073703415;
        Wed, 16 Feb 2022 20:55:03 -0800 (PST)
Received: from xz-m1.local ([94.177.118.126])
        by smtp.gmail.com with ESMTPSA id j15sm48731086pfj.102.2022.02.16.20.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 20:55:02 -0800 (PST)
Date:   Thu, 17 Feb 2022 12:54:54 +0800
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 4/4] mm: Rework swap handling of zap_pte_range
Message-ID: <Yg3VHr28m0739GQE@xz-m1.local>
References: <20220216094810.60572-1-peterx@redhat.com>
 <20220216094810.60572-5-peterx@redhat.com>
 <b04fabea-6216-3808-44e8-0a2125bf0230@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b04fabea-6216-3808-44e8-0a2125bf0230@nvidia.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 07:25:14PM -0800, John Hubbard wrote:
> On 2/16/22 1:48 AM, Peter Xu wrote:
> > Clean the code up by merging the device private/exclusive swap entry handling
> > with the rest, then we merge the pte clear operation too.
> 
> Maybe also mention that you reduced the code duplication in the 
> is_device_private_entry() area, by letting it fall through to the common
> pte_clear_not_present_full() at the end of the loop? Since you're listing
> the other changes, that one seems worth mentioning.

Isn't that the "we merge the pte clear operation" part? :)

I can add another sentence to it, if it looks better to you:

---8<---
Clean the code up by merging the device private/exclusive swap entry
handling with the rest, then we merge the pte clear operation too.  We do
it by letting the private/exclusive block fall through to the last call to
pte_clear_not_present_full().
---8<---

Thanks for the review,

-- 
Peter Xu

