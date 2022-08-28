Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC355A3D6B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 13:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiH1LxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 07:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiH1LxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 07:53:03 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CF411A0F;
        Sun, 28 Aug 2022 04:53:02 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oSGqb-0007QJ-4K; Sun, 28 Aug 2022 13:53:01 +0200
Message-ID: <9729ab5f-422d-19a8-d4e0-94de0877736d@leemhuis.info>
Date:   Sun, 28 Aug 2022 13:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/2] scsi: sd: Rework asynchronous resume support
 #forregzbot
Content-Language: en-US
Cc:     scsi <linux-scsi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org
References: <20220630195703.10155-1-bvanassche@acm.org>
 <alpine.DEB.2.22.394.2207191125130.1006766@ramsan.of.borg>
 <db19ed29-e7f9-e5b0-3a6c-f2812078a07d@acm.org>
 <CAMuHMdVzsgSYtbJQnaigNax_JbxPsQfU+gHcteS-ojWbxUdMfw@mail.gmail.com>
 <CAMuHMdWtxBj8ug7AHTqentF8UD4jpO2sgoWWcQCOvEKLJtdq8A@mail.gmail.com>
 <506ca1a6-1122-5755-fc74-60f7c7bfbd0d@acm.org>
 <CAMuHMdVQ2K2v8jpsFfOMk99DG_sBB4_ioiQRroC7K_Ov1wvp9w@mail.gmail.com>
 <6f70e742-9d8a-f389-0482-0ba9696bf445@acm.org>
 <CAMuHMdVc+ATGV-=R3uV6RyF0-mZiuKv7HpmogRBgqGVyO-MKWg@mail.gmail.com>
 <54e20a27-a10b-b77a-e950-1d3398e2e907@acm.org>
 <CAMuHMdURQpAEGgv4cY7v0rqzs12v2TT=Amt26Y0OoBSW7YAoaw@mail.gmail.com>
 <084e7c5a-f98d-d61e-de81-83525851ecf9@acm.org>
 <CAMuHMdW2vOC8ZsE_XF8TbSNoF9zCrwq7UkGZ5jXen1E1mTZe+g@mail.gmail.com>
 <14ec47f3-f3b8-61c7-2c64-d96d00dd7076@acm.org>
 <CAMuHMdW7nGxV_3Z2JV_TCM+WtTdYv5P+0cE6Tw=6krcseNCdAw@mail.gmail.com>
 <40700595-8c83-1b61-ea93-ea9554bfb2db@acm.org>
 <98592410-dd31-9081-86be-fda67d3b06d2@suse.cz>
To:     regressions@lists.linux.dev
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <98592410-dd31-9081-86be-fda67d3b06d2@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1661687582;b4a732ba;
X-HE-SMSGID: 1oSGqb-0007QJ-4K
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

On 17.08.22 21:07, Vlastimil Babka wrote:
> Hi, I have a T460 hanging on resume from suspend to ram in 6.0-rc1 that
> I bisected to this commit.
> 
>> Unfortunately the above does not learn us anything new. The code 
>> modified by commit 88f1669019bd ("scsi: sd: Rework asynchronous resume 
>> support") is only called if sdev->manage_start_stop != 1. Only the SATA 
>> code, the Firewire code and the manage_start_stop sysfs attribute store 
>> method set that member variable:
> [...]
> #regzbot introduced: 88f1669019bd62b3
> #regzbot monitor: https://lore.kernel.org/all/20220816172638.538734-1-bvanassche@acm.org/

#regzbot fixed-by: 785538bfdd682c8e962341d585f9b88262a0475

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
