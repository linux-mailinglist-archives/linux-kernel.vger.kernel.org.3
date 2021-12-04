Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1D1468310
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 08:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343993AbhLDHJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 02:09:08 -0500
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:41772 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243085AbhLDHJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 02:09:07 -0500
Received: from omf09.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9057818224D70;
        Sat,  4 Dec 2021 07:05:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 0CAE82002C;
        Sat,  4 Dec 2021 07:05:37 +0000 (UTC)
Message-ID: <06f74e760966a090027bcfec8c22e97bc040e933.camel@perches.com>
Subject: Re: [PATCH] xen-blkfront: Use the bitmap API when applicable
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, sstabellini@kernel.org,
        roger.pau@citrix.com, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Fri, 03 Dec 2021 23:05:37 -0800
In-Reply-To: <f9a5bc6c-347b-8243-2784-04199ef879c2@wanadoo.fr>
References: <1c73cf8eaff02ea19439ec676c063e592d273cfe.1638392965.git.christophe.jaillet@wanadoo.fr>
         <c529a221-f444-ad26-11ff-f693401c9429@suse.com>
         <d8f87c17-75d1-2e6b-65e1-23adc75bb515@wanadoo.fr>
         <6fcddba84070c021eb92aa9a5ff15fb2a47e9acb.camel@perches.com>
         <3d71577f-dabe-6e1a-4b03-2a44f304b702@wanadoo.fr>
         <863f2cddacac590d581cda09d548ee0a652df8a1.camel@perches.com>
         <1e9291c6-48bb-88e5-37dc-f604cfa4c4db@wanadoo.fr>
         <a6dd44e2-6ea6-d085-0131-1e9bac49461a@oracle.com>
         <f9a5bc6c-347b-8243-2784-04199ef879c2@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.23
X-Stat-Signature: kghtzb7181hs7t5uegz983zku95oz1k9
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 0CAE82002C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18WQvFgT880/VPxHgQ21iyOmrOfGf3TeLs=
X-HE-Tag: 1638601537-186527
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-12-04 at 07:57 +0100, Christophe JAILLET wrote:
> So, maybe adding an "official" 'bitmap_size()' (which is already 
> existing and duplicated in a few places) would ease things.
> 
> It would replace the 'nr_minors = BITS_TO_LONGS(end) * BITS_PER_LONG;' 
> and hide the implementation details of the bitmap API.
> 
> Something like:
> static __always_inline size_t bitmap_size(unsigned long nr_bits)
> {
> 	return BITS_TO_LONGS(nr_bits) * sizeof(long);
> }

Or maybe a bitmap_realloc

