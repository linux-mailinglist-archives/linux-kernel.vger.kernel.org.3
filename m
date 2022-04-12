Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD74FE6BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358086AbiDLRVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiDLRVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:21:10 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDF7522FC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:18:52 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e2afb80550so9538925fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1MO+MVC56kZBEIzmrDTAZJIjtd3zPAk5txwHxsm638E=;
        b=gZQ3Y+NeEP9WnYsHYan82XhAQmdLR4MoAYCSbsu+ev2sTjAHgsufOBM6FCGYJU6zEP
         3/pVjKBm/n0l4n4QmRYbeKn8rcIf8jo8aU/wEdDTv2h1z0d02KAoQ9RV4vQzITsBeuyh
         ML8muAuO9gykkVbYrJbzdXzwOHKwZElndDEDN5SKcgm4G5174MHF/izLExQEIQONlexh
         vwdEolH6xG21PjvQA6tOxn8mvBAhzHeOA9olSMPX+2SdmH6JQevgwga4LBINfT3Yig0W
         8I1f6cFrA6eb8XFuMqL5XMqaTIhWWS+8hWrkBXbatE9XfCc9zXOLlOAwTX3q4WcuS0hj
         WMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1MO+MVC56kZBEIzmrDTAZJIjtd3zPAk5txwHxsm638E=;
        b=evn8lPDCMA3wL7KffgmwWUUwfH3fHWxbGtYtxpJ3Fqn9spnlvpcU3mYVYr7G9Hid7h
         FpqO1n7pyd5XfCfra7uIm9hnZ+jsqB9vhDCPqfuzSWhjL0ynF18EXvtO5rNPtmuBwfms
         2RYXzX1P9VuGDrDLscTHpOlB0+kBbPslfesT11P+rVMjrNn/6kb7JEIE6uvOi2MMqXfF
         ZbOmE84yrHZdWvn/WtIRvPpof+0g6VEaY8eYKi+ffhdwdw0zfQGaDZfa538UdNcW/QgL
         KTfOnavwM+MbDezjVMocIMdsW64EqpulRkw39/7z2LW35fr0mGARFz+3gaKLel5rvFdq
         FEVQ==
X-Gm-Message-State: AOAM530Shc5r6vtmGxjKGH8VdruP70HdMO6AN/JX+q4VWY92AX9KSfLJ
        7pSv51nbCx6FB6cMShdSwDmYDALpv8zgaw==
X-Google-Smtp-Source: ABdhPJwKWPBqgUckZLmmXiV4ZdPDvtEqvyf2VWE1hES3i003XDLdLa/VDYnij36CUwjRegV5hR17xw==
X-Received: by 2002:a05:6870:b408:b0:dd:ed4f:b1c7 with SMTP id x8-20020a056870b40800b000dded4fb1c7mr2652911oap.41.1649783932009;
        Tue, 12 Apr 2022 10:18:52 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id z10-20020a0568301daa00b005ce0f36dd81sm13529594oti.12.2022.04.12.10.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 10:18:51 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <027acae3-29ee-ae35-4448-a56e66383849@lwfinger.net>
Date:   Tue, 12 Apr 2022 12:18:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: r8188eu: correct multiple misspellings in driver
 r8188eu
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>,
        Mahak Gupta <mahak_g@cs.iitr.ac.in>, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
References: <20220411205321.13109-1-mahak_g@cs.iitr.ac.in>
 <c5fc1685-b1cc-7cfa-1ddd-e2f93105c2a5@intel.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <c5fc1685-b1cc-7cfa-1ddd-e2f93105c2a5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 16:28, Dave Jiang wrote:
> Subject:
> 
> staging: r8188eu: fix multiple spelling errors in driver source
> 
> Given that it already annotated that it's the r8188eu driver, no need to add "in 
> driver r8188eu".
> 
> Maybe the log can be something less terse:
> 
> Fix multiple spelling errors reported by checkpatch.
> 
> 
> Probably doesn't hurt to fix other issues on the same line while you are at it. 
> See below...

Wrong on the first and last points. That subject is exactly what should be used 
- it describes what is being modified.

A given patch should fix one, and only one, problem.

Yes, the commit message could be less terse, but that is not a problem.

Larry
