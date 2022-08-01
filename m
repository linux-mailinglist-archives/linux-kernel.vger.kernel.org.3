Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92ABC58669D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiHAIyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiHAIyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:54:04 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8FE3AE60;
        Mon,  1 Aug 2022 01:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659344010; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=M0r0JCXgGx9pjQ/ydIjoSm+85Ug+MekmokoXdbPUmjwzAaZCuhBHOvH/y1PbTP4y47VYZICgIihZU/TXeSGmhjiPQYCnOwvjqFCKMurktVsbeJ6bD1GVr2P1VeHY6xeFxLksz6hQ9/c5g1V2H5FolCJeFj90C+zV43LcOvMQfHA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659344010; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9KIdphyCYOH/4OA0LAvAgOPow7h5ET3rK7jn+N74c4E=; 
        b=B4XOwHd4TerCqbXXjmKDYUCdC0TYlzBLpxCrl9PRCDy2n++lxb7/7PUBi2B2te2AEsfMCEzdj+0XeGz5DguoriRMOIYLBa5ty56cHV0u4R0oydM40nezBliRnaYeQt8hUkI1i4YheG9FTgz860fL1EhzuXpsPNNw/BoAtOVQLUs=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659344010;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=9KIdphyCYOH/4OA0LAvAgOPow7h5ET3rK7jn+N74c4E=;
        b=HWPQpzixnc+vQQ4haylmY3BafaioQvZvIoH1nf2bIU7rkyKLDyGlAFSNZdVGTBjU
        oJAVJQvrBPHE62jnYyVfyw5qb95aKnrePHhtXFhMYlCIYiSJU9KmVX3MWMsGRKka/OA
        yLoLOK9m6+3Lik5jScYafBn5XPeafkVqgzBTbNwE=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659343997151238.53429778420264; Mon, 1 Aug 2022 14:23:17 +0530 (IST)
Date:   Mon, 01 Aug 2022 14:23:17 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     "Dipanjan Das" <mail.dipanjan.das@gmail.com>,
        "David Howells" <dhowells@redhat.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        "Marius Fleischer" <fleischermarius@googlemail.com>,
        "Priyanka Bose" <its.priyanka.bose@gmail.com>
Message-ID: <182589c08c8.3f58696e264303.1478535037206263797@siddh.me>
In-Reply-To: <YueTG6Nla1pMcW/1@kroah.com>
References: <1822b768504.1d4e377e236061.5518350412857967240@siddh.me>
 <20220723135447.199557-1-code@siddh.me>
 <Ytv/4Tljvlt0PJ2r@kroah.com>
 <3558070.1658933200@warthog.procyon.org.uk>
 <182407602ce.190e58816827.7904364186178466266@siddh.me>
 <20220731181131.GB3569921@berlinger>
 <1825594fdb6.52eb2a02235647.5426665702277259900@siddh.me> <YueTG6Nla1pMcW/1@kroah.com>
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

On Mon, 01 Aug 2022 14:17:23 +0530  Greg KH <gregkh@linuxfoundation.org> wrote:
> There are no active supported kernels other than the ones listed on
> kernel.org, so 5.8 doesn't make much sense here, only 5.10 and 5.15 and
> 5.18 at the moment.
> 
> thanks,
> 
> greg k-h

Okay, thanks for correcting me.

-- Siddh
