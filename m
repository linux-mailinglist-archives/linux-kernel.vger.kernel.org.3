Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54DF565403
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiGDLpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbiGDLpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:45:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E8D11450
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4HrRuXuVA+Twe3QAd56nGmntiiPmbvBTaKZ1l1jeChc=; b=mSbUiv1/DRUA3lQIT0bPc7zWbu
        hYIsn/1ueg4pM4xgnObmk/HNo4XDuGhlHlQoQ3FijYv1D9Wz9sF4JRv8sECoVcNbUoBrI2j5nNB16
        Nhx3So2SdSRT4PWxWEpL2hOZzyZNk22odC2seMX4jYd+jvOgH/c0vjC3LF/dt3DR3Xv/BfU5vsdqn
        TMjFNJjQueSZWfe9JcXAOWc4raiUkoEAM8TaUSzi204T5B/T7Et2DyFHWWuTHxZMZcg2Hs6xGrbWI
        BQDraL1c4hIdfIa2nXqgvznU58iRnhuL+MNmPW8cqFSOa/haIukRZJtioNqImk/hZRwFqOBq+njBw
        4VnrMlyg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8KW5-00HE6L-Ke; Mon, 04 Jul 2022 11:45:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D81D8300362;
        Mon,  4 Jul 2022 13:45:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE0B42028F029; Mon,  4 Jul 2022 13:45:23 +0200 (CEST)
Date:   Mon, 4 Jul 2022 13:45:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Sathvika Vasireddy <sv@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v3 11/12] powerpc: Remove unreachable() from WARN_ON()
Message-ID: <YsLS02T6TAxN/HcL@hirez.programming.kicks-ass.net>
References: <20220624183238.388144-1-sv@linux.ibm.com>
 <20220624183238.388144-12-sv@linux.ibm.com>
 <70b6d08d-aced-7f4e-b958-a3c7ae1a9319@csgroup.eu>
 <92eae2ef-f9b6-019a-5a8e-728cdd9bbbc0@linux.vnet.ibm.com>
 <cce19b1c-449a-f306-533a-9edc855049aa@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce19b1c-449a-f306-533a-9edc855049aa@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 06:30:23PM +0000, Christophe Leroy wrote:


> The problem is that that function has size 0:
> 
> 00000000000003d0 l     F .text	0000000000000000 
> qdisc_root_sleeping_lock.part.0

I'm somewhat confused; how is an empty STT_FUNC a valid construct on
Power?
