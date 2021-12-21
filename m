Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD2E47BE28
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhLUKcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:32:14 -0500
Received: from bosmailout07.eigbox.net ([66.96.185.7]:56987 "EHLO
        bosmailout07.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhLUKcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:32:13 -0500
X-Greylist: delayed 1910 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Dec 2021 05:32:12 EST
Received: from bosmailscan06.eigbox.net ([10.20.15.6])
        by bosmailout07.eigbox.net with esmtp (Exim)
        id 1mzbwT-0005Kn-Kl; Tue, 21 Dec 2021 05:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ewhac.org;
         s=dkim; h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QmIfXa1NBe8IJtHxid2eGpNQ6Y3+/izj4TL3vJvfmsw=; b=1Le0rbkkmya3wAd04OmIRUoA0N
        B3vP824S9Ov7KtRWs2wq2OFijy2h0OGZumO4ysYAjID5Mi1HX2805H2HORivpJ9N70xDL1SY9wmoe
        boOlzicxpXSSDbCFMxcMehgENLLUKJo+fhmyHy47gRr/2yV/QvoPY5WdI52KpjY5CBgjYHKbAuz6P
        +KwWGTi8VyOSi9xlhk9fCA9S68+60/8jr4Fg34AeUlZ1XslDz72c4RjCKeYdmzdUYzCcMqLnTRkzn
        3Z1NKYgveRqWEG5OZ7aEyqtAlIwU4hT2h/GSSmriFfxtrgAsj4xVjOsiz/sNneq0jW+OGiv4oRstJ
        ly7e4fow==;
Received: from [10.115.3.32] (helo=bosimpout12)
        by bosmailscan06.eigbox.net with esmtp (Exim)
        id 1mzbwT-0004Io-Cc; Tue, 21 Dec 2021 05:00:21 -0500
Received: from bosauthsmtp10.yourhostingaccount.com ([10.20.18.10])
        by bosimpout12 with 
        id Yy0J260030D2CUy01y0Mzb; Tue, 21 Dec 2021 05:00:21 -0500
X-Authority-Analysis: v=2.3 cv=d4VuNSrE c=1 sm=1 tr=0
 a=Kpo39fPXdbgqDwiI3/AEUA==:117 a=lOZ7gjDonWBvovu+dU3iMA==:17
 a=kj9zAlcOel0A:10 a=IOMw9HtfNCkA:10 a=ltsmEuTAGloA:10 a=fmD_JHji_u0A:10
 a=1-s5akKHueuDfA8f6AsA:9 a=CjuIK1q_8ugA:10 a=Ixuhb_GfD2BeaOSowo0a:22
 a=HH7FIXwXL_sUf1zzYxQd:22
Received: from [135.180.175.56] (port=64548 helo=walkies.ewhac.org)
        by bosauthsmtp10.eigbox.net with esmtpa (Exim)
        id 1mzbwQ-0006eH-3n; Tue, 21 Dec 2021 05:00:18 -0500
Received: from ewhac by walkies.ewhac.org with local (Exim 4.95)
        (envelope-from <ewhac@ewhac.org>)
        id 1mzbwP-002hI5-1b;
        Tue, 21 Dec 2021 02:00:17 -0800
Date:   Tue, 21 Dec 2021 02:00:17 -0800
From:   "Leo L. Schwab" <ewhac@ewhac.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: spaceball - fix parsing of movement data packets
Message-ID: <YcGlsVKeJi7E0dWj@ewhac.org>
References: <20210727040625.2159196-1-ewhac@ewhac.org>
 <YcBF6bnRjYRMp2Cq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcBF6bnRjYRMp2Cq@google.com>
X-EN-UserInfo: a76222b247b80e113a63936ffdc903eb:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: ewhac@ewhac.org
Sender:  "Leo L. Schwab" <ewhac@ewhac.org>
X-EN-OrigIP: 135.180.175.56
X-EN-OrigHost: unknown
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:59:21AM -0800, Dmitry Torokhov wrote:
> Could we write
> 
> 			for (i == 0; i < ARRAY_SIZE(spaceball_axes); i++)
> 				input_report_abs(dev, spaceball_axes[i],
> 					(__s16)(get_unaligned_be16(&data[i * 2]);
> 
> instead?
>
	It's not as readable, but sure, I could do that.

> 			for (i == 0; i < ARRAY_SIZE(spaceball_axes); i++)
  			       ^^
	Pretty sure you didn't mean that :-).

> 				input_report_abs(dev, spaceball_axes[i],
> 					(__s16)(get_unaligned_be16(&data[i * 2]);
  					                                ^^^^^^^
	I'm new here, but it seems odd that an array index (shift plus add
to the base pointer) is preferred over a direct pointer reference.

> 					(__s16)(get_unaligned_be16(&data[i * 2]);
  					        ^^^^^^^^^^^^^^^^^^
	Ooo!  Didn't know about this; thank you!

					Schwab
