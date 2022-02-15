Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A20D4B6B47
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiBOLiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:38:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbiBOLiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:38:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19B314027
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:37:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84FC3210F9;
        Tue, 15 Feb 2022 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644925069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pw068fBCazlz3BwNkc7tJOJSYYz5n2wbrWj8hk+Qk0c=;
        b=FIzh/mtXss78WLaVXZ0p+HyizHWcg1OAgoO6jXye2Vs5V8A097HKb1BZctnDXeX7Nf4yCM
        /XwyoX/oLX6WDJsx7IB94As3hox/18NtQN2YE+uFhopBjerQCinyBRmkjVBeQ6imjJmwwa
        VKEqNYnrhUm7zQabflbD5olbqc6kMqE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F57313C40;
        Tue, 15 Feb 2022 11:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UgY1Fo2QC2KnQwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 15 Feb 2022 11:37:49 +0000
Date:   Tue, 15 Feb 2022 12:37:48 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 0/8] ucounts: RLIMIT_NPROC fixes
Message-ID: <20220215113748.GI21589@blackbody.suse.cz>
References: <20220207121800.5079-1-mkoutny@suse.com>
 <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
 <f0d686aa-3fad-afac-d377-f5d63111704a@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0d686aa-3fad-afac-d377-f5d63111704a@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 11:22:13AM -0700, Shuah Khan <skhan@linuxfoundation.org> wrote:
> Do we need updates to selftests - Michal's patch series included changes to
> selftests/exec

In my understanding the original rlimits-per-userns.c covers an invalid
use case -- clone(0);setuid();unshare(CLONE_NEWUSER) -- where the
created user_ns is owned by unprivileged user and the global
RLIMIT_NPROC cannot be breached.

My patched variant retains this use-case (should fail) and adds
clone(CLONE_NEWUSER);setuid() [1] variant which should be the valid
use-case for per-user per-user-ns RLIMIT_NPROC.

Michal

[1] In this situation theoretically equivalent to clone(0);unshare(CLONE_NEWUSER);setuid().

