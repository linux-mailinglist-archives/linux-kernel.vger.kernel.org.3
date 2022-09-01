Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD475A9FD2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiIATWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiIATWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:22:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0872286FEC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vymNTjSXwJnNsXJPg+cP79HIcPwkreZQDqVTNDdjveI=; b=HHrdNv6AMAl5SlNNAOe09sQ+cL
        SHuLWSoy1IK2Gd2FLQLKRF8RHZZrcmHzMKSNOM5G3V4wqbE1ZJ1zKYUeTsV0pNqfSiPRxeEhpAmgi
        xXZKiD3aKghMlXekpEOuAx3O6tyVPPBL6bo+iCRHknw1RKwl7lpRsKQHT+R8v1sPNKLeQYaIt2juE
        C1KJNETkkUzM92pIvIj4zvMNzC48RBIcjjAGTAFmaBa3t2mBqHqgZK39Ps7b6PFoaWj3eDYTNAJTO
        q7jWQQK80RuU86vWqg3jIPDEuyrDNVvchb2yGpKku+ZxFJPeDNbluJZD5GhpLwBzUk/JJv/efUxsn
        isAcz+Gg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTpla-006IUK-KN; Thu, 01 Sep 2022 19:22:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 12C4230010B;
        Thu,  1 Sep 2022 21:22:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0348A2B8D5A27; Thu,  1 Sep 2022 21:22:17 +0200 (CEST)
Date:   Thu, 1 Sep 2022 21:22:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        mingo@redhat.com, christophe.leroy@csgroup.eu, rostedt@goodmis.org,
        mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 09/16] objtool: Use target file endianness instead of
 a compiled constant
Message-ID: <YxEGaOAasQLMUcBN@hirez.programming.kicks-ass.net>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-10-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829055223.24767-10-sv@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 11:22:16AM +0530, Sathvika Vasireddy wrote:
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Some architectures like powerpc support both endianness, it's
> therefore not possible to fix the endianness via arch/endianness.h
> because there is no easy way to get the target endianness at
> build time.
> 
> Use the endianness recorded in the file objtool is working on.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
