Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7395B1CE9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiIHM1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiIHM1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B27D99FF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662640017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dGKTlWOLxBJbYRVRE+I5qqLpnIQyGsiUrPB3sGw4lVU=;
        b=QswhbJums2mW6pqKHOUGOLPA1EhuBFktZF29SaHscwPG8Z/0OeE5VOjeJz1fY2WGB63EcW
        knXZPXdwk8oySxmmjzPBBeZy6lyo4R9R8idxLzB2+vrlAjHz6yKn8nuuOcDF3eeKnLYOcF
        VB3soG9AhiW4yYgCoSX1HNTC7h6lN1c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-532-OLXJTJGFPyee3ez-4UVFCQ-1; Thu, 08 Sep 2022 08:26:56 -0400
X-MC-Unique: OLXJTJGFPyee3ez-4UVFCQ-1
Received: by mail-wr1-f70.google.com with SMTP id m2-20020adfc582000000b0021e28acded7so4604721wrg.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dGKTlWOLxBJbYRVRE+I5qqLpnIQyGsiUrPB3sGw4lVU=;
        b=3v08cprv3L6ceQbVahbb1y9h5wRYUR8x8tBlslKL4vRNklnt/H9bDIqKSFpH4piAem
         5n7SzA+RdMIaCFyz1nVrnJR+GVxD2zKgV81LA7+H7Nb2zGTCgH19cm7H9KvS+whmYLdg
         pe7rnE9fdSniK0hHdpjpshhYepSuNV1DXgGlOSsoeYU9YfvXKG6BRMRcj6zkuVGUKDq3
         aDYSfYbb9KznEKpX+ePnCApxCHCqQKmGHtbZRbRWcg2f1ijHYrnT3Phy4EoB8AseTayV
         3nUsKSDDPBTKP90qrO7zaa54zhPinyCCJ6j7Mu47JqJCCG31jnAKUrQfc9w8OF+hNf8/
         WHDA==
X-Gm-Message-State: ACgBeo2yDno88mtQJq/thGqrXoUepkDBXvoZd8gBRTuWiAIxeYFSewew
        xjV6DW/8xVALpRAJ91Y1186gSIpNsYw/vqVMyfiH1i1ChxparTkdoH1M9l+Rts45TWNWT71TFMo
        konCepxAYgUXNJyUvAh1PKjh5
X-Received: by 2002:adf:f50e:0:b0:228:de89:dace with SMTP id q14-20020adff50e000000b00228de89dacemr4947679wro.354.1662640015555;
        Thu, 08 Sep 2022 05:26:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4RLyX4rOipcAbCH56Y0xAwRcokhe1SoGCFXHd1n8wkSJRF61CuC2m0VpD6vfB+0QLA3PtNBw==
X-Received: by 2002:adf:f50e:0:b0:228:de89:dace with SMTP id q14-20020adff50e000000b00228de89dacemr4947666wro.354.1662640015331;
        Thu, 08 Sep 2022 05:26:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id by14-20020a056000098e00b0021e4829d359sm1622306wrb.39.2022.09.08.05.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:26:54 -0700 (PDT)
Message-ID: <cbb3a411-0e41-6d67-bb66-d21627fff90e@redhat.com>
Date:   Thu, 8 Sep 2022 14:26:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 4/4] memblock tests: add generic NUMA tests for
 memblock_alloc_try_nid*
Content-Language: en-US
To:     Rebecca Mckeever <remckee0@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1662264560.git.remckee0@gmail.com>
 <3644b4e2e459bb656dd29bdef0b62291528b2f65.1662264560.git.remckee0@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3644b4e2e459bb656dd29bdef0b62291528b2f65.1662264560.git.remckee0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.22 06:21, Rebecca Mckeever wrote:
> Add tests for memblock_alloc_try_nid() and memblock_alloc_try_nid_raw()
> where the simulated physical memory is set up with multiple NUMA nodes.
> Additionally, two of these tests set nid != NUMA_NO_NODE. All tests are
> run for both top-down and bottom-up allocation directions.
> 
> The tested scenarios are:
> 
> Range unrestricted:
> - region cannot be allocated:
>        + none of the nodes have enough memory to allocate the region
> 
> Range restricted:
> - region can be allocated in the specific node requested without dropping
>    min_addr:
>        + the range fully overlaps with the node, and there are adjacent
>          reserved regions
> - region cannot be allocated:
>        + nid is set to NUMA_NO_NODE and the total range can fit the region,
>          but the range is split between two nodes and everything else is
>          reserved
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>   tools/testing/memblock/tests/alloc_nid_api.c | 197 +++++++++++++++++++
>   1 file changed, 197 insertions(+)
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

