Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEC5572114
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiGLQgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbiGLQgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:36:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF5031903
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:35:53 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C391A6601978;
        Tue, 12 Jul 2022 17:35:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657643752;
        bh=7qZCgoybgm6UCfHE7zY0m0GJH4TDzHpHil2mzMKSvJE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Ej10UAxAfwHaJzPVfHEPdJaJy5YNMeBHRohqlkGYyIfX2rCLYenwyOLowzq1GJKJj
         Gzs1kFtTHk+yo4dk8Fru70eu3dHkOBdxZeTXffEOomV8Wlcqx5b2VxSEhkp0a7hvHg
         cWxmSPpJEJTaJUTX4KPMI+vBTxrRbwW4xqfvb7zaCpPlbtfB9tiN+E4K0+NemSbGI+
         z9GjtCSEMOOMwsssSaeZr59unI8ZRJhJXQBwoShp9IWH13e9w5SUDGuQ8otdyZpVGa
         oUo8dxbXYVwC2yNgyg3EcK3scUIBB5/JBVUE82NYsIFAIBq+LtZ9uvxgqVNa8nbHGd
         BNb70nLysRYng==
Message-ID: <f8725aba-2cd1-c79c-eaf9-d272c140049e@collabora.com>
Date:   Tue, 12 Jul 2022 19:35:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Regression in v5.19-rc4 Sound Distortion
Content-Language: en-US
To:     Daniel Exner <dex@dragonslave.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <46fd7a73-06fd-a8a0-8530-0ecf9b18c08d@dragonslave.de>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <46fd7a73-06fd-a8a0-8530-0ecf9b18c08d@dragonslave.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 19:02, Daniel Exner wrote:
> Hi everyone,
> 
> 
> (please keep me CC as I am currently not subscribed to LKML)
> 
> 
> Since  v5.19-rc4 this box got some *loud* distorting sound on boot and
> after some time without any sound if something plays sound again from
> the integrated speakers in my monitor.
> 
> 
> I managed to bisect this down to:
> 
>> commit 202773260023b56e868d09d13d3a417028f1ff5b
>> Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Date:   Fri Jun 17 15:24:02 2022 +0300
>>
>>    PM: hibernate: Use kernel_can_power_off()
>>
> 
> Reverting that commit on top of v5.19-rc6 does indeed fix the problem here.
> 
> Any ideas?

You're saying that the problem is on boot, but this patch is about
suspension to disk, which has nothing to do neither with the boot nor
with power-off. I'm afraid your bisection is incorrect.

-- 
Best regards,
Dmitry
