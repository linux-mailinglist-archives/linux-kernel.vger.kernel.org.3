Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C7D58F2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiHJTGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiHJTGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:06:31 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6371056A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:06:29 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Lr2AooOzc0DonLr2Aorj5l; Wed, 10 Aug 2022 21:06:28 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 10 Aug 2022 21:06:28 +0200
X-ME-IP: 90.11.190.129
Message-ID: <59ae9a23-4314-dc52-92da-78cefa0eb919@wanadoo.fr>
Date:   Wed, 10 Aug 2022 21:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: Intel: kbl_rt5663_max98927: Simplify clk_get()
 usage
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Harsha Priya <harshapriya.n@intel.com>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <55e59c4792d64ff6336fcaa85ec15590553e9d63.1659903516.git.christophe.jaillet@wanadoo.fr>
 <YvO3ip3LPw2QhADB@sirena.org.uk>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YvO3ip3LPw2QhADB@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/08/2022 à 15:50, Mark Brown a écrit :
> On Sun, Aug 07, 2022 at 10:18:54PM +0200, Christophe JAILLET wrote:
>> If clk_get() returns -ENOENT, there is no need to defer the driver, -ENOENT
>> will be returned the same for each retries.
>> So, return the error code directly instead of -EPROBE_DEFER.
> 
> Are you *sure* that this is the case on Intel platforms where we don't
> have a full firmware description for clocks and therefore can't identify
> cases where we expect a clock to at some point to become available.

No, I'm *not* sure.

This looked odd enough to deserve a patch proposal, that's all.
(based on my grep and coccinelle scripts, this is the only place in the 
kernel where the result of a clk_get() is handled that way)

There are many intel.com in cc:.
Would be nice if s.o. could confirm if the patch is valid or not.

CJ
