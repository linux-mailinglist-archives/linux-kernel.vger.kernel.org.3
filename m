Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83F450177E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347804AbiDNPjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351618AbiDNObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B20517A996
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649946104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lys9OvSbD/kPAhkzPWHuJKcH+xiG4FQId/LRShqL04Y=;
        b=aAoiDUkKdLtsOnhFyAijZKhQpGPerT9pLQQuvDxNmYonz8x7occdS7pHLsi2fWn+DEIYBQ
        Hp+Shmscb0JJKzkisvjELZa4Vgc+BqBTvo83xeA8OoFRpBu0ZWhKv8cipf54RQVHUOEa5j
        ixTliWBzceX2VChclrfp4TCwiWHToLY=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-O6oDWlEEP7yCO_BwiLcvUw-1; Thu, 14 Apr 2022 10:21:43 -0400
X-MC-Unique: O6oDWlEEP7yCO_BwiLcvUw-1
Received: by mail-il1-f198.google.com with SMTP id q9-20020a056e02106900b002cbc8d479eeso3102132ilj.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lys9OvSbD/kPAhkzPWHuJKcH+xiG4FQId/LRShqL04Y=;
        b=c/hlcwENYPVHNV2v9nNfhk4uy6UmAUDxB7xKy2rAMrz0NoTPTJnwRjfu74JwbdnZVy
         FLstQ+/BQyXKrCx8YBPTM7v9qfhTbzrLJYzsFn3VF/fvq7ONT/8ke6fShEwLZ7jRipRz
         38vzGmZ8NOhvt02eL+ASs790KTW9INk9o57MuIR5OrGLdRLw3DvTcCsBNf2khY4YvpHU
         yITdiQC98GneK3rbhh0sN3A91wk4q0EhDKe/oT7sr9go7PkgQlCjG9OPmNnepGwdcsUI
         DdlKyQXEbfBOGS9zhq1T8zOdJSSIgqVasOtAL+Y6Y0bNgpcgwyk0IXqUbqotoKkgeUtt
         yA4Q==
X-Gm-Message-State: AOAM530gapDSRe2oMygPR8CSNup3pUNxviwXlx+c7gbpcTCI0zpWctA1
        Krv847GXa0D0aDd6UwCDxUwRu/igJi9yYDcTyy6JbuXmt/qqYwwUHgxUnppqB/wb4ItAObTnGUW
        WeKfRVdZWhn+2xb+8ZOY8xrHe
X-Received: by 2002:a05:6e02:1a42:b0:2cb:eb85:4395 with SMTP id u2-20020a056e021a4200b002cbeb854395mr577694ilv.35.1649946102712;
        Thu, 14 Apr 2022 07:21:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySW9eFDl/20l+wYHt6KUUivHRwy3I3c9ZS4Vt8YHnsSsA7JdmygXiN3+pPwJ0aGkm91npruQ==
X-Received: by 2002:a05:6e02:1a42:b0:2cb:eb85:4395 with SMTP id u2-20020a056e021a4200b002cbeb854395mr577685ilv.35.1649946102337;
        Thu, 14 Apr 2022 07:21:42 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id y17-20020a92d0d1000000b002ca8027016bsm1105558ila.45.2022.04.14.07.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 07:21:42 -0700 (PDT)
Date:   Thu, 14 Apr 2022 10:21:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Remove stub for non_swap_entry()
Message-ID: <Ylgt9aLU5T+e+Qju@xz-m1.local>
References: <20220413191147.66645-1-peterx@redhat.com>
 <87zgko9obm.fsf@nvdebian.thelocal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zgko9obm.fsf@nvdebian.thelocal>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 03:48:33PM +1000, Alistair Popple wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > The stub for non_swap_entry() may not help much, because MAX_SWAPFILES has
> > already contained all the information to decide whether a swap entry is
> > real swap entry of pesudo ones (migrations, ...).
> >
> > There can be some performance influences on non_swap_entry() with below
> > conditions all met:
> >
> >   !CONFIG_MIGRATION && !CONFIG_MEMORY_FAILURE && !CONFIG_DEVICE_PRIVATE
> >
> > But that's definitely not the major config most machines will use, at the
> > meantime it's already in a slow path of swap entry (being parsed from a
> > swap pte), so IMHO it shouldn't be a major issue.  Also according to the
> > analysis from Alistair, somehow the stub didn't do the job right [1].
> 
> I wasn't so much concerned about execution speed given it's on the slow path
> anyway but overall code size, which is one reason all those config options might
> be disabled. However in practice it made little to no difference as those config
> options already remove most of the extra code so I agree we can drop the stub.

I see, yeah that's a good point.

I'd wildly guess a minumum set of Linux build could still like that, but
not strongly, as I'd first think about not having CONFIG_SWAP at all if so.

> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

Thanks!

-- 
Peter Xu

