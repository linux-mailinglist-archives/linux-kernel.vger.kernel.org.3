Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763BD524E78
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354529AbiELNmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354511AbiELNmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:42:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCF1D6162E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652362948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZ1iz42UuoFFLaKz0a8ddkWtT9BcQVuYpXvBQ9Jadug=;
        b=If9B4lUfshsQGu5uCdu6U6qwQJZhUpZ7QTCQFHfMWOSzE5f7EsFLGQMrgykw66Grdb7nV0
        8DBjpJMQXL12hb2xZyV8h2fOfI6COFi8a6nMouERx+b7JZaMwxZBjDU7CuaibgRCpO1bs7
        SCAHBQtr7BhRQlqtFObB+ujekO1rJdg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-E87etiXhMaSK06mQCxYQLw-1; Thu, 12 May 2022 09:42:25 -0400
X-MC-Unique: E87etiXhMaSK06mQCxYQLw-1
Received: by mail-wm1-f71.google.com with SMTP id g3-20020a7bc4c3000000b0039409519611so1644514wmk.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JZ1iz42UuoFFLaKz0a8ddkWtT9BcQVuYpXvBQ9Jadug=;
        b=i7b+UweayGTQykkpVDuhd+4Beaj7TxpbWH/EGV+d5Av4H9MsRvl5HVICF9KI10PCoA
         SIP38l05dfRkV04GFQfO+n8cK59xm93TCiTOHuSPmoK6lOGgrpYW00+JnFUNdg+p/rcV
         /1R+sxDUX6vB4G0SmPvvCsGOkKii9FyyI/yrqcdCm48Yr6UN2otFW1YZyXwCELSebbAJ
         JGfW0Zg0A3bMQL0C7HyAfe2w7DNFBBBpXjemDOzKZv5D3RuTEKOrYcmj527T18Rn7lS6
         GFOWfvuzj0yL2aXxgeHz0PFESnbO+3gxH2onkx6FDffaIjH6aRpWoXtI9ivwid0z46yW
         6yUw==
X-Gm-Message-State: AOAM5332R+ximUHZuSY0o5pGsZ3ARUn5MOTPP3OG8zmgLjsrkTJwv1A3
        MosyJtsn6wxn6p+6Wwk7RFv22RjkljzDi1V2t9mL2Vc7YhftOi59hJH+FKRASF7gcXsLN3IwlfJ
        uXgrl6EDcNw89FMNC3YcU4fic
X-Received: by 2002:a05:600c:4fd5:b0:394:55ae:32c7 with SMTP id o21-20020a05600c4fd500b0039455ae32c7mr10192430wmq.73.1652362944652;
        Thu, 12 May 2022 06:42:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0GfudMW0PDi8mJzfRw/b3zOX6EznbIkxPniElw+DxSXPt1wzfGfEq+gnrvWZc/0ylm4qGKA==
X-Received: by 2002:a05:600c:4fd5:b0:394:55ae:32c7 with SMTP id o21-20020a05600c4fd500b0039455ae32c7mr10192412wmq.73.1652362944446;
        Thu, 12 May 2022 06:42:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c2e0c00b003945781b725sm2636061wmf.37.2022.05.12.06.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 06:42:23 -0700 (PDT)
Message-ID: <3d7355b5-afa5-3a13-6169-eccc8adbe3ee@redhat.com>
Date:   Thu, 12 May 2022 15:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 13/15] mm/swap: clean up the comment of find_next_to_unuse
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        peterx@redhat.com, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-14-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509131416.17553-14-linmiaohe@huawei.com>
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
> Since commit 10a9c496789f ("mm: simplify try_to_unuse"), frontswap
> parameter is removed. Update the corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

