Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4D554969
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345696AbiFVIrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbiFVIrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:47:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43149393DA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655887622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eS3Mbme1/2pPmMpDc+wuDpVAj8lgyhu3EEjJBQhRSPI=;
        b=Wr7BhTSE1dFW1bPIoojhUCCWy3bJZR6nh8ezz4AzZlCf8903mS7OyPfqza3VS9xL2EcI0o
        qMTO3GHymb6tOprTzwrJddQ+IPOn5VQrGq+eZwZX4MPLDWvkUiK2yGtf2CxsLc43tIIxew
        YCAnxbC9laGD6rPfUEinu9pUwGoGtYc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-YODQEtXKO_-c7IP-rPlMfA-1; Wed, 22 Jun 2022 04:47:01 -0400
X-MC-Unique: YODQEtXKO_-c7IP-rPlMfA-1
Received: by mail-wm1-f72.google.com with SMTP id l3-20020a05600c1d0300b0039c7efa2526so7513243wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=eS3Mbme1/2pPmMpDc+wuDpVAj8lgyhu3EEjJBQhRSPI=;
        b=Ky2sRMjlPA713w2VlD0pSGwOnBKenK9O80eJen4Lqc5Gs1FxOVSbiCtv0UXxoqddDj
         zZqbwgXlOjJa1/8iyG67Ra4TTs476oH4HMtYG2BviOe32A7u7ccQAau4TcbNt1D/tMoF
         erXGrRlMiUSyFGc1LUtts4o+oK1Gu9nYUf0f0jd+WjKzT6vGlzT+QkkSw6uy7/EabtpU
         9fSdMxmsqmoapIIcNdLo1M0u/QNSt3RwWMJ7rCb2ZphGasMuHd77GajCnM3nEZ1tI3sG
         iTPFSRbmJDe77zqMopRm+19vR6OmubJjdASwXMDvHAQrM2a8u/s8MwYy8OJG4K+gK9Kq
         8i7Q==
X-Gm-Message-State: AJIora+n8kRoa33Rc9mJc5aZuqnCph1ncGY5ri3CSb8Munlb/l7oOu0L
        1Rrb+WHuvZQYaAvCrpvVfTWQsxnrc/kUWk+2S5a+pUMDQQIweIdC2+gBEfRxOvBob2s4865FqPH
        AIY+UEyXpg840MioRuvbFZKQC
X-Received: by 2002:a05:600c:ac4:b0:39c:4f54:9c5f with SMTP id c4-20020a05600c0ac400b0039c4f549c5fmr2585446wmr.135.1655887619734;
        Wed, 22 Jun 2022 01:46:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tRQuXS//dOmPMDP+OZGfs4QHv0XCl/njtBkEyzuMoLomceZAmL/OPVAmRfgr38xw4B+dmZow==
X-Received: by 2002:a05:600c:ac4:b0:39c:4f54:9c5f with SMTP id c4-20020a05600c0ac400b0039c4f549c5fmr2585430wmr.135.1655887619490;
        Wed, 22 Jun 2022 01:46:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:5100:9c77:ce13:2aeb:8748? (p200300cbc70351009c77ce132aeb8748.dip0.t-ipconnect.de. [2003:cb:c703:5100:9c77:ce13:2aeb:8748])
        by smtp.gmail.com with ESMTPSA id z7-20020a1c4c07000000b0039c4b518df4sm25678747wmf.5.2022.06.22.01.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 01:46:58 -0700 (PDT)
Message-ID: <01e9846d-1b52-0b7f-056c-e31994df3d22@redhat.com>
Date:   Wed, 22 Jun 2022 10:46:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/4] memblock tests: add user-provided arguments to
 Makefile
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1655878337.git.remckee0@gmail.com>
 <7deb3d3d4c05c884d3830325c816862ce927133f.1655878337.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7deb3d3d4c05c884d3830325c816862ce927133f.1655878337.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.22 08:19, Rebecca Mckeever wrote:
> Add VERBOSE and MEMBLOCK_DEBUG user-provided arguments. VERBOSE will
> enable verbose output from Memblock simulator. MEMBLOCK_DEBUG will enable
> memblock_dbg() messages.
> 
> Update the help message to include VERBOSE and MEMBLOCK_DEBUG. Update
> the README to include VERBOSE. The README does not include all available
> options and refers to the help message for the remaining options.
> Therefore, omit MEMBLOCK_DEBUG from README.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

