Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568CF534C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345132AbiEZJCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244100AbiEZJCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:02:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9048E76
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653555731;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=VkRVcuwUmHhQvgmzbN5fUu3aPF/UqGvHbOx7ppFnIDA=;
        b=P5YtOgeHavEMDbbqxY7/CmhbeGjh0WpUUyua126F2Bs1OAW7XibAHYDay+rJHKoRAgMwnU
        Jpi4RlZUhoUImlzdBRQ2VjjWN6mRwy8201cZJECEJjAxRmVoQAm3IZLgjLR9th9AFuZyuV
        jNuJSAzyJfgKyy/r3/iNo0wkbtgAchA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-mAkbAszGPsuGObx-ZfdXEQ-1; Thu, 26 May 2022 05:02:08 -0400
X-MC-Unique: mAkbAszGPsuGObx-ZfdXEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0055985A5BC;
        Thu, 26 May 2022 09:02:08 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.192.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3ADE2026D64;
        Thu, 26 May 2022 09:02:07 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 24Q924na094158
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 11:02:04 +0200
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 24Q9231D094157;
        Thu, 26 May 2022 11:02:03 +0200
Date:   Thu, 26 May 2022 11:02:02 +0200
From:   Jakub Jelinek <jakub@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: objtool warning, branch, patch, and .config (GCC bug)
Message-ID: <Yo9CCoEF7nOd6lQI@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20220525173332.GA4008581@paulmck-ThinkPad-P17-Gen-1>
 <20220525173444.GA4010526@paulmck-ThinkPad-P17-Gen-1>
 <20220526080313.GM2578@worktop.programming.kicks-ass.net>
 <20220526080849.GF6479@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526080849.GF6479@worktop.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 10:08:49AM +0200, Peter Zijlstra wrote:
> On Thu, May 26, 2022 at 10:03:13AM +0200, Peter Zijlstra wrote:
> 
> > Which is just bloody weird/broken if you ask me. What's worse, GCC-10
> > does the same. Only when I use GCC-11 do I get sensible code again:
> 
> Just to clarify, I can reproduce using:
> 
> gcc-9 (Debian 9.4.0-5) 9.4.0
> gcc-10 (Debian 10.3.0-15) 10.3.0
> 
> The good compiler is:
> 
> gcc-11 (Debian 11.3.0-1) 11.3.0

Such fallthrough into another function is typically the result
of __builtin_unreachable (), either explicit somewhere in the code,
or invoking undefined behavior somewhere and __builtin_unreachable ()
replacing the UB code.
I'd need preprocessed source + full gcc command line to tell more
(as long as it is not LTO, with LTO that isn't enough of course).

	Jakub

