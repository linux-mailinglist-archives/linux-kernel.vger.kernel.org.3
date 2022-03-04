Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDAE4CCDF5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbiCDGoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCDGoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:44:17 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6177139CE7;
        Thu,  3 Mar 2022 22:43:29 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nQ1ey-0006TW-E5; Fri, 04 Mar 2022 07:43:28 +0100
Message-ID: <ba16b515-80bc-626a-42ca-1083c78eb5aa@leemhuis.info>
Date:   Fri, 4 Mar 2022 07:43:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
Content-Language: en-US
To:     Steve French <smfrench@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Davyd McColl <davydm@gmail.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
 <CAH2r5mt_2f==5reyc0HmMLvYJVmP4Enykwauo+LQoFGFbVFeRQ@mail.gmail.com>
 <CAJjP=BvNVOj3KRnhFgk6xiwnxVhxE-sN98-pr6e1Kzc5Xg5EvQ@mail.gmail.com>
 <CAH2r5mvsetx5G+c=8ePh+X8ng7FvMrnuM9+FJ4Sid4b3E+T41Q@mail.gmail.com>
 <CAJjP=BvqZUnJPq=C0OUKbXr=mbJd7a6YDSJC-sNY1j_33_e-uw@mail.gmail.com>
 <CAN05THSGwCKckQoeB6D91iBv0Sed+ethK7tde7GSc1UzS-0OYg@mail.gmail.com>
 <CAJjP=BvcWrF-k_sFxak1mgHAHVVS7_JZow+h_47XB1VzG2+Drw@mail.gmail.com>
 <ebf8c487-0377-834e-fbb7-725cceae1fbb@leemhuis.info>
 <CAN05THRJJj48ueb34t18Yj=JYuhiwZ8hTvOssX4D6XhNpjx-bg@mail.gmail.com>
 <f7eb4a3e-9799-3fe4-d464-d84dd9e64510@leemhuis.info>
 <CAJjP=Bus1_ce4vbHXpiou1WrSe8a61U1NzGm4XvN5fYCPGNikA@mail.gmail.com>
 <fe156bb6-c6d2-57da-7f62-57d2972bf1ae@leemhuis.info>
 <CAHk-=wjSBvRk-ksUBOiQzJd=e19UZKvOSZs1UHahK5U0QVh6RQ@mail.gmail.com>
 <CAH2r5mvQnQTDQaci-NbLBjRb=gCPtMewrKhLBOLGrN2_Zpc3Bg@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAH2r5mvQnQTDQaci-NbLBjRb=gCPtMewrKhLBOLGrN2_Zpc3Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1646376209;23651f12;
X-HE-SMSGID: 1nQ1ey-0006TW-E5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.03.22 02:27, Steve French wrote:
> We have been looking to see if we could setup some VMs for something
> that old, and we are willing to test against it if it could
> realistically be setup, but it has been harder than expected.  Ronnie
> had some ideas and we are willing to experiment more but realistically
> it is very hard to deal with 'legacy museum style' unless we have some
> VMs available for old systems.
> 
> Feel free to contact Ronnie and me or Shyam etc (offline if easier) if
> you have ideas on how to setup something like this.   We don't want to
> be encouraging SMB1, but certainly not NTLMv1 auth with SMB1 given its
> security weaknesses (especially given the particular uses hackers have
> made of 25+ year old NTLMv1 weaknesses).

Linus, Steve, thx for your option on this. I not sure if "museum style
equipment" really applies here, as the hardware seems to be sold in
2013/2014 and according to the reporter even got a update in 2016. But
whatever, yes, it's niche thing and what the hw manufacturer did there
was a bad idea.

Anyway, I'll stop tracking this then.

#regzbot invalid: to niche/risky/old, see Linus and Steve's messages for
details

> On Wed, Mar 2, 2022 at 6:51 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Tue, Mar 1, 2022 at 10:58 PM Thorsten Leemhuis
>> <regressions@leemhuis.info> wrote:
>>>
>>> Thx for the update. I pointed Linus towards this thread two times now,
>>> but he didn't comment on it afaics. CCing him now, maybe that will to
>>> the trick.
>>
>> So I have to admit that I think it's a 20+ year old legacy and
>> insecure protocol that nobody should be using.
>>
>> When the maintainer can't really even test it, and it really has been
>> deprecated that long, I get the feeling that somebody who wants it to
>> be maintained will need to do that job himself.
>>
>> This seems to be a _very_ niche thing, possibly legacy museum style
>> equipment, and maybe using an older kernel ends up being the answer if
>> nobody steps up and maintains it as an external patch.
>>
>>              Linus
> 
> 
> 
