Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032704D0942
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 22:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242421AbiCGVS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 16:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiCGVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 16:18:54 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA3C2983D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 13:17:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B624D34EBBB;
        Mon,  7 Mar 2022 16:17:55 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id suQxVMfNVwYo; Mon,  7 Mar 2022 16:17:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6DED234E8F7;
        Mon,  7 Mar 2022 16:17:55 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6DED234E8F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1646687875;
        bh=sshHbozYZgHQWJpj5X4ksRxk1zVZ1/A5U8cI8+UqYVw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WuiPGgfIvxr3eEt35tX7ZoAuGYJwhiaunUh56bjuFR7nj7fcYmTzYCzoz3xrELQ1R
         +ZnqwlPhmyv12lApHdA5u7bVfy93u7cqIqNxiQ+8m0lHLAfFRG0VoxihKB3pRxsZw9
         Esxsnn46Hc5y669RQQoHs6nrjvrKXdHqzc99gmSgkZmsIaOiv4oE/qTZOFzjnIYa9j
         s7f2dzyNgvY8Fspq1ROT/tG69RlUqz5A4nhEwAyPwrgR0aNMxQitz6OrpOw+tHGV8F
         2AsdaYP0YrRRNClevH5G53Pz2L6bzbbVDoze/4JEqbQ+Hd1BM9+xdnIHEFImjXBJ46
         9A8AEoNMrpcVQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lEyQmS_tXKbR; Mon,  7 Mar 2022 16:17:55 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 62EC234ED19;
        Mon,  7 Mar 2022 16:17:55 -0500 (EST)
Date:   Mon, 7 Mar 2022 16:17:55 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1107588912.127428.1646687875294.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.13.2 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF97 (Linux)/8.8.15_GA_4232)
Thread-Index: sdhEkjIbeJvKI/brt+/jEwlhtEXs8w==
Thread-Topic: LTTng-modules 2.13.2 (Linux kernel tracer)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The 2.13.2 release of the LTTng kernel tracer includes a fix for the
syscall tracing feature. A bug crept into 2.13.0 which caused the
system call input arguments to be recorded on return from system call
rather than the output arguments. This fix was in the master branch of
lttng-modules, but was not cherry-picked into the 2.13 stable branch.

This missing backport went unnoticed through our CI integration       
because the relevant kernel tracer tests were not part of lttng-tools 
default test suite: "make check". This is now fixed in the lttng-tools
project.

This release also contains commits needed to trace the 5.17 kernels
(currently at v5.17-rc7).

Users of lttng-modules 2.13.0 and 2.13.1 should upgrade to 2.13.2
if they want to gather useful output arguments on return from system
call into their trace, rather than an extra copy of the system call
input arguments.

Thanks,

Mathieu

Changelog:

2022-03-07 (National Cereal Day) LTTng modules 2.13.2
        * Fix: incorrect in/out direction for syscall exit
        * fix: net: socket: rename SKB_DROP_REASON_SOCKET_FILTER (v5.17)
        * fix: net: skb: introduce kfree_skb_reason() (v5.17)
        * fix: random: rather than entropy_store abstraction, use global (v5.17)
        * fix: btrfs: pass fs_info to trace_btrfs_transaction_commit (v5.17)
        * fix: mm: compaction: fix the migration stats in trace_mm_compaction_migratepages() (v5.17)
        * fix: block: remove the ->rq_disk field in struct request (v5.17)
        * fix: block: remove GENHD_FL_SUPPRESS_PARTITION_INFO (v5.17)
        * Copyright ownership transfer

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
