Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EDF56707A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiGEOL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiGEOLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:11:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960A21409E;
        Tue,  5 Jul 2022 07:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53BE8B817EF;
        Tue,  5 Jul 2022 14:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C71C341C7;
        Tue,  5 Jul 2022 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657029806;
        bh=GYVhNrAzmIxHsezMV+ux3SV0O8/R3WOk68YoxoVfFok=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=RKubGH28bIJYqp89/tMWym1veJIhmpb7As9MNjfegrRYrEA92Kd9EdDfN1UdWYR+9
         MkUphZxXCYVt0KBDaRHs8J7A0Q7lurKvfBbH+cfkJxuNwX8RSktPmQwHop8aUUY/W7
         joPUGgpHHcOitizXwyqxw/gTU7FXReQmWMMt4gXUeTbsugM5lU3+ULzeq9dOBw7iin
         t3fo0q3BNDD3c3gJatsZ2/ydfz//npzSRVU6DfUwR3pzlNFymWK3cSZ5+rTjwOYis6
         Id6QF4UnVhelJR59c1y1klr8tXNOQKojmjhhEh3EOKXRnsTIVIhnaSYKaPMy/LpYKh
         t+kDupu7YH1hg==
Message-ID: <a60b5954-c9ac-0f2b-aef4-ad34b8f3abe7@kernel.org>
Date:   Tue, 5 Jul 2022 17:03:21 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/5] interconnect: qcom: icc-rpm: Support bucket
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705072336.742703-1-leo.yan@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220705072336.742703-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.07.22 10:23, Leo Yan wrote:
> This patch set is to support bucket in icc-rpm driver, so it implements
> the similar mechanism in the icc-rpmh driver.
> 
> We can use interconnect path tag to indicate the bandwidth voting is for
> which buckets, and there have three kinds of buckets: AWC, WAKE and
> SLEEP, finally the wake and sleep bucket values are used to set the
> corresponding clock (active and sleep clocks).  So far, we keep the AWC
> bucket but doesn't really use it.
> 
> Patches 01, 02, 03 enable interconnect path tag and update the DT
> binding document; patches 04 and 05 support bucket and use bucket values
> to set the bandwidth and clock rates.
> 
> Changes from v3:
> - Removed $ref and redundant sentence in DT binding document for
>    '#interconnect-cells' (Krzysztof Kozlowski).
> 
> Changes from v2:
> - Fixed for DT checker error for command ''make DT_CHECKER_FLAGS=-m
>    dt_binding_check' (Rob Herring).
> 
> Changes from v1:
> - Added description for property "#interconnect-cells" (Rob Herring);
> - Added Dimtry's reviewed tags for patches 02 and 03 (Dmitry Baryshkov);
> - Rebased on the latest mainline kernel and resolved conflict.
> 
> 
> Leo Yan (5):
>    dt-bindings: interconnect: Update property for icc-rpm path tag
>    interconnect: qcom: Move qcom_icc_xlate_extended() to a common file
>    interconnect: qcom: icc-rpm: Change to use qcom_icc_xlate_extended()
>    interconnect: qcom: icc-rpm: Support multiple buckets
>    interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values

Hi Leo,

Some patches do not apply clean on next. On which tree is this based? Do you have any additional 
patches?

Thanks,
Georgi
