Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6797D5A303C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbiHZT4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiHZTz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:55:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E99DF0BA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:55:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p185so2477565pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=gnz1q4pz/xVc6tlRyQeVFOV7IZAqBjfIyZ5BI3hft0U=;
        b=RrQhxaFx2nxyuhtWZesmSEiSBTXd5+FlSRNNc9KxxyKhJ0Bl69zgANMO0CqfLLj8Wp
         iXKbEy5JuscdAXPSe3gGBQ63tvwMHyDm2gbVkrPza31gsAZYPBPZg9W3zxSSrVKd9Yk/
         J+/Be93CyeaZPN1+vLYQK9NeE/6QAt0OcrlZs7WSL77ro535BbBF+8p7tRe3Z48slTfH
         iIe5XE/mQbWLDiWLPvaKtgmQE5QuLz8YkrScaxgHb8tKeFkCD20srFuQ2qBpk5W36v9K
         kRNALHXmbTvIxGBvpYWid7mpuiPBOXq/uf/Bi6sQ0xgEahLieNidSK48p393xVejDd95
         6kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gnz1q4pz/xVc6tlRyQeVFOV7IZAqBjfIyZ5BI3hft0U=;
        b=Q3WciREaf+If8DB8bQVdw9r/7FxAgP46SASlkMNbMCClAilu17MH+wFp7EIXWwDaOn
         gnrTPdQnHnk3Kw0jHhymIwDszieb+FsPFv1eNjloyXjgwQfeihk7/1w3FnAbi+ZRwrLV
         CUt7xjpWAXfOoOAKLnD4cuvrzGHwmRP2gedVvVrDNO6Lx82XttKtMQgERb69e50aX3hb
         zJXZQYx5B/1MJaeVlSUmoLkFppPnhMqfjnVFSygiAoyID6OCJeO09UP+INIPAj8repyK
         Op2ntRgFSkHldj9NYkdiB27rNHjuj/bgQgIVqFPdM9r+oFWoa4VOxusdWsKuFO8X2L1j
         KxnA==
X-Gm-Message-State: ACgBeo0mm06+OxmTjvZ1Sw3HcK0Tf5WFuf9fDC05fgVetcLbsGuUyP9o
        lPQojaQzfjZLKmle3ghX4cGATg==
X-Google-Smtp-Source: AA6agR7267EZysjs+BLPWLMdfKPDxv10ovdb1SjTwiW0Aq1A7/N3A/OV6mJ8qbkfeKKwzUr1R4DBNQ==
X-Received: by 2002:a05:6a00:1588:b0:52f:a5bb:b992 with SMTP id u8-20020a056a00158800b0052fa5bbb992mr5337159pfk.38.1661543755955;
        Fri, 26 Aug 2022 12:55:55 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t6-20020aa79466000000b0053692028ec1sm2148303pfq.34.2022.08.26.12.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 12:55:54 -0700 (PDT)
Date:   Fri, 26 Aug 2022 13:55:52 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, german.gomez@arm.com,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/2] coresight: etm4x: Expose default timestamp source
 in sysfs
Message-ID: <20220826195552.GA1991601@p14s>
References: <20220823160650.455823-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823160650.455823-1-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 05:06:48PM +0100, James Clark wrote:
> I've taken over this one from German because he's moved to a different
> team. I gave it a quick check and bumped the version number in the docs
> for the next release, but the month is an estimate.
> 
> Thanks
> 
> Changes since v2:
> 
>   * Rebased onto coresight/next (b99ee26a1a)
>   * Bumped release version to 6.1

I have applied this set.  Usually I'd let Suzuki handle it since he is already
familiar with the work but 1) he is currently away and 2) the patchset is fairly
simple.

Thanks,
Mathieu

> 
> Changes since v1:
> 
>   * Inline etmv4_to_ts_source() function.
>   * Collect review tag from Leo.
> 
> German Gomez (2):
>   coresight: etm4x: Expose default timestamp source in sysfs
>   coresight: etm4x: docs: Add documentation for 'ts_source' sysfs
>     interface
> 
>  .../testing/sysfs-bus-coresight-devices-etm4x |  8 +++++
>  .../coresight/coresight-etm4x-reference.rst   | 14 +++++++++
>  arch/arm64/include/asm/sysreg.h               |  1 +
>  .../coresight/coresight-etm4x-sysfs.c         | 29 +++++++++++++++++++
>  4 files changed, 52 insertions(+)
> 
> -- 
> 2.28.0
> 
