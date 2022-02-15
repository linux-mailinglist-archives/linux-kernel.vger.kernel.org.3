Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCF64B7985
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbiBOUyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:54:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243103AbiBOUyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:54:04 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DBE27165;
        Tue, 15 Feb 2022 12:53:53 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nK4pa-0007bZ-UA; Tue, 15 Feb 2022 21:53:50 +0100
Message-ID: <2adc3231-2f5c-78c0-7a68-e5a8a1363b55@leemhuis.info>
Date:   Tue, 15 Feb 2022 21:53:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Input: psmouse - set up dependency between PS/2 and SMBus
 companions
Content-Language: en-BZ
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rajat Jain <rajatja@google.com>, Wolfram Sang <wsa@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
References: <YgwQN8ynO88CPMju@google.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YgwQN8ynO88CPMju@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1644958433;d8100e34;
X-HE-SMSGID: 1nK4pa-0007bZ-UA
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.02.22 21:42, Dmitry Torokhov wrote:
> When we switch from emulated PS/2 to native (RMI4 or Elan) protocols, we
> create SMBus companion devices that are attached to I2C/SMBus controllers.
> However, when suspending and resuming, we also need to make sure that we
> take into account the PS/2 device they are associated with, so that PS/2
> device is suspended after the companion and resumed before it, otherwise
> companions will not work properly. Before I2C devices were marked for
> asynchronous suspend/resume, this ordering happened naturally, but now we
> need to enforce it by establishing device links, with PS/2 devices being
> suppliers and SMBus companions being consumers.
> 
> Fixes: 172d931910e1 ("i2c: enable async suspend/resume on i2c client devices")
> Reported-and-tested-by: Hugh Dickins <hughd@google.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

If you respin or commit this patch, could you please add the link to the
report, as explained in 'Documentation/process/submitting-patches.rst'
and 'Documentation/process/5.Posting.rst':

Link:
https://lore.kernel.org/r/89456fcd-a113-4c82-4b10-a9bcaefac68f@google.com

This would be helpful for me, as this is a regression tracked by
regzbot, my Linux kernel regression tracking bot, which then is able to
assign threads like this with the regression report and mark the
regression as resolved once the fix lands in the appropriate tree. tia!

Ciao, Thorsten

#regzbot ^backmonitor:
https://lore.kernel.org/r/89456fcd-a113-4c82-4b10-a9bcaefac68f@google.com

