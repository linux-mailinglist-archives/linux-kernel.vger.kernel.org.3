Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD04E4E44D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbiCVRQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiCVRQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:16:12 -0400
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C646EC68
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:14:42 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id C43E8A0040;
        Tue, 22 Mar 2022 18:14:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz C43E8A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1647969279; bh=x6V/BlAS8TdHyCaOrjtYpZSQgJjJyla2u7kpgw68GPg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h3P0mcEjxGcbZIU1GMNmQNkxEVgFps2mf2eSYi6uO55io445yF0lNRhsrZqpZyORL
         QaWNTV7B/c6d9Pd6MNBXNYO1DsXRPk4bF/XlQ0OqDabqmACTB1v9pkkk9OslKoYreV
         ETnvOJatRROix+2SD7Y3VbXEeDimCvA2T9A8aeQY=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue, 22 Mar 2022 18:14:35 +0100 (CET)
Message-ID: <53e52d32-dd17-7aa6-2ad0-432a5cf4cf35@perex.cz>
Date:   Tue, 22 Mar 2022 18:14:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] ALSA: pcm: Fix ioctl races
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc:     Hu Jiahui <kirin.say@gmail.com>, linux-kernel@vger.kernel.org
References: <20220322170720.3529-1-tiwai@suse.de>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220322170720.3529-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 03. 22 18:07, Takashi Iwai wrote:
> Hi,
> 
> this is a patch set to address the recently reported bug for the racy
> PCM ioctls.  In short, the current ALSA PCM core doesn't take enough
> care of concurrent ioctl calls, and the concurrent calls may result in
> a use-after-free.  The reported problem was the concurrent hw_free
> calls, but there can be similar cases with other code paths like
> hw_params, prepare, etc, too.
> 
> The patch set introduces the new runtime->buffer_mutex for protecting
> those.  The first patch is the fix for the reported issue (the races
> with hw_free), while the rest three are more hardening for the other
> similar executions.

Thank you Takashi.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
