Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C04A58431C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiG1Pa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiG1Pax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:30:53 -0400
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC422BB0F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659022234; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=ZKO3kS9nX3NIiXt/OTnPUDv4Om6OUQ7uQSA069nlffAFhZVKjSFAZLyPWq68AnZ1lepg7GV0/DKovJ1p/rpHT0XXe4R7rQxNoHB+7mFqsAThtVVJ01Kuc2375WCw1S2miUvBlAoMJ54uJQqfo2tVUq+gB9j/1Qa9EsCFhuDqgMI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659022234; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=DolUpRiughPORTgVS7n95UsCu0htJgsF8Zk4DvggZ/k=; 
        b=QOtnrFuQemRSap1Cd9Z8QRqKI7GrIUNizxxMNRrtlGi/HuCBAQR6MaXVdBb1KyuaB23lbHzo2PidaEltuvdwdwdfQG9/huHa+DHVCuNnNHYgkKKNxUChZgZu5ahUWzW4MDWWx665pTBHHlkQrhFvhmQYLh/p6Ine5QeNAZOYKhY=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659022234;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=DolUpRiughPORTgVS7n95UsCu0htJgsF8Zk4DvggZ/k=;
        b=P4lImngD7Mjo6TAxuwVN2oGGEeb+L1b34mUlsZOH5A/vFNhPIQKIUM87fnqULic7
        WTozxvKsw0Qk6t+RFgXCLVy1j4viqqHJS64mnIlaildLIz7DDtSk2MINWpOcOIxA9yd
        INJErl43VNAzK1IAUBPRanUCsBxOt96CHRItv8IM=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659022222821661.393770909466; Thu, 28 Jul 2022 21:00:22 +0530 (IST)
Date:   Thu, 28 Jul 2022 21:00:22 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "syzbot" <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
Cc:     "christophe.jaillet" <christophe.jaillet@wanadoo.fr>,
        "dhowells" <dhowells@redhat.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>
Message-ID: <182456e25c7.cd7fb4c79569.3198675383666226894@siddh.me>
In-Reply-To: <00000000000046e89e05e4851ee1@google.com>
References: <00000000000046e89e05e4851ee1@google.com>
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

#syz test: https://github.com/siddhpant/linux.git post_one_notification

