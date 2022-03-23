Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856D74E5644
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbiCWQYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238745AbiCWQYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:24:31 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC44BD6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:23:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q5so2005467plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ulHoL7OIwlWwMsNlax5o/BnlVh8FB9CoqsjWS1NIE8=;
        b=AA48uIaVopl/FniL0faxLHf6fd+JuMKR7eZEPdLO7aCJNq8mS8hxHzns3L+vJTOsA9
         CfJGqMZZJE2Wh/x5jEPZPLuSECYYXwJPuO/NyjxRd4kcfHdD7Gtl12QyWlzZJYDY56Sp
         yxIMkZ+Nz/l1vPvb0Eh9G8SRhb5ZI2yUZd6BB/bQFLGQfvaaDWajHuwQ85wxZyU8qE4J
         gY/gqlGTdaS+MZ9+IXSAOWE3bRHNkn1aHBK5+TIa6divXzosxnEV+eM9RA7DS40unhyO
         keqOeFNrcqA1TGCPQ/SY3QFV753BHvWpCw64PErzJTkKI3BE1ZVaHwpg5KQHzClDDkDx
         cV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ulHoL7OIwlWwMsNlax5o/BnlVh8FB9CoqsjWS1NIE8=;
        b=4wySoLHmaV9NWTOkmyleoq7JolasELIQ8ljhVo4/3xjgmAaYgItjeGUrkvbVdnzR7q
         tY0SnoG6YE1j8nvRMcCo3JbMNx9foni3Wx1iEqSZgL+zjbWQ1bNWkHa0eMI6SgGJg4U+
         zCmt4A4HKC/ag87shzKXimqnhyeP+WAWQU1ljPrn1unHooO06VzGsTWzRa4liKLpJV41
         fu7UdbXxRmH8p0TuirChb1foyXp4ubjdOE1NTUGNUVnDgi8QcDQlBgUvXNUJFEvWD9RE
         Feb9O3+migDyR941yURRA5SyIQD1TnGPPGVOuz7gJfPgGPOolsbHQ2vzXWQRlXO/IeGR
         QOvw==
X-Gm-Message-State: AOAM533yS+1GHcf2A4j3Ho+eiDafocS0/VWFXNAEoHIYaUMsGVh+Z0hn
        rvfgNvpVw6sWPx1xM5itswM4BA==
X-Google-Smtp-Source: ABdhPJyGaRJIdMSoUM8gN3DIusunSueAgO7RLIx9L8HWwRopwRU0domlqwWkRSc+rCZ/gWNTnJH3lA==
X-Received: by 2002:a17:90b:4c09:b0:1c6:f64a:dd0 with SMTP id na9-20020a17090b4c0900b001c6f64a0dd0mr480337pjb.45.1648052580940;
        Wed, 23 Mar 2022 09:23:00 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 8-20020a056a00070800b004e14ae3e8d7sm384475pfl.164.2022.03.23.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:22:59 -0700 (PDT)
Date:   Wed, 23 Mar 2022 10:22:57 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] Make ETM register accesses consistent with
 sysreg.h
Message-ID: <20220323162257.GC3248686@p14s>
References: <20220304171913.2292458-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304171913.2292458-1-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 05:18:57PM +0000, James Clark wrote:
> Changes since v2:
>  * Implement Mike's suggestion of not having _SHIFT and using the existing
>    FIELD_GET and FIELD_PREP methods.
>  * Dropped the change to add the new REG_VAL macro because of the above.
>  * FIELD_PREP could be used in some trivial cases, but in some cases the
>    shift is still required but can be calculated with __bf_shf
>  * Improved the commit messages.
>  * The change is still binary equivalent, but requires an extra step 
>    mentioned at the end of this cover letter.
> 
> Applies to coresight/next 3619ee28488
> Also available at https://gitlab.arm.com/linux-arm/linux-jc/-/tree/james-cs-register-refactor-v3
> 
> To check for binary equivalence follow the same steps in the cover letter
> of v2, but apply the following change to coresight-priv.h. This is because
> the existing version of the macros wrap the expression in a new scope {}
> that flips something in the compiler:
> 
>   #undef FIELD_GET
>   #define FIELD_GET(_mask, _reg) (((_reg) & (_mask)) >> __bf_shf(_mask))
>   #undef FIELD_PREP
>   #define FIELD_PREP(_mask, _val) (((_val) << __bf_shf(_mask)) & (_mask))
> 
> Thanks
> James
> 
> James Clark (15):
>   coresight: etm4x: Cleanup TRCIDR0 register accesses
>   coresight: etm4x: Cleanup TRCIDR2 register accesses
>   coresight: etm4x: Cleanup TRCIDR3 register accesses
>   coresight: etm4x: Cleanup TRCIDR4 register accesses
>   coresight: etm4x: Cleanup TRCIDR5 register accesses
>   coresight: etm4x: Cleanup TRCCONFIGR register accesses
>   coresight: etm4x: Cleanup TRCEVENTCTL1R register accesses
>   coresight: etm4x: Cleanup TRCSTALLCTLR register accesses
>   coresight: etm4x: Cleanup TRCVICTLR register accesses
>   coresight: etm3x: Cleanup ETMTECR1 register accesses
>   coresight: etm4x: Cleanup TRCACATRn register accesses
>   coresight: etm4x: Cleanup TRCSSCCRn and TRCSSCSRn register accesses
>   coresight: etm4x: Cleanup TRCSSPCICRn register accesses
>   coresight: etm4x: Cleanup TRCBBCTLR register accesses
>   coresight: etm4x: Cleanup TRCRSCTLRn register accesses
> 
>  .../coresight/coresight-etm3x-core.c          |   2 +-
>  .../coresight/coresight-etm3x-sysfs.c         |   2 +-
>  .../coresight/coresight-etm4x-core.c          | 136 +++++--------
>  .../coresight/coresight-etm4x-sysfs.c         | 180 +++++++++---------
>  drivers/hwtracing/coresight/coresight-etm4x.h | 122 ++++++++++--
>  5 files changed, 244 insertions(+), 198 deletions(-)

I am done reviewing this set.  I will wait until rc1 or rc2 before moving
forward.  If there are other comments needing a respin then I will wait for the
next revision.  Otherwise I will apply this one after correcting the extra lines
at the end of patch 15.
 
Thanks,
Mathieu

> 
> -- 
> 2.28.0
> 
