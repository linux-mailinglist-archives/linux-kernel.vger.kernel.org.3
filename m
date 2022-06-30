Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C70C561544
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbiF3Iik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiF3Iii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:38:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B103419A1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:38:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mf9so37642757ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RuzPecmK8lwJMTVULYofbK2iZPvsauIveMAadeADOMo=;
        b=tdsGB+2NFmsAPBB/EUtedO7vX9EzT1WMIVZfKvtgukXqhZsMXG5jbbtUpjF8gf9fc1
         rxu9gk0bvX8z+W8Km2DpbFNG+0QdkuFrZPwUdPmNZV+Q9BKlzHl4tj/xSg6zIi50w+xg
         YXDn0G76eumzK26kDBmguIwrj6qEf5N1OQYNnQQ/AhC7eF/8/G5hpwga4a+26kpTp1Do
         Et03yT7t8QjLvpnNDexMFNAiwpFeCGYVUHTcI0v66MLL7NQL7gg3CFsCwrUSVuNS4wc6
         MKWAs37cOdvtj6Tl4cnFjzGT9JlgHkIGlCsPSkheEuUnYssDpOee30VFxY74+mVVCRBI
         7AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RuzPecmK8lwJMTVULYofbK2iZPvsauIveMAadeADOMo=;
        b=gqb86jBXGGCsv91hG5hALlKYYTw9uBO8L6rvFaet1Nu2ILQnGDZba2jEef+8NRoQMp
         eqG2mJalFbT9U1XBZvcV/G0m865KMsr/euqO6yS/ekPKznkM27si+rOlFyGsepbxqIEt
         OagLJ6ohI1A6lqumf8rw7JhohT5h35T9CKhXa7QCgm7/B0aObf8h9UF349h4GjzOc1Kb
         5UVAljfvfP8WdjbS4hrZW53Y2i3RqRsMQb+WSHon+UWgmME5IeuFiMsZewRvFvFyVxns
         oFLzz0jL3qEfaPpCTK2KZPRLCLFHlBsjyCRgl2MjhuFRrF0Exu0rHJyttEYxeXGijzH9
         hSFA==
X-Gm-Message-State: AJIora8lb2NaNTyPEdmRvTa56BYb8tpb6176wjb9EEJ9uHw0509tMXpa
        sow+NvAv/HpoNP1Zpy5er67f7w==
X-Google-Smtp-Source: AGRyM1vOmh1Edq9HczZ5mN0Mwdrir6CkMIAV/8A030PfRiF/wOyhMosw+9txF/+//XvuX5XfYMRMxw==
X-Received: by 2002:a17:907:6d14:b0:726:34db:89fc with SMTP id sa20-20020a1709076d1400b0072634db89fcmr7666449ejc.406.1656578316020;
        Thu, 30 Jun 2022 01:38:36 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jw14-20020a170906e94e00b007263481a43fsm8471129ejb.81.2022.06.30.01.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 01:38:35 -0700 (PDT)
Message-ID: <494f610a-b252-44ba-c883-155731561769@linaro.org>
Date:   Thu, 30 Jun 2022 10:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8b29fa207024dc295639f9ba52c28e45782e3baa.1654849214.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 10:20, Viresh Kumar wrote:
> This patch adds support to allow multiple clocks for a device.
> 
> The design is pretty much similar to how this is done for regulators,
> and platforms can supply their own version of the config_clks() callback
> if they have multiple clocks for their device. The core manages the
> calls via opp_table->config_clks() eventually.
> 
> We have kept both "clk" and "clks" fields in the OPP table structure and
> the reason is provided as a comment in _opp_set_clknames(). The same
> isn't done for "rates" though and we use rates[0] at most of the places
> now.
> 
> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c     | 165 ++++++++++++++++++++++++++++-------------
>  drivers/opp/debugfs.c  |  27 ++++++-
>  drivers/opp/of.c       |  67 +++++++++++++----

I don't see bindings change here, but I think you included my pieces of
code related to parsing multiple opp-hz. Is that correct? If so, you
need to pick up the bindings patch as well.

Best regards,
Krzysztof
