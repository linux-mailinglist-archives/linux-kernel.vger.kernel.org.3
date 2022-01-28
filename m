Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A958949F1E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345799AbiA1DaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:30:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345795AbiA1DaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643340620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yWI4mSyMPfEGNDG7ZY+imHKSZHJZA8c9YX1u5t0lQ5c=;
        b=S8sefC62Uq6+Ut+/P0ummX4oJBnBbxW3uTNs8ET8CB5eQssnbuwMKuxbu+0xP/97ApXxVE
        8o/luiYjzbQW+XBpasnHUPNSlTPRdGNw7YO9M1dLPBd5gQ4ViFsuFYWD2rs3YR0ni5M0X6
        aucQW/m02t2bMRUJRzsyjJKQp73ZhBY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-8hocAmG_PreHTmHkwqlJdw-1; Thu, 27 Jan 2022 22:30:19 -0500
X-MC-Unique: 8hocAmG_PreHTmHkwqlJdw-1
Received: by mail-wm1-f69.google.com with SMTP id s190-20020a1ca9c7000000b00347c6c39d9aso2342305wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 19:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yWI4mSyMPfEGNDG7ZY+imHKSZHJZA8c9YX1u5t0lQ5c=;
        b=PNa0CyAhULLbNlh1kzlSq3mD0soCS7B8iBExm5CnqmK0VBAIHOHDyx0E41sXcZlFhp
         if2PolvDWjvEshL024mEQ0kuSEsdyesPafq7jgGQut630ral7lIbb6jWhT27Yx0JavO/
         cpDePu2JpvJwX6RUZ0bvv1wyrrnvCvYRlLb3s4hmLU6kQr1rqKuetY7U/wPW9g9+plt8
         219VpKlGK+IyE6byv0XFcXfOt34a58y6VPGcoghcYrKd3vL/waNZfJWzJUn8lUHQ37Ps
         yjJoGjMg+6bxNRh2mLUsv+QuaJThjF6gI4NG5Dol/Ak3sVYvAiPajMttdtm7DyCy5Kly
         Y8SA==
X-Gm-Message-State: AOAM533B8YrfviERPjQAMYJD5FlRabdAKLeP0OQW8bI2nKO/+Z8Be8bi
        Uh3rdccghw/+68rFr6deUl6YzpfA59ao5Ja6LvZnTgInWa99JXbvymBshJnvAHG7AuM5Wr8hZTU
        I+pp49wXO773W/FVy0srbMMaR
X-Received: by 2002:a5d:4dc6:: with SMTP id f6mr5255758wru.255.1643340617835;
        Thu, 27 Jan 2022 19:30:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4fygcXEjGmyBwc0eSz9VlZ7/dhPCinB97oCLxm3a5TE3y78GbubhUfyHuwvXqmbn6pcAA7Q==
X-Received: by 2002:a5d:4dc6:: with SMTP id f6mr5255746wru.255.1643340617661;
        Thu, 27 Jan 2022 19:30:17 -0800 (PST)
Received: from xz-m1.local ([64.64.123.9])
        by smtp.gmail.com with ESMTPSA id v5sm835287wmh.19.2022.01.27.19.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 19:30:17 -0800 (PST)
Date:   Fri, 28 Jan 2022 11:30:10 +0800
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] mm: Fix invalid page pointer returned with FOLL_PIN gups
Message-ID: <YfNjQhpxmWEeswkb@xz-m1.local>
References: <20220125033700.69705-1-peterx@redhat.com>
 <f5400544-f602-0bb4-5cb1-5ac682e41974@nvidia.com>
 <20220127004206.GP8034@ziepe.ca>
 <YfJjhop3senAUjue@xz-m1.local>
 <20220127152538.GQ8034@ziepe.ca>
 <YfNIjqPpty0YkLJP@xz-m1.local>
 <313e02c7-c116-3fe3-6747-d9e1b58ba2bb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <313e02c7-c116-3fe3-6747-d9e1b58ba2bb@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 06:32:27PM -0800, John Hubbard wrote:
> What you are missing is that other people are potentially writing code
> that we haven't seen yet, and that code may use follow_page_mask(). The
> idea, therefore, is to make it a good building block.

Yes, actually that's why I attached the WARN_ON_ONCE() since when people do add
that new code they'll quickly discover before posting, as long as they'll still
test the patch..

Then people may even start to wonder whether we should rework -EEXIST if
necessary, and IMHO that's the better place for a rework, not within the bugfix
here.

Please check the email I replied to Jason.  I hope both of you would agree that
I can repost with the fix only but drop the WARN_ON_ONCE(), or any explicit
suggestion on how we should move forward with the fix would be welcomed.

Thanks,

-- 
Peter Xu

