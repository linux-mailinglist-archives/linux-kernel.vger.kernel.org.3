Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C855526983
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383391AbiEMSnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383381AbiEMSnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:43:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFF23D4A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:42:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so11551800pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UHlmL/x6Zsq5f1dZm7J6ycZpIu5k6LF2pXgokYieGSQ=;
        b=kbDCl2XnKLioVndwsqRBsoxhm3KjCiTPva7sKDw9m0Kkk0FeRAlkDRPVafDXldoHvj
         w2Pf8XuuGw2jmMtQXDqBj8TEXMn8sGQJrJqWY2RBsHmWHgbIfFc3pTYX/BVmljWOV4Uo
         Rh+N4EllzXwL+TNxpKX93hohZDbpTd+f3pd8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UHlmL/x6Zsq5f1dZm7J6ycZpIu5k6LF2pXgokYieGSQ=;
        b=RnePWX+99+KK8uYJEBlOAb1uAaDyQuiw00JjfNB2LI4SU8Fe4tQsrVZpvHkyFP/BRh
         k/dZs1qd4eQe9IEMnhjXZb1hWubAXLLAkVNGmRuY0zWBQVUW8srh2Jx0reQTvVuaz5PE
         TrU3oScySW70qgNJ21C+Pge2bQYK1NaS/D9obMM9IqQsWEtVGxZ92j2j6+RwyDgZZTU+
         Jcnz4NdSFI+DtejSHkHetNjv94T+tK2CPNkp1+QwL5vLPcBXTxQ3mNLAW8T5FTPaL1li
         WgHw7TuixacQfgXghtDoZ2mO0IsmgmHI05sCXQKve3LA7EXuUFChMAur/pHu1ojfvkw3
         Gheg==
X-Gm-Message-State: AOAM532EjnA9Y/AvCXzj1zSU2Lk6GpUNJZyhGjoysF5dRl2Rx3PdEYyX
        GDATf40nP+M7i50uLAJApQr1RQ==
X-Google-Smtp-Source: ABdhPJwL+CcN57bB8luXFN20vwltRyDbpRVPGnBzPYZ8TaSdigLUWrrKqui1opgZlOdMOawRuecSsg==
X-Received: by 2002:a17:90a:7c4a:b0:1dc:f28f:4e06 with SMTP id e10-20020a17090a7c4a00b001dcf28f4e06mr6273884pjl.48.1652467377995;
        Fri, 13 May 2022 11:42:57 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:bc87:9632:bcce:8e17])
        by smtp.gmail.com with UTF8SMTPSA id p25-20020a62b819000000b0050dc7628182sm2160650pfe.92.2022.05.13.11.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 11:42:57 -0700 (PDT)
Date:   Fri, 13 May 2022 11:42:56 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: Document how Chromebooks with
 depthcharge boot
Message-ID: <Yn6msARxCafgGj9E@google.com>
References: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 09:59:17AM -0700, Douglas Anderson wrote:
> This documents how many Chromebooks pick the device tree that will be
> passed to the OS and can help understand the revisions / skus listed
> as the top-level "compatible" in many Chromebooks.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks!

a few nits below

> ---
> 
> Changes in v2:
> - ("Document how Chromebooks with depthcharge boot") new for v2.
> 
>  .../devicetree/chromebook-boot-flow.rst       | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/chromebook-boot-flow.rst
> 
> diff --git a/Documentation/devicetree/chromebook-boot-flow.rst b/Documentation/devicetree/chromebook-boot-flow.rst
> new file mode 100644
> index 000000000000..84aeb0a17ee4
> --- /dev/null
> +++ b/Documentation/devicetree/chromebook-boot-flow.rst
> @@ -0,0 +1,63 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +Chromebook Boot Flow
> +======================================
> +
> +Most recent Chromebooks that use device tree boot using the opensource

s/using/are using/

> +depthcharge bootloader. Depthcharge expects the OS to be packaged as a "FIT
> +Image" which contains an OS image as well as a collection of device trees. It
> +is up to depthcharge to pick the right device tree from the FIT Image and
> +provide it to the OS.
> +
> +The scheme that depthcharge uses to pick the device tree takes into account
> +three variables:
> +- Board name, specified at compile time.
> +- Board revision number, read from GPIO strappings at boot time.
> +- SKU number, read from GPIO strappings at boot time.
> +
> +For recent Chromebooks, depthcharge creates a match list that looks like this:
> +- google,$(BOARD)-rev$(REV)-sku$(SKU)
> +- google,$(BOARD)-rev$(REV)
> +- google,$(BOARD)-sku$(SKU)
> +- google,$(BOARD)
> +
> +Note that some older Chromebooks may use a slightly different list that may

nit: first 'may' isn't really needed, since this is about 'some' Chromebooks
whose list 'may' differ in certain ways.

> +not include sku matching or may prioritize sku/rev differently.
> +
> +Note that for some boards there may be extra board-specific logic to inject
> +extra compatibles into the list, but this is uncommon.
> +
> +Depthcharge will look through all device trees in the FIT image trying to
> +find one that matches the most specific compatible. It will then look
> +through all device trees in the FIT image trying to find the one that
> +matches the _second most_ specific compatible, etc.
> +
> +When searching for a device tree, depthcharge doesn't care where the
> +compatible falls within a given device tree. As an example, if we're on
> +board "lazor", rev 4, sku 0 and we have two device trees:
> +- "google,lazor-rev5-sku0", "google,lazor-rev4-sku0", "qcom,sc7180"
> +- "google,lazor", "qcom,sc7180"
> +
> +Then depthcharge will pick the first device tree even though
> +"google,lazor-rev4-sku0" was the second compatible listed in that device tree.
> +This is because it is a more specific compatible than "google,lazor".
> +
> +It should be noted that depthcharge does not have any smarts to try to
> +match board or SKU revisions that are "close by". That is to say that
> +if depthcharge knows it's on "rev4" of a board but there is no "rev4"
> +device tree that depthcharge _won't_ look for a "rev3" device tree.

s/that/then/

> +
> +In general when any significant changes are made to a board the board
> +revision number is increased even if none of those changes need to
> +be reflected in the device tree. Thus it's fairly common to see device
> +trees with multiple revisions.
> +
> +It should be noted that, taking into account the above system that the
> +depthcharge has, the most flexibility is achieved if the device tree

s/the depthcharge/depthcharge/

> +supporting the newest revision(s) of a board omits the "-rev{REV}"
> +compatible strings. When this is done then if you get a new board
> +revision and try to run old software on it then we'll at pick the most
> +reasonable device tree. If it turns out that the new revision actually
> +has no device-tree visible changes then we'll not only pick the most
> +reasonable device tree, we'll pick the exact right one.
> \ No newline at end of file
> -- 
> 2.36.0.550.gb090851708-goog
> 
