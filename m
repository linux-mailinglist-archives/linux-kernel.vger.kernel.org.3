Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C84157ADFA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiGTCbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbiGTCbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:31:18 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F64A6B263;
        Tue, 19 Jul 2022 19:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F9mpT8DMLfO/uuWLWsq8oxjm0eYtuiz1X0UBRp45R60=; b=IEKuBbrUyiXiCem/L6gkoJaFJa
        yi4Bb/2KxC9R1/Fe1HvQDp0TA5srr/T3EaBtr5Iqeo1Q6aXrZznbOjY7gjULoUjrAVZpDYuB5VNoi
        JhS7PQDT+Tfbdle6qLm59bMqsT6PGcPKssfze4mQpmB0MOTwM4e4EljSE7M8cXNL/kqXbfocXLvsl
        iLKd6cfJGdz/VlNTmduuD9fYXBKg1IhL9u4lvxTO0scILG3CDecLoBw5/33rE1E3iBGngtCy7LSnj
        m40KxD+la5hiQcgtpDNUmwvmaXOq4/PYUMP1V1TFI3jCFjGMwftP12sOtx8et/YJJbWzNUcIjlX2r
        1wDvQIiQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oDzUU-00DxIF-Om;
        Wed, 20 Jul 2022 02:31:10 +0000
Date:   Wed, 20 Jul 2022 03:31:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Helge Deller <deller@gmx.de>
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: Re: WARNING: CPU: 1 PID: 14735 at fs/dcache.c:365
 dentry_free+0x100/0x128
Message-ID: <Ytdo7pNf5W4VMr2H@ZenIV>
References: <20220709090756.2384-1-hdanton@sina.com>
 <20220715133300.1297-1-hdanton@sina.com>
 <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cff76e00-3561-4069-f5c7-26d3de4da3c4@gmx.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 07:27:30AM +0200, Helge Deller wrote:
> [108564.845444] dentry = 000000031624e6c0

*blink*
Is that really a plausible address of a kernel object on
parisc?  Or is that "mangle pointers for security fetish^W
purposes, lest somebody manages to get a useful information
out of dmesg" in action?

> [108564.889437] spin_is_locked(&dentry->d_lock) = 0
> [108564.945436] dname_external(dentry) = 0
> [108564.993436] dentry->d_flags & DCACHE_NORCU = 0
> [108565.045446] dentry->d_name.len = 3
> [108565.089435] dentry->d_name.hash = 89116695
> [108565.137435] dentry->d_lockref.count = -128
> [108565.189434] dentry->d_flags = 32776

0x8008, i.e. DCACHE_OP_DELETE | DCACHE_DENTRY_KILLED.  No
DCACHE_PAR_LOOKUP in sight...

> [108569.801407] dentry = 000000016d7d0000
> [108569.845407] spin_is_locked(&dentry->d_lock) = 0
> [108569.901422] dname_external(dentry) = 0
> [108569.949405] dentry->d_flags & DCACHE_NORCU = 0
> [108570.001405] dentry->d_name.len = 10
> [108570.045421] dentry->d_name.hash = e6582e53
> [108570.093476] dentry->d_lockref.count = -128
> [108570.145404] dentry->d_flags = 32776
> [108570.189420] dentry->d_inode = 0000000000000000
> [108570.241404] dentry->d_parent = 00000002332c2780
> [108570.297403] dentry->d_u.d_rcu = 0x416be770

Ditto.  Pointers look really weird...
