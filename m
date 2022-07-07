Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404C756A764
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiGGQGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiGGQGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:06:45 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1687B2E9CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657209967; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=ajmrtNb+aAAH0PerbDvalHj+zAqt6OQ7qHTE5aoNT180K/9GCYjFuyBT3qNgL3PtlSL5UCnOEWOsnfU5ZgVWFND9BLC/LoZRhe3Spxrx40FmmAxsvNTcUsrUm2B/0onZfcTr84YD7SiPFNYY0Jm/zNEFUR/TxdlOJq/AuKKcYkw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1657209967; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=+eQqgz8qWKtIP9TBIA7Um8SNanpPTx4XyuYdwKxD60M=; 
        b=GIRCrebO+4YsJCYuIrJJKUIEIEYSvfTpg4YdV0O80ZziaijSSrnCiI+hjGm/K2T/l9dEaurcNnTjByBBVCU9AlxGiO2/wKscyANUbFfnGsIFGPMG5GoDh0pwh+Xa2gyBi+Lurgd9IfE+gMYw1DuNCvJlQKILt5R+pkNqKb+jsWw=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657209967;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=+eQqgz8qWKtIP9TBIA7Um8SNanpPTx4XyuYdwKxD60M=;
        b=YlRccmHs/gYXMcKcuHKxkZSL+by/K19C6xMNfjaWGjXVKvU6Kbll84LvysTm40Xf
        F3ZfW1AbhTQjXmF+tehwYTLB+SSijmTR0Indt2zhsvDW0+BwGQ0jAKuysge779WhwEX
        HYvt5LgENVZp4ooMvRucOlJo5maIhlbwesFNZgCM=
Received: from localhost.localdomain (103.249.233.159 [103.249.233.159]) by mx.zoho.in
        with SMTPS id 1657209966196325.0145447766257; Thu, 7 Jul 2022 21:36:06 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     syzbot+fe013f55a2814a9e8cfd@syzkaller.appspotmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-next@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, vigneshr@ti.com
Message-ID: <20220707160545.7731-1-code@siddh.me>
Subject: Re: [syzbot] linux-next boot error: general protection fault in add_mtd_device
Date:   Thu,  7 Jul 2022 21:35:45 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <00000000000040624a05e2a6f2db@google.com>
References: <00000000000040624a05e2a6f2db@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test linux-next master

