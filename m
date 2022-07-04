Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2FF56517D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiGDJ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiGDJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:59:00 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCFB64F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:58:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso2793099pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WGrr02ePAubs5HwRrKkcQyXTzR45aRrdbF034mfwuek=;
        b=YRkn44iftoICxFbnHxWFVDMjjHS7DiP93ZU1X9rDNFfLwg53IuwEbXiEXSN0RqNqX1
         laHmRffBdsRWJLD4O2cOCdu3vx7XnrZe9D4n77vo9e+0vQPPNygZajpqJ1z9UY67nXPt
         V+aIpymm2b+y4sYlEASWbikw987qmyonRirggf62RwsxdVY8t284qFdRpYpInj7X1hVX
         oX5GBvdCBiAqY2ZeNkenPt9bcxnRFLMbfvJdnwPb6QooaXlWtNaC2DghB6RFwmDiGTKr
         BfFu00TydDotXzO2sp6GCgTss23VQWaTtHXvbyw44gOh7TIuC87ajdxHaX9HsxGSNlge
         kUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WGrr02ePAubs5HwRrKkcQyXTzR45aRrdbF034mfwuek=;
        b=v2WafE/1ZHR7Sv1OYZrZD/XS3dXB0fNeAmp5XdzkhUxMSdQh3MfiU1wc+2Ivo/mpHD
         RBx23AYzwfk6y88I1R+Zk+9F5YCTmTM6CayssiIl/0q36tb6brewcsRrmgjUDXR/7UyC
         WL3wpMRXFy9svXX0DZN1cST6HgSST50cl/tHjtAFoxSWi4WzZP0xDwE4gjWftw4BWIZD
         9mVHJzR2zqCKv0VC/ceM2O4qVtoqiYZvbBPGHH0Pwp6hiJd/A9/7EWMITXruxYtF5Lto
         vfMO5cAq1Vb3rol+/pvp4TOvO5I45ZNCOACgIcVHvnrHD8IXQAeF4pDnmbnQ4uvfN6xe
         nOyQ==
X-Gm-Message-State: AJIora/NsjVTzGmVvVD27neAV5b2oGJ+dc2qbSs7GZtETA+UOczChA21
        abeu/R2S0Al97d4xO5X7qUnPeQ==
X-Google-Smtp-Source: AGRyM1tQAJ7cAwh+QSo9VmbPkdVHykOKKm387L7Wh6EkVy1JK3yuq3YGdz53OY0hiqHWwsJAdQOmIQ==
X-Received: by 2002:a17:902:c7d5:b0:16b:ea78:4eb4 with SMTP id r21-20020a170902c7d500b0016bea784eb4mr829285pla.65.1656928739180;
        Mon, 04 Jul 2022 02:58:59 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id a3-20020a1709027e4300b0016b8b35d725sm13844964pln.95.2022.07.04.02.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 02:58:58 -0700 (PDT)
Date:   Mon, 4 Jul 2022 15:28:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/4] cpufreq: qcom-hw: LMH irq/hotplug interractions
Message-ID: <20220704095856.s3abmelpd2744nyl@vireshk-i7>
References: <20220615144321.262773-1-pierre.gondois@arm.com>
 <a9ab7982-b235-ef5f-2c1b-ecbc421552d1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ab7982-b235-ef5f-2c1b-ecbc421552d1@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-07-22, 11:55, Pierre Gondois wrote:
> Hello,
> I saw that:
> https://lore.kernel.org/all/20220617064421.l4vshytmqtittzee@vireshk-i7/
> 
> was applied, so this patch-set would need to be rebased. Please let me
> know if you think it requires modifications before it gets rebased,

Everything else looks fine, just rebase and resend. Thanks.

-- 
viresh
