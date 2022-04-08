Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6140B4F8F6A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiDHHVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiDHHVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:21:24 -0400
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA4226D10B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:19:09 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 7A4A860C9E;
        Fri,  8 Apr 2022 07:19:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id DC18D1C;
        Fri,  8 Apr 2022 07:19:01 +0000 (UTC)
Message-ID: <e1e0a871d1a991980ffc9afe7198775b27833f6d.camel@perches.com>
Subject: Re: [PATCH v2 1/2] staging: rtl8192u: replace ternary statement
 with if and assignment
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Rebecca Mckeever <remckee0@gmail.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Fri, 08 Apr 2022 00:19:01 -0700
In-Reply-To: <20220408063133.GP12805@kadam>
References: <cover.1649378587.git.remckee0@gmail.com>
         <36059ec66a2f3d58a8e339aa4f262772eabd3ef0.1649378587.git.remckee0@gmail.com>
         <alpine.DEB.2.22.394.2204080614400.2199@hadrien>
         <20220408055732.GO3293@kadam>
         <34d0ad73f44ff4990f6bee49105ac49bb55352a5.camel@perches.com>
         <20220408063133.GP12805@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: z9ba1f5jjc67q58cs4yz37pqbsf4e9xk
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: DC18D1C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+QikhRhVzwWv/z8uStoYQzqEakv0U9mx8=
X-HE-Tag: 1649402341-483837
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-08 at 09:31 +0300, Dan Carpenter wrote:
> On Thu, Apr 07, 2022 at 11:14:51PM -0700, Joe Perches wrote:
> > On Fri, 2022-04-08 at 08:57 +0300, Dan Carpenter wrote:
> > > On Fri, Apr 08, 2022 at 06:15:14AM +0200, Julia Lawall wrote:
> > > > On Thu, 7 Apr 2022, Rebecca Mckeever wrote:
> > > > 
> > > > > Replace ternary statement with an if statement followed by an assignment
> > > > > to increase readability and make error handling more obvious.
> > > > > Found with minmax coccinelle script.
> > []
> > > > > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> > []
> > > > > @@ -470,7 +470,9 @@ int ieee80211_wx_get_encode(struct ieee80211_device *ieee,
> > > > >  		return 0;
> > > > >  	}
> > > > >  	len = crypt->ops->get_key(keybuf, SCM_KEY_LEN, NULL, crypt->priv);
> > > > > -	erq->length = (len >= 0 ? len : 0);
> > > > > +	if (len < 0)
> > > > > +		len = 0;
> > > > > +	erq->length = len;
> > > > 
> > > > Maybe you could use max here?
> > > 
> > > Initially Rebecca did use max() but I NAKed it.  It's really not less
> > > readable.  Better to handle the error explicitly.  Keep the error path
> > > indented two tabs.  Separate from the success path.
> > 
> > A comment would be useful as it's not obvious it's an 'error' path.
> > One has to read all 3 get_key functions to determine that.
> > 
> 
> I'm so confused.  Negative error codes are the common case in the
> kernel.  We don't need to comment it.

If it was an error, it would handle it as an error not set
len to 0 and continue. That's why IMO a comment is useful.


