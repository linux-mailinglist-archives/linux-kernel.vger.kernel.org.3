Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56DF4A405E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358210AbiAaKmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:42:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358150AbiAaKmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643625733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3WGJS4EtzYInjhR2Hz+I2adZQDV1KF4dKMn9hLf+44=;
        b=VHIHXwZCnYrSrSvfUPWQ/8SLWvQEM6NkB6EcFTcEum2CBIu/4i47JXpW+nqe50bKLthxtL
        EaQcoNSyjv59+BzxXSfUH+/CM5+vM5iuFv3irhZSNrcFA3p+3c4o8bHUZLs+exmqvSvyL5
        gL8dT9c3CFWWMAscXF5IwhgjJEzH2Eg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656--8cJh1XoNUi-SjCfYZaW4g-1; Mon, 31 Jan 2022 05:42:12 -0500
X-MC-Unique: -8cJh1XoNUi-SjCfYZaW4g-1
Received: by mail-wm1-f71.google.com with SMTP id 7-20020a1c1907000000b003471d9bbe8dso3664829wmz.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 02:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=c3WGJS4EtzYInjhR2Hz+I2adZQDV1KF4dKMn9hLf+44=;
        b=neU6/fAs1LU1mJ3vaQOS5jQnJ4H9EaCbY/cFnYv9xt5oOpz4PBaZrLH9zwac/gVSZu
         6MmVIq3vqkViTR89MHMuknH7bWwr1kdnrZAhfmyJfB28YJocke4L2j/rn3Xuuknads2z
         hrbnIBjb+G3XexTNXhLDMXyGl7LisBk/HGO6d8ivydJxoyzjwKW/Jq9ld0VqXbA/jhkW
         VdSmE3Tn7xKrlX2yElCXOhUJfTByvLlycygeTawfQ8Tpgz8cv7+Z0yUvx1WHHSUIHHl7
         dAy8A/+9xJM2L66Q/N2om2FTg2lSBeIrzJ3qLOXBcv3QeO4l31Nku0whyA+Jko6Imi/g
         yirA==
X-Gm-Message-State: AOAM531Wtgb+CvdcpTV3yMVfGWNwDiZ6kRzBGQGgh1shNmNy71jRs1V/
        fCebi+MwQ0J0WJg9na1M24zur2OD/dIKa7TSbzTKzLdNAM/zrSpF0F/StjcKexRLXy8qHbdI8O9
        CICKyPeSbCBr0OcbwBvyBpG2dOJpCDPGfeJGR0HqOnQpV//t+fTuHaTrP6y6aQMz/2qSzO2K5
X-Received: by 2002:a05:6000:1104:: with SMTP id z4mr17168860wrw.268.1643625731027;
        Mon, 31 Jan 2022 02:42:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyH67E5runx3mv6aljRPRbKginbWLWSG1Kc2VVJTDiFu8CE3TW91+1b03gQpvuHXzqUF6ak1A==
X-Received: by 2002:a05:6000:1104:: with SMTP id z4mr17168828wrw.268.1643625730735;
        Mon, 31 Jan 2022 02:42:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:b200:f007:5a26:32e7:8ef5? (p200300cbc709b200f0075a2632e78ef5.dip0.t-ipconnect.de. [2003:cb:c709:b200:f007:5a26:32e7:8ef5])
        by smtp.gmail.com with ESMTPSA id w22sm11682389wra.59.2022.01.31.02.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 02:42:10 -0800 (PST)
Message-ID: <4632dc1a-e561-f04e-421c-a770f9271bbd@redhat.com>
Date:   Mon, 31 Jan 2022 11:42:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 2/2] drivers/base/memory: determine and store zone for
 single-zone memory blocks
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Rafael Parra <rparrazo@redhat.com>
References: <20220128152620.168715-1-david@redhat.com>
 <20220128152620.168715-3-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220128152620.168715-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  			 !IS_ALIGNED(start_pfn, pageblock_nr_pages) ||
> -			 !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION)))
> +			 !IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION) ||
> +			 page_zone(pfn_to_page(start_pfn)) != zone ||
> +			 page_zone(pfn_to_page(end_pfn - 1)) != zone))

I just realized that we have to do these sanity checks after our check
for memory holes.

-- 
Thanks,

David / dhildenb

