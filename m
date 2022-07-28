Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7189B583820
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 07:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiG1FZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 01:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiG1FZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 01:25:37 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436DD4C612
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 22:25:34 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1oGw1L-0003jm-L2; Thu, 28 Jul 2022 07:25:15 +0200
Date:   Thu, 28 Jul 2022 07:25:15 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: r8188eu: get da from ieee80211_mgmt
Message-ID: <20220728052515.tmzztbha2ckwusd2@viti.kaiser.cx>
References: <20220724153917.138848-1-martin@kaiser.cx>
 <20220724153917.138848-2-martin@kaiser.cx>
 <YuDeo4qHOqDkdZy9@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuDeo4qHOqDkdZy9@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Greg Kroah-Hartman (gregkh@linuxfoundation.org):

> On Sun, Jul 24, 2022 at 05:39:13PM +0200, Martin Kaiser wrote:
> > Define a struct ieee80211_mgmt in the OnAssocRsp function. Read the
> > destination address (da) from this struct.

> This explains (sortta) what this patch does, but not why you are doing
> this.

There's a bunch of macros and functions in the r8188eu driver to parse
standard messages. I'm trying to replace these driver-specific versions
with the generic ones that are shared between several drivers.

This patch removs one get_da call. It's not much but hopefully, we can
eventually remove get_da itself.

I know that we should leave the parsing of messages to mac80211 and get
rid of OnAssocRsp etc. Until we're at this point, I hope that doing the
parsing ourselves and using the generic helpers is a useful intermediate
step.

Would it make sense to rewrite the patch description or to summarize the
patches in this series to something like "read some response message
fields from struct ieee80211_mgmt"?

Thanks,
Martin

> To me this looks like a step backwards, why is this change needed at
> all?

> thanks,

> greg k-h
