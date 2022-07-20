Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37B657BD23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiGTRpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiGTRph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:45:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2AC3244C;
        Wed, 20 Jul 2022 10:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0829B6151C;
        Wed, 20 Jul 2022 17:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48216C3411E;
        Wed, 20 Jul 2022 17:45:33 +0000 (UTC)
Date:   Wed, 20 Jul 2022 13:45:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V6 02/16] rv: Add runtime reactors interface
Message-ID: <20220720134531.400b87af@gandalf.local.home>
In-Reply-To: <d168f357-e78e-5dc6-09cd-41e6e41e1f4f@kernel.org>
References: <cover.1658244826.git.bristot@kernel.org>
        <4b5f93e3186b067073c1692d4c2b50d0b42101d5.1658244826.git.bristot@kernel.org>
        <20220720124133.3cdd2c44@gandalf.local.home>
        <ba11409a-df46-8fad-61a9-256277c588c0@kernel.org>
        <20220720130209.65f501b1@gandalf.local.home>
        <d168f357-e78e-5dc6-09cd-41e6e41e1f4f@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 19:37:58 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> > That has logic that looks to require a lock to protect things from changing
> > from underneath.  
> 
> ack, so the only variable I see we can use READ_ONCE/WRITE_ONCE is the reacting_on...

WRITE_ONCE() does not supply memory barriers, which you may need.

I'm only at patch 3, I'm not sure what the full requirements of that is.

-- Steve
