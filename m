Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895D55862AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbiHACgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiHACgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:36:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EB762FD
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:36:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 17so9424897pfy.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/btFMtkRWmBmwZL2J5Giju8R89Pj69dl4iEYhrOPPD0=;
        b=l14ypADMZwmwBX3PPuNnhfhC0pkWgO3nxHo/kcyqcDQQy6USdhzex+seukGsSkiqSF
         CD7pjPOYfJb33Kd7/A6vDuOlVFJR69nqhta9PCeUDn5y37fM+EkdqrOWOxK0nM364cNI
         2hS6W+ancz2HhSWKGABkGucgEiskAd7ylplsxyesLdgbKYAGyM0I/K+ZEXPCQJj/GkFL
         8Y9XaXvYU44xz7LbcwFhfHWp3z3bb1GMR4qPIK58+MeCotpAY7lzMuOK025gYsWI0JgR
         W00nJkIsFipx8cXltA+pedB7ltCKnQ+3K6ezUJJcMD8vPYZcKGA2QkZCWNkwtVcXUu7k
         0vXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/btFMtkRWmBmwZL2J5Giju8R89Pj69dl4iEYhrOPPD0=;
        b=18orZUCRZ06bULK/3w3vt1he48R14gKl+0EG1htGAfiK65yEs6F/NHozDK6z/EeUyq
         9YnLGy+B/QFVD0/96rrGM88HFpKvFt9yMYszX3zp9wYU1ITG8JvgsZ/7Ut7Y101HgiTo
         amh3ZfX08GDb6zGYm3z6tq07YWoq6PP4F8WcyMsvTUi54bRA8pMArejr4ABq6waudbTT
         GYZTWeHvtnKNAgVMzuS1gK7mbMssDr9PtS7SSMwyy7xshpD+jwBJIbvppPpPEUq86vgx
         1ETc8Q3k7erOqIWiL9rYEQ8a7+h/JvkKfFtmoUbVHQxj5Dr3N9LuojE31kDjocl9V1Zo
         YwCg==
X-Gm-Message-State: AJIora+xvipbaUI+wTbx++cIlPD+RUidq5Y8E4/Kba5NYwU8qdxaZaNj
        ElB2btDw8QIOlyCsU6Vl1bIssw==
X-Google-Smtp-Source: AGRyM1uWuPpbJThAzj8401hKyu6FavGanE+K+gT78KliFc+nSDEucI4aDKw5IqZW2VO01+cLRobseA==
X-Received: by 2002:a05:6a00:24c6:b0:52b:ee89:eca9 with SMTP id d6-20020a056a0024c600b0052bee89eca9mr14043056pfv.78.1659321406689;
        Sun, 31 Jul 2022 19:36:46 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id j11-20020a170902da8b00b0016d1f6d1b99sm8237530plx.49.2022.07.31.19.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:36:46 -0700 (PDT)
Date:   Mon, 1 Aug 2022 08:06:36 +0530
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
Message-ID: <20220801023636.p5ytjqasedpohmdy@vireshk-i7>
References: <CA+G9fYuGFReF0Z9qj7-80eY0gz-J2C5MVpno_8NjrGSH5_RB0Q@mail.gmail.com>
 <20220725102711.p6eerjjzgeqi4blu@vireshk-i7>
 <f914f5c5-dd61-8495-b362-3043406582da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f914f5c5-dd61-8495-b362-3043406582da@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-22, 14:55, Stanimir Varbanov wrote:
> Hi Viresh,
> 
> I can take a look and provide a patch to fix that.

Any update on this ? I am going to send pull request for 5.20 very soon and it
would have been much better if this was fixed before I send that.

-- 
viresh
