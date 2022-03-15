Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C654D9311
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344695AbiCODai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344276AbiCODah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:30:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD79E1116B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:29:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gb39so38006931ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=biBla+wtK1cKk6UP+jkGB/rc6JdnscfBX/3SvfFa4OE=;
        b=xYNyIQE69JjNuMRQhqO8sZsNGIX49vmbJyfq8gbnPr1V+BhNist8R5afWeFNO92GId
         SEsngDpgREQdYaeG8PkggoDX8WTEtPkqBWnDIDYcyPyv9kHOM9CBMAcwIEj83D3Vz6ar
         3ug6HA0Gyx/RVPCN8NYgq3g1024bD5ShM+wprAccIVHjhivgbQVcHYcAkUMkOaQK1L46
         ZFBcsbUnVM16mrcma/Qxmxe+fscqGYaFDwqnbw5vDx5k9p1MeBvfrGzPaRKIulbbtpcK
         oBry8+EJd95rsFqdSKnHhYl8wQCkTwDhptquanVd7HspZ2YifDglFdmCJ9Ybn70/TF8/
         P5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=biBla+wtK1cKk6UP+jkGB/rc6JdnscfBX/3SvfFa4OE=;
        b=3Rlyd2JxSi222VG2kRI4e//9Wp1XtMtveVZDfo4rs16zTgEGqgPxtHMlllNNfS0c+p
         /Pccm0b+QYFLRhZLq2uCc9/J3JvNf7+2yR3aSFCEW7JwbyCYrtFZW/OADaG7uMGHU61C
         LL/wjLTHe8ER8Nth1afFgvAIVoZgS3kfmSIR1cpKztUrQhp3QrjzAtK7p+YDuqRXtntL
         CrLbg/U4G4AhUwjugZAVMqFmS1pEmHFmv3P0J4GHHi8C5gYXIZMm/GGWQ7cTLUEYLLz6
         Cd1QctRaTC0+QIUInYXyhXFdz0pLVeVuPUuKCmP2O5J77kx6ll+LDaCIffz9U6L6nvbv
         XjzA==
X-Gm-Message-State: AOAM532a5KUB0EAIMM7mMb1Ar7V4/9qXz3VPa0ZucZl8cDBa9v+g9/Rj
        MwwOvi//pko6w2iR1/G5UI02Zg==
X-Google-Smtp-Source: ABdhPJwuBQQrkKimz4ABJOBIAsASXj+1R2axNJ82lzoTalaZJn97wJZ+1hV7IfZ+EQ4LtWVIhU628g==
X-Received: by 2002:a17:907:3da6:b0:6db:aebf:5fd5 with SMTP id he38-20020a1709073da600b006dbaebf5fd5mr13971604ejc.503.1647314964081;
        Mon, 14 Mar 2022 20:29:24 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id r14-20020a1709067fce00b006db0edb8a80sm7576857ejs.225.2022.03.14.20.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 20:29:23 -0700 (PDT)
Date:   Tue, 15 Mar 2022 11:29:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] arch_topology: Correct CPU capacity scaling
Message-ID: <20220315032919.GA217475@leoy-ThinkPad-X240s>
References: <20220313055512.248571-1-leo.yan@linaro.org>
 <Yi+FMrG9NyBnMX0i@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi+FMrG9NyBnMX0i@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ionela,

On Mon, Mar 14, 2022 at 06:10:58PM +0000, Ionela Voinescu wrote:

[...]

> > Patch 03 is to handle the case for absenting "capacity-dmips-mhz"
> > property in CPU nodes, the patch proceeds to do CPU capacity scaling based
> > on CPU maximum capacity.  Thus it can reflect the correct CPU capacity for
> > Arm platforms with "fast" and "slow" clusters (CPUs in two clusters have
> > the same raw capacity but with different maximum frequencies).
> > 
> 
> In my opinion it's difficult to handle absent "capacity-dmips-mhz"
> properties, as they can be a result of 3 scenarios: potential..
>  1. bug in DT
>  2. unwillingness to fill this information in DT
>  3. suggestion that we're dealing with CPUs with same u-arch
>     (same capacity-dmips-mhz)

For absent "capacity-dmips-mhz" properties, I think we could divide into
two sub classes:

For all CPU nodes are absent "capacity-dmips-mhz" properties, it's
likely all CPUs have the same micro architecture, thus developers are
not necessarily to explictly set the property.

For partial CPUs absent "capacity-dmips-mhz" properties, this is an
usage issue in DT and kernel should handle this as an error and report
it.

> I'm not sure it's up to us to interpret suggestions in the code so I
> believe treating missing information as error is the right choice, which
> is how we're handling this now.

Yes, current kernel means to treat missing info as error, whatever if
all CPUs or partial CPUs are absent "capacity-dmips-mhz" properties.

> For 3. (and patch 03), isn't it easier to populate capacity-dmips-mhz to
> the same value (say 1024) in DT? That is a clear message that we're
> dealing with CPUs with the same u-arch.

"capacity-dmips-mhz" is defined as a _optional_ property in the DT
document (see devicetree/bindings/arm/cpu-capacity.txt).

Current kernel rolls back every CPU raw capacity to 1024 if DT doesn't
bind "capacity-dmips-mhz" properties, given many SoCs with same CPU
u-arch this is right thing to do; here I think kernel should proceed to
scale CPU capacity with its maximum frequency.

When I worked on a platform with a fast and a slow clusters (two clusters
have different max frequencies and with the same CPU u-arch), it's a bit
puzzle when I saw all CPU's capacities are always 1024.  In this case,
since a platform have no CPU capacity modeling, and "capacity-dmips-mhz"
property is not needed to populate in DT, but at the end the kernel
should can reflect the scaled CPU capacity correctly.

Thanks a lot for review,

Leo
