Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5038C569861
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 04:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiGGCwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 22:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbiGGCwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 22:52:41 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39A2F655
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 19:52:40 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s206so16019340pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 19:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ZuTruL3ue/6CgKdOpuehMwfWYtI2Dhi261HrtmxCik=;
        b=fVyCTz+rf7rh86j+mBAA4fYpkJaFBKnKI8izHlMMKFbvmHfzupnz4dN+eikGdyw6Uc
         AlZaW5P5kibC/UMBqkP3sZl9mTFPi2SuRCeAdOBqBvzQNTXS5+73RULXZyA69zKQLzKG
         l4yW5sUwrq56K1E6eq8ZslnJPIy2RumqqP7BnHJflsb5cqxz6eHxclhalZNLwAFRGGdY
         RLsInrVVISIDsOAmxMVCt/c7nBYpUbvMXpdHgkobCeeJDZPpZE9y9UauSD09y6MVo/pI
         Jewe+nyyCv6tLRqcRiukqByB1gn4bc5JMjYKqtukGnsasYaUijGtp2O+6HLqWuoVRAey
         c6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ZuTruL3ue/6CgKdOpuehMwfWYtI2Dhi261HrtmxCik=;
        b=h/GZ8jcIvhzVPv8JVGG6+fzeIDoFe3SvXo4F2pvxDNSuCYXKMnHTkxhESshBAKI5Ok
         we1OhlNH9ZiP617AoZXmltXQqrRp/Hwm7MEZrFHRUx5m/zBG6GAVY8hlUofOsdfHv9vu
         oxYmuDLVL8CBl7+PuNSsb1s9P8sVI9jj/COTCawZULUcfXZTTluv0CEOzpzv6OXZjn9V
         QHFwG5AuQ4mJ0Q44FKCemMRsgLO4MDKN1o/FWQV/dbgaVbIfZK/defRwPS98ZglNfgYB
         NZ+PLwyaHquKDAVa/YbNlX/IThZvWilel7n24yG53FtihttOP+e9xjEQ9CipDDcNs4Uw
         pvhQ==
X-Gm-Message-State: AJIora/eu9lo4B+gLpCGijFPsrgLuw/30O56nWI74uqn2b/EhgMgu0GG
        Ma/to7mUay55ICCSYPhtPvLnQg==
X-Google-Smtp-Source: AGRyM1sgJGTL5kjJFOSrf04CDLOknLzKPX9q8gUNLplOZITGK4ZgdYJ7pd6O8dIdx05HmCzPqtKB/A==
X-Received: by 2002:a17:902:e543:b0:16a:7d9e:6517 with SMTP id n3-20020a170902e54300b0016a7d9e6517mr50130482plf.151.1657162359715;
        Wed, 06 Jul 2022 19:52:39 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id p66-20020a625b45000000b0051b9ecb53e6sm25522341pfb.105.2022.07.06.19.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 19:52:39 -0700 (PDT)
Date:   Thu, 7 Jul 2022 10:52:33 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] interconnect: qcom: icc-rpm: Support bucket
Message-ID: <20220707025233.GA631004@leoy-ThinkPad-X240s>
References: <20220705072336.742703-1-leo.yan@linaro.org>
 <a60b5954-c9ac-0f2b-aef4-ad34b8f3abe7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a60b5954-c9ac-0f2b-aef4-ad34b8f3abe7@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi,

On Tue, Jul 05, 2022 at 05:03:21PM +0300, Georgi Djakov wrote:

[...]

> Hi Leo,
> 
> Some patches do not apply clean on next. On which tree is this based? Do you
> have any additional patches?

When rebased I included an out of tree patch, let me check a bit and
resend the new patch set.  Sorry for inconvenience.

Thanks,
Leo
