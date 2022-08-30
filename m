Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552325A6046
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiH3KGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiH3KGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:06:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E052CEE68A;
        Tue, 30 Aug 2022 03:03:26 -0700 (PDT)
Date:   Tue, 30 Aug 2022 12:03:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661853802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Th0mQ/sNN9c18CVRxErzRPXBEZvcyeYzQkxhouGlyc=;
        b=qMETC6v6RTxNCE90+XAWi3L/rz6zS3FsKcQe2Uj32rmKr8M0vVUZ0iD6iQ+/6v1YT62AKY
        UfmzmDieJiYqyLxx1/XJ5g7u9AhVAEnynv1O2TYCk2buD7zFdf7cLeajft8SWRFT/GSImi
        4yk5pfiCQ/1D6VWuafWjBidWdsrI9K/EhkUxNu9w2f7YxooeGv7Abv3FkWJr20P7zzZGHd
        fnB4umkby03JJarue+rnpk+Xr1znNtRpX40Nk0OP63an3yDMYbaGJ2xWxsLO0sRjMKy96A
        2pkLletIezeR4cPRY+qUHHMUYYACxtw2MEa+qqknEV5vGkbB/zXrJLB+x/jiYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661853802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Th0mQ/sNN9c18CVRxErzRPXBEZvcyeYzQkxhouGlyc=;
        b=C3ReCx7C6MDZVd65vQy2DaG87J1pVM2D6Je302ILkOPzKilw0k3yrFc3iUYHAF7iR6GhCu
        wLEcLJGk6gxrgSBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Subject: Re: [PATCH v2 11/25] usb: gadget: f_tcm: Execute command on write
 completion
Message-ID: <Yw3gaLk24rPvRsAn@linutronix.de>
References: <cover.1658192351.git.Thinh.Nguyen@synopsys.com>
 <b030d10834c13aa09bbbba7b33b1957d5ba3664c.1658192351.git.Thinh.Nguyen@synopsys.com>
 <YwhvmpdbG8WXhhZ0@linutronix.de>
 <20220826183732.vxogtdlwqiqbcg2t@synopsys.com>
 <Yw0YP1qUYAw6inMJ@linutronix.de>
 <20220829214738.g4sazbxapgmlyksa@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220829214738.g4sazbxapgmlyksa@synopsys.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-29 21:47:41 [+0000], Thinh Nguyen wrote:
> Ok. Maybe we should make a change in the target_execute_cmd() then. It
> seems unreasonable to force the caller to workaround this such as the
> wait+complete construct you did (and I don't recall we have changes in
> place to know/guarantee that interrupts are enabled before executing
> target_execute_cmd() previously either).

Sounds reasonable. Back then I wasn't sure if I'm putting all the puzzle
pieces correctly together so I preferred this over a target change I
wasn't sure was really needed. Anyway.

> For the dwc3, we masked the interrupt at this point, so interrupt won't
> be asserted here.

dwc3 has a irqrestore() after calling the routine so that will avoid the
splat. But lockdep should yell here.
Anyway, other interrupts on that CPU (timer for instance) could trigger.

> Thanks,
> Thinh

Sebastian
