Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D9F57FEC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiGYMJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiGYMJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:09:53 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017CFDF61
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:09:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o20-20020a17090aac1400b001f2da729979so577309pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/vAlD2Uj4JArMK2xat0u8itYglD8Kk8L5ACdFaAlxqs=;
        b=A2oNuiPlEVJtYLXgw2uTDbD5XoOkhTkRZ+TgJG9T0B0UnRIol8tNmoj+OnwvNTiEZc
         hle3V416mtDl6YnRY54Uz7ZYoma7m8kzIx8/sH8Zt/v1ff/uW63BeM/ei5HFh8fLCpNv
         6C0RZ+0axhJRxw1pbu0Wwk1xEj3iHOxBSS0IUpvGlOJDhX99a4BSryMuaAVVRNaigVCz
         Eezn91YMhIcU+BzP8pmyW2Cpxua8a69l8hJMfGFixyqsWwuCm1AYWNB+kPUmtzHc+fak
         63ETFIbHFLKullcdOwvTPZNIOwkGv8O/GjgK0UZ4M5Gg3dCujVbmnz3mHGPBMdy9JpDu
         nh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/vAlD2Uj4JArMK2xat0u8itYglD8Kk8L5ACdFaAlxqs=;
        b=YEeb5uGQciV7mlGZXvTeCEY/tUs2hOFvxTD7Vj2txcIjOYNZEQsfxchWJ+7Bm66yzo
         HMtW8Q+OyCdQyvUySW7ka7ixTm+/Rb0kqROO04QOvlUNJtwY+N/eS6T26Ir0sK8Om+bK
         mOISpcIis5o5gK4juXTTpZuazklT7SOTVDfMDQbjINqcQsrKkvGKTBicZ53wXi7PkaLR
         tmGnxGQbfwgwTI03wahAh8rOnmN0Pkxw5xe5Da8Q1oaY7xAF1E6nv4aBnkwE6JNH+3dR
         Pr0EcsJNOQZUcLgxCB/3rJkGw0+QQExSsz7UTt8LbWGK91Tn2iDiYVAAyb0W2By3/kFQ
         RG3Q==
X-Gm-Message-State: AJIora+6Ok/72RH5Gu2/0Pwxd3QjKNZxxzAC4g6jGiuYE3NonuV1dMyv
        dGsIiWq2usZWTyOA0qWeHkaG9g==
X-Google-Smtp-Source: AGRyM1sSBp98T6cTNyv8vujrNsns4paivHQuBGy782p0vi4eo2Asxwnq5ntBEh1AcH0145Y434mvdQ==
X-Received: by 2002:a17:90a:f003:b0:1f2:49f8:19d5 with SMTP id bt3-20020a17090af00300b001f249f819d5mr14573096pjb.28.1658750991448;
        Mon, 25 Jul 2022 05:09:51 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id r13-20020aa7962d000000b0052acb753b8bsm9325800pfg.158.2022.07.25.05.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:09:51 -0700 (PDT)
Date:   Mon, 25 Jul 2022 17:39:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, Linux PM <linux-pm@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: WARNING: CPU: 4 PID: 326 at drivers/opp/core.c:2471
 dev_pm_opp_set_config+0x344/0x620
Message-ID: <20220725120949.fofc7chlsnrgfpvm@vireshk-i7>
References: <CA+G9fYuGFReF0Z9qj7-80eY0gz-J2C5MVpno_8NjrGSH5_RB0Q@mail.gmail.com>
 <20220725102711.p6eerjjzgeqi4blu@vireshk-i7>
 <f914f5c5-dd61-8495-b362-3043406582da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f914f5c5-dd61-8495-b362-3043406582da@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-22, 14:55, Stanimir Varbanov wrote:
> Hi Viresh,
> 
> I can take a look and provide a patch to fix that.
> 
> But, is this a new warn or it is a consequence of new changes in
> opp/core.c ?

This WARN was missing earlier (by mistake) and is added now after some
redesigning. You can reproduce it on the OPP tree:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

-- 
viresh
