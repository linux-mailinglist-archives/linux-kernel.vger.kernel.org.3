Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA6F552A19
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbiFUER1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 00:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFUERY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 00:17:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2BC25ED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:17:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 202CE21F36;
        Tue, 21 Jun 2022 04:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655785040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nIWL9EVYdJEQWQuK0vpXzfqI0MxJEC5kZeDNzNQIaP4=;
        b=tz156sIsSo/UFoRCVe7HhhGUshcKwuSga/5PixBI7OLvsis6OsAIjGDCB30EvPrh6amKP+
        A4grCF1sglip7hZqE+lE1sUbl1gfq+G9nv621DCPjwvh42dSrYct/x6/SYp4ruVwxLeC1w
        TB7hYvg8U6pOBmvLOg/8TmrH3ULzfzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655785040;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nIWL9EVYdJEQWQuK0vpXzfqI0MxJEC5kZeDNzNQIaP4=;
        b=epuDo13d/ZZSVjA2fizAUvPFZAsxO/WQjBvz5lOxcyUrQDRkGj2xRv02pWa158zpDMq7pZ
        2+zpFLMA7V5DH5Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A99E313A37;
        Tue, 21 Jun 2022 04:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AAyQJk9GsWLLGwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 21 Jun 2022 04:17:19 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/2] Minor memoryhotplug refactoring
Date:   Tue, 21 Jun 2022 06:17:15 +0200
Message-Id: <20220621041717.6355-1-osalvador@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

these are a few cleanups.

The first one is to spare us with some operations when dealing with empty nodes,
and the second one is to refactor memory-hotplug code taking advantatge of the
fact that we initialize all nodes (empty or not) when booting the system.
That gives us the chance to only have to reset some fields when the node
goes offline again.

More information can be found in the respective patches.

v1 -> v2:
          - Addressed feedback from David

Oscar Salvador (2):
  mm/page_alloc: Do not calculate node's total pages and memmap pages
    when empty
  mm/memory_hotplug: Reset node's state when empty during offline

 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            | 54 ++++++++++++++++------------
 mm/page_alloc.c                | 65 +++++++++++-----------------------
 3 files changed, 53 insertions(+), 68 deletions(-)

-- 
2.35.3

