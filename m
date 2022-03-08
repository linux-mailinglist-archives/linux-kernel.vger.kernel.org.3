Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606244D22C9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245704AbiCHUpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiCHUpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:45:20 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70AF5133F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:44:22 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1nRggq-0008Kl-2l; Tue, 08 Mar 2022 21:44:16 +0100
Date:   Tue, 8 Mar 2022 21:44:16 +0100
From:   Martin Kaiser <lists@kaiser.cx>
To:     =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHI4MTg4?= =?utf-8?Q?eu=3A_core?=
 =?utf-8?Q?=3A?= use time_is_after_eq_jiffies() instead of open coding it
Message-ID: <20220308204416.flwg2z5jvbapnsud@viti.kaiser.cx>
References: <1646018092-61367-1-git-send-email-wangqing@vivo.com>
 <YiNCJFFLPcD+aGnr@martin-debian-1.paytec.ch>
 <SL2PR06MB30829C82386B3278C2E4A17ABD089@SL2PR06MB3082.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SL2PR06MB30829C82386B3278C2E4A17ABD089@SL2PR06MB3082.apcprd06.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote 王擎 (wangqing@vivo.com):

> >Hi,

> >Thus wrote Qing Wang (wangqing@vivo.com):

> >> From: Wang Qing <wangqing@vivo.com>

> >> Use the helper function time_is_{before,after}_jiffies() to improve
> >> code readability.

> >> Signed-off-by: Wang Qing <wangqing@vivo.com>
> >> ---
> >>  drivers/staging/r8188eu/core/rtw_pwrctrl.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)

> >> diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> >> index 46e44ae..9894abb
> >> --- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> >> +++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> >> @@ -102,7 +102,7 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
> >>        struct wifidirect_info  *pwdinfo = &adapter->wdinfo;
> >>        bool ret = false;

> >> -     if (adapter->pwrctrlpriv.ips_deny_time >= jiffies)
> >> +     if (time_is_after_eq_jiffies(adapter->pwrctrlpriv.ips_deny_time))
> >>                goto exit;

> >>        if (check_fwstate(pmlmepriv, WIFI_ASOC_STATE | WIFI_SITE_MONITOR) ||
> >> -- 
> >> 2.7.4


> >This doesn't compile on my system:

> >  CC [M]  drivers/staging/r8188eu/core/rtw_p2p.o
> >In file included from ./include/linux/irqflags.h:15,
> >                 from ./arch/arm/include/asm/atomic.h:14,
> >                 from ./include/linux/atomic.h:7,
> >                 from ./include/linux/rcupdate.h:25,
> >                 from ./include/linux/rculist.h:11,
> >                 from ./include/linux/sched/signal.h:5,
> >                 from drivers/staging/r8188eu/core/../include/osdep_service.h:7,
> >                from drivers/staging/r8188eu/core/rtw_pwrctrl.c:6:
> >drivers/staging/r8188eu/core/rtw_pwrctrl.c: In function ‘rtw_pwr_unassociated_idle’:
> >./include/linux/typecheck.h:12:25: warning: comparison of distinct pointer types lacks a cast
> >   12 |         (void)(&__dummy == &__dummy2); \
> >      |                         ^~
> >./include/linux/jiffies.h:111:10: note: in expansion of macro ‘typecheck’
> >  111 |         (typecheck(unsigned long, a) && \
> >      |          ^~~~~~~~~
> >./include/linux/jiffies.h:114:33: note: in expansion of macro ‘time_after_eq’
> >  114 | #define time_before_eq(a,b)     time_after_eq(b,a)
> >      |                                 ^~~~~~~~~~~~~
> ./include/linux/jiffies.h:166:37: note: in expansion of macro ‘time_before_eq’
> >  166 | #define time_is_after_eq_jiffies(a) time_before_eq(jiffies, a)
> >      |                                     ^~~~~~~~~~~~~~
> >drivers/staging/r8188eu/core/rtw_pwrctrl.c:92:13: note: in expansion of macro ‘time_is_after_eq_jiffies’
> >   92 |         if (time_is_after_eq_jiffies(adapter->pwrctrlpriv.ips_deny_time))
> >      |             ^~~~~~~~~~~~~~~~~~~~~~~~



> >time_is_after_eq_jiffies checks at compile time that its argument is
> >unsigned long but ips_deny_time is u32 in the r8188eu driver.

> >We should change ips_deny_time to unsigned long, the rtl8723bs driver did
> >this as well. ips_deny_time is used in these places

> >  11     92  drivers/staging/r8188eu/core/rtw_pwrctrl.c <<rtw_pwr_unassociated_idle>>
> >             if (adapter->pwrctrlpriv.ips_deny_time >= jiffies)
> >  12    363  drivers/staging/r8188eu/core/rtw_pwrctrl.c <<_rtw_pwr_wakeup>>
> >             if (pwrpriv->ips_deny_time < jiffies + rtw_ms_to_systime(ips_deffer_ms))
> >  13    364  drivers/staging/r8188eu/core/rtw_pwrctrl.c <<_rtw_pwr_wakeup>>
> >             pwrpriv->ips_deny_time = jiffies + rtw_ms_to_systime(ips_deffer_ms);
> >  14    399  drivers/staging/r8188eu/core/rtw_pwrctrl.c <<_rtw_pwr_wakeup>>
> >             if (pwrpriv->ips_deny_time < jiffies + rtw_ms_to_systime(ips_deffer_ms))
> >  15    400  drivers/staging/r8188eu/core/rtw_pwrctrl.c <<_rtw_pwr_wakeup>>
> >             pwrpriv->ips_deny_time = jiffies + rtw_ms_to_systime(ips_deffer_ms);

> >rtw_ms_to_systime converts milliseconds to jiffies and returns u32. We
> >should use msecs_to_jiffies instead, this functions returns unsigned long.

> >Do you want to have a go at this?

> >Best regards,

> >   Martin

> I see rtl8723bs/include/rtw_pwrctrl.h also has a definition of struct pwrctrl_priv on it, 
> which is unsigned long ips_deny_time.
> Is there any difference, or should it be changed to unsigned long?


Hi Wang,

yes, I believe that we should change ips_deny_time to unsigned long.

But before this, we have to change rtw_ms_to_systime to msecs_to_jiffies.

Best regards,
Martin
