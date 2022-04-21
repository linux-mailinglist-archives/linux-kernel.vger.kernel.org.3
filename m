Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF90509E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388582AbiDUKxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388581AbiDUKwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00550B99
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650538192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+3DyS/vXJ0jJRw1ixWNwrePkn/qlB8fKnq3IZYAMOOg=;
        b=G1jfUgIRMrhdwUdTRsE2ZurPSQCWLSf6OtSls9sPebVHKtaiUKS8uWVGZIjNaMU/ZXboJB
        aKfkBqKxIl4QLHtDcuWlDkxp5bnMt+yZnD7emFEjqqVFhFzasWJ8ERvvwwuw+PVrbdzeQp
        u9l3OAiCZTr0KpiP5sXbfQQLlMCqZdk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-h6hn3O3EOhGuB2O7mdIfUA-1; Thu, 21 Apr 2022 06:49:48 -0400
X-MC-Unique: h6hn3O3EOhGuB2O7mdIfUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9292811E75;
        Thu, 21 Apr 2022 10:49:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id BCB9D40CFD1E;
        Thu, 21 Apr 2022 10:49:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 21 Apr 2022 12:49:46 +0200 (CEST)
Date:   Thu, 21 Apr 2022 12:49:43 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC][PATCH] ptrace: Don't change __state
Message-ID: <20220421104914.GA20402@redhat.com>
References: <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
 <20220415101644.GA10421@redhat.com>
 <20220415105755.GA15217@redhat.com>
 <Yllep6B8eva2VURJ@hirez.programming.kicks-ass.net>
 <20220418170104.GA16199@redhat.com>
 <20220420131731.GF2731@worktop.programming.kicks-ass.net>
 <20220420180323.GA14947@redhat.com>
 <875yn3zdag.fsf_-_@email.froward.int.ebiederm.org>
 <20220421072138.GI2731@worktop.programming.kicks-ass.net>
 <20220421102631.GE2762@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421102631.GE2762@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21, Peter Zijlstra wrote:
>
> As such, I've taken the liberty of munging yours and Oleg's approach
> together. I've yet to actually test this but it looks feasible.

Agreed, but I am a but confused. Is it on top of 1/5? Doesn't look so,
and I can't apply it with or without 1/5. So I am not sure I understand
what exactly it does.

Oleg.

