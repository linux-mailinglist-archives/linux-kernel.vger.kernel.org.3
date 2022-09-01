Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62BC5A9F86
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiIATCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiIATCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:02:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED46DFA9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zVCtJuwv4BSK05o0Rzcawywp7RFYNazeMbOVnDEO6nk=; b=N2ZDJl7JSaVJjpRkp9/YCd3RWA
        10yUX4CboBDQDKq9YEu5TIQFkRPfDIyhNXCe6nnsR4kuZyztBiT55EnYIpsRaoOUw2+IkHn02VJuk
        8PVR/3ojKpqxi49hRyZQzFTBjTm0Shmhl+e921O8ODZQfzE9Y8c5ydfH3YVFYs/XuEi6TgxlpCeVz
        kRhRaE7vgNSMdMhBIZs2dQ7qFnzjZxmsPwVQgUsrkRyX37Lb3SGysC25n+wxzPaAO6hAm4vqM4VhK
        cC8UuYLLNSFl0etsmZZEQ0SNn79BHHin3Q4bhBFm4xdipEJJxUb3qjGNr0X+4fD8UxRH9svlBexSi
        JGSINe6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTpRh-006He9-Jy; Thu, 01 Sep 2022 19:01:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9DE5A300230;
        Thu,  1 Sep 2022 21:01:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82A2B2B8D5A22; Thu,  1 Sep 2022 21:01:42 +0200 (CEST)
Date:   Thu, 1 Sep 2022 21:01:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>
Subject: Re: [PATCH v2 15/16] objtool/powerpc: Enable objtool to be built on
 ppc
Message-ID: <YxEBlhXRpgR8FSoR@hirez.programming.kicks-ass.net>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-16-sv@linux.ibm.com>
 <2fb92e17-2ad5-9732-560c-a7321e6a2528@csgroup.eu>
 <20220901151117.GE25951@gate.crashing.org>
 <e0540fc2-9d38-2fd9-c8c1-a766dfc577d6@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0540fc2-9d38-2fd9-c8c1-a766dfc577d6@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 04:38:52PM +0000, Christophe Leroy wrote:

> objtool is a userland app, there is no access to kernel headers here.

Please have a look at tools/include/ :-)
