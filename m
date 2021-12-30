Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670A3481BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbhL3MMj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Dec 2021 07:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhL3MMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:12:38 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F948C061574;
        Thu, 30 Dec 2021 04:12:38 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1n2uIE-0006VY-Cx; Thu, 30 Dec 2021 13:12:26 +0100
Date:   Thu, 30 Dec 2021 13:12:26 +0100
From:   Florian Westphal <fw@strlen.de>
To:     cgel.zte@gmail.com
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux] netfilter: Remove unnecessary ret assignment
Message-ID: <20211230121226.GC21386@breakpoint.cc>
References: <20211230063143.586220-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20211230063143.586220-1-luo.penghao@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com <cgel.zte@gmail.com> wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
> 
> Regardless of whether the subsequent (copy_to_user(user, &info, *len) != 0)
> holds, the value of ret will be assigned a new value.
> 
> The clang_analyzer complains as follows:
> 
> net/ipv6/netfilter/ip6_tables.c:
> 
> Value stored to 'ret' is never read

Please fix this properly:

1. consider adding error unwinding instead.
2. net/ipv4/netfilter/ip_tables.c has same construct
