Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0CE487603
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346886AbiAGK7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346878AbiAGK7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:59:12 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB82C061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:59:12 -0800 (PST)
Received: from [77.23.61.2] (helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n5mxe-0005hj-CU; Fri, 07 Jan 2022 11:59:06 +0100
Message-ID: <7cd73147-2170-a0cd-c64e-ded4bef645b0@leemhuis.info>
Date:   Fri, 7 Jan 2022 11:59:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-BS
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Song Liu <songliubraving@fb.com>, Jens Axboe <axboe@kernel.dk>,
        wsa@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Special regressions report for the pending 5.16 release
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641553152;8e5e8aa0;
X-HE-SMSGID: 1n5mxe-0005hj-CU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,



a quick brief manual regressions report, as I assume you'll likely
release 5.16 soon and thus might find this helpful. Below is a list of
remaining regressions in 5.16-rc I'm currently aware of.


regressions where a fix exists

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



* This fix afaics is not yet mainlined:

[PATCH] md/raid1: fix missing bitmap update w/o WriteMostly devices

https://lore.kernel.org/all/20220103230401.180704-1-song@kernel.org/



But I'm pretty sure Jens (CCed) will send it onwards soon:

https://lore.kernel.org/all/499b185d-ff9a-934e-7768-ec796244fa1a@kernel.dk/



* There is an open regression "Applications that need amdgpu doesn't run
after waking up from suspend":

https://lore.kernel.org/all/1295184560.182511.1639075777725@mail.yahoo.com/



Wolfram (CCed) plans to revert a i2c commit to fix it, but I'm not sure
if he plans to send in onwards for 5.16 (or if that would be a good idea
at all):

https://lore.kernel.org/lkml/20220106122452.18719-1-wsa@kernel.org/



* There are suspend and resume problems related to amdgpu:

https://bugzilla.kernel.org/show_bug.cgi?id=215436

Mario (CCed) recently found the root cause and came up with a fix, but
it likely needs a little more time to bake:

https://lore.kernel.org/all/BL1PR12MB5157F21C23A020052FF5C13BE24C9@BL1PR12MB5157.namprd12.prod.outlook.com/


https://lore.kernel.org/all/20220106163054.13781-3-mario.limonciello@amd.com/

no fix in sight

~~~~~~~~~~~~~~~



 * screen contents do get restored after some input events (so it
doesn't stay blank).

https://bugzilla.kernel.org/show_bug.cgi?id=215203

(related: https://gitlab.freedesktop.org/drm/amd/-/issues/1840 )



Alex (CCed) is trying hard to find a fix for, but afaics needs more time.



Need more time to analyse

~~~~~~~~~~~~~~~~~~~~~~~~~



I'm aware of two more reports that afaics need (a lot?) more time to
analyse:



 * suspend issues for a user that faces another regression that might
interfer:

https://lore.kernel.org/linux-pm/256689953.114854578.1640622738334.JavaMail.root@zimbra40-e7.priv.proxad.net/

https://bugzilla.kernel.org/show_bug.cgi?id=215427



 * 5-10% increase in IO latencies with nohz balance patch

https://lore.kernel.org/lkml/YaUH5GFFoLiS4%2F3%2F@localhost.localdomain/



Closing words

~~~~~~~~~~~~~



HTH, ciao, Thorsten
