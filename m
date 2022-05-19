Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5268852DA57
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbiESQez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiESQew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:34:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6523C1EC8;
        Thu, 19 May 2022 09:34:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53BCAB82700;
        Thu, 19 May 2022 16:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924CFC385AA;
        Thu, 19 May 2022 16:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652978088;
        bh=G+m4YKjpIXQiJl0YWnr4XztPHSYVuhrZQ2+IlCOStTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2rUy6igUIiE5lvCybCgzhdH6TYEuZX4I4kGEiQPwIaGEPuzwV3bFk1NpVQY1Ez82G
         upYvXneeOLjChKZub9xEIC66PdquN6iDpU1xXfZvHAgQ7/Rk+q7UA8aO7puyPlVq5V
         mMmoTFGLZVq2iJSzNGQEWnU+MgAekBIJTMFRh8kk=
Date:   Thu, 19 May 2022 18:34:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v4 0/3] tty/serial: Process XON/XOFF robustly
Message-ID: <YoZxpHqW+DBsKkcq@kroah.com>
References: <20220426144935.54893-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220426144935.54893-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 05:49:32PM +0300, Ilpo Järvinen wrote:
> For this v4, I dropped Gilles' Tested-by as I made rather major
> modifications to the patch series so I don't want to claim he has
> tested this version (earlier versions are known to fix his problem and
> this one should too).
> 
> XON/XOFF are used for software flow-control on serial lines. XON and
> XOFF appear as characters within the stream but should be processed as
> soon as possible.
> 
> The characters received by the UART drivers are in intermediate buffers
> until TTY receives them. In the case where the TTY is not read from,
> the characters may get stuck into those intermediate buffers until
> user-space reads from the TTY. Among the characters stuck in the
> buffers, can also be those XON/XOFF flow control characters. A stuck
> flow-control character is not very useful.
> 
> This patch series addresses the issue by checking if TTY is slow to
> process characters, that is, eats less than the given amount. If TTY is
> slow, a lookahead is invoked for the characters that remain in the
> intermediate buffer(s).
> 
> Then at a later time, receive_buf needs to ensure the flow-control
> actions are not retaken when those same characters get pushed to TTY.
> 
> This patch series fixes an issue but I'm not able to pinpoint to a
> specific commit id to provide a Fixes tag. The last patch of the series
> is not needed for minimal fix (and has a small chance of regression
> too), thus that patch shouldn't be sent to stable.
> 
> v1 -> v2:
> - Add flow ctrl char funcs in separate change & rework logic a bit.
>   I believe it's now cleaner than it would have been with the
>   suggestions during v1 review, please recheck.
> - Renamed n_tty_lookahead_special to n_tty_lookahead_flow_ctrl
> - Fixed logic for START_CHAR == STOP_CHAR case
> - Use unsigned int for lookahead_count in receive_buf call chain
> - Use consistent types in lookahead call chain
> - Improved indentation & line splits for function params
> - Corrected tty_ldisc.h comments documenting tty_ldisc_ops
> - Tweaked comment format
> 
> v2 -> v3:
> - Split preparatory patch moving/rearranging code to two
> - Fix closing path giving change for ... || xx to execute
>   instead of skipping the flow-control char
> - Use the same flow-control char function on closing path
>   (just a cleanup, non-fix as last patch, a small change of
>   regression exists)
> 
> v3 -> v4:
> - Rework lookahead_count, it is now kept internal to n_tty ldisc rather
>   than passed around through the whole callchain
> - Dropped Gilles' Tested-by due to major changes
> - Improve comments & changelogs
> 
> Ilpo Järvinen (3):
>   tty: Rework receive flow control char logic
>   tty: Implement lookahead to process XON/XOFF timely
>   tty: Use flow-control char function on closing path
> 
>  drivers/tty/n_tty.c        | 107 ++++++++++++++++++++++++++++---------
>  drivers/tty/tty_buffer.c   |  59 ++++++++++++++++----
>  drivers/tty/tty_port.c     |  21 ++++++++
>  include/linux/tty_buffer.h |   1 +
>  include/linux/tty_ldisc.h  |  13 +++++
>  include/linux/tty_port.h   |   2 +
>  6 files changed, 170 insertions(+), 33 deletions(-)
> 
> -- 
> 2.30.2
> 

I took patch 1/3 of this series as it is "obviously correct".  I'd like
others to review the rest before taking them, and I don't have the
bandwidth today to do so, so I'll wait for others before considering
them.

thanks,

greg k-h
