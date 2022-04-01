Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49A64EFB79
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352146AbiDAU1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240467AbiDAU1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:27:42 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C5F2A5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:25:51 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-df22f50e0cso3949708fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oqLr3CQkeovfFARJlOS29QpiBz7Mv54uvfNsfK21+RE=;
        b=coOUZSozgph8g3yWCWkQpoEyvEcw2gzPyFFMsn0aOu49d0AOZRLPlt6DB6qkqE/1aa
         oZP8LkZY7cBvT/pMb0haVysTmw7cesWJ/R2J5jXQ9Nn/cXmlrWyuxxUGPvFed5adi4sB
         SPk6XCvE/fEhadDXiP5NicXLmDj5B/ofrUB8jORzZGoN3lNh4K4saSCMKh78xTS2u8mf
         JE5bo/FKjygn/SdX5FALm8Q/QVEw+XLRkF+jsVrhIw0qFKfc7v5PdxM2Cl5M+7ECLwSx
         messGYWBZpMOrq9ZMDr+IyEvR6gozjPg65suApTedWWcCms1+jjJbxa1jcNun68/RR3G
         1YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oqLr3CQkeovfFARJlOS29QpiBz7Mv54uvfNsfK21+RE=;
        b=WI+DvQo+qKnNyB69Kpb0X7Ju4PnIMDlza0RA/l2NgwW6flfIfRU8YoSJcKp4nO8S3W
         pBcD0KVl9lFcMKlu03iXa8qQgVsZANKsepogRk1xYuPXFqSP4VKnIsEBYjZkuP4fCdAv
         pIYbe+TSmaOCs480FHtY8yY1uZ0NlUfcUedFYnTkNWno1xoR8Shs67UG0PpkbMtPkESH
         mN7U+wIQZz5RpUyazZwIn9+LBm+dpsW9m74OU/Tf4FWfztJsMP+uZcbwK5FoANSCiSIJ
         qxqbBWnXsMMPjmdxqcsbUd7SUJC/mZ6PyuuRh0LdAdahEJeXlrnWqAr+tX+KmIhkQwt0
         k4kQ==
X-Gm-Message-State: AOAM530vKecxRbCvSLYAIha+45qTKMjbKsqgAdUUsf5QLpc7UL4rVQmb
        6JESMPWPw3qP5wl/lHOFIFWWkvjYOt4=
X-Google-Smtp-Source: ABdhPJzkb0JznTQj7KBrDYpwHJJyzvXVyXaU1Rdk3Hk1yrEsFgwqtafPkNRZupXizjn7fIqrVHbepg==
X-Received: by 2002:a05:6870:e9a0:b0:e1:c609:74ac with SMTP id r32-20020a056870e9a000b000e1c60974acmr1419358oao.127.1648844751291;
        Fri, 01 Apr 2022 13:25:51 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1004? (2603-8090-2005-39b3-0000-0000-0000-1004.res6.spectrum.com. [2603:8090:2005:39b3::1004])
        by smtp.gmail.com with ESMTPSA id h11-20020a9d6f8b000000b005b230ab0461sm1559019otq.64.2022.04.01.13.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 13:25:50 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <8e68501c-24fd-cfbc-60f2-ec3e277159ab@lwfinger.net>
Date:   Fri, 1 Apr 2022 15:25:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: r8188eu: Fix PPPoE tag insertion on big endian
 systems
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220401151257.3414576-1-linux@roeck-us.net>
 <782f0115-e45f-1aff-a152-5d403c990b31@lwfinger.net>
 <dcba377b-1fce-92e6-680a-77c5567cd06c@roeck-us.net>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <dcba377b-1fce-92e6-680a-77c5567cd06c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/22 14:25, Guenter Roeck wrote:
> The rest of the code uses htons/ntohs, so I prefer to follow that lead.

You just proved my point. It is hard to get be16_to_cpu() wrong. Sparse will 
flag the error when you use cpu_to_be16() instead. I expect that your 
htons/ntohs problem would also have shown up with Sparse.

Larry




