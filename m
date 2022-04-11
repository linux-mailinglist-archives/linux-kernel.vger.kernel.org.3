Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E644FB1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 04:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbiDKCvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 22:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240150AbiDKCvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:51:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685B42AF8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 19:49:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y6so12705014plg.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 19:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uXcIee9Yns7jOLzfV/llZix6Uxz5Viuskna/6ugB7Mw=;
        b=OD6rDXon45iZxMJDeZEO1PIWGEgxz7KmR0yEBJz5VUeRxfm9uUtDlzKbAL7iXtXjqA
         glo78+MtNXTUC983V2TiNtUs9HqNcSaHfqO3QAtgv9hDZJvqQqc1hE2uFzUCJtSWcECh
         /uw7o9idEqb7L94kNlgf0LFTDZdrwcufkxTLGP9WXxY0DyqnY3WVds3fzHiFCKhNDXFe
         ehf/KykXIA9mzy2wihmullxcP/LBPcEPW2RQrErUCldd7aFY4BLpn7sXOj0boqc4KAnn
         7LJe9ugK/ELoXgykQHl493EZzDijYZT8v0/rmM1pVgOMFD/ae+S37a6WhPaaLsYKj9Z7
         4nfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uXcIee9Yns7jOLzfV/llZix6Uxz5Viuskna/6ugB7Mw=;
        b=645SnH/6+6GHyYMXsylcIOLXmJfvCtsYQfPu+mf3FQLL1SL5a/iePUl19EvDEC9cUc
         A/5L27q9JyJdzkbITdg3uW2cDbghu7kr8vqbg27/le+J6UDRvooMPVFkAHwo2X671VEE
         +JJXlemL5sPJ7kPmFvwF6unUphfVpQ7C0r1arX8pSA05gxqDSZPsomZSel4uh1ziqEu1
         xQSQC8sGfFjqwntdYYP+rAbzS5eCSELkIN7RiA+WkeeSsBk0jMftpOoebOYekVTU1X3m
         sqkhrscxyB3h+TExzyh50O5QIa1y1ELPtPtxTidhGLCTA1so29mwfBaYjGykUHrHKOve
         wB+g==
X-Gm-Message-State: AOAM530HkHEqWwWH80fpYXvp+FLuYbv99x8K5uzuaeWA/F7w0djbl8cu
        n0Sjxd5foCp/zc6B+C3a95CUNQ==
X-Google-Smtp-Source: ABdhPJwiHW7XNh4KwMT8iJrViqSNRE5fm/cebUjnrBUONKKP70zUxuBBAP4I6t2IGX5tnm/+eN4DcA==
X-Received: by 2002:a17:90a:3d02:b0:1ca:7f92:1bf1 with SMTP id h2-20020a17090a3d0200b001ca7f921bf1mr34536653pjc.177.1649645357878;
        Sun, 10 Apr 2022 19:49:17 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id i7-20020a628707000000b004fa6eb33b02sm32511957pfe.49.2022.04.10.19.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 19:49:17 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:19:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: opp: Fix NULL pointer exception on a v2 table
 combined with v1 opps
Message-ID: <20220411024915.7zmoyphgongzorci@vireshk-i7>
References: <20220404123757.798917-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404123757.798917-1-krzysztof.kozlowski@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-04-22, 14:37, Krzysztof Kozlowski wrote:
> dev_pm_opp_add() adds a v1 OPP.

That's not correct, it adds a simpler version of OPP and doesn't
support complex types. A opp v2 table with just freq and voltage
should be supported by dev_pm_opp_add() and we shouldn't disallow it.

I think all we need here is a couple of checks to make sure the
earlier OPPs don't have anything which the new OPP can't support. For
example checking required-opps field, etc.

-- 
viresh
