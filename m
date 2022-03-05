Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CEB4CE273
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 04:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiCEDdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 22:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiCEDdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 22:33:49 -0500
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F3B1DB3C6;
        Fri,  4 Mar 2022 19:32:59 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 4EFE32B00158;
        Fri,  4 Mar 2022 22:32:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 04 Mar 2022 22:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=mJWJFr2xwIdcBLgWF
        leFF/ItCGiD5KO4oeAEsg0YmsE=; b=D7dROpaZ9IbFQXnayqKtFMyokt2JpYSXI
        Qx18D70ZW82wYhb+b/ovkqX1k86TG//9znkFpTfqH4waMn2MPBNhFIDYa4hQUdav
        cZXuGuHA/HT/+t9QCCsJZjE4EyP4y2QZxpUqgly1NAfZeL/db/lpqThv3n6mBnj3
        14haI1vN8PtMIHYtINe6C4B9sxakA5n+XtDx0kD1ETXTRfQ5b/0EQuK78ISraSHQ
        TKGGASOEEB9Yk3OBwRpaDoDAPN1lwKx69dTTGc4ZtB9sLQP8V51PCwqY44fo4pYm
        sfhqI7j8i/BPexSZu65cLnFe3VMZMUmkQNvn5MbbTyj16Ubv+tyEg==
X-ME-Sender: <xms:6dkiYlTDdgPqB7hlzkzr4ezW2CLNbqMKooP1De5xeuImvLywzsO-UA>
    <xme:6dkiYuy-dF6NVzLUNybff--ikyfYPQgYwro-JN2dAXCiiKuMT0vYMtUV6XUrCeetb
    aTFCbtqQR47An9tjcc>
X-ME-Received: <xmr:6dkiYq2qLbwBva--Fouzk3nRZPa3f7LisMDwRsP_Y19yPRwb853rkiqr7lt4-pk91k_uxMV1wi7Y0lzQjLNuW3lCkVm30ALNV5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtledgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:6dkiYtCFKMnKgeA7O3Y7eKtXowhGRn1eAixFMO6cY-9hrrW2DJd8zw>
    <xmx:6dkiYuidfQaazp8NBmtZbq1ShOEE0mxW7by5KEeGBdm2YfJRPymxXg>
    <xmx:6dkiYhpIIeK0ELvKPp9ke6j_-6BK_mRLGx-0dVy9vJJg6TkYJ-JQeg>
    <xmx:6dkiYlSmrP5_44RUGz8IgEJYVERsry9x32xffP2qDJs5wLmISLJ5pBq6B_I>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Mar 2022 22:32:54 -0500 (EST)
Date:   Sat, 5 Mar 2022 14:32:53 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Joe Perches <joe@perches.com>
cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Tom Rix <trix@redhat.com>,
        Konrad Wilhelm Kleine <kkleine@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        megaraidlinux.pdl@broadcom.com, scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
In-Reply-To: <451bb2c394b05928c815f1eb349a1281a687a608.camel@perches.com>
Message-ID: <80717e6-16ac-56b2-bf12-683d44f4743d@linux-m68k.org>
References: <20220127151945.1244439-1-trix@redhat.com>  <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>  <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com>  <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>  <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com>
  <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com>  <233660d0-1dee-7d80-1581-2e6845bf7689@linux-m68k.org>  <CABRYuGk+1AGpvfkR7=LTCm+bN4kt55fwQnQXCjidSXWxuMWsiQ@mail.gmail.com>  <95f5be1d-f5f3-478-5ccb-76556a41de78@linux-m68k.org> 
 <CANiq72kOJh_rGg6cT+S833HYqwHnZJzZss8v+kQDcgz_cZUfBQ@mail.gmail.com>  <7368bc3ea6dece01004c3e0c194abb0d26d4932b.camel@perches.com>  <9dc86e74-7741-bb8e-bbad-ae96cebaaebc@redhat.com>  <CANiq72nsKijH4zgLoEpiiq4462r1zYmaiDs13SEHDYR3aQziUw@mail.gmail.com> 
 <ad3567301af7b1b24cf4ac447fec8d618231ea33.camel@perches.com>  <CANiq72kWJtOTmcXNO+t4NY22v6xM49Z-U2aSB4apNd96PYbD4Q@mail.gmail.com> <451bb2c394b05928c815f1eb349a1281a687a608.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022, Joe Perches wrote:

> 
> Is that statement really disputable?
> 

If there was such a thing as an indisputable statement, a set of 
universally accepted style rules would soon follow, I suspect.

...

> 
> There is no "one true editor".
> There will not be "one true source code formatter" either.
> 

It only has to be sufficiently good that it produces a consensus.
