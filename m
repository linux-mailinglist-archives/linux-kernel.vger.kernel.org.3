Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B51352A440
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245740AbiEQOFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348446AbiEQOFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:05:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931704D603;
        Tue, 17 May 2022 07:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29B64B818EC;
        Tue, 17 May 2022 14:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E541C385B8;
        Tue, 17 May 2022 14:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652796304;
        bh=GudX6koMKPd3WgZ5qgsXK2Xg18G4EDiE+FysY70LTi0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dbQhGv2YdItufG4Za9YLbDOenBhNHSNRPsxL3LsDfZeJJraMhxtnsj5w+GCOQIchy
         mbT7RFit/M5XFAP/O717QdsOTVn/cSq/B1unj5OWStMFyLOs2XlRe5xfDmwY7In4rU
         rshHWtzcO/FhTFL9SnN+KQd+vdI30GuseXGyCLm0Ba3fMMPueK+Y/GBSgMfdHZ1XDX
         iavatjJmx1hflB4L9zNU0l1Zuj5BXTYIehWE1en/c4hOYUeu64G7Eu42elhISPgG47
         xQ+BnO7alXzdg/qdWYFy6XIcqFyFyKG8wE6jqqjTZZTgYqI8kIp47xRHYh2xz12XJ3
         MZsbKImO5x5TA==
Message-ID: <00f05f62-7bf5-0a57-d07a-2e068253b9e6@kernel.org>
Date:   Tue, 17 May 2022 16:04:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 16/20] media: s5p-mfc: Fix to handle reference queue
 during finishing
Content-Language: en-US
To:     Smitha T Murthy <smitha.t@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com
References: <20220517125548.14746-1-smitha.t@samsung.com>
 <CGME20220517125644epcas5p3fcabdc953c042cc9f2697f7fbfc74121@epcas5p3.samsung.com>
 <20220517125548.14746-17-smitha.t@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220517125548.14746-17-smitha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 14:55, Smitha T Murthy wrote:
> On receiving last buffer driver puts MFC to
> MFCINST_FINISHING state which in turn skips
> transferring of frame from SRC to REF queue.
> This causes driver to stop MFC encoding and
> last frame is lost.

What type of wrapping is it exactly?

https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> 
> This patch guarantees safe handling of frames
> during MFCINST_FINISHING and correct clearing
> of workbit to avoid early stopping of encoding.
> 

This looks like a bugfix so:
1. Send it separately please.
2. Add Fixes tag.
3. Add Cc stable tag.

Best regards,
Krzysztof
