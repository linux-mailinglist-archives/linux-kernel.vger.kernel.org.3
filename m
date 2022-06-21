Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF36B552C36
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347738AbiFUHjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347700AbiFUHjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:39:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FE741274F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655797177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N9tiKnq6phB8o+3F1BeH/xJoEGEmyesclfjwFxkzgCE=;
        b=JVyQemiRW1Znf96EWsJ/UAn3lvPM+TU+f1rog4pNvpZvgALi85R6U10DRBjbwOeDOcDGLl
        jLNyTqNxAK+D41bbvZl7+a5xSqZ+9p71BnuYbnNawXzE2+YIqxMYLMolVL+YEruabwC7Kx
        7Hhe8rTDuk+50cL7kiP56u0GwJhVFkA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-Wo9B4HvDNQGG97TBPUWeyw-1; Tue, 21 Jun 2022 03:39:35 -0400
X-MC-Unique: Wo9B4HvDNQGG97TBPUWeyw-1
Received: by mail-wr1-f70.google.com with SMTP id z11-20020adfc00b000000b0021a3ab8ec82so2787723wre.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=N9tiKnq6phB8o+3F1BeH/xJoEGEmyesclfjwFxkzgCE=;
        b=lu2nTJxUGQYDEZt2FddNupGuulI0CUR7/bu8pHCKc+jOCy/VSa698Nooa5a9UiZXfs
         mLQqQAdBlJtAT/9Xqml33WVYkPZopPmMHFJ8AlKHhxifw8W/w/L5cjpYFZMUyB5qMuUs
         rUpItjc1xV3GoEUKlQkaP91oXR4oIxa3Nm7c9PdUBLGvtL8EMfAvKwshYSdkivSD72RZ
         H1ckm3+ipeZ29mTGSJ6zoYSKeVvIbUdbnF1ueN+mpYdCyV/+Q7PNVWBf68UeAitrH6Ob
         VuFWpHHdEgBTTEyBEqSZ4TWhNUE9IkAo6rkjVSrDq3TwFArAO1MF6BSvB+DOZuwkNUWB
         nKeg==
X-Gm-Message-State: AJIora+5Uto2d2XM61o0PmhMTUYwDA9EfrcQ6SxpIiO7vrg9XVTodh/T
        bdkwXjhIDeWYcykDYm3gOFBJj/0fgcp8C7HjYhoGTAzIx5C5wI9AYG8U07ZjgJB7FKtVBUooAj/
        JLjHMjj1nMWAangDpSC11zM45
X-Received: by 2002:adf:e491:0:b0:213:ba6b:b017 with SMTP id i17-20020adfe491000000b00213ba6bb017mr2244119wrm.652.1655797174146;
        Tue, 21 Jun 2022 00:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vOMmayQmvf7SIYR8lv3P/I4QUP1e869MPBj5r5k76l2FUw/Qwk9oItuc7MizEnliZ9dC4/YQ==
X-Received: by 2002:adf:e491:0:b0:213:ba6b:b017 with SMTP id i17-20020adfe491000000b00213ba6bb017mr2244092wrm.652.1655797173867;
        Tue, 21 Jun 2022 00:39:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:2500:cdb0:9b78:d423:43f? (p200300d82f042500cdb09b78d423043f.dip0.t-ipconnect.de. [2003:d8:2f04:2500:cdb0:9b78:d423:43f])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d4c4f000000b0021b966abc19sm1468962wrt.19.2022.06.21.00.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 00:39:33 -0700 (PDT)
Message-ID: <b01d66f5-67c9-95a4-7dc7-ec7645560214@redhat.com>
Date:   Tue, 21 Jun 2022 09:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 1/2] mm: memory_hotplug: enumerate all supported
 section flags
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        corbet@lwn.net, mike.kravetz@oracle.com, osalvador@suse.de,
        paulmck@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220620110616.12056-1-songmuchun@bytedance.com>
 <20220620110616.12056-2-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220620110616.12056-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.06.22 13:06, Muchun Song wrote:
> We are almost running out of section flags, only one bit is available in
> the worst case (powerpc with 256k pages).  However, there are still some
> free bits (in ->section_mem_map) on other architectures (e.g. x86_64 has
> 10 bits available, arm64 has 8 bits available with worst case of 64K
> pages).  We have hard coded those numbers in code, it is inconvenient to
> use those bits on other architectures except powerpc.  So transfer those
> section flags to enumeration to make it easy to add new section flags in
> the future. Also, move SECTION_TAINT_ZONE_DEVICE into the scope of
> CONFIG_ZONE_DEVICE to save a bit on non-zone-device case.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

