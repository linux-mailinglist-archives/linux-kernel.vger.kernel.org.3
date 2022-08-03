Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3CF5886BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 07:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiHCFRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 01:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiHCFRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 01:17:45 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2F324F05
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 22:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659503839; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=RBC3pRHI0MjrsrB8TgwOMGMpiewU7OWczMIcuiipqNl7Ea50VikA0Ns3eEHEh9dpzIm+5CcqmPunkQbw0aoaM8l+oRo5ZhqnNtWUeL5msrxfeJJl0Khp28qom3cLq7ovCKWIVo3OFTmMNgBJvC24Oubb6xEUvCpstqL1IfSpiUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659503839; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=jO/j0c/x2ziklorqvuiXwVrts+Hyzi+oFKb2gKuw28A=; 
        b=CBPbB4fttQrAl+NyZY+SIXMhXdpziEaOd6D+IlYTlLvv+Nur4Te5OwEmfgXznT6SOSB8F+aLa8ZtSv1pnwNiHdW8MmvBiIoj7l1+gfP/flODlAwIf++K0TltY1mo6sc8iunndrYKWGva3NyNHeyYS0iIIdU7U1s5wR+xIPPx8go=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659503839;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=jO/j0c/x2ziklorqvuiXwVrts+Hyzi+oFKb2gKuw28A=;
        b=XwGtJCcQbrX97SfImB0516xCFGD9/FLvo89hmsyuHU0FTIuqxYkM45vFlQh4MgIr
        Vj8m7YXkb5k14PuV8aOVdLsKTMDEFjSi6lHSwJReRglol8Inl187pD5ndT+b6OnJTKC
        rviF1JeaCcNUvC5VHA6byshq3dChOYP+HsF9FNQg=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659503827052261.33404840524383; Wed, 3 Aug 2022 10:47:07 +0530 (IST)
Date:   Wed, 03 Aug 2022 10:47:07 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Eric Biggers" <ebiggers@kernel.org>
Cc:     "syzbot" <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        "hdanton" <hdanton@sina.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>
Message-ID: <1826222d84f.7e796357131272.8568477361906857088@siddh.me>
In-Reply-To: <Yun0/rDv4ptBl65S@sol.localdomain>
References: <20220801103533.972-1-hdanton@sina.com>
 <000000000000c7a83905e52bd127@google.com>
 <Yumkx4Nc5ZyPGYMz@sol.localdomain>
 <18261e01068.4a2910f2403165.1226720997594524412@siddh.me> <Yun0/rDv4ptBl65S@sol.localdomain>
Subject: Re: [syzbot] KASAN: use-after-free Read in post_one_notification
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

On Wed, 03 Aug 2022 09:39:34 +0530  Eric Biggers <ebiggers@kernel.org> wrote:
 > I don't think that's true; the pointer doesn't get dereferenced after
 > watch_queue::defunct is set.  See my message on the other thread where I
 > explained this: https://lore.kernel.org/lkml/YunKlJCDlmyn2hJ4@sol.localdomain
 > 
 > Of course, if you actually have a reproducer, or a KASAN report, or anything at
 > all that shows there is still a problem, then please post it.
 > 
 > - Eric

Replying to the other thread.

Thanks,
Siddh
