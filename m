Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459AE582882
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiG0OYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiG0OYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:24:05 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB2A24BC8;
        Wed, 27 Jul 2022 07:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658931818; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Gn6024WfIqYtxX409/CLXpvCxOVLgbqFJ6qEMea3xTxlY7nwj/9Q9JJrsB0EcxnhgVOQzVC2p8IygGnoZA8HmOcnHuzSa6a9EwwwNIeSSujseaj493ETZ119KI6D0Uk7yMtBbT2gqPq4Lqz6xFC4BCkw8S8gBeapv+Dbhm5+Umk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658931818; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vJz648pDJtTE6Zea5RSkp7IQnH9AlpVg9o0A4CGYeA0=; 
        b=ciEOj1Fr/2J5wyyAk/UMgLQIynSBGzd3zTddvhElc65sGCBvN4h27IKVqUdaRYy1HNyOImWTt29vbF16MLl8c/D3NLEz135bscA/ilTkCy/rvo0A4Jt/KYx94vz/ZJ6AdE0cGOpp6lgqhSObUR175oHzI2WgUB4AtuK8Gi4Isk0=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658931818;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=vJz648pDJtTE6Zea5RSkp7IQnH9AlpVg9o0A4CGYeA0=;
        b=ZQCB67Mu/wHCWnMIR0ae4dmc5rffor0LThYV+OyZtrTDNBN50Kq9kHAK56CX6U68
        cSptNF2hfrpmvhv1IkhduRq6lnqBT5Vz0L825c0y/faH3LGS17I5CE6OYFLfxBCGJ3E
        58kQiv9Bfw9A1RUBTAQAnu+d/6FjeJ/IToUDWh4g=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1658931806891187.92810589018586; Wed, 27 Jul 2022 19:53:26 +0530 (IST)
Date:   Wed, 27 Jul 2022 19:53:26 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "David Howells" <dhowells@redhat.com>
Cc:     "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
Message-ID: <182400a8296.20631a172223.5777840252698367587@siddh.me>
In-Reply-To: <3473429.1658931342@warthog.procyon.org.uk>
References: <20220723135447.199557-1-code@siddh.me> <3473429.1658931342@warthog.procyon.org.uk>
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 19:45:42 +0530  David Howells <dhowells@redhat.com> wrote:
> Siddh Raman Pant <code@siddh.me> wrote:
> 
> > +++ b/kernel/watch_queue.c
> > ...
> >+#ifdef CONFIG_WATCH_QUEUE
> 
> But it says:
> 
> obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
> 
> in the Makefile.
> 
> David
> 
> 

Yes, that's what I realised and meant in reply to Khalid.

I had sent a v2, which you can find here:
https://lore.kernel.org/linux-kernel/20220724040240.7842-1-code@siddh.me/

Thanks,
Siddh
