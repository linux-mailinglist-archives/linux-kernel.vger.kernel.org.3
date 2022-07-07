Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFD156A7B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiGGQLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiGGQL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:11:26 -0400
X-Greylist: delayed 215 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 09:10:18 PDT
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154345A2FA;
        Thu,  7 Jul 2022 09:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657210195; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=CObAYOgV35zS3R3raTi9n7O2w4JBuhywsZufHhPEXbI/jSD4RTAuLy+/Vfl5GRP0q1ytOpwkkOEmjbry4VW07WXY12fxsv7DVWUpgtLxDe/yDg6ep0bHwS15+xHzrVHpGorg1j1/nidh8xxbkDYkizeAVockPjYICOGPyBDmfXs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1657210195; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/gSZARatcisMo59OnwdFpAj4ZMFOcjkUzgk7epbNE2I=; 
        b=YEQfHYVWOE8HiZJ5VL/3uz12OOaJbTbnjOcwoalVovhSVT01lQypYcoGuh6Qbd/Yd5EqHOUNtXmY9fyZhBi/JYveo1m0mTQIQhWv+rHsrqoFi59PrlhgbHnOgDsFQlqOQjQ40t5vqEa17+Hb9g+NlwwxlHNhFNIjbK1f20LwctU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657210195;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=/gSZARatcisMo59OnwdFpAj4ZMFOcjkUzgk7epbNE2I=;
        b=TauEg0PanYubxQhxt4GXU5UYGMq+WoavDW/9QtyYudro4Px0WKAC5LYy+QetPazG
        pf+G7dybsIfARRSzh4+D5F49N3aJv0bTvoh7TSMdV5fYWHDXMapIuUKbM3JiQB/Acqf
        +BBEJP+erB7b25gSfUHcW7SjP2Q14r0MRhR3Vso0=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1657210184231166.44837593893465; Thu, 7 Jul 2022 21:39:44 +0530 (IST)
Date:   Thu, 07 Jul 2022 21:39:44 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "syzbot" <syzbot+fe013f55a2814a9e8cfd@syzkaller.appspotmail.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-mtd" <linux-mtd@lists.infradead.org>,
        "linux-next" <linux-next@vger.kernel.org>,
        "miquel.raynal" <miquel.raynal@bootlin.com>,
        "richard" <richard@nod.at>, "sfr" <sfr@canb.auug.org.au>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>,
        "vigneshr" <vigneshr@ti.com>
Message-ID: <181d96ca20b.6fc4a90525206.7370482761379113134@siddh.me>
In-Reply-To: <0000000000005fcfa605e339458c@google.com>
References: <0000000000005fcfa605e339458c@google.com>
Subject: Re: [syzbot] linux-next boot error: general protection fault in
 add_mtd_device
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SCC_BODY_URI_ONLY,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
