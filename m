Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD14B4700B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbhLJMfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:35:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37868 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbhLJMe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:34:59 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5DDC5210FE;
        Fri, 10 Dec 2021 12:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639139483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=je+1cmnZgm8XKJ91EI4nD+oZ9pAYy/cntf23eSQrui0=;
        b=hu7iKJPSYmMN5Z8UAsn+5fP/MxLctaIrgtEowPJx7vKLfhF6UhhMKt0xq9nraCLmzpB5+r
        fUoSEcLiR4qmqz56IHf9Ks0BfiDyiRXrIC0sRuujWazkPILIVYgDnbWD+3DEJT7PQUkkvv
        5TKZLvAe7cdkRCl6RRXB7YF8HSok+V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639139483;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=je+1cmnZgm8XKJ91EI4nD+oZ9pAYy/cntf23eSQrui0=;
        b=hzUooKz1cBT1u/19m+5jieL7kUZDjv7bnZm9lI0Lc41hRka+ZARdmmNoMVdW0g2AMuotgJ
        1jeTLkQdIYCemDAg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4B066A3B85;
        Fri, 10 Dec 2021 12:31:23 +0000 (UTC)
Date:   Fri, 10 Dec 2021 13:31:23 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Heiko Carstens <hca@linux.ibm.com>
cc:     Jerome Marchand <jmarchan@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount.pl: look for jgnop instruction as well as
 bcrl on s390
In-Reply-To: <alpine.LSU.2.21.2112101310080.5704@pobox.suse.cz>
Message-ID: <alpine.LSU.2.21.2112101321010.5704@pobox.suse.cz>
References: <20211210093827.1623286-1-jmarchan@redhat.com> <alpine.LSU.2.21.2112101054070.5704@pobox.suse.cz> <YbMyvJ6gz7LvoXgE@osiris> <alpine.LSU.2.21.2112101310080.5704@pobox.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Otherwise I would be surprised that this would make any difference.
> 
> How come? I mean, s390 does not define HAVE_C_RECORDMCOUNT which implies 
> that recordmcount.pl is used (see scripts/Makefile.build and 
> BUILD_C_RECORDMCOUNT definition in Makefile).

Ah, sorry, that was too quick.

I guess you want to say that recordmcount is not used at all and GCC 
should do it. Because CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT is not set, 
since FTRACE_MCOUNT_USE_CC should be set.

What a maze.

But isn't -mrecord-mcount x86_64-only option?

Miroslav
