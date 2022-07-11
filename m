Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3F356D2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 03:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiGKBkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 21:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGKBkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 21:40:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F086466
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 18:40:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l12so3212535plk.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 18:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XnfQp3ERPcXVr1SfkvpwTPOkDbA2V1JzdVQnqv1Kq0c=;
        b=DfH3oPQL71Fe6KNC7/zUETjNSjvncogdffp2osrlzSYUn60ybVRrEv6r6S03BVS0NK
         qplGNxnRuWr7w2VwTN+ILehM9FwnqbwdjGoi38WZg8yNp1CPlK8LxiLB5ud3bMsBKMZG
         4aqUbeR4TJqrSXopv0HSapGUFELXczIHcmNFWaayNuciAWiVeCJYndJJI08KJDRARiB9
         l5O5YWhqnUREz5pGDEwYfbxbJ09S0Jwq/cVI82ltJ+3BvRHBK1VLLJBTQOX0Xg0CXW3R
         QT5KBsRkQJbJzOnjQ13LVY5MluDP4sROIFWq6MkxNLZxJ0qb0LoHeofn83gJFHQrtoy/
         rYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XnfQp3ERPcXVr1SfkvpwTPOkDbA2V1JzdVQnqv1Kq0c=;
        b=Yb9T+4Ml/RCIpr1pVfdaiuQYt9LIBU9lMnW/sWGkhiRvn1F9SmbEW8DVaEXCAFBoYE
         lDxzPuSE00nSFy/aIJ8oaKSG4QfMDG4meCaUdlxqh+s2heUG+cYei0dfwg2E9QGKIVMT
         xo63xk9gNAH73mgWXjrsMmKIpr3OrMP33G31Bik6fwukZT4Ui/kGO4jYhCS8HSIbJGfq
         INvTwtdxur1y4wC4RuQ9LO6O5gkDVxYaX7AdP3b2XJ6HFzD0SO00WgqVsNiHbSHY9Mee
         Qt+ixC3HZV0iasEU/3Th60OBbqUsrI5bEM96aTIgiDn7DIi8hYHYdQaCloBCLpOlf2a3
         36wQ==
X-Gm-Message-State: AJIora/DoHIeYFmMP5tbX+MnSaXz5MlUKLojmXI6+0wPSqcPix/jBsex
        dlMx3ZuGaRvducj9uZ9Z5llQfg==
X-Google-Smtp-Source: AGRyM1ubFzAa7m3tTwbWVmmRxlJPIgWuw4SnSfi8v61PLkuELiYBaErfL0WEi/gjpsvgeEnQPJuedA==
X-Received: by 2002:a17:902:d48d:b0:16b:f0a8:446c with SMTP id c13-20020a170902d48d00b0016bf0a8446cmr16131168plg.50.1657503621081;
        Sun, 10 Jul 2022 18:40:21 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id n67-20020a632746000000b003fbfe88be17sm3020302pgn.24.2022.07.10.18.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:40:20 -0700 (PDT)
Date:   Mon, 11 Jul 2022 07:10:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/14] cpufreq: cpufreq: export cpufreq cpu release
 and acquire
Message-ID: <20220711014018.xgflrf55bpahdvtg@vireshk-i7>
References: <20220709141940.836412-1-Perry.Yuan@amd.com>
 <20220711003934.rn2igfoxtpcsiocm@vireshk-i7>
 <DM4PR12MB5278B192484CF7B728875DD59C879@DM4PR12MB5278.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5278B192484CF7B728875DD59C879@DM4PR12MB5278.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-07-22, 01:39, Yuan, Perry wrote:
> The amd-pstate for EPP mode is under testing, I will push that patchset in a few days for reviewing.
> If this patch makes confusing, maybe I need to move this patch to coming patchset.

Yeah, it should come with users and not like this.

-- 
viresh
