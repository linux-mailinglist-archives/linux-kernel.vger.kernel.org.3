Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A28513258
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiD1LYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345588AbiD1LX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD5A55371;
        Thu, 28 Apr 2022 04:20:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08A2B61F41;
        Thu, 28 Apr 2022 11:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176E4C385A9;
        Thu, 28 Apr 2022 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651144841;
        bh=TY47/0/sbw4f9kkF8QnQ8nbEpKwxiWT9PmOLyB2eupo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=evVFGsSgkLC0lENLdtt85BsdKLf2gH3q08LxuD8/MfP6HK2L4V/1egXXfyB+cLbDx
         OJ/z9JzWW087ZqQV9V15lxzkj0XT78enOk5292msRqO1h1F8VwUAxL3DTTMO1iq/ah
         9A6JGeyrneYBCcMNIOyAGpoO0fiNSI2AQLIQdgPVoQUhqh4xDtemM21Ej1AwsXTUl4
         Y1LQMNiHXnL7UsXLsAlX2MH9vpQi/lSMOrmdg0hjrkfB8e89dYuJjtzaiZGlbCkP6u
         hLycJ5XdnOxJcRB1zbZF7a8B9jlS4hrZmwqnw47dB1lA3p4vPsiLtTNp28/+hPk55P
         kywp9Z8wSxG2g==
Message-ID: <837facd5-2b8e-2bad-6b62-9550656a2dad@kernel.org>
Date:   Thu, 28 Apr 2022 14:20:36 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] interconnect: qcom: use icc_sync_state
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220427145616.523557-1-krzysztof.kozlowski@linaro.org>
 <4769c796-6edd-c23a-ee2a-ce54495548f7@kernel.org>
 <e77d9ff9-67a5-e0f3-8ad8-848342ed4dfb@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <e77d9ff9-67a5-e0f3-8ad8-848342ed4dfb@linaro.org>
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


On 28.04.22 13:23, Krzysztof Kozlowski wrote:
> On 27/04/2022 17:34, Georgi Djakov wrote:
>> On 27.04.22 17:56, Krzysztof Kozlowski wrote:
>>> Use icc_sync_state for interconnect providers, so that the bandwidth
>>> request doesn't need to stay on maximum value.
>>
>> Did you test this? In general, we should not enable this on boards that
>> do not have full interconnect scaling support in consumer drivers yet.
>> Some of the interconnects could be enabled by default by the bootloader
>> and usually later during boot the consumer drivers request the bandwidth
>> that they need. But if the requests are missing, the interconnects
>> without bandwidth users will be disabled when we reach sync state. So
>> this may (or not) cause issues...
> 
> I understand, thanks for bringing this up. It does not look like an
> issue of interconnect provider but instead consumers and DTS. It's not
> the job of provider driver to know all possible uses and DTS files. The
> driver should expose itself and if platform is not ready, should not use
> it by not enabling the interconnect. It's a job for DTS, not for the
> interconnect provider.

Agree, but we still need to make sure this is tested and does not
introduce any regressions at least with the DT that is upstream.

> Imagine some out of tree DTS which cannot use interconnects because we
> assume that all users of that provider are missing bandwidth requests.
> No, instead provider should allow anyone to use it.

I have an idea to introduce a kernel parameter like clk_ignore_unused,
but for interconnects.

> I understand my change might cause unexpected issues, but it is still
> technically correct, just maybe should be followed with disabling in DTS
> the providers without proper consumers?

Not sure that enabling/disabling stuff in DT is a good option. DT should
be just a description of the hardware and it might not be updated as often
as the kernel.

Thanks,
Georgi
