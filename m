Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AD0523A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344784AbiEKQbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344818AbiEKQbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 865311E3EED
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652286665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NwRUdIGOtIagk3/zZnpGlBztHUulW1Iopy3U8SZNQBg=;
        b=Igk3jGn5Sx/IbYEM75m7WGbRjyLWUFFMCZW+aYV8psVPnLOsmy5Wc20ljoHe/OJd3GUhUT
        r4YjsuBVAN19gf6eaoWW7JpsOJYNVcNHOf0GqCd3lo8wyP8G6pmbCk5QTmb3/e/nqFL+RN
        CC/C7mCmf/PabSLUASslEjnfLGn9kK4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-IuZ0THWPN5aYSxjfVdTtag-1; Wed, 11 May 2022 12:31:03 -0400
X-MC-Unique: IuZ0THWPN5aYSxjfVdTtag-1
Received: by mail-wr1-f69.google.com with SMTP id j27-20020adfb31b000000b0020c4ca11566so1032948wrd.14
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=NwRUdIGOtIagk3/zZnpGlBztHUulW1Iopy3U8SZNQBg=;
        b=kIy7boaQWJhzQIP5t7L68pqbFcRFl9uBSiwGUtEVTypSr9aL2CyCKSpVBRM33+UBw0
         RXDpUKt13YZLygNN0MCfnDZmZnv4UCYOUddMoNbCy5MaY+deokrj+MM54XqhqyO633e8
         KZyoNMyAiU0kHTx0xm5ELmKnv+VwzGXCewFXR/pji3cNV60rWWCo3GixDTA+Bv4XVw5v
         orI5h/OukmHsC2JTiTNNvGma/gH9Tr9hObunwfbHgAUwPzPI4ZmugrMrJT+Y3icUzXDh
         ScI+bBfydhZBQZqZ0mcRwwVNH3HMTMuJa23BsF1qPtUAaWpb75pr01aQ81Dc+9YWQh94
         ib5g==
X-Gm-Message-State: AOAM530QIdGyoNN/GyqFmerZXow8A7hQ8o3RBrtU5P9wvWwo/AH1sVbt
        OzZAUIQD7wSZjdb2rskU9V/pOgxPB3NLFtQwXSiL2+nm97YW4EORx/S8Kv8o/OmUvHoYhtpHa1J
        cDax9uYUY1d2PuBusYHtFqB4D
X-Received: by 2002:a05:600c:3515:b0:394:8c7e:fbde with SMTP id h21-20020a05600c351500b003948c7efbdemr5660659wmq.165.1652286662379;
        Wed, 11 May 2022 09:31:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxBi1Dj04MlOukt9LYl4UqTJT36Sqbp84lQ3YdTyLI0xlWc6yJdnKpgzjmA8uHrQm9JnMgUw==
X-Received: by 2002:a05:600c:3515:b0:394:8c7e:fbde with SMTP id h21-20020a05600c351500b003948c7efbdemr5660632wmq.165.1652286662173;
        Wed, 11 May 2022 09:31:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:700:2393:b0f4:ef08:bd51? (p200300cbc70107002393b0f4ef08bd51.dip0.t-ipconnect.de. [2003:cb:c701:700:2393:b0f4:ef08:bd51])
        by smtp.gmail.com with ESMTPSA id o3-20020adfeac3000000b0020c66310845sm2016448wrn.55.2022.05.11.09.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:31:00 -0700 (PDT)
Message-ID: <d3a0a870-dccf-186c-e079-96b8309721cd@redhat.com>
Date:   Wed, 11 May 2022 18:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v8 06/23] mm/shmem: Handle uffd-wp special pte in page
 fault handler
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014844.14239-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220405014844.14239-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * This is actually a page-missing access, but with uffd-wp special pte
> + * installed.  It means this pte was wr-protected before being unmapped.
> + */
> +static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
> +{
> +	/*
> +	 * Just in case there're leftover special ptes even after the region
> +	 * got unregistered - we can simply clear them.  We can also do that
> +	 * proactively when e.g. when we do UFFDIO_UNREGISTER upon some uffd-wp
> +	 * ranges, but it should be more efficient to be done lazily here.
> +	 */
> +	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
> +		return pte_marker_clear(vmf);

What would happen if we do a unregister followed by a register? IMHO we
should start with a clean uffd-wp slate then. Your comment makes ma
assume that we could receive stale WP events, which would be wrong?

-- 
Thanks,

David / dhildenb

