Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F634D0274
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242699AbiCGPIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbiCGPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:08:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B296C2DE0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:07:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6F9DC1F394;
        Mon,  7 Mar 2022 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646665652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nNqrbcx3hlm6bW5QamgpEPJVajxBuWoj7VtZh9OD3tg=;
        b=CWa8yZuYAuQBxa6hAXICLsLOPu4OQlApY1SyBAU/aQ35Ne3D0XHbLIiY1VHuJnNggRYYGK
        qBbNLosXBXkusBFxESZ9q3c9WYUjIU/pz+DI2m6mkn4pOqi9csdAG3N0QKcubzYFJ2pxUX
        sqB7RjWt+4MrKmuYnXLW2Rdmpcqh5JE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646665652;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nNqrbcx3hlm6bW5QamgpEPJVajxBuWoj7VtZh9OD3tg=;
        b=UyvTe/9aUvyUe2vAwXMVy8aojAB+HmE+v6kjDl7sQONxFIKuOXIeeZvWM3amwmgS7n2E9e
        NiuUOif/kv2p9ABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6468132BC;
        Mon,  7 Mar 2022 15:07:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nQaDNbMfJmLrHgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 07 Mar 2022 15:07:31 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/3] A minor hotplug refactoring
Date:   Mon,  7 Mar 2022 16:07:22 +0100
Message-Id: <20220307150725.6810-1-osalvador@suse.de>
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

These are a few cleanups that go on top of Michal's work [1].

Thanks

[1] https://lore.kernel.org/lkml/20220127085305.20890-1-mhocko@kernel.org/

Oscar Salvador (3):
  mm/page_alloc: Do not calculate node's total pages and memmap pages
    when empty
  mm/memory_hotplug: Reset node's state when empty during offline
  mm/memory_hotplug: Refactor hotadd_init_pgdat and try_online_node

 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            | 93 ++++++++++++++++++----------------
 mm/page_alloc.c                | 59 +++++++--------------
 3 files changed, 69 insertions(+), 85 deletions(-)

-- 
2.34.1

