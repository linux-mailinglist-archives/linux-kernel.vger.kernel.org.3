Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B0749A0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848178AbiAXXVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:21:54 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:5910 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1586017AbiAXWZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1643063133; x=1674599133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AKt8vr05GreDSyVNxjtV2CHg4TV7DId+cTaYdsIngFM=;
  b=lFA0ga3fIn0Whf3GjFFAKnlAtWUyCyNOlAUjpA2wXM9iJd5E3L1xEWT4
   R8qYHiefa6bTm2snI/tYDFajLWwdB3hgYeW+JCQK375t2tasL5NSUEQlB
   jbJZxGaWqw+kHHSeZPQ5PmAPMJMYsZs7WY5hZjSt3IMexLpuie7oQ6ZVf
   M=;
X-IronPort-AV: E=Sophos;i="5.88,313,1635206400"; 
   d="scan'208";a="171891279"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-02ee77e7.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 24 Jan 2022 22:15:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-02ee77e7.us-west-2.amazon.com (Postfix) with ESMTPS id E080F41997;
        Mon, 24 Jan 2022 22:15:03 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 24 Jan 2022 22:15:01 +0000
Received: from 88665a182662.ant.amazon.com (10.43.162.8) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 24 Jan 2022 22:14:51 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     <dave.hansen@intel.com>
CC:     <benh@amazon.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <kuni1840@gmail.com>, <kuniyu@amazon.co.jp>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <x86@kernel.org>
Subject: Re: [PATCH] x86/boot: Avoid redundant address overlap tests in memcpy().
Date:   Tue, 25 Jan 2022 07:14:47 +0900
Message-ID: <20220124221447.1030-1-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <bd7c111c-8bd4-9c4d-4715-c0fb5fd034ee@intel.com>
References: <bd7c111c-8bd4-9c4d-4715-c0fb5fd034ee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.8]
X-ClientProxiedBy: EX13D21UWB004.ant.amazon.com (10.43.161.221) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From:   Dave Hansen <dave.hansen@intel.com>
Date:   Mon, 24 Jan 2022 09:38:40 -0800
> On 1/22/22 17:58, Kuniyuki Iwashima wrote:
> > -void *memmove(void *dest, const void *src, size_t n)
> > +void *____memmove(void *dest, const void *src, size_t n)
> >   {
> >   	unsigned char *d = dest;
> >   	const unsigned char *s = src;
> >   
> > -	if (d <= s || d - s >= n)
> > -		return ____memcpy(dest, src, n);
> > -
> >   	while (n-- > 0)
> >   		d[n] = s[n];
> >   
> >   	return dest;
> >   }
> 
> The ___ naming is pretty cruel.  Could we call it memmove_no_overlap() 
> or memmove_unsafe()?  Surely we can put some *useful* bytes in the name 
> rather than padding it out with _'s.  No need to perpetuate the 
> ____memcpy() naming.

Sure.  I will rename it to memmove_unsafe() because it supports another
overlap case. (d > s)


> 
> Also, is this worth the churn?  It probably saves less than 10 
> instructions, all of which are ridiculously cheap.  Is there a *reason* 
> for this other than being a pure cleanup?

This is just for cleanup.
