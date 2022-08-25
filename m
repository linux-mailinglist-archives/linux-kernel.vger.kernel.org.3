Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D08C5A0874
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiHYFdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiHYFdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:33:03 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCF4C7822B;
        Wed, 24 Aug 2022 22:33:02 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.ssi.bg (Proxmox) with ESMTP id 7320528778;
        Thu, 25 Aug 2022 08:33:00 +0300 (EEST)
Received: from ink.ssi.bg (unknown [193.238.174.40])
        by mg.ssi.bg (Proxmox) with ESMTP id 525492888D;
        Thu, 25 Aug 2022 08:32:59 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id EBB493C07D1;
        Thu, 25 Aug 2022 08:32:52 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 27P5WpCj010719;
        Thu, 25 Aug 2022 08:32:52 +0300
Date:   Thu, 25 Aug 2022 08:32:51 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     "longguang.yue" <bigclouds@163.com>
cc:     horms@verge.net.au, kadlec@netfilter.org, fw@strlen.de,
        pablo@netfilter.org, lvs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] ipvs: add a sysctl switch to control ipvs to bypass
 OUTPUT chain or not
In-Reply-To: <31196e83.2cbe.182d3693f03.Coremail.bigclouds@163.com>
Message-ID: <e1adaaad-49f-de31-1dff-183eee242dc@ssi.bg>
References: <20220819100702.14889-1-bigclouds@163.com> <495ceee5-f8dc-06e-d1ef-258d1889c7b8@ssi.bg> <31196e83.2cbe.182d3693f03.Coremail.bigclouds@163.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811672-110765213-1661405572=:5176"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811672-110765213-1661405572=:5176
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


	Hello,

On Thu, 25 Aug 2022, longguang.yue wrote:

> I see. 
> I hope we could find a maintainable and decoupled way to keep ipvs high performance.
> especially for kubernetes environment, there are from dozens up to one hundred rules in OUTPUT chain.

	May be some rules can help the bunch of rules to
be applied only for first packet, not for every packet in
connection, such as:

iptables -t filter -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t filter -A OUTPUT -m ipvs --ipvs -j ACCEPT

Regards

--
Julian Anastasov <ja@ssi.bg>
---1463811672-110765213-1661405572=:5176--

