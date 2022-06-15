Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B44554D085
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357810AbiFOR6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358237AbiFOR6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:58:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6975B27FF0;
        Wed, 15 Jun 2022 10:58:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so1536714wms.3;
        Wed, 15 Jun 2022 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=KwgxQKTurbR04VbDoFBBQGoh1GTDU5LHbSaT2BVEv68=;
        b=Rqf0t0EyXvXh4IJSUpMG4/jmg4iXbEdRfNi7nwoUtDNc1vtsGu0RGMDs+aNrZ3HP4J
         E9GlwvYDAPClGBszutHknKF6FQNwnNahNH+wiMzaod4CyuGiFrQ9GcsHrZiu1vsHQt6r
         B+moWFhub+SDoNXkjMWfOkdop5Ein3LDPqCRNw3USqIDyUIVv4bBwmacxIe8K3ZpHrBE
         t9Y8Fr2QBv4XFCtzlZRmLzW9j45VZcKNYfRqyvv9Vu63mviCBnjnnD1pYxzdpHU6uKwK
         1OtIVl/bdUD2jnN5T6IxKMN3BdmeCRa3zms9+vclRElxpELf4t+i40IPdANzDeJ2vt/v
         rx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=KwgxQKTurbR04VbDoFBBQGoh1GTDU5LHbSaT2BVEv68=;
        b=CAzgZAdb/HwJYmDRpzboQ08ipT3njZKo1/qQgRWf5H6doFPfKp+rrI4DViTvvrENka
         DJvxGAPB/ckAc67ndEM6kgId0qoX1ixuVKX/6AMBWuS4+ZO/UBYsxNJOAOYLrPFt5Dt6
         DsNz3ccRo2NBKYoAZctDnOrV6CzWmv77NTMDPVmVGeHzZYPSKpVMt1fYYlyVG61g9URK
         sarCrTD+/Twts2/FvBWm+WfUpNQfEZ6cdeo4wgR6ZvCB7JCvnb13ACNls27rCLMkEbOf
         coTDL8rXGFDRfk/fj+e/Xn0VJgHnfXr8N7vHQVAlZ2a6btQw7jelC1MLG1qd5gpnxJw4
         1DIg==
X-Gm-Message-State: AJIora9RlAsWUeO3mpgjz+b647jp6xQlYAeiNxEXIsD2u2UKe6lWnamZ
        O0n2kSOj0VuczgODCd8QSSg=
X-Google-Smtp-Source: AGRyM1ujty6P3eMQimMT3bT5EXYQaUW1b/posxJSj02nvDnjHVXsTv7WfhU4bzdsuItDxJI3fXJCJQ==
X-Received: by 2002:a05:600c:3c8f:b0:39b:808c:b5cb with SMTP id bg15-20020a05600c3c8f00b0039b808cb5cbmr663767wmb.11.1655315920810;
        Wed, 15 Jun 2022 10:58:40 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b0039c5224bfcbsm3398451wms.46.2022.06.15.10.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:58:40 -0700 (PDT)
Message-ID: <62aa1dd0.1c69fb81.b9887.676e@mx.google.com>
X-Google-Original-Message-ID: <YqoRKPJFdOsH8D+Z@Ansuel-xps.>
Date:   Wed, 15 Jun 2022 19:04:40 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: add pcm reset for ipq806x lcc
References: <20220615163408.30154-1-ansuelsmth@gmail.com>
 <a92fe431-a995-4c7f-b90b-8e80298bc71a@linaro.org>
 <62aa1b41.1c69fb81.95632.5b71@mx.google.com>
 <717ad899-31ad-5e70-b299-ffb8ca287071@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <717ad899-31ad-5e70-b299-ffb8ca287071@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:50:17AM -0700, Krzysztof Kozlowski wrote:
> On 15/06/2022 09:53, Ansuel Smith wrote:
> > On Wed, Jun 15, 2022 at 10:43:10AM -0700, Krzysztof Kozlowski wrote:
> >> On 15/06/2022 09:34, Christian 'Ansuel' Marangi wrote:
> >>> Add pcm reset define for ipq806x lcc.
> >>>
> >>> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> >> To prevent any confusion about identities (we have strict rules about
> >> these), I need to ask - who uses this email address?
> >>
> >> https://lore.kernel.org/all/?q=ansuelsmth%40gmail.com
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > Same person. Started using extended name, wanted to do this change from
> > a long time but all the patch were already pushed so I couldn't change
> > it since they were already proposed and on the various mailing list.
> 
> Previously "Ansuel Smith" was used entirely, without any parts of this
> name. Here 'Ansuel' appears in quotes, which usually is used for nicknames.
> 
> Is "Ansuel Smith" your real name or a nickname? What do you mean by
> "extended name"?
>

Ansuel is second name. Smith is not real... (sorry)
So with extendend name I mean full name + second name that is
Christian Ansuel Marangi.

Honestly it's a very stupid mistake by me not using the full name from
the start.

> 
> Best regards,
> Krzysztof

-- 
	Ansuel
