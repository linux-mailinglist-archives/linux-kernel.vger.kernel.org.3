Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1A4530200
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 11:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbiEVJIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 05:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbiEVJIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 05:08:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C18344EB
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 02:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5693DB80ACC
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 09:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A0EC385AA;
        Sun, 22 May 2022 09:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653210476;
        bh=Tnd9k7iRjgfdcQgXzfq2JZ4qYtO5XwbTFBmo19t2jIA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S8xXimqwBxzn98bU6z1yaq8fOwEkP+dYMHN4eCURaFRz1fCsgAvfxI9/nsO9Umk+2
         SA1sZoI38b6YE61f3Lya/sy7xMavAKqSUYWRuKg3zXQwN9jIf337VBGkqckkyI6Yco
         gFjd7P1zz1tNPnfmBUGwqel+eI3I5ACsqtRgOrSnpcMl2Jdjh7+joPY4TioEsLFQ//
         i8+ZpTnOSrNQWUuShcWtDsJuzaS41D/07R1BjG1RnAXK/cpBCEnrasRXZqNAi4iMpU
         8ZNZzzXyYbLAEbPAbWYRW0XdJWbCqEIedtT3HnQ4A7UsGV2LLJGCTYJiF4ZSTiQc0a
         NdZYWnmCuBQjQ==
Message-ID: <a673356d-4534-afd9-b85f-b8de7f58c9a8@kernel.org>
Date:   Sun, 22 May 2022 11:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [Ksummit-discuss] uninitialized variables bugs
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>, kbuild@lists.01.org,
        lkp@intel.com
References: <20220506091338.GE4031@kadam>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220506091338.GE4031@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 11:13, Dan Carpenter wrote:
> There is also stuff like this which is harmless:
> 
> 	uint val;
> 
> 	ret = read(&val);
> 	*p = val;  // <-- uninitialized variable if read() fails
> 	return ret;
> 
> Btw, here is how to run Smatch on your code:
> https://staticthinking.wordpress.com/2022/04/25/how-to-run-smatch-on-your-code/

In the topic of suppressing false positives we also have several
"fixes", sometimes pointed out incorrectly by Coverity, for missing
check for of_device_get_match_data().

Compare:
https://elixir.bootlin.com/linux/v5.18-rc7/source/drivers/clk/clk-aspeed.c#L415
https://elixir.bootlin.com/linux/v5.18-rc7/source/drivers/clk/clk-oxnas.c#L216

Although in theory the of_device_get_match_data() can return NULL, in
practice it is not possible because driver matches via OF thus there
will be always of_device_id->driver data.

Coverity screams about it, people fix it by adding checks for NULL,
which is pointless. Half of drivers add the !NULL check, half do not...

Best regards,
Krzysztof
