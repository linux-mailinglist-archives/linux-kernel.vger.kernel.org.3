Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4976F588620
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 05:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbiHCD7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 23:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHCD7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 23:59:31 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DB729C9E;
        Tue,  2 Aug 2022 20:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659499130; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=SxluoMGqshcewBNXgbTBE+Wj78bg7jVL4wk9wYS/+08/F6J/6txR07qNAGNIAkJUmP0B+xpBOcbYO/dvN00G32dd4TJac3RI79ql+ox7lP6Vw4jPvKTjrHQ90wjOIavjLf1DKSNv+OxH6VULKL4ySPilhEUZYYm9qI3b+Nvul6o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659499130; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=EOCqi05TVQ1bxrfwzBcSMdn9OtCKKp7BF1VgC9KoHcQ=; 
        b=BUBYkVsY2M1EuLEY0lBl3Ma2TxCkL8iC+J4wVims7qhcPkgGGk7S9aZ7FpttsP/ztv2GHDIQDC2vz3rbMkIX3Pb5676XxQ1Sv1KQAwDN3Mdi483qXMka6xwfi7v8O4bvU/NjZin6OCqgfgztbR5CK55MQgCgWM7O85zd5/I5TJY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659499130;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=EOCqi05TVQ1bxrfwzBcSMdn9OtCKKp7BF1VgC9KoHcQ=;
        b=JHDi2gpAYfI2FcQtzPlchMdta80W2hcoLI3WAPhl+fTo7ZGiYWmQqkwJmsf7s49B
        NPZzITdqwH53t+h7I9+8oejJCNQyGfHdbonem+ud2KCXEQEtkUmZDIswJVGPQaxUTnG
        omdzGVvy8+5GQLajrybLuisF3f3g6qN29O+z8ero=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659499118244159.0457474938786; Wed, 3 Aug 2022 09:28:38 +0530 (IST)
Date:   Wed, 03 Aug 2022 09:28:38 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Eric Biggers" <ebiggers@kernel.org>
Cc:     "Dipanjan Das" <mail.dipanjan.das@gmail.com>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "David Howells" <dhowells@redhat.com>,
        "Eric Dumazet" <edumazet@google.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Message-ID: <18261dafe82.76905409402903.8534116548428194689@siddh.me>
In-Reply-To: <YunMXRhAM5g3tNnJ@sol.localdomain>
References: <20220728155121.12145-1-code@siddh.me>
 <18258c1d370.6c4bec7a269297.4170944235031209431@siddh.me>
 <Yuepw21SyLbWt9F+@kroah.com>
 <182597c78f6.70a93066293735.4741894763116073008@siddh.me>
 <182597eccd3.14cac6a4293987.1730526835854998440@siddh.me>
 <20220801161642.GA1932489@berlinger>
 <1825abd83c7.2fc2819e194605.6286442523651645797@siddh.me> <YunMXRhAM5g3tNnJ@sol.localdomain>
Subject: Re: [PATCH v3] kernel/watch_queue: Make pipe NULL while clearing
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

On Wed, 03 Aug 2022 06:46:13 +0530  Eric Biggers <ebiggers@kernel.org> wrote:
> There were several watch_queue fixes that got merged in v5.10.134, so there's no
> point in testing v5.10.131.  If you're still seeing a bug in the *latest*
> 5.10.y, then please check whether it's also present upstream.  If yes, then send
> out a fix for it.  If no, then tell stable@vger.kernel.org what commit(s) need
> to be backported.  Please provide *full* details in each case, including any
> KASAN reports or other information that would help people understand the bug.
> 
> - Eric
> 

Okay, noted.

Thanks,
Siddh
