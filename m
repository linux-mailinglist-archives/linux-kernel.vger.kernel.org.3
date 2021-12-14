Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0DD47418A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbhLNLg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:36:56 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56379 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbhLNLgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:36:55 -0500
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BEBaScV060602;
        Tue, 14 Dec 2021 20:36:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Tue, 14 Dec 2021 20:36:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BEBaRIr060525
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 14 Dec 2021 20:36:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <4ad30f21-9955-a72c-d7f0-912de6c205be@i-love.sakura.ne.jp>
Date:   Tue, 14 Dec 2021 20:36:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] tomoyo: Check exceeded quota early in
 tomoyo_domain_quota_is_ok().
Content-Language: en-US
To:     Dmitry Vyukov <dvyukov@google.com>, takedakn@nttdata.co.jp,
        jmorris@namei.org, serge@hallyn.com
Cc:     nogikh@google.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211214094526.2442154-1-dvyukov@google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20211214094526.2442154-1-dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/14 18:45, Dmitry Vyukov wrote:
> If tomoyo is used in a testing/fuzzing environment in learning mode,
> for lots of domains the quota will be exceeded and stay exceeded
> for prolonged periods of time. In such cases it's pointless (and slow)
> to walk the whole acl list again and again just to rediscover that
> the quota is exceeded. We already have the TOMOYO_DIF_QUOTA_WARNED flag
> that notes the overflow condition. Check it early to avoid the slowdown.

Thank you.

This patch will make a slight but user visible change.

When tomoyo_profile(domain->ns, domain->profile)->pref[TOMOYO_PREF_MAX_LEARNING_ENTRY] is
increased (or domain->profile switches to a different profile which has larger
pref[TOMOYO_PREF_MAX_LEARNING_ENTRY] value) after domain->flags[TOMOYO_DIF_QUOTA_WARNED] = true
is called, tomoyo_domain_quota_is_ok() will continue returning "false", and ACLs are no longer
appended.

Therefore, administrator will have to manually do domain->flags[TOMOYO_DIF_QUOTA_WARNED] = false
after increasing pref[TOMOYO_PREF_MAX_LEARNING_ENTRY] value (or changing domain->profile).

But since the message

  WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.

is a hint that tells administrator that "you will surely fail to try the enforcing mode on this
domain because the kernel has failed to automatically append at least one ACL to this domain",
administrator would have to retry the learning mode after increasing
pref[TOMOYO_PREF_MAX_LEARNING_ENTRY] value (or changing domain->profile) even without this patch.

Therefore, asking administrator to also clear domain->flags[TOMOYO_DIF_QUOTA_WARNED] after
increasing pref[TOMOYO_PREF_MAX_LEARNING_ENTRY] value (or changing domain->profile) would be
tolerable...
