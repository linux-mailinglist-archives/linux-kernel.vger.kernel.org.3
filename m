Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F99559EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiFXQpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFXQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:45:18 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344BB47549;
        Fri, 24 Jun 2022 09:45:17 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C54ADC0005;
        Fri, 24 Jun 2022 16:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656089116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Yof9puEZCThqdywnFFBZccm9TUQN0Wk2gtyzAn9V20=;
        b=Dq3lTFyxOWlCEqKtGGlOdH/oGnRRx6pLTtK3ckpNEeDpz8bQ7AR3+HheTeWQHWj9Mem0ww
        wtchoEsWAYGFIYyrHBy5yFhrg63uiB2f0j+aU2png94/hFmMxLXau2vCAzTQfpBPKEjA9P
        9itAYU6jFeI7z5rbr9NXan+23pNdgvNZXMuITmkwe6fk0HqDy82x/jqM4/14QaZnrM3E4v
        OPPfzFB/ncQJ7DoHNA6iNISJd+hga9Tw6hnJa4Iy3SqEDQnj4LjI+VzAgqghK3ZYgYqFwE
        NAd0IoqTrzWSW6D1E5/O9FXmBdRKH8PGtlGdbZ3u0cS13ZiiCJPswDt3Y5ng+g==
From:   alexandre.belloni@bootlin.com
To:     linux-kernel@vger.kernel.org, mat.jonczyk@o2.pl,
        linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com,
        a.zummo@towertech.it, tglx@linutronix.de, mingo@redhat.com
Subject: Re: (subset) [PATCH 1/3] rtc-mc146818-lib: reduce RTC_UIP polling period
Date:   Fri, 24 Jun 2022 18:45:11 +0200
Message-Id: <165608905386.24026.1966178825029089110.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220225215011.861477-2-mat.jonczyk@o2.pl>
References: <20220225215011.861477-1-mat.jonczyk@o2.pl> <20220225215011.861477-2-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

On Fri, 25 Feb 2022 22:50:09 +0100, Mateusz Jończyk wrote:
> Waiting 1ms every time is not necessary, for example on some AMD boxes
> the RTC_UIP bit is documented as being high for around 270 microseconds
> in some cases [1], which agreed with experiments on an SB710
> southbridge. So 100us seems optimal.
> 
> This in preparation for mach_get_cmos_time() refactoring.
> The functions mc146818_get_time() and mach_get_cmos_time() in
> arch/x86/kernel/rtc.c perform the same function and the code is
> duplicated. mach_get_cmos_time() is busy waiting for the RTC_UIP
> bit to clear, so make mc146818_get_time() more similar to it by reducing
> the polling period.
> 
> [...]

Applied, thanks!

[1/3] rtc-mc146818-lib: reduce RTC_UIP polling period
      commit: 4b94a798e1ca59f4614f5ff6b94fe0c287412b9b

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
