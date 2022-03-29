Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCA44EA8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiC2IE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiC2IEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:04:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C421E3DE;
        Tue, 29 Mar 2022 01:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4320C60F0C;
        Tue, 29 Mar 2022 08:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB31AC340ED;
        Tue, 29 Mar 2022 08:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648540962;
        bh=6TsUOpn6AsckH4cmA4B2bHsaxo9YC8A9bA/g+oZhyUM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vJ8PiRL168sZ2+k9IY4IQBnw2efnqrY69ty6M6bL7jCCD7c03xce2qzoVVcHjS783
         ytjp+LckHX+wuVCK5uVpRzbWVAFekxqzBhtwM3ouPggby4ePfLfEvVISV5/Ktfa2FG
         QLlGscwhHArQEbZM3iOmXg0wKnvxdpOBb43FO1gZYF9bl20/hT0UFPkfx9vGmT6yUY
         zmkmEQkd8wzGs99VbR51X7LXQOAmvR5P77LuveIjSX52a22QHo/NJYlIrHvnw+UOGn
         8fdeNCrydzyLCIS/yjoK3yyg+L3coROznuQ57VR9MMdSXxOh62oY5BT36No00SgDc8
         cAhbaovRftQww==
Message-ID: <def0fe2c-645e-1dbc-8a1a-dd7393176891@kernel.org>
Date:   Tue, 29 Mar 2022 10:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] memory: omap-gpmc: Allow building as a module
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>
Cc:     miquel.raynal@bootlin.com, tony@atomide.com, vigneshr@ti.com,
        kishon@ti.com, nm@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220328111319.1236-1-rogerq@kernel.org>
 <20220328111319.1236-3-rogerq@kernel.org>
 <8a55260d-7354-028b-8439-475a9fbfe092@kernel.org>
 <c9b0b3e5-28f3-67a2-6456-d63f3232e432@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <c9b0b3e5-28f3-67a2-6456-d63f3232e432@kernel.org>
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

On 29/03/2022 09:37, Roger Quadros wrote:
> Hi Krzysztof,
> 
> On 28/03/2022 16:11, Krzysztof Kozlowski wrote:
>> On 28/03/2022 13:13, Roger Quadros wrote:
>>> Allow OMAP_GPMC to be built as a module.
>>>
>>> Remove redundant of_match_node() call before
>>> of_platform_default_populate() as the latter takes
>>> care of matching with of_default_bus_match_table.
>>
>> Split this part to separate commit, please. It does not look related to
>> making it a module.
> 
> Actually it is related. Without that change build fails
> as it cannot find symbol 'of_default_bus_match_table'

Hm, because of missing EXPORT?

Then it is related although to me removal of redundant code still could
be split to separate commit. But I do not insist, if you mention it in
commit msg.


Best regards,
Krzysztof
