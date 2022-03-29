Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFA14EA970
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiC2IhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiC2IhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:37:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D5F23F9FD;
        Tue, 29 Mar 2022 01:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2E1CB81289;
        Tue, 29 Mar 2022 08:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2044C2BBE4;
        Tue, 29 Mar 2022 08:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648542929;
        bh=/IgiTLHO0OlmIrIOxlJIDS4eEAqr6nu6wDTstJjIgNg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tJFB+r/SF5mC07nLTbLLNlPW6S62rOVp4XyNU2BfsZjCzpWoQZoCjYgqH1R1XtaMV
         P7LlPPKUJPtK6/+4lhIijF9awnHTtz2NTLgRRwCq13c+/CnlWZrSw4qO48+BLShhP7
         9ZRRFr6X6lGwD5vL+TtLOdk1tlj8cF8+MJWsa0HubaTmrDzlxrT3B1jv4AO5h4zAdg
         igMCXYm4EdfdDHmX72QWWmDGhOi4cjTyZ1EbP0v96sZfVrrukWh0/79iOFoKaVlL9i
         /EquZQq2pa0rVea0eN1rbt34a0ipzFGTaBW5g00p/PPvN0R0yxHkPJ49vxAnq4FOOe
         iSCXh7awMPgNg==
Message-ID: <128b1d74-1ce6-bb50-cb44-50e4743186d6@kernel.org>
Date:   Tue, 29 Mar 2022 11:35:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] memory: omap-gpmc: Allow building as a module
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220328111319.1236-1-rogerq@kernel.org>
 <20220328111319.1236-3-rogerq@kernel.org>
 <8a55260d-7354-028b-8439-475a9fbfe092@kernel.org>
 <c9b0b3e5-28f3-67a2-6456-d63f3232e432@kernel.org>
 <def0fe2c-645e-1dbc-8a1a-dd7393176891@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <def0fe2c-645e-1dbc-8a1a-dd7393176891@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/2022 11:02, Krzysztof Kozlowski wrote:
> On 29/03/2022 09:37, Roger Quadros wrote:
>> Hi Krzysztof,
>>
>> On 28/03/2022 16:11, Krzysztof Kozlowski wrote:
>>> On 28/03/2022 13:13, Roger Quadros wrote:
>>>> Allow OMAP_GPMC to be built as a module.
>>>>
>>>> Remove redundant of_match_node() call before
>>>> of_platform_default_populate() as the latter takes
>>>> care of matching with of_default_bus_match_table.
>>>
>>> Split this part to separate commit, please. It does not look related to
>>> making it a module.
>>
>> Actually it is related. Without that change build fails
>> as it cannot find symbol 'of_default_bus_match_table'
> 
> Hm, because of missing EXPORT?

Yes, only module build fails. Built-in is fine.

> 
> Then it is related although to me removal of redundant code still could
> be split to separate commit. But I do not insist, if you mention it in
> commit msg.

OK. Thanks.
> 
> 
> Best regards,
> Krzysztof

--
cheers,
-roger
