Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88F249F362
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346311AbiA1GQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:16:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235649AbiA1GQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643350567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FSteX9W3PLWEuASmDON9me2d/UIiV3TbmFqzK6jQr4M=;
        b=exyHxMKC/5CVY7SokVr+6WPK21979XT4Dwv149qzOG4d70Q54cL4YQJ+7iwE/jXqI4T9Vs
        6GXVviyTSqpDKKZB/VPgDryNngusVmkRQYvv8trIGTfKsApJg76wZopFtINcLQyrZScjeX
        VvDLkQI3QrFKCNv9+3AsXVndYmjOrQ8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-a7y8ZmV6M_amCSwxVwYqKw-1; Fri, 28 Jan 2022 01:16:05 -0500
X-MC-Unique: a7y8ZmV6M_amCSwxVwYqKw-1
Received: by mail-pj1-f70.google.com with SMTP id 19-20020a17090a001300b001b480b09680so3162110pja.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FSteX9W3PLWEuASmDON9me2d/UIiV3TbmFqzK6jQr4M=;
        b=ih1nDbV9DTrxilNcAkveblZ60vP4cEvSLQwApEG+dhvEH28TEm3bdiaYLXYZVem3H2
         pteWVue7sO4WwkmzOMFqSHwwgjCAskb2gihVxm6HZoH6feM/6tDoph4eOj7yFsQDmQXh
         IPhWJRIiOAEFU0R+pmKoR2xBwjiZVh9UjjZ+xA9dOAHq9yogodG8wj4HfclMMcFxuI74
         FFh5RA6I9pLiTotuOzXMBFqLeuBRjycqw1ppO28khiLiZjhwfJU/fbcno46whWkYEEs8
         zX1LzFmJ1PUXJ0fsQyb7tkyJ3b9QxztPrEetlvWEQSN2IFDPx7FQhzW4tMqGhdJOrv6U
         Zlmw==
X-Gm-Message-State: AOAM533fRdvGy2aziAStDoBxkc5fBiFx/txSzKiuy2p+vhk5Jxc4PNUT
        GRY0miIpT5cNtT4zZeAufU50UP7UY8WIOY6Oyb46zQEij2GPdAivDWPNhm8A9v/AD5djS5OX5N2
        o2mpho+R3gZa87Q1tAlraIh02
X-Received: by 2002:a17:90b:4c8e:: with SMTP id my14mr18040497pjb.243.1643350564127;
        Thu, 27 Jan 2022 22:16:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBh69AF7fxpG19IrHi85o0ocI89x0eLeIZI+GAD7OdM5Lf69TwqdWkDCY/AsuxNlDs5C7u6A==
X-Received: by 2002:a17:90b:4c8e:: with SMTP id my14mr18040465pjb.243.1643350563714;
        Thu, 27 Jan 2022 22:16:03 -0800 (PST)
Received: from xz-m1.local ([94.177.118.75])
        by smtp.gmail.com with ESMTPSA id z13sm7923190pfe.20.2022.01.27.22.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 22:16:03 -0800 (PST)
Date:   Fri, 28 Jan 2022 14:15:56 +0800
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
Message-ID: <YfOKHMbk2caH4d5g@xz-m1.local>
References: <20220125033700.69705-1-peterx@redhat.com>
 <f5400544-f602-0bb4-5cb1-5ac682e41974@nvidia.com>
 <20220127004206.GP8034@ziepe.ca>
 <YfJjhop3senAUjue@xz-m1.local>
 <20220127152538.GQ8034@ziepe.ca>
 <YfNIjqPpty0YkLJP@xz-m1.local>
 <20220128023127.GR8034@ziepe.ca>
 <YfNiWHDYH0dtj9rK@xz-m1.local>
 <b773a0ab-e226-6acb-eab5-24036b0cf6f4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b773a0ab-e226-6acb-eab5-24036b0cf6f4@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:57:34PM -0800, John Hubbard wrote:
> On 1/27/22 19:26, Peter Xu wrote:
> ...
> > I see that both you and John has a strong preference on at least the
> > WARN_ON_ONCE() in the patch.
> > 
> > Do you think it's okay I repost with only the one-liner fix, which will keep
> > the Fixes but drop the WARN_ON_ONCE?  Then we can leave the rest as follow up.
> > 
> 
> I think that's OK with me, anyway. You'll recall that I initially requested
> that you split this into two patches, after all.
> 
> Would you like me to post a follow-up that does the refactoring that Jason
> and I are requesting? I see that we have some fundamental differences in
> opinion about how this should be done, so rather than drive you crazy with
> debating, maybe that would be smoother?  :)

Sure thing. :-)

Please just double check that the pud devmap will still always work on mlock().
I believe both of you are much more familiar than me on that; it just still
seems a little bit tricky.

I'll repost this one, thanks.

-- 
Peter Xu

