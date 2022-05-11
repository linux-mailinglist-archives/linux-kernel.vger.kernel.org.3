Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53988522B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiEKFG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiEKFGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:06:51 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D244EF47
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:06:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 204so1012862pfx.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AUEIkeNWULTqIuIT1TZeXx+IdneqcLu7BzWDktuhfnk=;
        b=F8jn7i4bbQ95N7G7p4DIUqUUwb8R45Ly5JB7TyyhJiHYhrGNc7SkaFJWOMLSwQiz6B
         mLVffC7ztUhB4aMrEx9YveKtguy8R5xI87IrhfPmry6wYuvrkwwXZhpMXR2S/FF3paXF
         4vR4IChTGPB+fepRra4S8AToZBNXV2Un6pyThhngFfNZ12B4XRupcgr9ykO+zGnLooZe
         WEypzao1fonjiP3LL3Df9bvaMieh8T3HC9Lp2fDodmttzz5+CZTXnRYZn2ANc1NCvkus
         AfLV9HnZVpARsF8gv35ufAIkT1BXKQoDK835N2MrukdhICpE6kgp8lRM8SUu7m7KiNPy
         GOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AUEIkeNWULTqIuIT1TZeXx+IdneqcLu7BzWDktuhfnk=;
        b=gMdDBO5G1uhIaIHnzi85JIkrKWCX0OYdVOy3XjKGHm74IVhbv8lHuTnet6N7CysBTf
         BGogcIgZpKjVf0/HAh9s/GkT7TWyjX8KnQWgHcHuFAiQ+tU0Z+NB6f42iEQiVfTaIGNp
         0ozowHYap4pz6gC8ANXHG10RdCg8vO32ABNIt4GxzVgvk5sG3OkJClJHwBKC6YyoRT0T
         wEjxSbwdgXHZ0wduyzdTCeEeQbiApWh5VpwS3ci2Xlw3leRDgRHSFCv4nFW8q2Jcik9X
         +QbFmXJz2lEJWCHcX2IE7I+Z6SkRqP7AuDhDBjFZpjqIDX8riKTSqCnHK/bPLHZwjAHV
         2EHQ==
X-Gm-Message-State: AOAM531C/Q59KclS+DmVXc+5ZWVX46mqvJNBLtlEtiZmB7wpDwPO2wXM
        gDt5s0sodcUUqYOSOYTRVO7qww==
X-Google-Smtp-Source: ABdhPJw19bwjjubf5ZE0oIAmRAefBe7FNecIitByBceQ0V+zCTh9c6/8TSu7+c0yFISh4fD8ZvKs3w==
X-Received: by 2002:a05:6a00:18a9:b0:50d:d41b:7240 with SMTP id x41-20020a056a0018a900b0050dd41b7240mr23119315pfh.66.1652245606028;
        Tue, 10 May 2022 22:06:46 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id 13-20020a62190d000000b0050dc7628161sm496573pfz.59.2022.05.10.22.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 22:06:45 -0700 (PDT)
Date:   Wed, 11 May 2022 10:36:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/6] PM: opp: allow control of multiple clocks
Message-ID: <20220511050643.hd5tcrojb3wkbg7t@vireshk-i7>
References: <20220411154347.491396-1-krzysztof.kozlowski@linaro.org>
 <20220411154347.491396-5-krzysztof.kozlowski@linaro.org>
 <20220425072710.v6gwo4gu3aouezg4@vireshk-i7>
 <dea39b1f-0091-2690-7f07-108d07ef9f3c@linaro.org>
 <20220510044053.ykn6ygnbeokhzrsa@vireshk-i7>
 <1e533194-7047-8342-b426-f607fddbfaa3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e533194-7047-8342-b426-f607fddbfaa3@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-05-22, 15:09, Krzysztof Kozlowski wrote:
> On 10/05/2022 06:40, Viresh Kumar wrote:
> > They shouldn't reach the OPP core then. What will the OPP core do if a
> > clock has a value for one OPP and not the other ?
> 
> That would be the same mistake as providing one voltage as 0 or with
> something outside of a spec (but still within regulators min/max).
> Mistakes in DTS create undesirable behavior and this part is no different.

Right, I agree and so it shouldn't be allowed in principle.

> However I understand your point - since the driver provides the list of
> clocks to OPP, it should not provide ones which are irrelevant.

Right.

> > IMHO, this is broken by design. I can easily see that someone wants to
> > have few variants of all other frequencies for the same frequency of
> > the so called "main" clock, i.e. multiple OPPs with same "main" freq
> > value.  I don't think we can mark the clocks "main" or otherwise as
> > easily for every platform.
> > 
> > Stephen, any inputs on this ?
> 
> In such case, matching opps by frequency would be a quite different API.
> The drivers can use now:
> https://github.com/krzk/linux/commit/ebc31798494fcc66389ae409dce6d9489c16156a#diff-b6370444c32afa2e55d9b6150f355ba6f4d20c5ed5da5399ea8295d323de8267R1200
> 
> If you assume that this frequency can be used for multiple OPPs, then
> the API should be different. Something like:
> int dev_pm_opp_set_rate(struct device *dev, unsigned long *target_freqs,
>                         size_t num_freqs);

At this point I am not looking for a new API, but just continuing the discussion
to understand what different hardwares want or look like.

> Finding right opp for given frequencies would be also quite much more
> complicated task. Not a simple ceil/floor search by one frequency.

Right.

> I don't need that use-case and my implementation does not prevent anyone
> from implementing it in the future. IOW, why developing now complex
> solution which no one currently needs? If anyone needs such scaling by
> multiple-frequencies, the PM OPP can be reworked/extended/improved again.

It isn't about being complex or simple for me, but the design needs to be
robust. Either we can have a guaranteed "main" frequency or not and that would
decide how we need to proceed here.

-- 
viresh
