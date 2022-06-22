Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F695542BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352538AbiFVGOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351477AbiFVGNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:13:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5256D2F8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:13:43 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id n12so8229387pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mM0l1sKIlwdyQ+D80uJ2mxXHQE5erm6J2cRxjRDe3v4=;
        b=YR7IThXDdANaHApmuh4oUh1oywvHKe9S6viUt0T7hQiRq617GMj5QvAWMkIrDIjysu
         R3+zhUDus0MAX6HTyHOQ7bPrvBMeHn03WlZVsV9R0R9k8Frgv0v4B2xKwcwVOKSmaDnB
         9lOfDyThO1/Ei3dRRy2o+sK3MN2LLYATbd2/AQzVreM3rXAP6A98I5n36F7LnWo8bw3A
         7aXI4nmMh+nrcwj/2xfWfTB6Bc6IVg/E+i4F39W3iaMPHrJvbpKUtDDxXlqdMsDExtzw
         R4Hcv88OROvZej5QoiJ5BL1MJbJs9U4iLOoV3iMwwpb/82vi1PymHVUwBiKaRU6NgFRx
         fK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mM0l1sKIlwdyQ+D80uJ2mxXHQE5erm6J2cRxjRDe3v4=;
        b=fySae/GI/y1ncIlQQiYb2fDCrQ+5NgCF33xR848tZEmA2LgAuJzG2iO617UVLIwLGN
         KgxbkxI1zzTSOReIzBBWOkisWm2SmwZPgq2KwObD2RnCBdvMdIMI6WPbSCHFSgKCl28n
         eVRXj4HWd4xGYRNTPT2qffx7ciCBljat5e0ba1MPUvGz1NWuh+Pj7V6cMd9UCyhRU8Aw
         cQYftsM7ZT+UDdsSvukCCEtpKRp45hRKjMvmyAOkKAZS1vSNHBJ8EEGY5tX/pOvD9JmJ
         pjCU+I3pXTuOtq6UmvA87nOnaOeoq543jLKD0sicB0lNhOw+hKymeaTvj9Aw5ls8VLQG
         wMyA==
X-Gm-Message-State: AJIora8aocNNS2GtBhjmD6NMydFmttCwYuJUSSkGuekKaaRpxXOP7HnF
        595S/wWekt8TKB40av5IsMSAPQ==
X-Google-Smtp-Source: AGRyM1v2UKuqwf/xfl9ihDjMoQEXjqUMaJRnK2M3jwktms/yEi20wOHaA40jS7KxqOeMpk8r4iBctA==
X-Received: by 2002:a05:6a00:4406:b0:51c:244f:85d8 with SMTP id br6-20020a056a00440600b0051c244f85d8mr33496254pfb.36.1655878422623;
        Tue, 21 Jun 2022 23:13:42 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id d9-20020a621d09000000b0051c157f83e3sm4222855pfd.96.2022.06.21.23.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:13:42 -0700 (PDT)
Date:   Wed, 22 Jun 2022 11:43:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/31] OPP: Add dev_pm_opp_set_config() and friends
Message-ID: <20220622061339.irbznus5oh34g6wb@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <9c4b2bfe628bf7a583a96cee7cc3539e2e66245e.1653564321.git.viresh.kumar@linaro.org>
 <da2f1552-6896-5ae8-4837-28f31f3031a9@collabora.com>
 <20220621153440.aazq7cjiq5vgkvxy@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621153440.aazq7cjiq5vgkvxy@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-22, 21:04, Viresh Kumar wrote:
> > 2. Patches aren't bisectable, please make sure that all patches compile
> > individually and without warnings.
> 
> That is strange. I will try build over each and every patch (again). Also I
> think the kernel bots (from LKP) test individual patches and I haven't got any
> failure messages yet. Which patch broke the build for you ?

Hmm, surprisingly (as I do test this for my patches) one patch was emitting
non-harmful warnings and one broke the build. Fixed them both, the final diff
remains the same though for opp/linux-next.

Thanks for reporting this.

-- 
viresh
