Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CD84CD61F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbiCDOQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiCDOQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:16:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F692DD9;
        Fri,  4 Mar 2022 06:15:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D07A1B829B6;
        Fri,  4 Mar 2022 14:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E4BC340E9;
        Fri,  4 Mar 2022 14:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646403341;
        bh=F/2k6eMz7hjrqupMnq2HXK2Ni/do4IC0NA+XuZbZvas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmypJgGCGUl/emlFcDJzUGubEK7b7oBjFc1mRmB+l2cd2gwMSLzGA25gj/Zd6DGTL
         wzblPBFeJvUmAVRN5F605CDamY//QnfktqAH1KfD7s+P2845ZGMVOVR6TkhwerHWOa
         4v2FH5BUBDQvzZJxhasUstxhoAxkZXxKaS9UoCYk=
Date:   Fri, 4 Mar 2022 15:15:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock at reboot?
Message-ID: <YiIfCDjOIBoM+KlB@kroah.com>
References: <20220304104942.lypg3wvlgk2ywi2t@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304104942.lypg3wvlgk2ywi2t@houat>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 11:49:42AM +0100, Maxime Ripard wrote:
> Hi,
> 
> I'm not entirely sure who I'm supposed to send this to, so apologies if
> I forgot somebody.
> 
> I've had an issue when rebooting on and off for a couple of monthes, but
> I got a stacktrace from lockdep today:
> 
> [71721.872904] reboot: Restarting system
> [71721.876743] ------------[ cut here ]------------
> [71721.877081]
> [71721.877084] ======================================================
> [71721.877086] WARNING: possible circular locking dependency detected
> [71721.877088] 5.17.0-rc6-next-20220303-v8+ #10 Not tainted

This is linux-next, does this also happen on Linus's tree?

If not, can you bisect to find the offending commit?

thanks,

greg k-h
