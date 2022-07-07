Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C69D569EEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiGGJ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiGGJ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:56:42 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190A74D4EB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:56:41 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 73so2128787pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 02:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U351d5E2MpRFjyUSNEgNyALDATw3NXHvofLVg4W2Lw4=;
        b=bZaKsQzuVZH+z6KPK70RdHoPL2FHeGS90NKF0V3v1TTfliL/DH0HYIPLMmlaSJfDkf
         JVLrZt9l/aE/zXTgXEtp9D1TRCtXzA4QIplDRoYfDS/h34wCZTzi6vz83eaiLSwdjO2F
         5Z0IKHEQzKHAbEzexcO+JHjtFAbdHHnEPsTzNKTBIGAopsb0XdjRUKE41RM8vc4h5M4h
         GKRiF4GP8V+88Anxr96aK4OKhdGVx68sXsaINf9rai/HoruyVCYxvbGVngE+XGBD+wBo
         TcFHdLVX2RGphlB6lhFmdZoCVkrrh9v4kVICOc29eOPlIcIuMBZ+zoh14eyRR0l8eff3
         FGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U351d5E2MpRFjyUSNEgNyALDATw3NXHvofLVg4W2Lw4=;
        b=H34g0a5nRHYBmY5/pzmt89nLJgJhJxCoRJx//9udJ/05WhzO/cPohsr7hsH6zRdCcq
         lzMU8roj1CMUlktoIljgPl4o97YCe+MzbbVfVQck8jCop5ELefvxPNOpKj0nZmyw7IC1
         mSU6M0WMxY4v+KtTyt8FY0FFh7R/J4wcBCAVtzMjr/n7mr2aINDBDcsAIObKDcEuft+8
         fANAvO91I8FlrUs8/ePcTMEKWTzC9aGTcRLrVPMJaoo8nbGQFFNRXHAxg4xskBua0GR4
         STGisVoW+kWoeSIzvJkZtypTpYS/YzdZDP11am94N7PMbJjWeaOcHF8fsulbgmEqhhnH
         7Ryg==
X-Gm-Message-State: AJIora/u5kvv3b7Gp2T1RwYIhIcI3fTxfEjPxshwIeO8esnoe0tyf3Mp
        G0ebWhexBmptk7UBUInt4eWexPQpC82BzMo4WFA=
X-Google-Smtp-Source: AGRyM1uIHrFoly14ncX+ozpfagiuGY6yYktV/BvSfwNLriG/ZIlVhBSGE9Lm2UKjF+YrvUZ96PU1TQ==
X-Received: by 2002:a17:90b:1b10:b0:1ed:44:d00d with SMTP id nu16-20020a17090b1b1000b001ed0044d00dmr4226986pjb.234.1657187800379;
        Thu, 07 Jul 2022 02:56:40 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077154.netvigator.com. [58.152.77.154])
        by smtp.gmail.com with ESMTPSA id y62-20020a626441000000b0050dc76281d3sm138214pfb.173.2022.07.07.02.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 02:56:39 -0700 (PDT)
Date:   Thu, 7 Jul 2022 17:56:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] interconnect: qcom: icc-rpm: Support bucket
Message-ID: <20220707095635.GD631004@leoy-ThinkPad-X240s>
References: <20220705072336.742703-1-leo.yan@linaro.org>
 <a60b5954-c9ac-0f2b-aef4-ad34b8f3abe7@kernel.org>
 <20220707025233.GA631004@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707025233.GA631004@leoy-ThinkPad-X240s>
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

On Thu, Jul 07, 2022 at 10:52:33AM +0800, Leo Yan wrote:

[...]

> > Some patches do not apply clean on next. On which tree is this based? Do you
> > have any additional patches?
> 
> When rebased I included an out of tree patch, let me check a bit and
> resend the new patch set.  Sorry for inconvenience.

Bryan has sent out the patch
"interconnect: icc-rpm: Set destination bandwidth as well as source
bandwidth" [1].  My patch series was based on Bryan's patch, you could
apply them cleanly after applying Bryan's patch.

Please let us know what's your preference for picking patches order, if
you prefer to apply my patch series before Bryan's fixing patch, I will
rebase the patch set on the mainline kernel with dropping Bryan's patch
(which means Bryan needs to rebase his patch).

Thanks,
Leo

[1] https://lore.kernel.org/linux-pm/20220707093823.1691870-1-bryan.odonoghue@linaro.org/T/#r304f7b103c806e1570d555a0f5aaf83ae3990ac0
