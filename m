Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BDE5120A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbiD0Pey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbiD0Peu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:34:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7B7171C36;
        Wed, 27 Apr 2022 08:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 361206165E;
        Wed, 27 Apr 2022 15:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA94C385A7;
        Wed, 27 Apr 2022 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651073497;
        bh=aJfZ+9yvCFPE8xiq6retolbqjQ4Eg2L17bY7gOXE74g=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ki1ozcB0ESMwvpYya8NCHAJU3wvB53xx5SaFASY2lNNf6DM2I1xOWC+oP9aMm3c4P
         l1M+MP6t9ws2yfdCNJt3f1rdRoiUjFuBcN5xXXwr9mcDmaXUCQGpSG1AFPbMIWbYQl
         huGSCrxSvhqmhxJdwPFvSL+qCwPwo57BcXUpMGN0OGYQUn3e3VA5viIJ7gzmnZNyh7
         YV9yCjenKfxx8DraC2LW3lGT9pMesU/pD92HdrbPtRLVCXpNY+o5siZA3HoFjc8akN
         EBPeMBMtB1cSS6d6uzK/CShGCf1pDwiGfsquWaYpi7Vl5QNKPThr7wzic6cU9+XiqO
         49K+VuREX7QxA==
Message-ID: <99491be0-a438-cac7-1441-396aade91ea4@kernel.org>
Date:   Wed, 27 Apr 2022 18:31:32 +0300
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] interconnect: qcom: constify qcom_icc_desc
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220412102623.227607-1-krzysztof.kozlowski@linaro.org>
 <b96fd335-df13-6657-c2ff-38ff677555a4@linaro.org>
 <12570c36-d005-f51c-654b-01d52c50205c@kernel.org>
 <6d9ded33-f5fc-6346-51ca-2de8e7a644ec@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <6d9ded33-f5fc-6346-51ca-2de8e7a644ec@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27.04.22 15:59, Krzysztof Kozlowski wrote:
> On 27/04/2022 14:17, Georgi Djakov wrote:
>> On 22.04.22 18:25, Krzysztof Kozlowski wrote:
>>> On 12/04/2022 12:26, Krzysztof Kozlowski wrote:
>>>> struct qcom_icc_desc is not modified so it can be made const for safety.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>    drivers/interconnect/qcom/msm8916.c |  6 +++---
>>>>    drivers/interconnect/qcom/msm8939.c |  8 ++++----
>>>>    drivers/interconnect/qcom/msm8974.c | 12 ++++++------
>>>>    drivers/interconnect/qcom/qcm2290.c | 12 ++++++------
>>>>    drivers/interconnect/qcom/qcs404.c  |  6 +++---
>>>>    drivers/interconnect/qcom/sc7180.c  | 26 +++++++++++++-------------
>>>>    drivers/interconnect/qcom/sc7280.c  | 24 ++++++++++++------------
>>>>    drivers/interconnect/qcom/sdm660.c  | 12 ++++++------
>>>>    drivers/interconnect/qcom/sm8150.c  | 22 +++++++++++-----------
>>>>    drivers/interconnect/qcom/sm8250.c  | 22 +++++++++++-----------
>>>>    drivers/interconnect/qcom/sm8350.c  | 20 ++++++++++----------
>>>>    drivers/interconnect/qcom/sm8450.c  | 22 +++++++++++-----------
>>>
>>> Hi folks,
>>>
>>> Any comments here?
>>
>> Thanks for the patches! I had actually some of these changes in my local tree
>> for a long time.
> 
> Indeed I see them now in linux-next. Sorry for pinging, I just did not
> get any notification they got applied.

I meant that i did similar changes, that i never sent upstream, so thanks
for doing this. Pings are welcome.

BR,
Georgi
