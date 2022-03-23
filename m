Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1144E59C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 21:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiCWU0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 16:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240272AbiCWU0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 16:26:04 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF0B3D48D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:24:34 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38190)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nX7Wt-007dRw-6V; Wed, 23 Mar 2022 14:24:27 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35242 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nX7Ws-0080N1-2F; Wed, 23 Mar 2022 14:24:26 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Alexey Gladkov <legion@kernel.org>
References: <cover.1644862280.git.legion@kernel.org>
Date:   Wed, 23 Mar 2022 15:24:18 -0500
In-Reply-To: <cover.1644862280.git.legion@kernel.org> (Alexey Gladkov's
        message of "Mon, 14 Feb 2022 19:18:13 +0100")
Message-ID: <877d8kfmdp.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nX7Ws-0080N1-2F;;;mid=<877d8kfmdp.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+bc2v0BvmToXTwnCKZgjNRumB58N8N6oQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 552 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 9 (1.7%), parse: 0.81 (0.1%),
         extract_message_metadata: 11 (2.0%), get_uri_detail_list: 1.02 (0.2%),
         tests_pri_-1000: 14 (2.5%), tests_pri_-950: 1.19 (0.2%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 107 (19.4%), check_bayes:
        105 (19.1%), b_tokenize: 6 (1.1%), b_tok_get_all: 6 (1.0%),
        b_comp_prob: 1.97 (0.4%), b_tok_touch_all: 89 (16.1%), b_finish: 0.78
        (0.1%), tests_pri_0: 395 (71.5%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 3.0 (0.5%), poll_dns_idle: 1.14 (0.2%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] ipc: Bind to the ipc namespace at open time.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the per-namespace-ipc-sysctls-for-v5.18 tag from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git per-namespace-ipc-sysctls-for-v5.18
  HEAD: 1f5c135ee509e89e0cc274333a65f73c62cb16e5 ipc: Store ipc sysctls in the ipc namespace


The per ipc namespace sysctls have been imperfect since they were
implemented.  Instead of binding to the ipc namespace of the opener of
the file the code bound to the ipc namespace of the writer of the
file.

This short series of changes addresses that old deficiency in the
code.

Alexey Gladkov (2):
      ipc: Store mqueue sysctls in the ipc namespace
      ipc: Store ipc sysctls in the ipc namespace

 include/linux/ipc_namespace.h |  37 ++++++++-
 ipc/ipc_sysctl.c              | 189 +++++++++++++++++++++++++++---------------
 ipc/mq_sysctl.c               | 121 +++++++++++++++------------
 ipc/mqueue.c                  |  10 +--
 ipc/namespace.c               |  10 +++
 5 files changed, 235 insertions(+), 132 deletions(-)

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>


Eric
