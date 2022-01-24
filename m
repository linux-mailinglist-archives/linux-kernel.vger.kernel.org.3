Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D791497663
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 01:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbiAXAC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 19:02:59 -0500
Received: from smtp-fw-80006.amazon.com ([99.78.197.217]:32056 "EHLO
        smtp-fw-80006.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiAXAC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 19:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1642982577; x=1674518577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=884EPx7zeLdONILeLA66h3ygMwUbXySanvZ39llmgO4=;
  b=TOD+OLNeYlk0ouJ1ouncPyWLDPG4rL+Yl8fd+NymAviHihc1eCihUUnq
   EmHwJ2alfnmLSRn6V3i2Ax7x1VWQdgCP1EBkmQYAGq7NBZAyLf4Q4ULJA
   rVSoeQjFiJeutXFvoNe/ICejMqjUcn6O4lRWuC6S0EURsTkn1wbvp2Fy4
   E=;
X-IronPort-AV: E=Sophos;i="5.88,311,1635206400"; 
   d="scan'208";a="57429041"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 24 Jan 2022 00:02:57 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com (Postfix) with ESMTPS id EE8794199F;
        Mon, 24 Jan 2022 00:02:56 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 24 Jan 2022 00:02:56 +0000
Received: from 88665a182662.ant.amazon.com (10.43.160.114) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 24 Jan 2022 00:02:53 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     <shorne@gmail.com>
CC:     <benh@amazon.com>, <jonas@southpole.se>, <kuni1840@gmail.com>,
        <kuniyu@amazon.co.jp>, <linux-kernel@vger.kernel.org>,
        <openrisc@lists.librecores.org>,
        <stefan.kristiansson@saunalahti.fi>
Subject: Re: [PATCH] openrisc/boot: Remove unnecessary initialisation in memcpy().
Date:   Mon, 24 Jan 2022 09:02:49 +0900
Message-ID: <20220124000249.4295-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Ye3keps4aHhkbYzr@antec>
References: <Ye3keps4aHhkbYzr@antec>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.114]
X-ClientProxiedBy: EX13D03UWC003.ant.amazon.com (10.43.162.79) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From:   Stafford Horne <shorne@gmail.com>
Date:   Mon, 24 Jan 2022 08:27:54 +0900
> On Sun, Jan 23, 2022 at 11:01:00AM +0900, Kuniyuki Iwashima wrote:
> > 'd' and 's' are initialised later with 'dest_w' and 'src_w', so we need not
> > initialise them before that.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> 
> This looks fine to me.  I will queue this for the next release.

Thank you.


> 
> Just curious why are you working on OpenRISC?

While reading memcpy() variants, I found a nit to fix in x86 boot-time
memcpy() [0].  While I'm at it, I just started reading all arch ones ;)

[0]: https://lore.kernel.org/lkml/20220123015807.45005-1-kuniyu@amazon.co.jp/


> 
> -Stafford
> 
> > ---
> >  arch/openrisc/lib/memcpy.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/openrisc/lib/memcpy.c b/arch/openrisc/lib/memcpy.c
> > index fe2177628..e2af9b510 100644
> > --- a/arch/openrisc/lib/memcpy.c
> > +++ b/arch/openrisc/lib/memcpy.c
> > @@ -101,7 +101,7 @@ void *memcpy(void *dest, __const void *src, __kernel_size_t n)
> >   */
> >  void *memcpy(void *dest, __const void *src, __kernel_size_t n)
> >  {
> > -	unsigned char *d = (unsigned char *)dest, *s = (unsigned char *)src;
> > +	unsigned char *d, *s;
> >  	uint32_t *dest_w = (uint32_t *)dest, *src_w = (uint32_t *)src;
> >  
> >  	/* If both source and dest are word aligned copy words */
> > -- 
> > 2.30.2
