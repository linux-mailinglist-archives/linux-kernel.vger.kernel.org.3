Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A51524E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354504AbiELNjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240653AbiELNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC11C247374
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652362747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PnKqdjvcZK6/v20kwL3cvMyHQOuF2Fu63Oq5RE2SrU=;
        b=cAWUNLwRB0W+w5PP2zXfienmhDT3VHqxrhsqC282AsXH18RFQ2KiEYH7+ch0mra9oZxRDT
        A5ASRFhNfJhJG6cv/0TCgviGQtyIOqau/BI0Uz7bo7hDpFxQY9CzI0na4aGo6tpU03viaP
        ikT6EI5jfsPRlrPzzHNQ0BCNkKgeh2M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-jivnzDSaPJak4AjLnuYFdA-1; Thu, 12 May 2022 09:39:06 -0400
X-MC-Unique: jivnzDSaPJak4AjLnuYFdA-1
Received: by mail-wm1-f71.google.com with SMTP id m124-20020a1c2682000000b00393fcd2722dso1688594wmm.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7PnKqdjvcZK6/v20kwL3cvMyHQOuF2Fu63Oq5RE2SrU=;
        b=PZDTkq0fTTEqtM9JEhvuheQStOuvjXP5PJx0rpdXks3uCDG8NGBDJvU9dOesijfSBe
         Axa8ne2NnXdNfAj9dFj7VK3uXmJ2aAbCjby5nt8lPYDO+U28+ChP5oHsgRHbF3TXR/I3
         tFEJm4O3d9ihwzZlxhI1WtHBip1a0KMcYSF1Rd+9sDA+omga/64vgoJHtyd51EVR+hOE
         9P3Eqn83ohWk547cYmnvw6q7kaSAU1doJ4lBcTq+KQoO7CZXE1dBoLIaxUe0myDsYDBO
         1bdHWXAFSJlghwAg4OAGq+ylkVe4mKP0OZKm8zpNFNx2aN37fhyAUPgqjwxL5nYkquWH
         jpsg==
X-Gm-Message-State: AOAM53167hxZXl7lp1bv8b5J4q7U//VO884uwAI1yEVHQtvbHeR6pRKz
        j59miHf+iaddv0fNrEShHOQEw9ldTMhLe5op/I25SIuSPRafMoLMp/cWG+TvQVIJvn4G57hhSbf
        T3jTdPvFI1WAR2MepS4cr2Yui
X-Received: by 2002:a7b:ce04:0:b0:394:1f46:213 with SMTP id m4-20020a7bce04000000b003941f460213mr10074816wmc.157.1652362745544;
        Thu, 12 May 2022 06:39:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs5GXQv6CH5nZgYgHf2t89HxiGpxcKxrP7usek7FTknx2NYCrQo3wnKCmKVkOC9ybOOO51HA==
X-Received: by 2002:a7b:ce04:0:b0:394:1f46:213 with SMTP id m4-20020a7bce04000000b003941f460213mr10074792wmc.157.1652362745291;
        Thu, 12 May 2022 06:39:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id bi22-20020a05600c3d9600b003942a244edbsm3230054wmb.32.2022.05.12.06.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:39:04 -0700 (PDT)
Message-ID: <6f514908-0659-8c23-a11c-90e5fb88c45a@redhat.com>
Date:   Thu, 12 May 2022 15:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 08/15] mm/swap: make page_swapcount and
 __lru_add_drain_all
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        peterx@redhat.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-9-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509131416.17553-9-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.22 15:14, Miaohe Lin wrote:
> Make page_swapcount and __lru_add_drain_all static. They are only used
> within the file now.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

