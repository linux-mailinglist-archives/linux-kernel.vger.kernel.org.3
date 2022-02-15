Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168AF4B7A38
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244460AbiBOWJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:09:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiBOWJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:09:25 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F823BC0;
        Tue, 15 Feb 2022 14:09:13 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F3AB6C0007;
        Tue, 15 Feb 2022 22:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644962952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/k2GIivlZAYSXRNIeqS36LGVGK2dubipw8sDLnURaqI=;
        b=l0mtlzEmBUvB3i5I9/gQY+FnjB5QH9PSiWFy+1w2V8zUuANxPmy3UxDHMnrPzqZgscxBBV
        qN8IzCV814yubkbuxCnT+E72iSvJUF3gP+OUmyjcbbHr94/c7otZJCDftZZfoHZNlDDInA
        uQBleDsSPECvv5VTcBeVVqKt//H1JpfB6qLbBgli5bbw/lUlH0b3EFZ3p+ZhpZ9pwTUC20
        S0MdnmCQH4UX2UTlNtD7y9jbeBACt7IxEgTbCw5VliwD9sIWdFgQno9AU5Xpt+wGPwJLd8
        D/Z6WaGiWtAxpW9Wk2U+YQkUCWtwdxiH0z1UUIs+19gOTYU3/pzjPO+sOZqj+A==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>, kernel@axis.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: fix use-after-free on device removal
Date:   Tue, 15 Feb 2022 23:09:11 +0100
Message-Id: <164496294249.63790.9626913004798028224.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20211210160951.7718-1-vincent.whitchurch@axis.com>
References: <20211210160951.7718-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 17:09:51 +0100, Vincent Whitchurch wrote:
> If the irqwork is still scheduled or running while the RTC device is
> removed, a use-after-free occurs in rtc_timer_do_work().  Cleanup the
> timerqueue and ensure the work is stopped to fix this.
> 
>  BUG: KASAN: use-after-free in mutex_lock+0x94/0x110
>  Write of size 8 at addr ffffff801d846338 by task kworker/3:1/41
> 
> [...]

Applied, thanks!

[1/1] rtc: fix use-after-free on device removal
      commit: c8fa17d9f08a448184f03d352145099b5beb618e

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
