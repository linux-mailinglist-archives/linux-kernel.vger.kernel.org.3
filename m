Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFA45A6391
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiH3MiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiH3MiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:38:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0218EE49E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5325EB81AAC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 12:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AF7C433C1;
        Tue, 30 Aug 2022 12:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661863087;
        bh=dtW/SOjJDW94TxZ8w3wKkSeL8vM5A/imHUXtJMcE4EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IiWOKDYTCI9sr5W1xBV73txNiapKXE0XCTlRiiYT9OXIE1ufXr4+Yi79ZrF/4ZdtZ
         56zb0tYrKJ6IGe0x26UexFlBcCKcHq73poYrUHoRTLXw1e1kbAN34cIh11E1u1t8mr
         dd5J0snlOHxD/82i6IfvAwI1z2iqXBnRvADMLlKM=
Date:   Tue, 30 Aug 2022 14:38:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v4 1/2] tty: n_gsm: replace kicktimer with delayed_work
Message-ID: <Yw4ErPa8lfF49EFd@kroah.com>
References: <20220829131640.69254-1-pchelkin@ispras.ru>
 <20220829131640.69254-2-pchelkin@ispras.ru>
 <46019fb5-dcc1-f0df-4043-e25e6db3c226@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46019fb5-dcc1-f0df-4043-e25e6db3c226@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:30:27AM +0200, Jiri Slaby wrote:
> On 29. 08. 22, 15:16, Fedor Pchelkin wrote:
> > A kick_timer timer_list is replaced with kick_timeout delayed_work to be
> > able to synchronize with mutexes as a prerequisite for the introduction
> > of tx_mutex.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> 
> But I think this conflicts with Tetsuo's cleanup [1]. So one of you will
> likely have to rebase and resubmit.
> 
> [1] https://lore.kernel.org/all/2110618e-57f0-c1ce-b2ad-b6cacef3f60e@I-love.SAKURA.ne.jp/

I've fixed it up by hand now, no worries.

greg k-h
