Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0682D4F967D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiDHNOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbiDHNN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91265D6F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649423503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOFlqhY22jYsoq+ob7xKTzQP+SCAy2ygHB8Qj3FLlrk=;
        b=M+l2FPwIdUfnUJFBtRKVZBw1aqyudv8/Y8mb3roZ9yK3LkM/LnB4KVsZe2iRfgojcRkTIR
        nJ+VYy/w6y7HKE2yn1mqrxmKVwcaWIGGMYc3tvQxHGSFl13AbKynJzb29GfumqnsDnqbtt
        hiC8igPmGeRTubFMd9eBDt3It/pqwjw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-uYa_KmDNPj2wfrh3Nhu2hA-1; Fri, 08 Apr 2022 09:11:41 -0400
X-MC-Unique: uYa_KmDNPj2wfrh3Nhu2hA-1
Received: by mail-ej1-f70.google.com with SMTP id gn14-20020a1709070d0e00b006e84581e345so1692638ejc.19
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 06:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oOFlqhY22jYsoq+ob7xKTzQP+SCAy2ygHB8Qj3FLlrk=;
        b=c0QFFqdsxiLWElDjHTKvEffynSuEqXNYPGf1FHHo+qxwgrXNgRdlAmNzKH8w+ZTe+C
         NenpZLjXUbL7Ro+DaCddqb7fTy3SP9Mt2Beki5ZPyFKFZIv1FmbTL45G2hSiBYLGBsSP
         Hn6Eys8FDgBZcsxwCPgaaXnEsdneRrTdukca17wj92m++AP18DQXM/NLShXAQ5t/tOqs
         dSDUa0qtQ6col2MjWUfZuXPp3Mg3Z/DgyFg89Xd8zAizWOYj/BK2q9mFgEEqFuG3ISX/
         sPX4f+yrD93YIGu1DQ7UXdJUwJ+52VwQGrbtf2ofo0boaEvCLow8VXMNpmj+xXVYIFf9
         Z8Qg==
X-Gm-Message-State: AOAM5319dKHugycWUEtz4jPlIAQOypLYNOXNTO5NmHbjjUFoj27LnK9G
        dq2rSuARhwne40gXsHy9HVdSm6Osx1aFHUCgwKYHsYamo/KsbR0hSCHTXYj5lQ07gBzA1+h2ML4
        Q2Kh0owgpqQTC7H7GUAI7uPjt
X-Received: by 2002:a17:907:8688:b0:6d2:c19:e1a0 with SMTP id qa8-20020a170907868800b006d20c19e1a0mr17642069ejc.249.1649423500620;
        Fri, 08 Apr 2022 06:11:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGqWMXtLxjkDiB9O5FvZYY9poEXz7xmy/mjbGXXrp6fd6M5rVBrNzOmCmqPPF0uyeM5Pww/A==
X-Received: by 2002:a17:907:8688:b0:6d2:c19:e1a0 with SMTP id qa8-20020a170907868800b006d20c19e1a0mr17642050ejc.249.1649423500417;
        Fri, 08 Apr 2022 06:11:40 -0700 (PDT)
Received: from [10.0.0.45] (host-95-245-33-130.retail.telecomitalia.it. [95.245.33.130])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b006a625c583b9sm8747089ejd.155.2022.04.08.06.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 06:11:40 -0700 (PDT)
Message-ID: <06ee8466-ffb9-20f5-f66b-3c36e45b1488@redhat.com>
Date:   Fri, 8 Apr 2022 15:11:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] rtla: Don't overwrite existing directory mode
Content-Language: en-US
To:     John Kacur <jkacur@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20220402043939.6962-1-jkacur@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220402043939.6962-1-jkacur@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/22 06:39, John Kacur wrote:
> The mode on /usr/bin is often 555 these days,
> but make install on rtla overwrites this with 755
> 
> Fix this by preserving the current directory if it exists.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Thanks!
-- Daniel

