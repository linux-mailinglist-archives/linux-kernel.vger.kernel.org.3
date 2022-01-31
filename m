Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01434A4986
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbiAaOnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiAaOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:43:04 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFADC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:43:04 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id c189so12159106qkg.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JAZyr7wnoTSbJ0PuEd8LL3wN3COcS3Wif99num8xEkY=;
        b=oLI4NSBMa0PoK8Te/qCbZ6cl4Nea7Eq3MxG6Mg0dnHDAv98os673yLav7xZwMsVxJg
         qqDh191XYr31q4a0RZQfL8losPuuO5VtlXEY7EUKx8izXT7QZWIZ3SCpTNOTemdRiB4O
         YdCTKLWwxEnaIkgSvgVwt/aYYuqSZlrOGdARRZxlW69RpBrv9reqCPXFBMMKPWwN1xtM
         IMgWQzft113jwgO1pssIp3u0hjIM+AoIy3B1NxhQcPX6jNic/z6TFbQu1cHoKFEmQbUr
         9Uumxw9JDXh2KG06LBAip3w4UFpd0eFHY9EVCj3tUpNe2pfcC2zG/eXDwLLgzPw+ekiO
         /IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JAZyr7wnoTSbJ0PuEd8LL3wN3COcS3Wif99num8xEkY=;
        b=iyz68GoiMiz45X05pYx+EhEPGoyjWwmDPR0q3fFqw/5HarBFWk14Ks3Kj34nM91pz6
         c4tQoNpNwkRh0CBjRrGztM/OIQ0+aeR10k//KL8e+LONqt/IlNmJhRScLtu8DShfKdHA
         0ZOyNnBkA0ETr41SHcyKhlKsnlw4l0UNDpuLLcWptlmeBV5Z+Ze+inDCIn6w7CzduJUX
         AaXebBdojtX4PuPSwrEzIsnTdxh7pqCM6dmqTgDajjUZwU5RqJMasE0wPGSoF2PzAzP8
         JKdVlQrp3UulzZHOeJe7mlVskSlNgqD6UCW4Thd0MEOznrfZL+Or3VsvzVwSMbIf0H7s
         dPqA==
X-Gm-Message-State: AOAM5336ztiex+b32WkB93ZVy/Eha5Rw7hiFf/HDCMcrDk4moDq3Znp0
        +T2+Y/UyzdDSYXgryXJ6FGUQG4gmVb+TmA==
X-Google-Smtp-Source: ABdhPJz+aDdDVXCopOf4/uz7hGWz3CrQp48rpZlh6phynYV0r+VWa3WKKYg70welDx6T/GZ7wiJiXg==
X-Received: by 2002:a05:620a:414f:: with SMTP id k15mr4341414qko.564.1643640183549;
        Mon, 31 Jan 2022 06:43:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b10sm8813288qtb.67.2022.01.31.06.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 06:43:03 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nEXtW-009Xdc-HS; Mon, 31 Jan 2022 10:43:02 -0400
Date:   Mon, 31 Jan 2022 10:43:02 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm/gup: remove unused pin_user_pages_locked()
Message-ID: <20220131144302.GY8034@ziepe.ca>
References: <20220131051752.447699-1-jhubbard@nvidia.com>
 <20220131051752.447699-4-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131051752.447699-4-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 09:17:51PM -0800, John Hubbard wrote:
> This routine was used for a short while, but then the calling code was
> refactored and the only caller was removed.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm.h |  2 --
>  mm/gup.c           | 29 -----------------------------
>  2 files changed, 31 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
