Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDED508EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381272AbiDTRqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381241AbiDTRqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:46:07 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D87B47073
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:43:18 -0700 (PDT)
Received: (qmail 24508 invoked by uid 989); 20 Apr 2022 17:43:16 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
From:   Florian Fischer <florian.fischer@muhq.space>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v5] perf list: print all available tool events
Date:   Wed, 20 Apr 2022 19:42:43 +0200
Message-Id: <20220420174244.1741958-1-florian.fischer@muhq.space>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <YmA4byoEa3QBNeST@kernel.org>
References: <YmA4byoEa3QBNeST@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: +
X-Rspamd-Report: BAYES_SPAM(0.000069) R_MISSING_CHARSET(0.5) MIME_GOOD(-0.1) MID_CONTAINS_FROM(1)
X-Rspamd-Score: 1.400069
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Wed, 20 Apr 2022 19:43:16 +0200
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Introduce names for the new tool events 'user_time' and 'system_time'.
> 
> Before:
> 
> duration_time                                      [Tool event]
> 
> After:
> 
> $ perf list | grep Tool
> duration_time OR                                   [Tool event]
> user_time OR                                       [Tool event]
> system_time OR                                     [Tool event]
> $
> 
> So now we have that extraneous "OR", can you please take a look?
> Probably needs to check if there is an alias?
> 
> - Arnaldo

Sorry about that. Exactly as you guessed the code was missing a check if the tool
event actually has an alias.

Fixed Output:

$ perf list | grep Tool
  duration_time                                   [Tool event]
  user_time                                       [Tool event]
  system_time                                     [Tool event]

[v5]: Add missing alias check.

Florian Fischer

