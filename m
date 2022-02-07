Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987934AC79E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381909AbiBGRcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356919AbiBGR2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:28:17 -0500
Received: from relay.hostedemail.com (relay.a.hostedemail.com [64.99.140.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A9EC0401D8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 09:28:16 -0800 (PST)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay11.hostedemail.com (Postfix) with ESMTP id E747180E12;
        Mon,  7 Feb 2022 17:28:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id CBDBC20033;
        Mon,  7 Feb 2022 17:28:14 +0000 (UTC)
Message-ID: <355c9305d74c666a976b526f3d80ce208c0ec927.camel@perches.com>
Subject: Re: [PATCH] Staging: wfx: CHECK: usleep_range is preferred over
 udelay
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Leonardo Araujo <leonardo.aa88@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Date:   Mon, 07 Feb 2022 09:28:13 -0800
In-Reply-To: <YgFM1HHs7rSqp/0Q@kroah.com>
References: <20220207160051.27829-1-leonardo.aa88@gmail.com>
         <YgFM1HHs7rSqp/0Q@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CBDBC20033
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: zzama9ow5pq3kkmx1hjco5u56cx8pc77
X-Rspamd-Server: rspamout07
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX195MAd3iiiDNQHmDE4VHCECmci3L2/s1PE=
X-HE-Tag: 1644254894-989860
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-07 at 17:46 +0100, Greg KH wrote:
> On Mon, Feb 07, 2022 at 01:00:51PM -0300, Leonardo Araujo wrote:
> > Fixes the checks reported by checkpatch.pl for usleep_range.
[]
> > diff --git a/drivers/staging/wfx/bh.c b/drivers/staging/wfx/bh.c
[]
> > @@ -312,7 +312,7 @@ void wfx_bh_poll_irq(struct wfx_dev *wdev)
> >  			dev_err(wdev->dev, "time out while polling control register\n");
> >  			return;
> >  		}
> > -		udelay(200);
> > +		usleep_range(200, 200);

range with the same low/high values is pretty useless.

And Leonardo, checkpatch should have warned you about this.
You, as a novice kernel submitter, should always use it on patches
you create before you send them out for review.

> Do you have the hardware to verify that this is the correct fix for
> this?
> 
> You can not just blindly make this type of change here, sorry, otherwise
> we would have done so long ago with a simple search/replace :)

Greg, you keep writing this but treewide search/replace is almost never done.


