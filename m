Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D6552CDB3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiESH5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbiESH5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:57:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8D137A14;
        Thu, 19 May 2022 00:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tgepYw5nexzkSdGrWECyn2GcidGFnnV2G28XjZEYgZo=; b=AznSJfdbbB2IVJ1vyPGXWTsPnG
        EJU7TfcGzrf5gXo3OUfHJnEUhbcY5hUaZx9n1ZuCBBHDi6BNVAo2CaDKd5D+Php3PKFrPYXspKkNg
        ZSmeNgQEPblVBcdFgnZ9y48NesV8yJByzXeoOCalqgo2G1jwceZcPxb0O1ZLD0WIEb6PpDEZ5QLef
        rH/9XEHG/kgYVy0HiRpbuimpV4xJigf3ChbN9XZ5FMSF9aOLTWXKMPlaE+JJzIQjr8ADcd27SWf0P
        Wr4eIaffunA8GGRzMLl7SGDjMKGuTCFQYEvRxIE1Y///sGtCfFR1dla+TRE/jXlaUwmbmP0B5NF18
        WhvnTGzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrb19-00CXmu-MV; Thu, 19 May 2022 07:56:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 453D8980E0B; Thu, 19 May 2022 09:56:19 +0200 (CEST)
Date:   Thu, 19 May 2022 09:56:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 03/16] kdb: Use real_parent when displaying a list of
 processes
Message-ID: <20220519075619.GE2578@worktop.programming.kicks-ass.net>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <20220518225355.784371-3-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518225355.784371-3-ebiederm@xmission.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 05:53:42PM -0500, Eric W. Biederman wrote:
> kdb has a bug that when using the ps command to display a list of
> processes, if a process is being debugged the debugger as the parent
> process.
> 
> This is silly, and I expect it never comes up in ptractice.  As there
                                                   ^^^^^^^^^

Lol, love the new word :-)
