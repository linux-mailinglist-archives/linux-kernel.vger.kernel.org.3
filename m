Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683085A9FE8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiIAT0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiIAT0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:26:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07F428716
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bOMIr6g0AdsIjeMY/p/MhqGzXLprGWVwMTwh9NVS/a8=; b=TfFSurf2JxBz34xirgQRXpYcaI
        f6AWqYBFavVSO43blQn6NSrHVRe0qWCAI1vVAiv3sOK/woi0N/gxsPJFEPFQ1Zwzp5tzX6Ld1ONHW
        Djt3YDYZzFDPlMRNK+oS1z0ra2bhPmFGxrQYRAt9icAZQk56sjO75Zr3WMyNl1F3qE4vfx5n0Xf/M
        hBzaUVJS2JCmXXcbiPgP8oNkriP9Q4E686vRiNtMg786UFZAtxF/m8PYeh5t+OEgii0q3Ln4SL+BN
        vUUISkTuqm6b+cTOCUuOs14/3Y4vSCG6+HzSHiozpOSOkes1Mficfj7hHPZLne6nJ7ecJ1u1mKxWv
        5atPp+8g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTpor-006Iaw-6k; Thu, 01 Sep 2022 19:25:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9931F300230;
        Thu,  1 Sep 2022 21:25:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 819872B8D5A28; Thu,  1 Sep 2022 21:25:39 +0200 (CEST)
Date:   Thu, 1 Sep 2022 21:25:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 11/16] objtool: Add --mnop as an option to --mcount
Message-ID: <YxEHM8ZL1XAFsj4H@hirez.programming.kicks-ass.net>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-12-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829055223.24767-12-sv@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:22:18AM +0530, Sathvika Vasireddy wrote:
> Architectures can select HAVE_NOP_MCOUNT if they choose
> to nop out mcount call sites. If that config option is
> selected, then --mnop is passed as an option to objtool,
> along with --mcount.
> 
> Also, make sure that --mnop can be passed as an option
> to objtool only when --mcount is passed.
> 
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>

IIRC you want to nop the things yourself because PLT entries or
something?

Anyway, patch looks fine, even though the Changelog doesn't relaly
justify the change.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
