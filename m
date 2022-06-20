Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F095510C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbiFTG45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiFTG44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:56:56 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA985FCA;
        Sun, 19 Jun 2022 23:56:55 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o3BL9-000466-Of; Mon, 20 Jun 2022 08:56:51 +0200
Message-ID: <5bcb5963-9da0-fd59-45c5-d27af02e7748@leemhuis.info>
Date:   Mon, 20 Jun 2022 08:56:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Arun Easi <aeasi@marvell.com>,
        Tony Battersby <tonyb@cybernetics.com>
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <baef87c3-5dad-3b47-44c1-6914bfc90108@cybernetics.com>
 <alpine.LRH.2.21.9999.2205271524460.4730@mvluser05.qlc.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [REGRESSION] qla2xxx: tape drive not removed after unplug FC
 cable
In-Reply-To: <alpine.LRH.2.21.9999.2205271524460.4730@mvluser05.qlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1655708215;9d5f6de7;
X-HE-SMSGID: 1o3BL9-000466-Of
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 28.05.22 02:27, Arun Easi wrote:
> Hi Tony,
> 
> Thanks for reporting the issue. We are trying to recreate this issue in 
> house. I will reach out to you for logs, if we cannot repro. Typically, we 
> get sufficient context to the issue when the problem is reproduced with 
> module parameter "ql2xextended_error_logging=1".
> 
> Anyway, I will let you know the status.

What's the status here? Tony, did you provide the info Arun asked for=
Or was some progress made somehow without it?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

> On Wed, 25 May 2022, 3:03pm, Tony Battersby wrote:
> 
>> #regzbot introduced: 44c57f205876
>>
>> I have several different QLogic FC HBAs (8, 16, 32 Gbps) and several
>> different FC LTO tape drives (IBM Ultrium 8 & 9).  When I plug in the FC
>> cable, the tape drive shows up as a SCSI device as expected.  With older
>> kernels, when I unplug the FC cable, the tape drive SCSI device would
>> disappear after about 30 seconds.  But with newer kernels (including
>> 5.18), when I unplug the FC cable, the tape drive SCSI device never
>> disappears.  I have bisected the change in behavior to the following
>> commit in kernel 5.15:
>>
>> 44c57f205876 ("scsi: qla2xxx: Changes to support FCP2 Target")
>>
>> This commit has been backported to various -stable kernels, so they are
>> also affected.
>>
>> When testing with two different tape drives:
>> 1) Plug FC cable into tape drive A.  Tape drive A shows up as a SCSI device.
>> 2) Unplug FC cable; wait 60 seconds.  Tape drive A does not disappear.
>> 3) Plug FC cable into tape drive B.  Tape drive A disappears 30 seconds
>> later, but tape drive B does not show up.
>> 4) Unplug FC cable and plug it back into tape drive B.  Tape drive B
>> shows up as a SCSI device.
>>
>> So I can actually make a tape drive disappear by plugging the cable into
>> a different tape drive, but then I have to reseat the cable again to
>> make the new tape drive show up.
>>
>> lspci -n
>> 83:00.0 0c04: 1077:2031 (rev 02)
>> 83:00.1 0c04: 1077:2031 (rev 02)
>>
>> When plugging in cable:
>> qla2xxx [0000:83:00.1]-500a:7: LOOP UP detected (8 Gbps).
>>
>> When unplugging cable with old kernel:
>> qla2xxx [0000:83:00.1]-500b:7: LOOP DOWN detected (2 7 0 0).
>> rport-7:0-2: blocked FC remote port time out: removing target and saving binding
>>
>> When unplugging cable with new kernel:
>> qla2xxx [0000:83:00.1]-500b:7: LOOP DOWN detected (2 7 0 0).
>>
>> /sys/class/fc_remote_ports/rport-*/
>> dev_loss_tmo: 30
>> supported_classes: Class 3
>> port_state: Online
>> (port_state remains Online even when FC cable unplugged)
>>
>> /proc/scsi/scsi
>> Host: scsi7 Channel: 00 Id: 01 Lun: 00
>>   Vendor: IBM      Model: ULTRIUM-HH8      Rev: K4K1
>>   Type:   Sequential-Access                ANSI  SCSI revision: 06
>>
>> Tony Battersby
>> Cybernetics
>>
