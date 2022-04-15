Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529295025F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350837AbiDOHCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245147AbiDOHB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:01:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28C101EA;
        Thu, 14 Apr 2022 23:59:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29654B82BF0;
        Fri, 15 Apr 2022 06:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17957C385A5;
        Fri, 15 Apr 2022 06:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650005968;
        bh=gjZUSGDTebqm+7kMg8qn41MG0S0apgk+Sr5BdM0f3BM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7mlmLOZVL9wubHJz12vp4Q5rhFTSrmrxTAENiUJ/M95LOskQc3ZxTSAJIUEUWINc
         LXGoGFxiwDj1iuuH2pP0wIehea0dYF1fcMHbCOFCvBIxgUZfneMr33fKPgj8DQjnSW
         5XGTTB4YEZRNgLg/lEpAyfCHQF24VJEC/kq+dlsM=
Date:   Fri, 15 Apr 2022 08:59:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, dianders@chromium.org
Subject: Re: [V3] drivers/tty/serial/qcom-geni-serial: Do stop_rx in suspend
 path for console if console_suspend is disabled
Message-ID: <YlkXzQcqUWoRZCqE@kroah.com>
References: <1649316351-9220-1-git-send-email-quic_vnivarth@quicinc.com>
 <1649316351-9220-2-git-send-email-quic_vnivarth@quicinc.com>
 <0f52c6aa-46be-6971-76df-364150b1c1e1@kernel.org>
 <e42527f9-fa5e-f03d-3af8-fe2c27f9597b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42527f9-fa5e-f03d-3af8-fe2c27f9597b@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 11:45:11AM +0530, Vijaya Krishna Nivarthi wrote:
> 
> On 4/7/2022 1:21 PM, Jiri Slaby wrote:
> > On 07. 04. 22, 9:25, Vijaya Krishna Nivarthi wrote:
> > > For the case of console_suspend disabled, if back to back suspend/resume
> > > test is executed, at the end of test, sometimes console would appear to
> > > be frozen not responding to input. This would happen because, for
> > > console_suspend disabled, suspend/resume routines only turn resources
> > > off/on but don't do a port close/open.
> > > As a result, during resume, some rx transactions come in before
> > > system is
> > > ready, malfunction of rx happens in turn resulting in console appearing
> > > to be stuck.
> > > 
> > > Do a stop_rx in suspend sequence to prevent this. start_rx is already
> > > present in resume sequence as part of call to set_termios which does a
> > > stop_rx/start_rx.
> > 
> > So why is it OK for every other driver? Should uart_suspend_port() be
> > fixed instead?
> 
> For qcom driver we know that set_termios() call in uart_suspend_port() will
> recover with a call to start_rx.
> However that may not be the case with other drivers.
> 
> We can move stop_rx to uart_suspend_port() and additionally have a start_rx
> in uart_resume_port()
> Please let know if such a change would be ok.

This should not be something that each individual driver has to do,
please fix it for everyone.

thanks,

greg k-h
