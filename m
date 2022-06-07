Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC5E53FFE3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244593AbiFGNWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244565AbiFGNWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:22:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640E4DF28;
        Tue,  7 Jun 2022 06:22:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 031E961444;
        Tue,  7 Jun 2022 13:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B8CC385A5;
        Tue,  7 Jun 2022 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654608142;
        bh=mvnWMGO6RzBqXBpcRpSUzaGVzTY06v4HmkJIpzzdts0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEJrslirgPy//LpTyZb1J6N1eFFJueSe5uJ3DdSl0jifuADTc0Qv3tLESMYCTW7DL
         KJSXqUwmbHorFW2mNZOinb9De5jWgTZQn9Aj0mtBmBR4549c+yOL4oI0tl8akL9KBc
         Sa4INIEfpPIuc1rRykdZZlLLnYATa1+UgITrXFvA=
Date:   Tue, 7 Jun 2022 15:22:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        dianders@chromium.org, mka@chromium.org, swboyd@chromium.org
Subject: Re: [V4] serial: core: Do stop_rx in suspend path for console if
 console_suspend is disabled
Message-ID: <Yp9RCelSM9L+hpAV@kroah.com>
References: <1652692810-31148-1-git-send-email-quic_vnivarth@quicinc.com>
 <CGME20220523213246eucas1p2d0da08d931a996cd3410eda1c2fd48c0@eucas1p2.samsung.com>
 <bf7eec57-6ad6-2c1a-ea61-0e1d06fc77f5@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf7eec57-6ad6-2c1a-ea61-0e1d06fc77f5@samsung.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:32:46PM +0200, Marek Szyprowski wrote:
> Hi,
> 
> On 16.05.2022 11:20, Vijaya Krishna Nivarthi wrote:
> > For the case of console_suspend disabled, if back to back suspend/resume
> > test is executed, at the end of test, sometimes console would appear to
> > be frozen not responding to input. This would happen because, during
> > resume, rx transactions can come in before system is ready, malfunction
> > of rx happens in turn resulting in console appearing to be stuck.
> >
> > Do a stop_rx in suspend sequence to prevent this.
> >
> > Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> > ---
> > v4: moved the change to serial core to apply for all drivers
> > v3: swapped the order of conditions to be more human readable
> > v2: restricted patch to contain only stop_rx in suspend sequence
> > v1: intial patch contained 2 additional unrelated changes in vicinity
> > ---
> 
> This patch landed recently in linux-next as commit c9d2325cdb92 
> ("serial: core: Do stop_rx in suspend path for console if 
> console_suspend is disabled").
> 
> Unfortunately it breaks console operation on my test systems after 
> system suspend/resume cycle if 'no_console_suspend' kernel parameter is 
> present. System properly resumes from suspend, the console displays all 
> the messages and even command line prompt, but then doesn't react on any 
> input. If I remove the 'no_console_suspend' parameter, the console is 
> again operational after system suspend/resume cycle. Before this patch 
> it worked fine regardless the 'no_console_suspend' parameter.

Did this ever get resolved or do I need to revert this?

thanks,

greg k-h
