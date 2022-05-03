Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE22517B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiECBTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiECBTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 126306545
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 18:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651540528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KPSwa6BO4nhm2D1ATK5m6d1e69zEH/tlPY6FsAWaZCg=;
        b=bDhWpTGUvc6OPfQzNO0x00g+aE0PY7hTK4UaWlLfsOWDtsCNPBmZ4JWEmOy1BKTiSwZW8E
        ukZ7DEYioDOIOt+q79Ldxx6UGHB2TFirKyeCGV8m4Jbyj7BHhUyGWYxyJeIaHqryr+9NSg
        e8C4fBvNve2dpE+oNI+or4ss1kzRbis=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-vAllI6uhMz6S3pSAPwOLkQ-1; Mon, 02 May 2022 21:15:27 -0400
X-MC-Unique: vAllI6uhMz6S3pSAPwOLkQ-1
Received: by mail-pj1-f69.google.com with SMTP id l2-20020a17090ad10200b001ca56de815aso523920pju.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 18:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=KPSwa6BO4nhm2D1ATK5m6d1e69zEH/tlPY6FsAWaZCg=;
        b=SxjJBgxQFYJrHWQ3XJPq4V+kmwhhV0mAZTaDd7TEt3KGwwAlklXnTbQwiRumh4erQe
         /CQvsZ4dIN8C/MQmQRaHRgyTdtwMlRmA89EU+mZ+Q6uygBUHESs0eZlMDck2onsRqOrf
         ZsUAK63JP+CeedDBBYZrcpMOFcdQ9xkJYkifWRyJ+r6aS64EdadX+v5Xn1YLCyAj32+S
         xazPeCbfAlvjCH/VDhlgP6PW2RHyFsQhj/wT8WsmoeNFK6U2XZtbxBjC+N5Mu5voVDaK
         Dt4IdNYknSAuHSEN+DBL38GcbMQO+L2ZC5BuHoBQvKRY4OR5jdAocauq1JHupnB1RVXN
         kGOQ==
X-Gm-Message-State: AOAM532nVxDFW6N2CRhL+mXPpogwn1whfffRGOwFy+tFU+fMyER9v4j/
        boxtVYvwDUjtffL1MyD/+plt/w0r5i8L47f4GPgvPk38pFoiamgSDhNIuCRKGi638g7Juz+wlB2
        Qb/zvCvYYl0BZ/qQCSmW0NOd6
X-Received: by 2002:a17:90b:1b07:b0:1dc:5ec5:56b0 with SMTP id nu7-20020a17090b1b0700b001dc5ec556b0mr2084207pjb.165.1651540526632;
        Mon, 02 May 2022 18:15:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYaUKBUmtnpR1yq4t3oy9VkaYKnH/ZmncA1pOMAEMZOY2M85HcjCLicImCLIKUwltXpRVGiA==
X-Received: by 2002:a17:90b:1b07:b0:1dc:5ec5:56b0 with SMTP id nu7-20020a17090b1b0700b001dc5ec556b0mr2084173pjb.165.1651540526288;
        Mon, 02 May 2022 18:15:26 -0700 (PDT)
Received: from [10.10.69.234] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id j5-20020a654d45000000b003c14af50621sm11895993pgt.57.2022.05.02.18.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 18:15:25 -0700 (PDT)
Message-ID: <08e9855c-395d-f40c-de3d-1ec8b644bfe8@redhat.com>
Date:   Tue, 3 May 2022 03:15:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mm: fix is_pinnable_page against on cma page
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>
References: <20220502173558.2510641-1-minchan@kernel.org>
 <29d0c1c3-a44e-4573-7e7e-32be07544dbe@redhat.com>
 <YnAhaRNjmIhtGUjk@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YnAhaRNjmIhtGUjk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> However, I assume we have the same issue right now already with
>> ZONE_MOVABLE and MIGRATE_CMA when trying to pin a page residing on these
> 
> ZONE_MOVALBE is also changed dynamically?
> 

Sorry, with "same issue" I meant failing to pin if having to migrate and
the page is temporarily unmovable.

>> there are temporarily unmovable and we fail to migrate. But it would now
>> apply even without ZONE_MOVABLE or MIGRATE_CMA. Hm...
> 
> Didn't parse your last mention.

On a system that neither uses ZONE_MOVABLE nor MIGRATE_CMA we might have
to migrate now when pinning.

-- 
Thanks,

David / dhildenb

