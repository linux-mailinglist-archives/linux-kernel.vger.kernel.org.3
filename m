Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D634056169B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiF3Jjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiF3Jjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:39:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9126765F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:39:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d5so16509588plo.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dydFLHE7XkUecc9XF6jhG98rpOLX4SjR+B+7JsSqIGU=;
        b=I5NSIEy/iFdPDGb0Ec8Ti7bAlJr+3ugd/B5m1AMyuoprepBDKQev30jwfo7PMXQ3W/
         Gh8JsVXr5OUZYXdrTDXpGnA4OG/PBFXNy4LrkC63nWTIE240I9QiNpdvKy19OZyIqCD+
         OU9wxvziKGEJMJUMi79pJALToOcHM391yWb6b8LKMm5t/XN9JvAXKe1phnjJRQncJWjN
         ONjnA5OctW67lTPrteb87ZBEs9GL+r/zznMCFBstVDsrpwAffFpE0Nsua3t9Ez/LwDt5
         tEm+wqNdWb4sKrRIbyJtzGZus83SWI1bRYXjlR0Uq16Rgprinlx7/TmE3onvKW/KI70+
         6q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dydFLHE7XkUecc9XF6jhG98rpOLX4SjR+B+7JsSqIGU=;
        b=sZO+hJcaCIiYwsHw1npZkS0bh1Be+HaahA3DggDAoAQNTvXnLoVIdbcNjWjISrrCPh
         bSemqJZl1gArNxKr5BDKpAR9Fuk3Wb2hLRp+FELvFOcEqma241TkMvYBLG09c+QRsVs8
         XEY4Fu+fsFSJgLSpvNTVhpjlcxPq7Qk5ayo1bluHcGRrB9kZ+IWyzfuKcA2HASjPqMzT
         D9XL3lj2K23GbTLE/QJHn5lz5Sir7sCfrQVCj+05jyrrjCQh150ce1+xhKs+UK6swuSc
         Fp537hxc3YY5Ofs0/i4kmEZh3p1peM4uSdiFGKkVXfnO7Q0ujgHqP/6g+El97Y3fdET4
         fzxw==
X-Gm-Message-State: AJIora/+wUcQPlHE/b0VMJYbjRG1/fTfqivqq66oMCh5O703lmkEx8gQ
        BH68YXs0GZYa7GkX0rAsVptBWw==
X-Google-Smtp-Source: AGRyM1sT8oyjVbl8+ZH8C9w6qWxGI7sbhpuOfD4bxocenF46Tm8u+dWub1Dftt3bu1OuObOuullOTQ==
X-Received: by 2002:a17:90a:f8d2:b0:1ec:b55b:2fdc with SMTP id l18-20020a17090af8d200b001ecb55b2fdcmr9071778pjd.115.1656581990072;
        Thu, 30 Jun 2022 02:39:50 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902d2c300b0016796cdd802sm13203381plc.19.2022.06.30.02.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 02:39:49 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:09:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Message-ID: <20220630093947.lgr5x6qmcp63ksut@vireshk-i7>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
 <494f610a-b252-44ba-c883-155731561769@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <494f610a-b252-44ba-c883-155731561769@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-06-22, 10:38, Krzysztof Kozlowski wrote:
> On 10/06/2022 10:20, Viresh Kumar wrote:
> > This patch adds support to allow multiple clocks for a device.
> > 
> > The design is pretty much similar to how this is done for regulators,
> > and platforms can supply their own version of the config_clks() callback
> > if they have multiple clocks for their device. The core manages the
> > calls via opp_table->config_clks() eventually.
> > 
> > We have kept both "clk" and "clks" fields in the OPP table structure and
> > the reason is provided as a comment in _opp_set_clknames(). The same
> > isn't done for "rates" though and we use rates[0] at most of the places
> > now.
> > 
> > Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/opp/core.c     | 165 ++++++++++++++++++++++++++++-------------
> >  drivers/opp/debugfs.c  |  27 ++++++-
> >  drivers/opp/of.c       |  67 +++++++++++++----
> 
> I don't see bindings change here, but I think you included my pieces of
> code related to parsing multiple opp-hz. Is that correct? If so, you
> need to pick up the bindings patch as well.

My bad, will pick that.

-- 
viresh
