Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D854FE175
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355071AbiDLNA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354926AbiDLNAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A05446154
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649766929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iJqglimaomRAKenwQeCDnCnI75AgWyOOY6lOl0E6tbs=;
        b=Qh/XsueH5OQSbq4hWk2PEJ6QaSWoHBXlNQQ6XehhGV0OWgXrfHmFG+Hob6iFZa1cKC8VUZ
        Mv/Ya4Y+8TWmDepwj213gjso1j75jFnhaEc9UoMKysuAnAvr7w/U0A1kPMMPJlq+QQgsjv
        kqAka+sWE2ZemdyXYssoYXflfRunoXY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-2gvD7-gdM66dssevqWlD6Q-1; Tue, 12 Apr 2022 08:35:28 -0400
X-MC-Unique: 2gvD7-gdM66dssevqWlD6Q-1
Received: by mail-wm1-f71.google.com with SMTP id o6-20020a05600c510600b0038ec5f6d217so1215116wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=iJqglimaomRAKenwQeCDnCnI75AgWyOOY6lOl0E6tbs=;
        b=LDLIDVJJCr+XnTAD0sCtquBMI7IRsjzvW6OC4/1IRI6oB/93Qr3SIStFFE/9BQQ9Uq
         qIy2pBWNfIX5tnSoLbtGCpY7qeFsb8h6elLnhqc0yyKLQFPLY3IzY34/jCUseburO/vL
         6a87srQi14p/apAr6iCoyEgcuVyU1PcEWuioftCZ+ZPXd2uXXYnX/Nnh1b+mumsBJXSu
         cDXXwWqmu5C5YbH3vC33zRiDHg+se0IlqtTPfjRLhYbFyatgzN89xdQtvO1Vr/gHhvDs
         gmm701eL3PWyA7aF3X1VmR0TruB8L5vkKmbVPNYj05ZMxGqq0FKb1z5b89q1rU/CBY5U
         mRrQ==
X-Gm-Message-State: AOAM533L9wlnfIOWf/dboggsY/1g82WnR3FAzna69vgYASyLKURv1TU/
        iJoVrRtA4J/xz/EA9NNeeP4UkP7iE7Luc5n/JQZwWoa6+9fYm37NRppYjU8YiGNmTpabV/hWw5p
        5QvxbluZtcLeERbWEygJftbQ3
X-Received: by 2002:a05:6000:1f8e:b0:207:a52d:f611 with SMTP id bw14-20020a0560001f8e00b00207a52df611mr9182379wrb.266.1649766927063;
        Tue, 12 Apr 2022 05:35:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydZ5Q8ljJxU2bpbKbM9Dux/MSsB7WSQBOCEUZQwPv9Vg5TXtMNLisSRZglh2z5p3/OYrFUJA==
X-Received: by 2002:a05:6000:1f8e:b0:207:a52d:f611 with SMTP id bw14-20020a0560001f8e00b00207a52df611mr9182354wrb.266.1649766926776;
        Tue, 12 Apr 2022 05:35:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1800:7c14:16cc:5291:a9f3? (p200300cbc70718007c1416cc5291a9f3.dip0.t-ipconnect.de. [2003:cb:c707:1800:7c14:16cc:5291:a9f3])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4e08000000b002054b5437f2sm28472436wrt.115.2022.04.12.05.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:35:26 -0700 (PDT)
Message-ID: <9ba426a0-3cbf-2794-39bc-bc0dfbeb3841@redhat.com>
Date:   Tue, 12 Apr 2022 14:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v10 0/5] Use pageblock_order for cma and
 alloc_contig_range alignment.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20220406151858.3149821-1-zi.yan@sent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220406151858.3149821-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.22 17:18, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi David,

Hi!

> 
> This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
> and alloc_contig_range(). It prepares for my upcoming changes to make
> MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2022-04-05-15-54.

Sorry for the late reply, I've got way too many irons in the fire right now.

> 
> I also added "Content-Type: text/plain; charset=UTF-8" to all email bodies
> explicitly, please let me know if you still cannot see the emails in a
> proper format.

Oh, thanks! But no need to work around Mimecast mailing issues on your
side. This just has to be fixed for good on the RH side ...


I yet heave to give #3 a thorough review, sorry for not commenting on
that earlier. It's a bit more involved, especially, with all the
possible corner cases :)

-- 
Thanks,

David / dhildenb

