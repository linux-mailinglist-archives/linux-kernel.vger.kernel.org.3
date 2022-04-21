Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1350A7A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391078AbiDUSAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391096AbiDUSAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D7544AE29
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650563876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fe/IOGLeVKdooReU88aUvmgSHsxEqZOz3Fv5B7MP1bw=;
        b=WZ8VXdx6H/um4z6ahOsSqPGXYCWnfJlknfcJ+rnmXnWXK68/B4t9yjCBxUVyyPNmFRJSv5
        35LWXqn6yDQZq3kc2QQ0uQaHo33ofDafdWVKBku/y1scBtugsEvecQvDzqhVuwewiAuEBr
        R+5d8XFrUksASknSt+sg52k6+wBMto0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-RvEarh4NMHG-j4s5DuJLmA-1; Thu, 21 Apr 2022 13:57:52 -0400
X-MC-Unique: RvEarh4NMHG-j4s5DuJLmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D272838378A7;
        Thu, 21 Apr 2022 17:57:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD427145BA47;
        Thu, 21 Apr 2022 17:57:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 21 Apr 2022 19:57:51 +0200 (CEST)
Date:   Thu, 21 Apr 2022 19:57:47 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] freezer,sched: Rewrite core freezer logic
Message-ID: <20220421175746.GB20402@redhat.com>
References: <20220421150248.667412396@infradead.org>
 <20220421150655.001952823@infradead.org>
 <878rrys5yj.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rrys5yj.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21, Eric W. Biederman wrote:
>
> I would like to say that we can do without the wait_task_inactive,
> but it looks like it is necessary to ensure that all of the userspace
> registers are saved where the tracer can get at them.

Yes, for example, fpu regs.

But there are more problems. For example, if debugger changes TIF_BLOCKSTEP
we need to ensure the child is already inactive and it will do another
switch_to() after that.

Oleg.

