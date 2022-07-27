Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879D2582A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiG0Pzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiG0Pze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:55:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACB6DE88
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G5uaoCkoTqBe2WG7lihqpqoIyreTbOi/GvFJVoRcBiY=; b=nZ7n2ALCV85Ajrb8U2b7W6eZ7w
        NA6RcFhEueNJHpQTpKh8BA6uCXcrNc0Vt0KkadYrLy/h65yzh5xnGKf/dq/wf3r9mu4TpHV2JDb10
        qJvQ3wwTGT6p2pNDWLyzDKNR4W2+CZDxhCRlWhqG5sWrYcJKkyXkwTtUryMVbvTfEzluaNIa2zJkk
        ZA/FyIaKWPFfscweKBBcxvESIf74042ZnvYmMpysY9DRJv3PZkx7ZB4BD8QdTJJxh8ZdKzNBQL4ih
        MlRzxBGO3VU7LX7cQKKj+XftIr5LPrFFq6U4WQyIIcYF7Wl2JYzYsnA+RbxKaqSw+LD3y3D6c5HZm
        otcEhFDA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGjNV-0031ex-Nc; Wed, 27 Jul 2022 15:55:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7C99980403; Wed, 27 Jul 2022 17:55:16 +0200 (CEST)
Date:   Wed, 27 Jul 2022 17:55:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stanislav Goriainov <goriainov@ispras.ru>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] objtool: Fix memory leak in create_static_call_section()
Message-ID: <YuFf5LiWGLH6ul5E@worktop.programming.kicks-ass.net>
References: <20220727154825.3427-1-goriainov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727154825.3427-1-goriainov@ispras.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 06:48:25PM +0300, Stanislav Goriainov wrote:
> On some paths of function create_static_call_section() the memory,
> allocated for key_name via strdup(), is not freed. Even though this
> is a utility function, and all memory will be freed automatically
> after the process is finished, there is free(key_sym) in some cases,
> so it would be sensible to always deallocate the memory.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 

This is a run-once die on error program. This is pointless and most
certainly doesn't 'fix' anything.
