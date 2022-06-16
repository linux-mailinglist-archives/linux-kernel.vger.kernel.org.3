Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07EF54E2C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377489AbiFPN7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377453AbiFPN6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:58:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45062F657
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C8HUoWbkEZfFi5Ww+b/aIrWTUO0EXGNVkEGEo9LVJjo=; b=nGXEooabTbb0KLw5oHlgpsPeqx
        fPen/6rTxyKZGwJnQ0odoQUTMevOda2oR5cGjcV/WHjZ2cU/vnLk0Pu4ebiiZ0/Ypknuk2hdNVhNt
        igkit05wkwuyzfIBeeldUwXMzhFeoXk+gvHB8+U8bRfoct1HrVD6NsZXWHypy2pT3ShcPi2rKvDFP
        +xaiMXmZLXwOGyuqCH41y1mL7M+6bqy79sCWKcEXWtd04gnqfqu5QiXy2TV2w/F/6yAmVzvJXqml1
        SMjsMCswQo9c2WHhlfjZwM3EC8d0zQ7scoomQ8TU2hFZPpJuXXrmbLvLsEbbV9kmJKzs2Ghnekx2X
        zR+c3IGA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1q0R-008QMy-3Z; Thu, 16 Jun 2022 13:57:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C474F300372;
        Thu, 16 Jun 2022 15:57:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B17BF2029FD42; Thu, 16 Jun 2022 15:57:51 +0200 (CEST)
Date:   Thu, 16 Jun 2022 15:57:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.vnet.ibm.com>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Subject: Re: [RFC PATCH 4/4] objtool/powerpc: Add --mcount specific
 implementation
Message-ID: <Yqs235037JrOOhBA@hirez.programming.kicks-ass.net>
References: <20220523175548.922671-1-sv@linux.ibm.com>
 <20220523175548.922671-5-sv@linux.ibm.com>
 <6be5c941-07b0-64d5-7f36-fe5770fb5244@csgroup.eu>
 <59170f18-1356-1140-70e3-30cb627f00bc@linux.vnet.ibm.com>
 <578ec055-0d63-e579-0caa-ad57846b8995@csgroup.eu>
 <f1decbb7-b441-a241-469a-4ba118e08212@csgroup.eu>
 <c1e2cf35-2a8d-87e6-3a7e-7f144392db23@csgroup.eu>
 <1655386289.uh0k7sgl1r.naveen@linux.ibm.com>
 <30f3791c-0fdd-e635-4a85-ec457f990fae@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30f3791c-0fdd-e635-4a85-ec457f990fae@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 01:40:34PM +0000, Christophe Leroy wrote:
> sizeof(u64) is always 8 by definition.
> 
> So if size is 8 we are working on a binary file for a 64 bits target, if 
> not it means we are working for a 32 bits target.

Cross-builds invalidate this I think. Best to look at something like:

  elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32


