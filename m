Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEE459F6DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiHXJvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbiHXJvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:51:01 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24FF481D0;
        Wed, 24 Aug 2022 02:50:56 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oQn2F-00065t-1o; Wed, 24 Aug 2022 11:50:55 +0200
Message-ID: <4291cff9-b9d6-17f4-f62a-d88a9c01048a@leemhuis.info>
Date:   Wed, 24 Aug 2022 11:50:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [REGRESSION 5.19] NULL dereference by ucsi_acpi driver
Content-Language: en-US
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87r11cmbx0.wl-tiwai@suse.de>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <87r11cmbx0.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1661334657;dc02e3de;
X-HE-SMSGID: 1oQn2F-00065t-1o
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker.

On 19.08.22 18:32, Takashi Iwai wrote:
> Hi,
> 
> we've got multiple reports about 5.19 kernel starting crashing after
> some time, and this turned out to be triggered by ucsi_acpi driver.
> The details are found in:
>   https://bugzilla.suse.com/show_bug.cgi?id=1202386
> 
> The culprit seems to be the commit 87d0e2f41b8c
>     usb: typec: ucsi: add a common function ucsi_unregister_connectors()
>     
> This commit looks as if it were a harmless cleanup, but this failed in
> a subtle way.  Namely, in the error scenario, the driver gets an error
> at ucsi_register_altmodes(), and goes to the error handling to release
> the resources.  Through this refactoring, the release part was unified
> to a funciton ucsi_unregister_connectors().  And there, it has a NULL
> check of con->wq, and it bails out the loop if it's NULL. 
> Meanwhile, ucsi_register_port() itself still calls destroy_workqueue()
> and clear con->wq at its error path.  This ended up in the leftover
> power supply device with the uninitialized / cleared device.
> 
> It was confirmed that the problem could be avoided by a simple
> revert.
> 
> I guess another fix could be removing the part clearing con->wq, i.e.
> 
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1192,11 +1192,6 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
>  out_unlock:
>  	mutex_unlock(&con->lock);
>  
> -	if (ret && con->wq) {
> -		destroy_workqueue(con->wq);
> -		con->wq = NULL;
> -	}
> -
>  	return ret;
>  }
>  
> 
> ... but it's totally untested and I'm not entirely sure whether it's
> better.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot introduced 87d0e2f41b8c ^
https://bugzilla.suse.com/show_bug.cgi?id=1202386
#regzbot title NULL dereference by ucsi_acpi driver
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
