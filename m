Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623975320AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiEXCHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiEXCHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:07:17 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303C97C173;
        Mon, 23 May 2022 19:07:13 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id c15-20020a9d684f000000b0060b097c71ecso4394022oto.10;
        Mon, 23 May 2022 19:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avW4K7LcQhKBy63mDTEwp3yorTkoVIJO+916OJZVwwM=;
        b=zUg3eeKpzpF6XOFjlK/0HGG3I1NWZuwrgD8j4y4YE20X/W8iiZaT9vGlSXtJP2tooi
         Qr+61ai7ahk724vc94Ts67nkrRcBiJ7gcWkOZZFQbNj2WzvWETsN5CfDScgLUMBmnuci
         EaI5Biif68rigxP2ZXZKA1zHUjVS9WrYNN6V3UZxqXnswt1lPfM0LIO/g7c81KuvDuAD
         5BsB7ez7TYnc3gkjbOzs+M+7Yf8S94FTrEhd0kjOg3MX2v948WW4iD9mIF6rP3jisnCQ
         ft5Xargs4C3P8n7kjUjeQrFfiLOzYG8c8qpRogh8WyOSLLmiIxi6v/ga6mc2TUZhvdUV
         QtSQ==
X-Gm-Message-State: AOAM533QBeAjZdhfCq0nDJAOqCoLXvfI5d/o26ZGcpmbU/mXHaq1BEHG
        2SRKLERuABjfFWDFhTPoMFJgtwdbFQ==
X-Google-Smtp-Source: ABdhPJznrLWgCsmGMJ6jUb47IejHe4ZA03bJM03kOnz6E2td6t6bAdxfAMXXb7V7rn4u4RRUaO1h/A==
X-Received: by 2002:a9d:4c09:0:b0:60b:1bec:89ba with SMTP id l9-20020a9d4c09000000b0060b1bec89bamr2033343otf.281.1653358032320;
        Mon, 23 May 2022 19:07:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v132-20020aca618a000000b00325cda1ffabsm4565426oib.42.2022.05.23.19.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:07:11 -0700 (PDT)
Received: (nullmailer pid 2607989 invoked by uid 1000);
        Tue, 24 May 2022 02:07:10 -0000
Date:   Mon, 23 May 2022 21:07:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-soc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: Add support for external
 MCLKs for LPASS on SC7280
Message-ID: <20220524020710.GA2607925-robh@kernel.org>
References: <20220523092314.14252-1-quic_tdas@quicinc.com>
 <20220523092314.14252-3-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523092314.14252-3-quic_tdas@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 14:53:13 +0530, Taniya Das wrote:
> Support external mclk to interface external MI2S clocks for SC7280.
> 
> Fixes: 57405b795504 ("dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7280").
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  include/dt-bindings/clock/qcom,lpasscorecc-sc7280.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
