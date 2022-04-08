Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E34F9828
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbiDHOhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbiDHOhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:37:50 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E10D21A0D7;
        Fri,  8 Apr 2022 07:35:46 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id k13so2803831plk.12;
        Fri, 08 Apr 2022 07:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CK7pYF/7NP50OLfe9YKqbwh4fS4YoxdxpXdervGIEnA=;
        b=DCow2EKnyqmT77aOo3TW8vaqvje9+/AbvdBhi2721SL9SbGRO4b2rSMj+La6z8tpQX
         VZ60tDRFxihDpEcKcrf0k1EXTNmhroYA2LixqD6+fC8VH5nAfh/YqD1R1Xp1Ghx75rYi
         QaiZ1edpQWl7ZTnX20H181yhUMUnGU4ZjnwEN6ClZfX4P+ZDuIIvtXgllmpG7c2ZV9vI
         S3WDHaa1J0/ODk49vSs6kuxOpa0RoLmaI6g1QK2g3m2OnSkx1rixKLDiBRXM6ptpW5R9
         RA9gIfx6b2jI/53iZUd/g7BTjdVY2/O2wZT46wEy/uApXqgDIfUPRIctq/ZiDb/p2SmB
         iLbg==
X-Gm-Message-State: AOAM531bAgvLzpuwa2vAJjuAZzA8gltZvLITH/YnSMTH1HCqqyVmIC+o
        7Lnvw/7+N6IkjZRrkDWjexhI0tqMDtU=
X-Google-Smtp-Source: ABdhPJyw4qpskWoZ0IGB9hflof+s+GHqdmFo7uq22kcwCPQrhVd0Gy5XxuxgV1vMAFlXddBA/VFITg==
X-Received: by 2002:a17:90b:350f:b0:1c7:7769:3cc6 with SMTP id ls15-20020a17090b350f00b001c777693cc6mr21920426pjb.120.1649428545868;
        Fri, 08 Apr 2022 07:35:45 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id 196-20020a6300cd000000b0039940fd184dsm13471201pga.9.2022.04.08.07.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 07:35:45 -0700 (PDT)
Message-ID: <bf2ba622-a882-6a59-9db2-461933d59594@acm.org>
Date:   Fri, 8 Apr 2022 07:35:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] scsi: ufs: ufshcd: constify pointed data
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
 <20220408103027.311624-4-krzysztof.kozlowski@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220408103027.311624-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 03:30, Krzysztof Kozlowski wrote:
> Constify arrays and pointers to data which is not modified for code
> safety.

This patch includes changes that have already been posted. See also 
https://lore.kernel.org/linux-scsi/20220331223424.1054715-1-bvanassche@acm.org/T/#m47f9489f1976039d07bfa4ec766b06d3f2d73239

Thanks,

Bart.
