Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8A45AD113
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbiIELDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbiIELDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:03:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E611D38476
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ypM18Z5ljJUiQQttcJrsZfaN7kkbHtJv44yfmv2Mtt0=; b=BENQB3G5Jz7YBveRI3zDczVV82
        5SudM98HuTo1DTgHCf2OgaBQ0F6k4ydXadwlenZMNJmJLXy0DjRF7qcTUQEedmETyKOCr8A14uTsf
        qjJOHFBtcYbvLl0D5b4payMCzWduyM2y+U6ALkF5NaZHnqL7j9Ro99zstihU6o/qxf1L5yc72YJ2a
        WCYPy7oKerwMe8MWbnvgdBGTe7uIq6ym9uJ19wxb3FdUjBDM+i8pL7+Zg8kZG6FiLc2Y+5bsoTtZu
        THYM/VnMhxeBbTGSxsEJBtjEi4e2lbU92fPYZgbnPSg2qC9bjiKB4oUzmKNniMsngLAthH9hSQ0Jq
        it+2RAEQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oV9s4-009Pra-Vc; Mon, 05 Sep 2022 11:02:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D53513002A3;
        Mon,  5 Sep 2022 13:02:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F0BC209EC608; Mon,  5 Sep 2022 13:02:23 +0200 (CEST)
Date:   Mon, 5 Sep 2022 13:02:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 03/16] powerpc: Fix objtool unannotated intra-function
 call warnings
Message-ID: <YxXXP+s7qe6vbWPX@hirez.programming.kicks-ass.net>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-4-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829055223.24767-4-sv@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:22:10AM +0530, Sathvika Vasireddy wrote:

> objtool does not add STT_NOTYPE symbols with size 0 to the

I suspect we can fix that once:

  https://lkml.kernel.org/r/20220902130949.789826745@infradead.org

lands.
